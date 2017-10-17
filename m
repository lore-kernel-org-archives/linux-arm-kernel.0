From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 17 Oct 2017 14:47:04 +0200
Subject: [PATCH v3 2/5] irqchip: Add Realtek RTD1295 mux driver
In-Reply-To: <20171017124708.6242-1-afaerber@suse.de>
References: <20171017124708.6242-1-afaerber@suse.de>
Message-ID: <20171017124708.6242-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This irq mux driver implements the RTD1295 SoC's non-linear mapping
between status and enable bits.

Based in part on QNAP's arch/arm/mach-rtk119x/rtk_irq_mux.c and
Synology's drivers/irqchip/irq-rtk.c code.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3:
 * Adopted spin_lock_irq{save,restore}() (Marc)
 * Adopted single-write masking (Marc)
 * Adopted misc compatible string
 * Introduced explicit bit mapping
 * Adopted looped processing of pending interrupts (Marc)
 * Replaced unmask implementation with UMSK_ISR write
 * Introduced enable/disable ops and dropped no longer needed UART0 quirk
 
 v1 -> v2:
 * Renamed struct fields to avoid ambiguity (Marc)
 * Refactored offset lookup to avoid per-compatible init functions
 * Inserted white lines to clarify balanced locking (Marc)
 * Dropped forwarding of set_affinity to GIC (Marc)
 * Added spinlocks for consistency (Marc)
 * Limited initialization quirk to iso mux
 * Fixed spinlock initialization (Andrew)
 
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-rtd119x-mux.c | 291 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+)
 create mode 100644 drivers/irqchip/irq-rtd119x-mux.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 845abc107ad5..99a95428ac9d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -79,3 +79,4 @@ obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
 obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
