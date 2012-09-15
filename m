From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 15 Sep 2012 00:21:30 -0600
Subject: [PATCH V5 2/5] ARM: bcm2835: add interrupt controller driver
In-Reply-To: <1347690093-16910-1-git-send-email-swarren@wwwdotorg.org>
References: <1347690093-16910-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347690093-16910-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Arlott <simon@fire.lp0.eu>

The BCM2835 contains a custom interrupt controller, which supports 72
interrupt sources using a 2-level register scheme. The interrupt
controller, or the HW block containing it, is referred to occasionally
as "armctrl" in the SoC documentation, hence the symbol naming in the
code.

This patch was extracted from git://github.com/lp0/linux.git branch
rpi-split as of 2012/09/08, and modified as follows:

* s/bcm2708/bcm2835/.
* Modified device tree vendor prefix.
* Moved implementation to drivers/irchip/.
* Added devicetree documentation, and hence removed list of IRQs from
  bcm2835.dtsi.
* Changed shift in MAKE_HWIRQ() and HWIRQ_BANK() from 8 to 5 to reduce
  the size of the hwirq space, and pass the total size of the hwirq space
  to irq_domain_add_linear(), rather than just the number of valid hwirqs;
  the two are different due to the hwirq space being sparse.
* Added the interrupt controller DT node to the top-level of the DT,
  rather than nesting it inside a /axi node. Hence, changed the reg value
  since /axi had a ranges property. This seems simpler to me, but I'm not
  sure if everyone will like this change or not.
* Don't set struct irq_domain_ops.map = irq_domain_simple_map, hence
  removing the need to patch include/linux/irqdomain.h or
  kernel/irq/irqdomain.c.
* Simplified armctrl_of_init() using of_iomap().
* Removed unused IS_VALID_BANK()/IS_VALID_IRQ() macros.
* Renamed armctrl_handle_irq() to prevent possible symbol clashes.
* Made armctrl_of_init() static.
* Removed comment "Each bank is registered as a separate interrupt
  controller" since this is no longer true.
* Removed FSF address from license header.
* Added my name to copyright header.

Signed-off-by: Chris Boot <bootc@bootc.net>
Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Dom Cobley <dc4@broadcom.com>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
--
v5:
* Adjusted DT for ranges in /soc node.
v4:
* Moved IRQ driver to drivers/irqchip/.
* Simplified armctrl_of_init() using of_iomap().
* Moved binding into Documentation/devicetree/bindings/interrupt-controller/.
* s/bcm2708/bcm2835/.
* Updated for new device tree vendor prefix.
v3:
* New patch.
---
 .../brcm,bcm2835-armctrl-ic.txt                    |  110 ++++++++++
 arch/arm/boot/dts/bcm2835.dtsi                     |    8 +
 arch/arm/mach-bcm2835/bcm2835.c                    |   10 +-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-bcm2835.c                      |  223 ++++++++++++++++++++
 include/linux/irqchip/bcm2835.h                    |   29 +++
 8 files changed, 376 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
 create mode 100644 drivers/irqchip/Kconfig
 create mode 100644 drivers/irqchip/Makefile
 create mode 100644 drivers/irqchip/irq-bcm2835.c
 create mode 100644 include/linux/irqchip/bcm2835.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
