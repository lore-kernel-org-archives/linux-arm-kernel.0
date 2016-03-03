From: mahaijuns@gmail.com (Ma Haijun)
Date: Thu, 3 Mar 2016 23:32:26 +0800
Subject: [PATCH 02/17] irqchip: Add PLX Technology RPS IRQ Controller
In-Reply-To: <1457005210-18485-3-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <000201d17562$5f6f0090$1e4d01b0$@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Glad to see the mainline efforts of this SoC family.

Previously, I did not really understand what this "RPS" stood for.
After some digging(1)., now I believe it means ARM's Reference Peripheral
Specification
though the spec itself seems not publicly available, the peripheral specs
are accessible.
The interrupt controller is an AMBA Interrupt Controller(2) and the timers
are
AMBA Timer(3). Besides, ARM Dual-Timer Module (SP804)(4) looks like an
extended version
of the AMBA timer

1)
http://infocenter.arm.com/help/topic/com.arm.doc.dai0030a/DAI0030A_sw_int_ap
psnote.pdf
2) http://infocenter.arm.com/help/topic/com.arm.doc.ddi0047d/DDI0047.pdf
3) http://infocenter.arm.com/help/topic/com.arm.doc.ddi0049c/AMBA_Timer.pdf
4) http://infocenter.arm.com/help/topic/com.arm.doc.ddi0271d/DDI0271.pdf

Regards,
Haijun

-----Original Message-----
From: Neil Armstrong [mailto:narmstrong at baylibre.com] 
Subject: [PATCH 02/17] irqchip: Add PLX Technology RPS IRQ Controller

Add PLX Technology RPS IRQ Controller as irqchip driver.

CC: Ma Haijun <mahaijuns@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/irqchip/Kconfig   |   5 ++
 drivers/irqchip/Makefile  |   1 +
 drivers/irqchip/irq-rps.c | 128
++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/irqchip/irq-rps.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig index
fb50911..7892c1a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -135,6 +135,11 @@ config PIC32_EVIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config PLXTECH_RPS
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config RENESAS_INTC_IRQPIN
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile index
18caacb..3eec3a0 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_I8259)			+= irq-i8259.o
 obj-$(CONFIG_IMGPDC_IRQ)		+= irq-imgpdc.o
 obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
 obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
+obj-$(CONFIG_PLXTECH_RPS)		+= irq-rps.o
 obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
diff --git a/drivers/irqchip/irq-rps.c b/drivers/irqchip/irq-rps.c new file
mode 100644 index 0000000..bcd4a31
--- /dev/null
+++ b/drivers/irqchip/irq-rps.c
@@ -0,0 +1,128 @@
+/*
+ * drivers/irqchip/irq-rps.c
+ *
+ * Copyright (C) 2009 Oxford Semiconductor Ltd
+ * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
+ * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify 
+it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but 
+WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
+or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public 
+License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/version.h>
+#include <linux/irqchip.h>
+
+#include <asm/exception.h>
+
+struct rps_chip_data {
+	void __iomem *base;
+	struct irq_domain *domain;
+} rps_data;
+
+enum {
+	RPS_IRQ_COUNT = 32,
+
+	RPS_STATUS = 0,
+	RPS_RAW_STATUS = 4,
+	RPS_UNMASK = 8,
+	RPS_MASK = 0xc,
+};
+
+/* Routines to acknowledge, disable and enable interrupts */ static 
+void rps_mask_irq(struct irq_data *d) {
+	u32 mask = BIT(d->hwirq);
+
+	iowrite32(mask, rps_data.base + RPS_MASK); }
+
+static void rps_unmask_irq(struct irq_data *d) {
+	u32 mask = BIT(d->hwirq);
+
+	iowrite32(mask, rps_data.base + RPS_UNMASK); }
+
+static void rps_ack_irq(struct irq_data *d) {
+	/* NOP */
+}
+
+static void __exception_irq_entry handle_irq(struct pt_regs *regs) {
+	u32 irqstat;
+	int hwirq;
+
+	irqstat = ioread32(rps_data.base + RPS_STATUS);
+	hwirq = __ffs(irqstat);
+
+	do {
+		handle_IRQ(irq_find_mapping(rps_data.domain, hwirq), regs);
+
+		irqstat = ioread32(rps_data.base + RPS_STATUS);
+		hwirq = __ffs(irqstat);
+	} while (irqstat);
+}
+
+int __init rps_of_init(struct device_node *node, struct device_node 
+*parent) {
+	int ret;
+	struct irq_chip_generic *gc;
+
+	if (WARN_ON(!node))
+		return -ENODEV;
+
+	rps_data.base = of_iomap(node, 0);
+	WARN(!rps_data.base, "unable to map rps registers\n");
+
+	rps_data.domain = irq_domain_add_linear(node, RPS_IRQ_COUNT,
+						&irq_generic_chip_ops,
+						NULL);
+	if (!rps_data.domain) {
+		pr_err("%s: could add irq domain\n",
+		       node->full_name);
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(rps_data.domain, RPS_IRQ_COUNT,
1,
+					     "RPS", handle_level_irq,
+					     0, 0, IRQ_GC_INIT_NESTED_LOCK);
+	if (ret) {
+		pr_err("%s: could not allocate generic chip\n",
+		       node->full_name);
+		irq_domain_remove(rps_data.domain);
+		return -EINVAL;
+	}
+
+	gc = irq_get_domain_generic_chip(rps_data.domain, 0);
+	gc->chip_types[0].chip.irq_ack = rps_ack_irq;
+	gc->chip_types[0].chip.irq_mask = rps_mask_irq;
+	gc->chip_types[0].chip.irq_unmask = rps_unmask_irq;
+
+	/* Disable all IRQs */
+	iowrite32(~0, rps_data.base + RPS_MASK);
+
+	set_handle_irq(handle_irq);
+
+	pr_info("Registered %d rps interrupts\n", RPS_IRQ_COUNT);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(nas782x, "plxtech,nas782x-rps", rps_of_init);
--
1.9.1