+obj-$(CONFIG_ARCH_REALTEK)		+= irq-rtd119x-mux.o
diff --git a/drivers/irqchip/irq-rtd119x-mux.c b/drivers/irqchip/irq-rtd119x-mux.c
new file mode 100644
index 000000000000..ad6e2093fcd3
--- /dev/null
+++ b/drivers/irqchip/irq-rtd119x-mux.c
@@ -0,0 +1,291 @@
+/*
+ * Realtek RTD129x IRQ mux
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: GPL-2.0+
+ */
+
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+
+struct rtd119x_irq_mux_info {
+	unsigned isr_offset;
+	unsigned umsk_isr_offset;
+	unsigned scpu_int_en_offset;
+	const u32 *isr_to_scpu_int_en_mask;
+};
+
+struct rtd119x_irq_mux_data {
+	void __iomem *reg_isr;
+	void __iomem *reg_umsk_isr;
+	void __iomem *reg_scpu_int_en;
+	const struct rtd119x_irq_mux_info *info;
+	int irq;
+	struct irq_domain *domain;
+	spinlock_t lock;
+};
+
+static void rtd119x_mux_irq_handle(struct irq_desc *desc)
+{
+	struct rtd119x_irq_mux_data *data = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 scpu_int_en, isr, mask;
+	int ret, i;
+
+	chained_irq_enter(chip, desc);
+
+	scpu_int_en = readl_relaxed(data->reg_scpu_int_en);
+	isr = readl_relaxed(data->reg_isr);
+
+	for (i = 0; i < 32; i++) {
+		if (!(isr & BIT(i)))
+			continue;
+
+		mask = data->info->isr_to_scpu_int_en_mask[i];
+		if (!(scpu_int_en & mask))
+			continue;
+
+		ret = generic_handle_irq(irq_find_mapping(data->domain, i));
+		if (ret == 0)
+			writel_relaxed(BIT(i), data->reg_isr);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void rtd119x_mux_mask_irq(struct irq_data *data)
+{
+	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(BIT(data->hwirq), mux_data->reg_isr);
+}
+
+static void rtd119x_mux_unmask_irq(struct irq_data *data)
+{
+	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(BIT(data->hwirq), mux_data->reg_umsk_isr);
+}
+
+static void rtd119x_mux_enable_irq(struct irq_data *data)
+{
+	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 scpu_int_en, mask;
+
+	mask = mux_data->info->isr_to_scpu_int_en_mask[data->hwirq];
+	if (!mask)
+		return;
+
+	spin_lock_irqsave(&mux_data->lock, flags);
+
+	scpu_int_en = readl_relaxed(mux_data->reg_scpu_int_en);
+	scpu_int_en |= mask;
+	writel_relaxed(scpu_int_en, mux_data->reg_scpu_int_en);
+
+	spin_unlock_irqrestore(&mux_data->lock, flags);
+}
+
+static void rtd119x_mux_disable_irq(struct irq_data *data)
+{
+	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 scpu_int_en, mask;
+
+	mask = mux_data->info->isr_to_scpu_int_en_mask[data->hwirq];
+	if (!mask)
+		return;
+
+	spin_lock_irqsave(&mux_data->lock, flags);
+
+	scpu_int_en = readl_relaxed(mux_data->reg_scpu_int_en);
+	scpu_int_en &= ~mask;
+	writel_relaxed(scpu_int_en, mux_data->reg_scpu_int_en);
+
+	spin_unlock_irqrestore(&mux_data->lock, flags);
+}
+
+static int rtd119x_mux_set_affinity(struct irq_data *d,
+			const struct cpumask *mask_val, bool force)
+{
+	/* Forwarding the affinity to the parent would affect all 32 interrupts. */
+	return -EINVAL;
+}
+
+static struct irq_chip rtd119x_mux_irq_chip = {
+	.name			= "rtd119x-mux",
+	.irq_mask		= rtd119x_mux_mask_irq,
+	.irq_unmask		= rtd119x_mux_unmask_irq,
+	.irq_enable		= rtd119x_mux_enable_irq,
+	.irq_disable		= rtd119x_mux_disable_irq,
+	.irq_set_affinity	= rtd119x_mux_set_affinity,
+};
+
+static int rtd119x_mux_irq_domain_map(struct irq_domain *d,
+		unsigned int irq, irq_hw_number_t hw)
+{
+	struct rtd119x_irq_mux_data *data = d->host_data;
+
+	irq_set_chip_and_handler(irq, &rtd119x_mux_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, data);
+	irq_set_probe(irq);
+
+	return 0;
+}
+
+static struct irq_domain_ops rtd119x_mux_irq_domain_ops = {
+	.xlate	= irq_domain_xlate_onecell,
+	.map	= rtd119x_mux_irq_domain_map,
+};
+
+enum rtd129x_iso_isr_bits {
+	RTD1295_ISO_ISR_UR0_SHIFT = 2,
+	RTD1295_ISO_ISR_IRDA_SHIFT = 5,
+	RTD1295_ISO_ISR_I2C0_SHIFT = 8,
+	RTD1295_ISO_ISR_I2C1_SHIFT = 11,
+	RTD1295_ISO_ISR_RTC_HSEC_SHIFT,
+	RTD1295_ISO_ISR_RTC_ALARM_SHIFT,
+	RTD1295_ISO_ISR_GPIOA_SHIFT = 19,
+	RTD1295_ISO_ISR_GPIODA_SHIFT,
+	RTD1295_ISO_ISR_GPHY_DV_SHIFT = 29,
+	RTD1295_ISO_ISR_GPHY_AV_SHIFT,
+	RTD1295_ISO_ISR_I2C1_REQ_SHIFT,
+};
+
+static const u32 rtd129x_iso_isr_to_scpu_int_en_mask[32] = {
+	[RTD1295_ISO_ISR_UR0_SHIFT]		= BIT(2),
+	[RTD1295_ISO_ISR_IRDA_SHIFT]		= BIT(5),
+	[RTD1295_ISO_ISR_I2C0_SHIFT]		= BIT(8),
+	[RTD1295_ISO_ISR_I2C1_SHIFT]		= BIT(11),
+	[RTD1295_ISO_ISR_RTC_HSEC_SHIFT]	= BIT(12),
+	[RTD1295_ISO_ISR_RTC_ALARM_SHIFT]	= BIT(13),
+	[RTD1295_ISO_ISR_GPIOA_SHIFT]		= BIT(19),
+	[RTD1295_ISO_ISR_GPIODA_SHIFT]		= BIT(20),
+	[RTD1295_ISO_ISR_GPHY_DV_SHIFT]		= BIT(29),
+	[RTD1295_ISO_ISR_GPHY_AV_SHIFT]		= BIT(30),
+	[RTD1295_ISO_ISR_I2C1_REQ_SHIFT]	= BIT(31),
+};
+
+enum rtd129x_misc_isr_bits {
+	RTD1295_ISR_UR1_SHIFT = 3,
+	RTD1295_ISR_UR1_TO_SHIFT = 5,
+	RTD1295_ISR_UR2_SHIFT = 8,
+	RTD1295_ISR_RTC_MIN_SHIFT = 10,
+	RTD1295_ISR_RTC_HOUR_SHIFT = 11,
+	RTD1295_ISR_RTC_DATA_SHIFT = 12,
+	RTD1295_ISR_UR2_TO_SHIFT = 13,
+	RTD1295_ISR_I2C5_SHIFT = 14,
+	RTD1295_ISR_I2C4_SHIFT = 15,
+	RTD1295_ISR_GPIOA_SHIFT = 19,
+	RTD1295_ISR_GPIODA_SHIFT = 20,
+	RTD1295_ISR_LSADC0_SHIFT = 21,
+	RTD1295_ISR_LSADC1_SHIFT = 22,
+	RTD1295_ISR_I2C3_SHIFT = 23,
+	RTD1295_ISR_SC0_SHIFT = 24,
+	RTD1295_ISR_I2C2_SHIFT = 26,
+	RTD1295_ISR_GSPI_SHIFT = 27,
+	RTD1295_ISR_FAN_SHIFT = 29,
+};
+
+static const u32 rtd129x_misc_isr_to_scpu_int_en_mask[32] = {
+	[RTD1295_ISR_UR1_SHIFT]			= BIT(3),
+	[RTD1295_ISR_UR1_TO_SHIFT]		= BIT(5),
+	[RTD1295_ISR_UR2_TO_SHIFT]		= BIT(6),
+	[RTD1295_ISR_UR2_SHIFT]			= BIT(7),
+	[RTD1295_ISR_RTC_MIN_SHIFT]		= BIT(10),
+	[RTD1295_ISR_RTC_HOUR_SHIFT]		= BIT(11),
+	[RTD1295_ISR_RTC_DATA_SHIFT]		= BIT(12),
+	[RTD1295_ISR_I2C5_SHIFT]		= BIT(14),
+	[RTD1295_ISR_I2C4_SHIFT]		= BIT(15),
+	[RTD1295_ISR_GPIOA_SHIFT]		= BIT(19),
+	[RTD1295_ISR_GPIODA_SHIFT]		= BIT(20),
+	[RTD1295_ISR_LSADC0_SHIFT]		= BIT(21),
+	[RTD1295_ISR_LSADC1_SHIFT]		= BIT(22),
+	[RTD1295_ISR_SC0_SHIFT]			= BIT(24),
+	[RTD1295_ISR_I2C2_SHIFT]		= BIT(26),
+	[RTD1295_ISR_GSPI_SHIFT]		= BIT(27),
+	[RTD1295_ISR_I2C3_SHIFT]		= BIT(28),
+	[RTD1295_ISR_FAN_SHIFT]			= BIT(29),
+};
+
+static const struct rtd119x_irq_mux_info rtd129x_iso_irq_mux_info = {
+	.isr_offset		= 0x0,
+	.umsk_isr_offset	= 0x4,
+	.scpu_int_en_offset	= 0x40,
+	.isr_to_scpu_int_en_mask = rtd129x_iso_isr_to_scpu_int_en_mask,
+};
+
+static const struct rtd119x_irq_mux_info rtd129x_misc_irq_mux_info = {
+	.umsk_isr_offset	= 0x8,
+	.isr_offset		= 0xc,
+	.scpu_int_en_offset	= 0x80,
+	.isr_to_scpu_int_en_mask = rtd129x_misc_isr_to_scpu_int_en_mask,
+};
+
+static const struct of_device_id rtd1295_irq_mux_dt_matches[] = {
+	{
+		.compatible = "realtek,rtd1295-iso-irq-mux",
+		.data = &rtd129x_iso_irq_mux_info,
+	}, {
+		.compatible = "realtek,rtd1295-misc-irq-mux",
+		.data = &rtd129x_misc_irq_mux_info,
+	}, {
+	}
+};
+
+static int __init rtd119x_irq_mux_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	struct rtd119x_irq_mux_data *data;
+	const struct of_device_id *match;
+	const struct rtd119x_irq_mux_info *info;
+	void __iomem *base;
+
+	match = of_match_node(rtd1295_irq_mux_dt_matches, node);
+	if (!match)
+		return -EINVAL;
+
+	info = match->data;
+	if (!info)
+		return -EINVAL;
+
+	base = of_iomap(node, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->info = info;
+	data->reg_isr		= base + info->isr_offset;
+	data->reg_umsk_isr	= base + info->umsk_isr_offset;
+	data->reg_scpu_int_en	= base + info->scpu_int_en_offset;
+
+	data->irq = irq_of_parse_and_map(node, 0);
+	if (data->irq <= 0) {
+		kfree(data);
+		return -EINVAL;
+	}
+
+	spin_lock_init(&data->lock);
+
+	data->domain = irq_domain_add_linear(node, 32,
+				&rtd119x_mux_irq_domain_ops, data);
+	if (!data->domain) {
+		kfree(data);
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler_and_data(data->irq, rtd119x_mux_irq_handle, data);
+
+	return 0;
+}
+IRQCHIP_DECLARE(rtd1295_iso_mux, "realtek,rtd1295-iso-irq-mux", rtd119x_irq_mux_init);
+IRQCHIP_DECLARE(rtd1295_misc_mux, "realtek,rtd1295-misc-irq-mux", rtd119x_irq_mux_init);
-- 
2.13.6
