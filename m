From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Fri, 27 Sep 2013 21:57:38 +1200
Subject: [PATCH v3] irq: bmc2835: Re-implement the hardware IRQ handler.
In-Reply-To: <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
References: <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
Message-ID: <1380275858-1289-1-git-send-email-slapdau@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Force the re-reading of the pending status registers before dispatching
the next interrupt request.  There is no guarantee that the values will
remain valid.  Actions taken by interrupt handlers could handle and
acknowledge multiple interrupts.  For example, the DMA controller has
it's own view of the interrupt status of all channels rather than just
the one that the interrupt was dispatched for.  The cost of re-reading
is small.  The cost of unnecessary dispatches is large.

Reorder the internal numbering of interrupt banks so that hardware IRQ
numbers range from 0 to 71, and match the natural numbering implied by
the FIQ source register.  This is in anticipation of being to implement
a viable mechanism for registering one of the available interrupts as a
fast interrupt.  Preferably based on device tree configuration.

Enable device tree interrupt specifications to identify interrupts with
shortcut bits in the base register by either the shortcut bit, or the
canonical GPU register bit.   E.g. UART can be either <0, 19> or <2,
25>.

Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org

---
v3 Fixes as per Stephen Warren's comments:
 * Restore table lookup for IRQ enable/disable.
 * Move magic numbers to defines.
 * Extract and document dt_to_internal_bank().
 * Correct #include line ordering.
 * remove .irq_ack from the chip definition.  It's unneccesary. The
   interrupt framework calls .irq_mask if it's not defined.
 * Various other layout fixes.
 * Correct the patch summary line.

v2:
 * Correct a stupid defect.  Should always test even minor changes.
 * Add forgotten bits to the commit message.
---
 drivers/irqchip/irq-bcm2835.c | 367 ++++++++++++++++++++++++------------------
 1 file changed, 206 insertions(+), 161 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index 1693b8e7..f2241e84 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -1,6 +1,7 @@
 /*
  * Copyright 2010 Broadcom
  * Copyright 2012 Simon Arlott, Chris Boot, Stephen Warren
+ * Copyright 2013 Craig McGeachie
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -11,212 +12,256 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * Quirk 1: Shortcut interrupts don't set the bank 1/2 register pending bits
- *
- * If an interrupt fires on bank 1 that isn't in the shortcuts list, bit 8
- * on bank 0 is set to signify that an interrupt in bank 1 has fired, and
- * to look in the bank 1 status register for more information.
- *
- * If an interrupt fires on bank 1 that _is_ in the shortcuts list, its
- * shortcut bit in bank 0 is set as well as its interrupt bit in the bank 1
- * status register, but bank 0 bit 8 is _not_ set.
- *
- * Quirk 2: You can't mask the register 1/2 pending interrupts
- *
- * In a proper cascaded interrupt controller, the interrupt lines with
- * cascaded interrupt controllers on them are just normal interrupt lines.
- * You can mask the interrupts and get on with things. With this controller
- * you can't do that.
- *
- * Quirk 3: The shortcut interrupts can't be (un)masked in bank 0
- *
- * Those interrupts that have shortcuts can only be masked/unmasked in
- * their respective banks' enable/disable registers. Doing so in the bank 0
- * enable/disable registers has no effect.
- *
- * The FIQ control register:
- *  Bits 0-6: IRQ (index in order of interrupts from banks 1, 2, then 0)
- *  Bit    7: Enable FIQ generation
- *  Bits  8+: Unused
- *
- * An interrupt must be disabled before configuring it for FIQ generation
- * otherwise both handlers will fire at the same time!
  */
 
+#include <linux/bitops.h>
 #include <linux/io.h>
-#include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/irq.h>
 #include <linux/irqdomain.h>
 
 #include <asm/exception.h>
-#include <asm/mach/irq.h>
 
 #include "irqchip.h"
 