new file mode 100644
index 0000000..7bcf2f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
@@ -0,0 +1,110 @@
+BCM2835 Top-Level ("ARMCTRL") Interrupt Controller
+
+The BCM2835 contains a custom top-level interrupt controller, which supports
+72 interrupt sources using a 2-level register scheme. The interrupt
+controller, or the HW block containing it, is referred to occasionally
+as "armctrl" in the SoC documentation, hence naming of this binding.
+
+Required properties:
+
+- compatible : should be "brcm,bcm2835-armctrl-ic.txt"
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2.
+
+  The 1st cell is the interrupt bank; 0 for interrupts in the "IRQ basic
+  pending" register, or 1/2 respectively for interrupts in the "IRQ pending
+  1/2" register.
+
+  The 2nd cell contains the interrupt number within the bank. Valid values
+  are 0..7 for bank 0, and 0..31 for bank 1.
+
+The interrupt sources are as follows:
+
+Bank 0:
+0: ARM_TIMER
+1: ARM_MAILBOX
+2: ARM_DOORBELL_0
+3: ARM_DOORBELL_1
+4: VPU0_HALTED
+5: VPU1_HALTED
+6: ILLEGAL_TYPE0
+7: ILLEGAL_TYPE1
+
+Bank 1:
+0: TIMER0
+1: TIMER1
+2: TIMER2
+3: TIMER3
+4: CODEC0
+5: CODEC1
+6: CODEC2
+7: VC_JPEG
+8: ISP
+9: VC_USB
+10: VC_3D
+11: TRANSPOSER
+12: MULTICORESYNC0
+13: MULTICORESYNC1
+14: MULTICORESYNC2
+15: MULTICORESYNC3
+16: DMA0
+17: DMA1
+18: VC_DMA2
+19: VC_DMA3
+20: DMA4
+21: DMA5
+22: DMA6
+23: DMA7
+24: DMA8
+25: DMA9
+26: DMA10
+27: DMA11
+28: DMA12
+29: AUX
+30: ARM
+31: VPUDMA
+
+Bank 2:
+0: HOSTPORT
+1: VIDEOSCALER
+2: CCP2TX
+3: SDC
+4: DSI0
+5: AVE
+6: CAM0
+7: CAM1
+8: HDMI0
+9: HDMI1
+10: PIXELVALVE1
+11: I2CSPISLV
+12: DSI1
+13: PWA0
+14: PWA1
+15: CPR
+16: SMI
+17: GPIO0
+18: GPIO1
+19: GPIO2
+20: GPIO3
+21: VC_I2C
+22: VC_SPI
+23: VC_I2SPCM
+24: VC_SDIO
+25: VC_UART
+26: SLIMBUS
+27: VEC
+28: CPG
+29: RNG
+30: VC_ARASANSDIO
+31: AVSPMON
+
+Example:
+
+intc: interrupt-controller {
+	compatible = "brcm,bcm2835-armctrl-ic";
+	reg = <0x2000b200 0x200>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index a31cb40..8842d75 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -3,6 +3,7 @@
 / {
 	compatible = "brcm,bcm2835";
 	model = "BCM2835";
+	interrupt-parent = <&intc>;
 
 	chosen {
 		bootargs = "earlyprintk";
@@ -13,5 +14,12 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x7e000000 0x20000000 0x02000000>;
+
+		intc: interrupt-controller {
+			compatible = "brcm,bcm2835-armctrl-ic";
+			reg = <0x7e00b200 0x200>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 };
diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
index f6b36b4..72c4b5f 100644
--- a/arch/arm/mach-bcm2835/bcm2835.c
+++ b/arch/arm/mach-bcm2835/bcm2835.c
@@ -13,12 +13,12 @@
  */
 
 #include <linux/init.h>
+#include <linux/irqchip/bcm2835.h>
 #include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/exception.h>
 
 #include <mach/bcm2835_soc.h>
 
@@ -34,14 +34,6 @@ void __init bcm2835_map_io(void)
 	iotable_init(&io_map, 1);
 }
 
-void __init bcm2835_init_irq(void)
-{
-}
-
-asmlinkage void __exception_irq_entry bcm2835_handle_irq(struct pt_regs *regs)
-{
-}
-
 void __init bcm2835_init(void)
 {
 	int ret;
diff --git a/drivers/Kconfig b/drivers/Kconfig
index ece958d..36d3daa 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -152,4 +152,6 @@ source "drivers/vme/Kconfig"
 
 source "drivers/pwm/Kconfig"
 
+source "drivers/irqchip/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 5b42184..8c30e73 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -5,6 +5,8 @@
 # Rewritten to use lists instead of if-statements.
 #
 
+obj-y				+= irqchip/
+
 # GPIO must come after pinctrl as gpios may need to mux pins etc
 obj-y				+= pinctrl/
 obj-y				+= gpio/
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
new file mode 100644
index 0000000..054321d
--- /dev/null
+++ b/drivers/irqchip/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_BCM2835) += irq-bcm2835.o
diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
new file mode 100644
index 0000000..dc670cc
--- /dev/null
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -0,0 +1,223 @@
+/*
+ * Copyright 2010 Broadcom
+ * Copyright 2012 Simon Arlott, Chris Boot, Stephen Warren
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Quirk 1: Shortcut interrupts don't set the bank 1/2 register pending bits
+ *
+ * If an interrupt fires on bank 1 that isn't in the shortcuts list, bit 8
+ * on bank 0 is set to signify that an interrupt in bank 1 has fired, and
+ * to look in the bank 1 status register for more information.
+ *
+ * If an interrupt fires on bank 1 that _is_ in the shortcuts list, its
+ * shortcut bit in bank 0 is set as well as its interrupt bit in the bank 1
+ * status register, but bank 0 bit 8 is _not_ set.
+ *
+ * Quirk 2: You can't mask the register 1/2 pending interrupts
+ *
+ * In a proper cascaded interrupt controller, the interrupt lines with
+ * cascaded interrupt controllers on them are just normal interrupt lines.
+ * You can mask the interrupts and get on with things. With this controller
+ * you can't do that.
+ *
+ * Quirk 3: The shortcut interrupts can't be (un)masked in bank 0
+ *
+ * Those interrupts that have shortcuts can only be masked/unmasked in
+ * their respective banks' enable/disable registers. Doing so in the bank 0
+ * enable/disable registers has no effect.
+ *
+ * The FIQ control register:
+ *  Bits 0-6: IRQ (index in order of interrupts from banks 1, 2, then 0)
+ *  Bit    7: Enable FIQ generation
+ *  Bits  8+: Unused
+ *
+ * An interrupt must be disabled before configuring it for FIQ generation
+ * otherwise both handlers will fire at the same time!
+ */
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/bcm2835.h>
+
+#include <asm/exception.h>
+
+/* Put the bank and irq (32 bits) into the hwirq */
+#define MAKE_HWIRQ(b, n)	((b << 5) | (n))
+#define HWIRQ_BANK(i)		(i >> 5)
+#define HWIRQ_BIT(i)		BIT(i & 0x1f)
+
+#define NR_IRQS_BANK0		8
+#define BANK0_HWIRQ_MASK	0xff
+/* Shortcuts can't be disabled so any unknown new ones need to be masked */
+#define SHORTCUT1_MASK		0x00007c00
+#define SHORTCUT2_MASK		0x001f8000
+#define SHORTCUT_SHIFT		10
+#define BANK1_HWIRQ		BIT(8)
+#define BANK2_HWIRQ		BIT(9)
+#define BANK0_VALID_MASK	(BANK0_HWIRQ_MASK | BANK1_HWIRQ | BANK2_HWIRQ \
+					| SHORTCUT1_MASK | SHORTCUT2_MASK)
+
+#define REG_FIQ_CONTROL		0x0c
+
+#define NR_BANKS		3
+#define IRQS_PER_BANK		32
+
+static int reg_pending[] __initconst = { 0x00, 0x04, 0x08 };
+static int reg_enable[] __initconst = { 0x18, 0x10, 0x14 };
+static int reg_disable[] __initconst = { 0x24, 0x1c, 0x20 };
+static int bank_irqs[] __initconst = { 8, 32, 32 };
+
+static const int shortcuts[] = {
+	7, 9, 10, 18, 19,		/* Bank 1 */
+	21, 22, 23, 24, 25, 30		/* Bank 2 */
+};
+
+struct armctrl_ic {
+	void __iomem *base;
+	void __iomem *pending[NR_BANKS];
+	void __iomem *enable[NR_BANKS];
+	void __iomem *disable[NR_BANKS];
+	struct irq_domain *domain;
+};
+
+static struct armctrl_ic intc __read_mostly;
+
+static void armctrl_mask_irq(struct irq_data *d)
+{
+	writel_relaxed(HWIRQ_BIT(d->hwirq), intc.disable[HWIRQ_BANK(d->hwirq)]);
+}
+
+static void armctrl_unmask_irq(struct irq_data *d)
+{
+	writel_relaxed(HWIRQ_BIT(d->hwirq), intc.enable[HWIRQ_BANK(d->hwirq)]);
+}
+
+static struct irq_chip armctrl_chip = {
+	.name = "ARMCTRL-level",
+	.irq_mask = armctrl_mask_irq,
+	.irq_unmask = armctrl_unmask_irq
+};
+
+static int armctrl_xlate(struct irq_domain *d, struct device_node *ctrlr,
+	const u32 *intspec, unsigned int intsize,
+	unsigned long *out_hwirq, unsigned int *out_type)
+{
+	if (WARN_ON(intsize != 2))
+		return -EINVAL;
+
+	if (WARN_ON(intspec[0] >= NR_BANKS))
+		return -EINVAL;
+
+	if (WARN_ON(intspec[1] >= IRQS_PER_BANK))
+		return -EINVAL;
+
+	if (WARN_ON(intspec[0] == 0 && intspec[1] >= NR_IRQS_BANK0))
+		return -EINVAL;
+
+	*out_hwirq = MAKE_HWIRQ(intspec[0], intspec[1]);
+	*out_type = IRQ_TYPE_NONE;
+	return 0;
+}
+
+static struct irq_domain_ops armctrl_ops = {
+	.xlate = armctrl_xlate
+};
+
+static int __init armctrl_of_init(struct device_node *node,
+	struct device_node *parent)
+{
+	void __iomem *base;
+	int irq, b, i;
+
+	base = of_iomap(node, 0);
+	if (!base)
+		panic("%s: unable to map IC registers\n",
+			node->full_name);
+
+	intc.domain = irq_domain_add_linear(node, MAKE_HWIRQ(NR_BANKS, 0),
+			&armctrl_ops, NULL);
+	if (!intc.domain)
+		panic("%s: unable to create IRQ domain\n", node->full_name);
+
+	for (b = 0; b < NR_BANKS; b++) {
+		intc.pending[b] = base + reg_pending[b];
+		intc.enable[b] = base + reg_enable[b];
+		intc.disable[b] = base + reg_disable[b];
+
+		for (i = 0; i < bank_irqs[b]; i++) {
+			irq = irq_create_mapping(intc.domain, MAKE_HWIRQ(b, i));
+			BUG_ON(irq <= 0);
+			irq_set_chip_and_handler(irq, &armctrl_chip,
+				handle_level_irq);
+			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		}
+	}
+	return 0;
+}
+
+static struct of_device_id irq_of_match[] __initconst = {
+	{ .compatible = "brcm,bcm2835-armctrl-ic", .data = armctrl_of_init }
+};
+
+void __init bcm2835_init_irq(void)
+{
+	of_irq_init(irq_of_match);
+}
+
+/*
+ * Handle each interrupt across the entire interrupt controller.  This reads the
+ * status register before handling each interrupt, which is necessary given that
+ * handle_IRQ may briefly re-enable interrupts for soft IRQ handling.
+ */
+
+static void armctrl_handle_bank(int bank, struct pt_regs *regs)
+{
+	u32 stat, irq;
+
+	while ((stat = readl_relaxed(intc.pending[bank]))) {
+		irq = MAKE_HWIRQ(bank, ffs(stat) - 1);
+		handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
+	}
+}
+
+static void armctrl_handle_shortcut(int bank, struct pt_regs *regs,
+	u32 stat)
+{
+	u32 irq = MAKE_HWIRQ(bank, shortcuts[ffs(stat >> SHORTCUT_SHIFT) - 1]);
+	handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
+}
+
+asmlinkage void __exception_irq_entry bcm2835_handle_irq(
+	struct pt_regs *regs)
+{
+	u32 stat, irq;
+
+	while ((stat = readl_relaxed(intc.pending[0]) & BANK0_VALID_MASK)) {
+		if (stat & BANK0_HWIRQ_MASK) {
+			irq = MAKE_HWIRQ(0, ffs(stat & BANK0_HWIRQ_MASK) - 1);
+			handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
+		} else if (stat & SHORTCUT1_MASK) {
+			armctrl_handle_shortcut(1, regs, stat & SHORTCUT1_MASK);
+		} else if (stat & SHORTCUT2_MASK) {
+			armctrl_handle_shortcut(2, regs, stat & SHORTCUT2_MASK);
+		} else if (stat & BANK1_HWIRQ) {
+			armctrl_handle_bank(1, regs);
+		} else if (stat & BANK2_HWIRQ) {
+			armctrl_handle_bank(2, regs);
+		} else {
+			BUG();
+		}
+	}
+}
diff --git a/include/linux/irqchip/bcm2835.h b/include/linux/irqchip/bcm2835.h
new file mode 100644
index 0000000..48a859b
--- /dev/null
+++ b/include/linux/irqchip/bcm2835.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2010 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __LINUX_IRQCHIP_BCM2835_H_
+#define __LINUX_IRQCHIP_BCM2835_H_
+
+#include <asm/exception.h>
+
+extern void bcm2835_init_irq(void);
+
+extern asmlinkage void __exception_irq_entry bcm2835_handle_irq(
+	struct pt_regs *regs);
+
+#endif
-- 
1.7.9.5
