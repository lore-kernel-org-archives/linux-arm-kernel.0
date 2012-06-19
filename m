From: Barry.Song@csr.com (Barry Song)
Date: Tue, 19 Jun 2012 15:16:56 +0800
Subject: [PATCH v2] PINCTRL: SiRF: add GPIO and GPIO irq support in CSR
 SiRFprimaII
Message-ID: <1340090216-1689-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

In SiRFprimaII, Each GPIO pin can be configured as input or output
independently. If a GPIO is configured as input, it can also be
enabled as an interrupt source (either edge or level triggered).

These pins must be either MUXed as GPIO or other function pads.

Signed-off-by: Yuping Luo <Yuping.Luo@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2:
 merge into pinctrl-sirf.c since it is pinmux, gpio and irq source;
 use irq domain according to Linus Walleij's feedback;
 some other cleanup to Linus Walleij's feedback

 arch/arm/Kconfig                         |    1 +
 arch/arm/mach-prima2/include/mach/gpio.h |   13 +
 arch/arm/mach-prima2/include/mach/irqs.h |    2 +-
 drivers/pinctrl/pinctrl-sirf.c           |  489 +++++++++++++++++++++++++++++-
 4 files changed, 503 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-prima2/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b1b2752..6ee51a0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -389,6 +389,7 @@ config ARCH_PRIMA2
 	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
 	select CPU_V7
 	select NO_IOPORT
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-prima2/include/mach/gpio.h b/arch/arm/mach-prima2/include/mach/gpio.h
new file mode 100644
index 0000000..1904bb0
--- /dev/null
+++ b/arch/arm/mach-prima2/include/mach/gpio.h
@@ -0,0 +1,13 @@
+#ifndef __MACH_GPIO_H
+#define __MACH_GPIO_H
+
+/* Pull up/down values */
+enum sirfsoc_gpio_pull {
+	SIRFSOC_GPIO_PULL_NONE,
+	SIRFSOC_GPIO_PULL_UP,
+	SIRFSOC_GPIO_PULL_DOWN,
+};
+
+void sirfsoc_gpio_set_pull(unsigned gpio, unsigned mode);
+
+#endif
diff --git a/arch/arm/mach-prima2/include/mach/irqs.h b/arch/arm/mach-prima2/include/mach/irqs.h
index bb354f9..f6014a0 100644
--- a/arch/arm/mach-prima2/include/mach/irqs.h
+++ b/arch/arm/mach-prima2/include/mach/irqs.h
@@ -11,7 +11,7 @@
 
 #define SIRFSOC_INTENAL_IRQ_START  0
 #define SIRFSOC_INTENAL_IRQ_END    59
-
+#define SIRFSOC_GPIO_IRQ_START     (SIRFSOC_INTENAL_IRQ_END + 1)
 #define NR_IRQS	220
 
 #endif
diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index e9f8e7d..2aae8a8 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -8,24 +8,61 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/irqdomain.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/bitops.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #define DRIVER_NAME "pinmux-sirf"
 
 #define SIRFSOC_NUM_PADS    622
-#define SIRFSOC_GPIO_PAD_EN(g) ((g)*0x100 + 0x84)
 #define SIRFSOC_RSC_PIN_MUX 0x4
 