-/* Put the bank and irq (32 bits) into the hwirq */
-#define MAKE_HWIRQ(b, n)	((b << 5) | (n))
-#define HWIRQ_BANK(i)		(i >> 5)
-#define HWIRQ_BIT(i)		BIT(i & 0x1f)
-
-#define NR_IRQS_BANK0		8
-#define BANK0_HWIRQ_MASK	0xff
-/* Shortcuts can't be disabled so any unknown new ones need to be masked */
-#define SHORTCUT1_MASK		0x00007c00
-#define SHORTCUT2_MASK		0x001f8000
-#define SHORTCUT_SHIFT		10
-#define BANK1_HWIRQ		BIT(8)
-#define BANK2_HWIRQ		BIT(9)
-#define BANK0_VALID_MASK	(BANK0_HWIRQ_MASK | BANK1_HWIRQ | BANK2_HWIRQ \
-					| SHORTCUT1_MASK | SHORTCUT2_MASK)
-
-#define REG_FIQ_CONTROL		0x0c
-
-#define NR_BANKS		3
-#define IRQS_PER_BANK		32
-
-static int reg_pending[] __initconst = { 0x00, 0x04, 0x08 };
-static int reg_enable[] __initconst = { 0x18, 0x10, 0x14 };
-static int reg_disable[] __initconst = { 0x24, 0x1c, 0x20 };
-static int bank_irqs[] __initconst = { 8, 32, 32 };
-
-static const int shortcuts[] = {
-	7, 9, 10, 18, 19,		/* Bank 1 */
-	21, 22, 23, 24, 25, 30		/* Bank 2 */
-};
+/*
+ * Internal to this file, IRQs are numbered as per the enable and disable
+ * registers.  The register banks GPU1, GPU2, and BASE are numbered 0, 1, and 2
+ * respectively. IRQs 0..31 are bits 0..31 of the GPU1 register.  IRQs 32..63
+ * are bits 0..31 of the GPU2 register.  IRQs 64..71 are bits 0..7 of the BASE
+ * register.  This is the same numbering scheme used in bits 0..6 of the FIQ
+ * register.
+ *
+ * Translation into and out of this address space happens at two
+ * points:
+ * - external drivers registering handlers will result in a call to
+ *   bmc2835_domain_xlate()
+ * - interrupt pending status registers are read in bcm2835_handle_irq() which
+ *   uses bmc2835_dispatch_irq() to map through the internal hardware IRQ space
+ *   into the kernel's registered IRQ address space.
+ */
+
+#define MAKE_HWIRQ(b, n)	(((b) << 5) | ((n) & 0x1f))
+#define HWIRQ_BANK(i)		((i) >> 5)
+#define HWIRQ_BIT(i)		BIT((i) & 0x1f)
+
+#define GPU1_BANK	0
+#define GPU2_BANK	1
+#define BASE_BANK	2
+#define NR_BANKS	3
+
+#define BITS_PER_REG	32
+
+#define BASE_PEND_OFF	0x00
+#define GPU1_PEND_OFF	0x04
+#define GPU2_PEND_OFF	0x08
+
+#define BASE_READABLE	0x001fffff
+#define BASE_GPU1	BIT(8)
+#define BASE_GPU2	BIT(9)
+#define BASE_IRQS	(BASE_READABLE & ~(BASE_GPU1 | BASE_GPU2))
+#define GPU1_IRQS	~(BIT(7) | BIT(9) | BIT(10) | BIT(18) | BIT(19))
+#define GPU2_IRQS	~(BIT(21) | BIT(22) | BIT(23) | BIT(23) | BIT(25) \
+				| BIT(30))
+
+#define NR_CHIP_IRQS	(BITS_PER_REG * 2 + 8)
+#define BAD_IRQ_NUM	-1
+
+static int reg_enable[] __initconst = { 0x10, 0x14, 0x18 };
+static int reg_disable[] __initconst = { 0x1c, 0x20, 0x24 };
 
-struct armctrl_ic {
-	void __iomem *base;
-	void __iomem *pending[NR_BANKS];
+static struct ctrlr {
+	void __iomem *iobase;
+	void __iomem *base_pend;
+	void __iomem *gpu1_pend;
+	void __iomem *gpu2_pend;
 	void __iomem *enable[NR_BANKS];
 	void __iomem *disable[NR_BANKS];
 	struct irq_domain *domain;
-};
-
-static struct armctrl_ic intc __read_mostly;
-static asmlinkage void __exception_irq_entry bcm2835_handle_irq(
-	struct pt_regs *regs);
-
-static void armctrl_mask_irq(struct irq_data *d)
-{
-	writel_relaxed(HWIRQ_BIT(d->hwirq), intc.disable[HWIRQ_BANK(d->hwirq)]);
-}
+	unsigned int hwirq_xlat[BITS_PER_REG * NR_BANKS];
+} ctrlr __read_mostly;
 
-static void armctrl_unmask_irq(struct irq_data *d)
-{
-	writel_relaxed(HWIRQ_BIT(d->hwirq), intc.enable[HWIRQ_BANK(d->hwirq)]);
+/**
+ * dt_to_internal_bank() - translate DT bank to hardware bank.
+ * @dt_bank:	bank number as read from device tree.
+ *
+ * The device tree represents GPU1, GPU2, and BASE are numbered 1, 2, and 0
+ * respectively. Internally they are represented as 0, 1,and 2 respectively.
+ * This function performs the conversion.
+ */
+static inline unsigned int dt_to_internal_bank(const u32 dt_bank) {
+	return (dt_bank + 2) % 3;
 }
 
-static struct irq_chip armctrl_chip = {
-	.name = "ARMCTRL-level",
-	.irq_mask = armctrl_mask_irq,
-	.irq_unmask = armctrl_unmask_irq
-};
-
-static int armctrl_xlate(struct irq_domain *d, struct device_node *ctrlr,
+/**
+ * bmc2835_domain_xlate() - translate FTD IRQ specification to hardware IRQ
+ * @d:		controller domain
+ * @np:		device node
+ * @intspec:	interrupt specification values
+ * @intsize:	interrupt specification size
+ * @out_hwirq:	return the hardware IRQ
+ * @out_type:	return the IRQ type
+ *
+ * The interrupt is specified as two u32 values.  The first is the FDT bank
+ * number, the second is the bit number in bank.
+ *
+ * Interrupt specifiers may refer to an interrupt with a shortcut bit in the
+ * BASE register in two ways. Either by refering to the BASE register shortcut
+ * bit, or by referring to the GPU1/GPU2 register bit.  For example, UART may
+ * be either <0, 19> or <2, 25>.
+ */
+static int bmc2835_domain_xlate(struct irq_domain *d, struct device_node *np,
 	const u32 *intspec, unsigned int intsize,
 	unsigned long *out_hwirq, unsigned int *out_type)
 {
-	if (WARN_ON(intsize != 2))
-		return -EINVAL;
+	unsigned int bank, hwirq;
 
-	if (WARN_ON(intspec[0] >= NR_BANKS))
+	if (WARN_ON(intsize != 2 || intspec[0] >= NR_BANKS || intspec[1] >= 32))
 		return -EINVAL;
-
-	if (WARN_ON(intspec[1] >= IRQS_PER_BANK))
-		return -EINVAL;
-
-	if (WARN_ON(intspec[0] == 0 && intspec[1] >= NR_IRQS_BANK0))
+	bank = dt_to_internal_bank(intspec[0]);
+	hwirq = ctrlr.hwirq_xlat[MAKE_HWIRQ(bank, intspec[1])];
+	if (WARN_ON(hwirq == BAD_IRQ_NUM))
 		return -EINVAL;
-
-	*out_hwirq = MAKE_HWIRQ(intspec[0], intspec[1]);
+	*out_hwirq = hwirq;
 	*out_type = IRQ_TYPE_NONE;
 	return 0;
 }
 
-static struct irq_domain_ops armctrl_ops = {
-	.xlate = armctrl_xlate
+static struct irq_domain_ops bmc2835_ops = {
+	.xlate = bmc2835_domain_xlate
 };
 
-static int __init armctrl_of_init(struct device_node *node,
-	struct device_node *parent)
+static void bmc2835_mask_irq(struct irq_data *d)
 {
-	void __iomem *base;
-	int irq, b, i;
-
-	base = of_iomap(node, 0);
-	if (!base)
-		panic("%s: unable to map IC registers\n",
-			node->full_name);
+	void __iomem *ioreg = ctrlr.disable[HWIRQ_BANK(d->hwirq)];
+	u32 bit = HWIRQ_BIT(d->hwirq);
 
-	intc.domain = irq_domain_add_linear(node, MAKE_HWIRQ(NR_BANKS, 0),
-			&armctrl_ops, NULL);
-	if (!intc.domain)
-		panic("%s: unable to create IRQ domain\n", node->full_name);
+	writel_relaxed(bit, ioreg);
+}
 
-	for (b = 0; b < NR_BANKS; b++) {
-		intc.pending[b] = base + reg_pending[b];
-		intc.enable[b] = base + reg_enable[b];
-		intc.disable[b] = base + reg_disable[b];
-
-		for (i = 0; i < bank_irqs[b]; i++) {
-			irq = irq_create_mapping(intc.domain, MAKE_HWIRQ(b, i));
-			BUG_ON(irq <= 0);
-			irq_set_chip_and_handler(irq, &armctrl_chip,
-				handle_level_irq);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-		}
-	}
+static void bmc2835_unmask_irq(struct irq_data *d)
+{
+	void __iomem *ioreg = ctrlr.enable[HWIRQ_BANK(d->hwirq)];
+	u32 bit = HWIRQ_BIT(d->hwirq);
 
-	set_handle_irq(bcm2835_handle_irq);
-	return 0;
+	writel_relaxed(bit, ioreg);
 }
 
-/*
- * Handle each interrupt across the entire interrupt controller.  This reads the
- * status register before handling each interrupt, which is necessary given that
- * handle_IRQ may briefly re-enable interrupts for soft IRQ handling.
- */
+static struct irq_chip bmc2835_chip = {
+	.name = "bmc2835-level",
+	.irq_mask = bmc2835_mask_irq,
+	.irq_unmask = bmc2835_unmask_irq,
+};
 
-static void armctrl_handle_bank(int bank, struct pt_regs *regs)
-{
-	u32 stat, irq;
+/**
+ * bmc2835_dispatch_irq() - translate bank/bit to kernel IRQ and dispatch
+ * @bank:	Register bank (BASE, GPU1, or GPU2).
+ * @bits:	Pending interrupt status bits.
+ * @regs:	register pointer passed on to the handler.
+ *
+ * The bits passed are the full set of bits read from register.  Only the lowest
+ * order bit is translated and dispatched. Dispatching the other IRQs requires
+ * re-reading the register and calling this function again.
+ */
+static void __exception_irq_entry bmc2835_dispatch_irq(int bank, u32 bits,
+	struct pt_regs *regs) {
+	unsigned int irq = ctrlr.hwirq_xlat[MAKE_HWIRQ(bank, ffs(bits) - 1)];
 
-	while ((stat = readl_relaxed(intc.pending[bank]))) {
-		irq = MAKE_HWIRQ(bank, ffs(stat) - 1);
-		handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
+	if (irq == BAD_IRQ_NUM) {
+		BUG();
+		return;
 	}
-}
-
-static void armctrl_handle_shortcut(int bank, struct pt_regs *regs,
-	u32 stat)
-{
-	u32 irq = MAKE_HWIRQ(bank, shortcuts[ffs(stat >> SHORTCUT_SHIFT) - 1]);
-	handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
+	handle_IRQ(irq_linear_revmap(ctrlr.domain, irq), regs);
 }
 
 static asmlinkage void __exception_irq_entry bcm2835_handle_irq(
 	struct pt_regs *regs)
 {
-	u32 stat, irq;
-
-	while ((stat = readl_relaxed(intc.pending[0]) & BANK0_VALID_MASK)) {
-		if (stat & BANK0_HWIRQ_MASK) {
-			irq = MAKE_HWIRQ(0, ffs(stat & BANK0_HWIRQ_MASK) - 1);
-			handle_IRQ(irq_linear_revmap(intc.domain, irq), regs);
-		} else if (stat & SHORTCUT1_MASK) {
-			armctrl_handle_shortcut(1, regs, stat & SHORTCUT1_MASK);
-		} else if (stat & SHORTCUT2_MASK) {
-			armctrl_handle_shortcut(2, regs, stat & SHORTCUT2_MASK);
-		} else if (stat & BANK1_HWIRQ) {
-			armctrl_handle_bank(1, regs);
-		} else if (stat & BANK2_HWIRQ) {
-			armctrl_handle_bank(2, regs);
-		} else {
-			BUG();
+	u32 stat;
+
+	while ((stat = readl_relaxed(ctrlr.base_pend) & BASE_READABLE)) {
+		if (stat & BASE_IRQS) {
+			bmc2835_dispatch_irq(BASE_BANK, stat & BASE_IRQS, regs);
+			continue;
+		}
+		if (stat & BASE_GPU1) {
+			stat = readl_relaxed(ctrlr.gpu1_pend) & GPU1_IRQS;
+			if (stat)
+				bmc2835_dispatch_irq(GPU1_BANK, stat, regs);
+			continue;
 		}
+		if (stat & BASE_GPU2) {
+			stat = readl_relaxed(ctrlr.gpu2_pend) & GPU2_IRQS;
+			if (stat)
+				bmc2835_dispatch_irq(GPU2_BANK, stat, regs);
+			continue;
+		}
+		BUG();
 	}
 }
 
-IRQCHIP_DECLARE(bcm2835_armctrl_ic, "brcm,bcm2835-armctrl-ic", armctrl_of_init);
+/**
+ * int shortcut_xlat[] - normalisation of BASE pending register shortcut bits.
+ *
+ * Bits 10..20 of the BASE pending register are shortcuts.  For example, bit 19
+ * is the UART IRQ bit.  As an internal IRQ number, that would be 83.  Its
+ * canonical internal IRQ number is 57 (GPU1, bit 25).  When this array is
+ * copied into the appropriate subrange of ctrlr.hwirq_xlat, then
+ * ctrlr.hwirq_xlat[83] = 57.
+ */
+static int shortcut_xlat[] __initconst = {
+	MAKE_HWIRQ(GPU1_BANK,  7),
+	MAKE_HWIRQ(GPU1_BANK,  9),
+	MAKE_HWIRQ(GPU1_BANK, 10),
+	MAKE_HWIRQ(GPU1_BANK, 18),
+	MAKE_HWIRQ(GPU1_BANK, 19),
+	MAKE_HWIRQ(GPU2_BANK, 21),
+	MAKE_HWIRQ(GPU2_BANK, 22),
+	MAKE_HWIRQ(GPU2_BANK, 23),
+	MAKE_HWIRQ(GPU2_BANK, 24),
+	MAKE_HWIRQ(GPU2_BANK, 25),
+	MAKE_HWIRQ(GPU2_BANK, 30),
+};
+
+static int __init bmc2835_of_init(struct device_node *node,
+	struct device_node *parent)
+{
+	int i;
+
+	ctrlr.iobase = of_iomap(node, 0);
+	if (!ctrlr.iobase)
+		panic("%s: unable to map IC registers\n", node->full_name);
+	ctrlr.domain = irq_domain_add_linear(node, NR_CHIP_IRQS, &bmc2835_ops,
+		&ctrlr);
+	if (!ctrlr.domain)
+		panic("%s: unable to create IRQ domain\n", node->full_name);
+
+	ctrlr.base_pend = ctrlr.iobase + BASE_PEND_OFF;
+	ctrlr.gpu1_pend = ctrlr.iobase + GPU1_PEND_OFF;
+	ctrlr.gpu2_pend = ctrlr.iobase + GPU2_PEND_OFF;
+	for (i = 0; i != NR_BANKS; i++) {
+		ctrlr.enable[i] = ctrlr.iobase + reg_enable[i];
+		ctrlr.disable[i] = ctrlr.iobase + reg_disable[i];
+	}
+
+	for (i = 0; i != NR_CHIP_IRQS; i++)
+		ctrlr.hwirq_xlat[i] = i;
+	for (i = NR_CHIP_IRQS; i != BITS_PER_REG * NR_BANKS; i++)
+		ctrlr.hwirq_xlat[i] = BAD_IRQ_NUM;
+	for (i = 0; i != ARRAY_SIZE(shortcut_xlat); i++)
+		ctrlr.hwirq_xlat[i + NR_CHIP_IRQS + 2] = shortcut_xlat[i];
+
+	for (i = 0; i != NR_CHIP_IRQS; i++) {
+		int irq = irq_create_mapping(ctrlr.domain, i);
+
+		BUG_ON(irq <= 0);
+		irq_set_chip_and_handler(irq, &bmc2835_chip, handle_level_irq);
+		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	}
+
+	set_handle_irq(bcm2835_handle_irq);
+	return 0;
+}
+
+IRQCHIP_DECLARE(bcm2835_armctrl_ic, "brcm,bcm2835-armctrl-ic", bmc2835_of_init);
-- 
1.8.3.1