+#define SIRFSOC_GPIO_PAD_EN(g) ((g)*0x100 + 0x84)
+#define SIRFSOC_GPIO_CTRL(g, i)			((g)*0x100 + (i)*4)
+#define SIRFSOC_GPIO_DSP_EN0			(0x80)
+#define SIRFSOC_GPIO_PAD_EN(g)			((g)*0x100 + 0x84)
+#define SIRFSOC_GPIO_INT_STATUS(g)		((g)*0x100 + 0x8C)
+
+#define SIRFSOC_GPIO_CTL_INTR_LOW_MASK		0x1
+#define SIRFSOC_GPIO_CTL_INTR_HIGH_MASK		0x2
+#define SIRFSOC_GPIO_CTL_INTR_TYPE_MASK		0x4
+#define SIRFSOC_GPIO_CTL_INTR_EN_MASK		0x8
+#define SIRFSOC_GPIO_CTL_INTR_STS_MASK		0x10
+#define SIRFSOC_GPIO_CTL_OUT_EN_MASK		0x20
+#define SIRFSOC_GPIO_CTL_DATAOUT_MASK		0x40
+#define SIRFSOC_GPIO_CTL_DATAIN_MASK		0x80
+#define SIRFSOC_GPIO_CTL_PULL_MASK		0x100
+#define SIRFSOC_GPIO_CTL_PULL_HIGH		0x200
+#define SIRFSOC_GPIO_CTL_DSP_INT		0x400
+
+#define SIRFSOC_GPIO_NO_OF_BANKS        5
+#define SIRFSOC_GPIO_BANK_SIZE          32
+#define SIRFSOC_GPIO_NUM(bank, index)	(((bank)*(32)) + (index))
+
+struct sirfsoc_gpio_bank {
+	struct of_mm_gpio_chip chip;
+	struct irq_domain *domain;
+	int id;
+	int parent_irq;
+	spinlock_t lock;
+};
+
+static struct sirfsoc_gpio_bank sgpio_bank[SIRFSOC_GPIO_NO_OF_BANKS];
+static DEFINE_SPINLOCK(sgpio_lock);
+
 /*
  * pad list for the pinmux subsystem
  * refer to CS-131858-DC-6A.xls
@@ -1204,7 +1241,457 @@ static int __init sirfsoc_pinmux_init(void)
 }
 arch_initcall(sirfsoc_pinmux_init);
 
+static inline int sirfsoc_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct sirfsoc_gpio_bank *bank = container_of(to_of_mm_gpio_chip(chip),
+		struct sirfsoc_gpio_bank, chip);
+
+	return irq_find_mapping(bank->domain, offset);
+}
+
+static inline int sirfsoc_gpio_to_offset(unsigned int gpio)
+{
+	return gpio % SIRFSOC_GPIO_BANK_SIZE;
+}
+
+static inline struct sirfsoc_gpio_bank *sirfsoc_gpio_to_bank(unsigned int gpio)
+{
+	return &sgpio_bank[gpio / SIRFSOC_GPIO_BANK_SIZE];
+}
+
+void sirfsoc_gpio_set_pull(unsigned gpio, unsigned mode)
+{
+	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(gpio);
+	int idx = sirfsoc_gpio_to_offset(gpio);
+	u32 val, offset;
+	unsigned long flags;
+
+	offset = SIRFSOC_GPIO_CTRL(bank->id, idx);
+
+	spin_lock_irqsave(&sgpio_lock, flags);
+
+	val = readl(bank->chip.regs + offset);
+
+	switch (mode) {
+	case SIRFSOC_GPIO_PULL_NONE:
+		val &= ~SIRFSOC_GPIO_CTL_PULL_MASK;
+		break;
+	case SIRFSOC_GPIO_PULL_UP:
+		val |= SIRFSOC_GPIO_CTL_PULL_MASK;
+		val |= SIRFSOC_GPIO_CTL_PULL_HIGH;
+		break;
+	case SIRFSOC_GPIO_PULL_DOWN:
+		val |= SIRFSOC_GPIO_CTL_PULL_MASK;
+		val &= ~SIRFSOC_GPIO_CTL_PULL_HIGH;
+		break;
+	default:
+		break;
+	}
+
+	writel(val, bank->chip.regs + offset);
+
+	spin_unlock_irqrestore(&sgpio_lock, flags);
+}
+EXPORT_SYMBOL(sirfsoc_gpio_set_pull);
+
+static inline struct sirfsoc_gpio_bank *sirfsoc_irqchip_to_bank(struct gpio_chip *chip)
+{
+	return container_of(to_of_mm_gpio_chip(chip), struct sirfsoc_gpio_bank, chip);
+}
+
+static void sirfsoc_gpio_irq_ack(struct irq_data *d)
+{
+	struct sirfsoc_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	int idx = d->hwirq % SIRFSOC_GPIO_BANK_SIZE;
+	u32 val, offset;
+	unsigned long flags;
+
+	offset = SIRFSOC_GPIO_CTRL(bank->id, idx);
+
+	spin_lock_irqsave(&sgpio_lock, flags);
+
+	val = readl(bank->chip.regs + offset);
+
+	writel(val, bank->chip.regs + offset);
+
+	spin_unlock_irqrestore(&sgpio_lock, flags);
+}
+
+static void __sirfsoc_gpio_irq_mask(struct sirfsoc_gpio_bank *bank, int idx)
+{
+	u32 val, offset;
+	unsigned long flags;
+
+	offset = SIRFSOC_GPIO_CTRL(bank->id, idx);
+
+	spin_lock_irqsave(&sgpio_lock, flags);
+
+	val = readl(bank->chip.regs + offset);
+	val &= ~SIRFSOC_GPIO_CTL_INTR_EN_MASK;
+	val &= ~SIRFSOC_GPIO_CTL_INTR_STS_MASK;
+	writel(val, bank->chip.regs + offset);
+
+	spin_unlock_irqrestore(&sgpio_lock, flags);
+}
+
+static void sirfsoc_gpio_irq_mask(struct irq_data *d)
+{
+	struct sirfsoc_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+
+	__sirfsoc_gpio_irq_mask(bank, d->hwirq % SIRFSOC_GPIO_BANK_SIZE);
+}
+
+static void sirfsoc_gpio_irq_unmask(struct irq_data *d)
+{
+	struct sirfsoc_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	int idx = d->hwirq % SIRFSOC_GPIO_BANK_SIZE;
+	u32 val, offset;
+	unsigned long flags;
+
+	offset = SIRFSOC_GPIO_CTRL(bank->id, idx);
+
+	spin_lock_irqsave(&sgpio_lock, flags);
+
+	val = readl(bank->chip.regs + offset);
+	val &= ~SIRFSOC_GPIO_CTL_INTR_STS_MASK;
+	val |= SIRFSOC_GPIO_CTL_INTR_EN_MASK;
+	writel(val, bank->chip.regs + offset);
+
+	spin_unlock_irqrestore(&sgpio_lock, flags);
+}
+
+static int sirfsoc_gpio_irq_type(struct irq_data *d, unsigned type)
+{
+	struct sirfsoc_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	int idx = d->hwirq % SIRFSOC_GPIO_BANK_SIZE;
+	u32 val, offset;
+	unsigned long flags;
+
+	offset = SIRFSOC_GPIO_CTRL(bank->id, idx);
+
+	spin_lock_irqsave(&sgpio_lock, flags);
+
+	val = readl(bank->chip.regs + offset);
+	val &= ~SIRFSOC_GPIO_CTL_INTR_STS_MASK;
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		val |= SIRFSOC_GPIO_CTL_INTR_HIGH_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK;
+		val &= ~SIRFSOC_GPIO_CTL_INTR_LOW_MASK;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		val &= ~SIRFSOC_GPIO_CTL_INTR_HIGH_MASK;
+		val |= SIRFSOC_GPIO_CTL_INTR_LOW_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		val |= SIRFSOC_GPIO_CTL_INTR_HIGH_MASK | SIRFSOC_GPIO_CTL_INTR_LOW_MASK |
+			 SIRFSOC_GPIO_CTL_INTR_TYPE_MASK;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		val &= ~(SIRFSOC_GPIO_CTL_INTR_HIGH_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK);
+		val |= SIRFSOC_GPIO_CTL_INTR_LOW_MASK;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		val |= SIRFSOC_GPIO_CTL_INTR_HIGH_MASK;
+		val &= ~(SIRFSOC_GPIO_CTL_INTR_LOW_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK);
+		break;
+	}
+
+	writel(val, bank->chip.regs + offset);
+
+	spin_unlock_irqrestore(&sgpio_lock, flags);
+
+	return 0;
+}
+
+static struct irq_chip sirfsoc_irq_chip = {
+	.name = "sirf-gpio-irq",
+	.irq_ack = sirfsoc_gpio_irq_ack,
+	.irq_mask = sirfsoc_gpio_irq_mask,
+	.irq_unmask = sirfsoc_gpio_irq_unmask,
+	.irq_set_type = sirfsoc_gpio_irq_type,
+};
+
+static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)
+{
+	struct sirfsoc_gpio_bank *bank = irq_get_handler_data(irq);
+	u32 status, ctrl;
+	int idx = 0;
+	unsigned int first_irq;
+
+	status = readl(bank->chip.regs + SIRFSOC_GPIO_INT_STATUS(bank->id));
+	if (!status) {
+		printk(KERN_WARNING
+			"%s: gpio id %d status %#x no interrupt is flaged\n",
+			__func__, bank->id, status);
+		handle_bad_irq(irq, desc);
+		return;
+	}
+
+	first_irq = bank->domain->revmap_data.legacy.first_irq;
+
+	while (status) {
+		ctrl = readl(bank->chip.regs + SIRFSOC_GPIO_CTRL(bank->id, idx));
+
+		/*
+		 * Here we must check whether the corresponding GPIO's interrupt
+		 * has been enabled, otherwise just skip it
+		 */
+		if ((status & 0x1) && (ctrl & SIRFSOC_GPIO_CTL_INTR_EN_MASK)) {
+			pr_debug("%s: gpio id %d idx %d happens\n",
+				__func__, bank->id, idx);
+			generic_handle_irq(first_irq + idx);
+		}
+
+		idx++;
+		status = status >> 1;
+	}
+}
+
+static inline void sirfsoc_gpio_set_input(struct sirfsoc_gpio_bank *bank, unsigned ctrl_offset)
+{
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+
+	val = readl(bank->chip.regs + ctrl_offset);
+	val &= ~SIRFSOC_GPIO_CTL_OUT_EN_MASK;
+	writel(val, bank->chip.regs + ctrl_offset);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+}
+
+static int sirfsoc_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct sirfsoc_gpio_bank *bank = sirfsoc_irqchip_to_bank(chip);
+	unsigned long flags;
+
+	if (pinctrl_request_gpio(chip->base + offset))
+		return -ENODEV;
+
+	spin_lock_irqsave(&bank->lock, flags);
+
+	/*
+	 * default status:
+	 * set direction as input and mask irq
+	 */
+	sirfsoc_gpio_set_input(bank, SIRFSOC_GPIO_CTRL(bank->id, offset));
+	__sirfsoc_gpio_irq_mask(bank, offset);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
+}
+
+static void sirfsoc_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	struct sirfsoc_gpio_bank *bank = sirfsoc_irqchip_to_bank(chip);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+
+	__sirfsoc_gpio_irq_mask(bank, offset);
+	sirfsoc_gpio_set_input(bank, SIRFSOC_GPIO_CTRL(bank->id, offset));
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	pinctrl_free_gpio(chip->base + offset);
+}
+
+static int sirfsoc_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
+{
+	struct sirfsoc_gpio_bank *bank = sirfsoc_irqchip_to_bank(chip);
+	int idx = sirfsoc_gpio_to_offset(gpio);
+	unsigned long flags;
+	unsigned offset;
+
+	offset = SIRFSOC_GPIO_CTRL(bank->id, idx);
+
+	spin_lock_irqsave(&bank->lock, flags);
+
+	sirfsoc_gpio_set_input(bank, offset);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
+}
+
+static inline void sirfsoc_gpio_set_output(struct sirfsoc_gpio_bank *bank, unsigned offset,
+	int value)
+{
+	u32 out_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+
+	out_ctrl = readl(bank->chip.regs + offset);
+	if (value)
+		out_ctrl |= SIRFSOC_GPIO_CTL_DATAOUT_MASK;
+	else
+		out_ctrl &= ~SIRFSOC_GPIO_CTL_DATAOUT_MASK;
+
+	out_ctrl &= ~SIRFSOC_GPIO_CTL_INTR_EN_MASK;
+	out_ctrl |= SIRFSOC_GPIO_CTL_OUT_EN_MASK;
+	writel(out_ctrl, bank->chip.regs + offset);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+}
+
+static int sirfsoc_gpio_direction_output(struct gpio_chip *chip, unsigned gpio, int value)
+{
+	struct sirfsoc_gpio_bank *bank = sirfsoc_irqchip_to_bank(chip);
+	int idx = sirfsoc_gpio_to_offset(gpio);
+	u32 offset;
+	unsigned long flags;
+
+	offset = SIRFSOC_GPIO_CTRL(bank->id, idx);
+
+	spin_lock_irqsave(&sgpio_lock, flags);
+
+	sirfsoc_gpio_set_output(bank, offset, value);
+
+	spin_unlock_irqrestore(&sgpio_lock, flags);
+
+	return 0;
+}
+
+static int sirfsoc_gpio_get_value(struct gpio_chip *chip, unsigned offset)
+{
+	struct sirfsoc_gpio_bank *bank = sirfsoc_irqchip_to_bank(chip);
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+
+	val = readl(bank->chip.regs + SIRFSOC_GPIO_CTRL(bank->id, offset));
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return !!(val & SIRFSOC_GPIO_CTL_DATAIN_MASK);
+}
+
+static void sirfsoc_gpio_set_value(struct gpio_chip *chip, unsigned offset,
+	int value)
+{
+	struct sirfsoc_gpio_bank *bank = sirfsoc_irqchip_to_bank(chip);
+	u32 ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+
+	ctrl = readl(bank->chip.regs + SIRFSOC_GPIO_CTRL(bank->id, offset));
+	if (value)
+		ctrl |= SIRFSOC_GPIO_CTL_DATAOUT_MASK;
+	else
+		ctrl &= ~SIRFSOC_GPIO_CTL_DATAOUT_MASK;
+	writel(ctrl, bank->chip.regs + SIRFSOC_GPIO_CTRL(bank->id, offset));
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+}
+
+int sirfsoc_gpio_irq_map(struct irq_domain *d, unsigned int irq,
+	irq_hw_number_t hwirq)
+{
+	struct sirfsoc_gpio_bank *bank = d->host_data;
+
+	if (!bank)
+		return -EINVAL;
+
+	irq_set_chip(irq, &sirfsoc_irq_chip);
+	irq_set_handler(irq, handle_level_irq);
+	irq_set_chip_data(irq, bank);
+	set_irq_flags(irq, IRQF_VALID);
+
+	return 0;
+}
+
+const struct irq_domain_ops sirfsoc_gpio_irq_simple_ops = {
+	.map = sirfsoc_gpio_irq_map,
+	.xlate = irq_domain_xlate_twocell,
+};
+
+static int __devinit sirfsoc_gpio_probe(struct device_node *np)
+{
+	int i, err = 0;
+	struct sirfsoc_gpio_bank *bank;
+	void *regs;
+	struct platform_device *pdev;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return -ENODEV;
+
+	regs = of_iomap(np, 0);
+	if (!regs)
+		return -ENOMEM;
+
+	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
+		bank = &sgpio_bank[i];
+		spin_lock_init(&bank->lock);
+		bank->chip.gc.request = sirfsoc_gpio_request;
+		bank->chip.gc.free = sirfsoc_gpio_free;
+		bank->chip.gc.direction_input = sirfsoc_gpio_direction_input;
+		bank->chip.gc.get = sirfsoc_gpio_get_value;
+		bank->chip.gc.direction_output = sirfsoc_gpio_direction_output;
+		bank->chip.gc.set = sirfsoc_gpio_set_value;
+		bank->chip.gc.to_irq = sirfsoc_gpio_to_irq;
+		bank->chip.gc.base = i * SIRFSOC_GPIO_BANK_SIZE;
+		bank->chip.gc.ngpio = SIRFSOC_GPIO_BANK_SIZE;
+		bank->chip.gc.label = kstrdup(np->full_name, GFP_KERNEL);
+		bank->chip.gc.of_node = np;
+		bank->chip.regs = regs;
+		bank->id = i;
+		bank->parent_irq = platform_get_irq(pdev, i);
+		if (bank->parent_irq < 0) {
+			err = bank->parent_irq;
+			goto out;
+		}
+
+		err = gpiochip_add(&bank->chip.gc);
+		if (err) {
+			pr_err("%s: error in probe function with status %d\n",
+				np->full_name, err);
+			goto out;
+		}
+
+		bank->domain = irq_domain_add_legacy(np, SIRFSOC_GPIO_BANK_SIZE,
+			SIRFSOC_GPIO_IRQ_START + i * SIRFSOC_GPIO_BANK_SIZE, 0,
+			&sirfsoc_gpio_irq_simple_ops, bank);
+
+		if (!bank->domain) {
+			pr_err("%s: Failed to create irqdomain\n", np->full_name);
+			err = -ENOSYS;
+			goto out;
+		}
+
+		irq_set_chained_handler(bank->parent_irq, sirfsoc_gpio_handle_irq);
+		irq_set_handler_data(bank->parent_irq, bank);
+	}
+
+out:
+	iounmap(regs);
+	return err;
+}
+
+static int __init sirfsoc_gpio_init(void)
+{
+
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, pinmux_ids);
+
+	if (!np)
+		return -ENODEV;
+
+	return sirfsoc_gpio_probe(np);
+}
+subsys_initcall(sirfsoc_gpio_init);
+
 MODULE_AUTHOR("Rongjun Ying <rongjun.ying@csr.com>, "
+	"Yuping Luo <yuping.luo@csr.com>, "
 	"Barry Song <baohua.song@csr.com>");
 MODULE_DESCRIPTION("SIRFSOC pin control driver");
 MODULE_LICENSE("GPL");
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
