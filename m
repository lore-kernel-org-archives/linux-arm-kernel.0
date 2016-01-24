From: johannes@sipsolutions.net (Johannes Berg)
Date: Sun, 24 Jan 2016 17:02:25 +0100
Subject: [PATCH 1/2] arm/mach-imx: use endian-safe readl/readw/writel/writew
Message-ID: <1453651346-12760-1-git-send-email-johannes@sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of __raw_*, use *_relaxed. The conversion was done
using the following spatch (since that automatically adjusts
the coding style unlike a simple search&replace).

@@
expression E1, E2;
@@
-__raw_writel(E1, E2)
+writel_relaxed(E1, E2)
@@
expression E1, E2;
@@
-__raw_writew(E1, E2)
+writew_relaxed(E1, E2)
@@
expression E1;
@@
-__raw_readl(E1)
+readl_relaxed(E1)
@@
expression E1;
@@
-__raw_readw(E1)
+readw_relaxed(E1)

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 arch/arm/mach-imx/3ds_debugboard.c    | 30 +++++++++++++++---------------
 arch/arm/mach-imx/avic.c              | 32 +++++++++++++++++---------------
 arch/arm/mach-imx/cpu-imx27.c         |  3 +--
 arch/arm/mach-imx/cpu-imx31.c         |  2 +-
 arch/arm/mach-imx/cpu-imx35.c         |  2 +-
 arch/arm/mach-imx/cpu.c               | 16 ++++++++--------
 arch/arm/mach-imx/epit.c              | 22 +++++++++++-----------
 arch/arm/mach-imx/iomux-imx31.c       | 12 ++++++------
 arch/arm/mach-imx/iomux-v1.c          |  4 ++--
 arch/arm/mach-imx/iomux-v3.c          |  6 +++---
 arch/arm/mach-imx/mach-armadillo5x0.c |  4 ++--
 arch/arm/mach-imx/mach-imx51.c        |  6 +++---
 arch/arm/mach-imx/mach-mx27ads.c      |  6 +++---
 arch/arm/mach-imx/mach-mx31ads.c      | 16 ++++++++--------
 arch/arm/mach-imx/mach-mx31moboard.c  |  2 +-
 arch/arm/mach-imx/mach-qong.c         |  6 +++---
 arch/arm/mach-imx/pm-imx27.c          |  4 ++--
 arch/arm/mach-imx/pm-imx3.c           |  4 ++--
 arch/arm/mach-imx/pm-imx5.c           | 26 +++++++++++++-------------
 arch/arm/mach-imx/system.c            |  6 +++---
 arch/arm/mach-imx/tzic.c              | 34 +++++++++++++++++-----------------
 21 files changed, 122 insertions(+), 121 deletions(-)

diff --git a/arch/arm/mach-imx/3ds_debugboard.c b/arch/arm/mach-imx/3ds_debugboard.c
index 16496a071ecb..abe2cc07ac1b 100644
--- a/arch/arm/mach-imx/3ds_debugboard.c
+++ b/arch/arm/mach-imx/3ds_debugboard.c
@@ -94,8 +94,8 @@ static void mxc_expio_irq_handler(struct irq_desc *desc)
 	/* irq = gpio irq number */
 	desc->irq_data.chip->irq_mask(&desc->irq_data);
 
-	imr_val = __raw_readw(brd_io + INTR_MASK_REG);
-	int_valid = __raw_readw(brd_io + INTR_STATUS_REG) & ~imr_val;
+	imr_val = readw_relaxed(brd_io + INTR_MASK_REG);
+	int_valid = readw_relaxed(brd_io + INTR_STATUS_REG) & ~imr_val;
 
 	expio_irq = 0;
 	for (; int_valid != 0; int_valid >>= 1, expio_irq++) {
@@ -117,17 +117,17 @@ static void expio_mask_irq(struct irq_data *d)
 	u16 reg;
 	u32 expio = d->hwirq;
 
-	reg = __raw_readw(brd_io + INTR_MASK_REG);
+	reg = readw_relaxed(brd_io + INTR_MASK_REG);
 	reg |= (1 << expio);
-	__raw_writew(reg, brd_io + INTR_MASK_REG);
+	writew_relaxed(reg, brd_io + INTR_MASK_REG);
 }
 
 static void expio_ack_irq(struct irq_data *d)
 {
 	u32 expio = d->hwirq;
 
-	__raw_writew(1 << expio, brd_io + INTR_RESET_REG);
-	__raw_writew(0, brd_io + INTR_RESET_REG);
+	writew_relaxed(1 << expio, brd_io + INTR_RESET_REG);
+	writew_relaxed(0, brd_io + INTR_RESET_REG);
 	expio_mask_irq(d);
 }
 
@@ -136,9 +136,9 @@ static void expio_unmask_irq(struct irq_data *d)
 	u16 reg;
 	u32 expio = d->hwirq;
 
-	reg = __raw_readw(brd_io + INTR_MASK_REG);
+	reg = readw_relaxed(brd_io + INTR_MASK_REG);
 	reg &= ~(1 << expio);
-	__raw_writew(reg, brd_io + INTR_MASK_REG);
+	writew_relaxed(reg, brd_io + INTR_MASK_REG);
 }
 
 static struct irq_chip expio_irq_chip = {
@@ -162,9 +162,9 @@ int __init mxc_expio_init(u32 base, u32 intr_gpio)
 	if (brd_io == NULL)
 		return -ENOMEM;
 
-	if ((__raw_readw(brd_io + MAGIC_NUMBER1_REG) != 0xAAAA) ||
-	    (__raw_readw(brd_io + MAGIC_NUMBER2_REG) != 0x5555) ||
-	    (__raw_readw(brd_io + MAGIC_NUMBER3_REG) != 0xCAFE)) {
+	if ((readw_relaxed(brd_io + MAGIC_NUMBER1_REG) != 0xAAAA) ||
+	    (readw_relaxed(brd_io + MAGIC_NUMBER2_REG) != 0x5555) ||
+	    (readw_relaxed(brd_io + MAGIC_NUMBER3_REG) != 0xCAFE)) {
 		pr_info("3-Stack Debug board not detected\n");
 		iounmap(brd_io);
 		brd_io = NULL;
@@ -181,10 +181,10 @@ int __init mxc_expio_init(u32 base, u32 intr_gpio)
 	gpio_direction_input(intr_gpio);
 
 	/* disable the interrupt and clear the status */
-	__raw_writew(0, brd_io + INTR_MASK_REG);
-	__raw_writew(0xFFFF, brd_io + INTR_RESET_REG);
-	__raw_writew(0, brd_io + INTR_RESET_REG);
-	__raw_writew(0x1F, brd_io + INTR_MASK_REG);
+	writew_relaxed(0, brd_io + INTR_MASK_REG);
+	writew_relaxed(0xFFFF, brd_io + INTR_RESET_REG);
+	writew_relaxed(0, brd_io + INTR_RESET_REG);
+	writew_relaxed(0x1F, brd_io + INTR_MASK_REG);
 
 	irq_base = irq_alloc_descs(-1, 0, MXC_MAX_EXP_IO_LINES, numa_node_id());
 	WARN_ON(irq_base < 0);
diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 1a8932335b21..59bf1d9a4811 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -66,12 +66,14 @@ static int avic_set_irq_fiq(unsigned int irq, unsigned int type)
 		return -EINVAL;
 
 	if (irq < AVIC_NUM_IRQS / 2) {
-		irqt = __raw_readl(avic_base + AVIC_INTTYPEL) & ~(1 << irq);
-		__raw_writel(irqt | (!!type << irq), avic_base + AVIC_INTTYPEL);
+		irqt = readl_relaxed(avic_base + AVIC_INTTYPEL) & ~(1 << irq);
+		writel_relaxed(irqt | (!!type << irq),
+			       avic_base + AVIC_INTTYPEL);
 	} else {
 		irq -= AVIC_NUM_IRQS / 2;
-		irqt = __raw_readl(avic_base + AVIC_INTTYPEH) & ~(1 << irq);
-		__raw_writel(irqt | (!!type << irq), avic_base + AVIC_INTTYPEH);
+		irqt = readl_relaxed(avic_base + AVIC_INTTYPEH) & ~(1 << irq);
+		writel_relaxed(irqt | (!!type << irq),
+			       avic_base + AVIC_INTTYPEH);
 	}
 
 	return 0;
@@ -94,8 +96,8 @@ static void avic_irq_suspend(struct irq_data *d)
 	struct irq_chip_type *ct = gc->chip_types;
 	int idx = d->hwirq >> 5;
 
-	avic_saved_mask_reg[idx] = __raw_readl(avic_base + ct->regs.mask);
-	__raw_writel(gc->wake_active, avic_base + ct->regs.mask);
+	avic_saved_mask_reg[idx] = readl_relaxed(avic_base + ct->regs.mask);
+	writel_relaxed(gc->wake_active, avic_base + ct->regs.mask);
 }
 
 static void avic_irq_resume(struct irq_data *d)
@@ -104,7 +106,7 @@ static void avic_irq_resume(struct irq_data *d)
 	struct irq_chip_type *ct = gc->chip_types;
 	int idx = d->hwirq >> 5;
 
-	__raw_writel(avic_saved_mask_reg[idx], avic_base + ct->regs.mask);
+	writel_relaxed(avic_saved_mask_reg[idx], avic_base + ct->regs.mask);
 }
 
 #else
@@ -140,7 +142,7 @@ static void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
 	u32 nivector;
 
 	do {
-		nivector = __raw_readl(avic_base + AVIC_NIVECSR) >> 16;
+		nivector = readl_relaxed(avic_base + AVIC_NIVECSR) >> 16;
 		if (nivector == 0xffff)
 			break;
 
@@ -164,16 +166,16 @@ void __init mxc_init_irq(void __iomem *irqbase)
 	/* put the AVIC into the reset value with
 	 * all interrupts disabled
 	 */
-	__raw_writel(0, avic_base + AVIC_INTCNTL);
-	__raw_writel(0x1f, avic_base + AVIC_NIMASK);
+	writel_relaxed(0, avic_base + AVIC_INTCNTL);
+	writel_relaxed(0x1f, avic_base + AVIC_NIMASK);
 
 	/* disable all interrupts */
-	__raw_writel(0, avic_base + AVIC_INTENABLEH);
-	__raw_writel(0, avic_base + AVIC_INTENABLEL);
+	writel_relaxed(0, avic_base + AVIC_INTENABLEH);
+	writel_relaxed(0, avic_base + AVIC_INTENABLEL);
 
 	/* all IRQ no FIQ */
-	__raw_writel(0, avic_base + AVIC_INTTYPEH);
-	__raw_writel(0, avic_base + AVIC_INTTYPEL);
+	writel_relaxed(0, avic_base + AVIC_INTTYPEH);
+	writel_relaxed(0, avic_base + AVIC_INTTYPEL);
 
 	irq_base = irq_alloc_descs(-1, 0, AVIC_NUM_IRQS, numa_node_id());
 	WARN_ON(irq_base < 0);
@@ -188,7 +190,7 @@ void __init mxc_init_irq(void __iomem *irqbase)
 
 	/* Set default priority value (0) for all IRQ's */
 	for (i = 0; i < 8; i++)
-		__raw_writel(0, avic_base + AVIC_NIPRIORITY(i));
+		writel_relaxed(0, avic_base + AVIC_NIPRIORITY(i));
 
 	set_handle_irq(avic_handle_irq);
 
diff --git a/arch/arm/mach-imx/cpu-imx27.c b/arch/arm/mach-imx/cpu-imx27.c
index fe8d36f7e30e..095d965a58dd 100644
--- a/arch/arm/mach-imx/cpu-imx27.c
+++ b/arch/arm/mach-imx/cpu-imx27.c
@@ -39,8 +39,7 @@ static int mx27_read_cpu_rev(void)
 	 * the silicon revision very early we read it here to
 	 * avoid any further hooks
 	*/
-	val = __raw_readl(MX27_IO_ADDRESS(MX27_SYSCTRL_BASE_ADDR
-				+ SYS_CHIP_ID));
+	val = readl_relaxed(MX27_IO_ADDRESS(MX27_SYSCTRL_BASE_ADDR + SYS_CHIP_ID));
 
 	mx27_cpu_partnumber = (int)((val >> 12) & 0xFFFF);
 
diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
index fde1860a2521..c5c61846b8f3 100644
--- a/arch/arm/mach-imx/cpu-imx31.c
+++ b/arch/arm/mach-imx/cpu-imx31.c
@@ -39,7 +39,7 @@ static int mx31_read_cpu_rev(void)
 	u32 i, srev;
 
 	/* read SREV register from IIM module */
-	srev = __raw_readl(MX31_IO_ADDRESS(MX31_IIM_BASE_ADDR + MXC_IIMSREV));
+	srev = readl_relaxed(MX31_IO_ADDRESS(MX31_IIM_BASE_ADDR + MXC_IIMSREV));
 	srev &= 0xff;
 
 	for (i = 0; i < ARRAY_SIZE(mx31_cpu_type); i++)
diff --git a/arch/arm/mach-imx/cpu-imx35.c b/arch/arm/mach-imx/cpu-imx35.c
index ec3aaa098c17..54fc8b7294d1 100644
--- a/arch/arm/mach-imx/cpu-imx35.c
+++ b/arch/arm/mach-imx/cpu-imx35.c
@@ -20,7 +20,7 @@ static int mx35_read_cpu_rev(void)
 {
 	u32 rev;
 
-	rev = __raw_readl(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR + MXC_IIMSREV));
+	rev = readl_relaxed(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR + MXC_IIMSREV));
 	switch (rev) {
 	case 0x00:
 		return IMX_CHIP_REVISION_1_0;
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 5b0f752d5507..579d6e34d5b9 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -45,20 +45,20 @@ void __init imx_set_aips(void __iomem *base)
  * Set all MPROTx to be non-bufferable, trusted for R/W,
  * not forced to user-mode.
  */
-	__raw_writel(0x77777777, base + 0x0);
-	__raw_writel(0x77777777, base + 0x4);
+	writel_relaxed(0x77777777, base + 0x0);
+	writel_relaxed(0x77777777, base + 0x4);
 
 /*
  * Set all OPACRx to be non-bufferable, to not require
  * supervisor privilege level for access, allow for
  * write access and untrusted master access.
  */
-	__raw_writel(0x0, base + 0x40);
-	__raw_writel(0x0, base + 0x44);
-	__raw_writel(0x0, base + 0x48);
-	__raw_writel(0x0, base + 0x4C);
-	reg = __raw_readl(base + 0x50) & 0x00FFFFFF;
-	__raw_writel(reg, base + 0x50);
+	writel_relaxed(0x0, base + 0x40);
+	writel_relaxed(0x0, base + 0x44);
+	writel_relaxed(0x0, base + 0x48);
+	writel_relaxed(0x0, base + 0x4C);
+	reg = readl_relaxed(base + 0x50) & 0x00FFFFFF;
+	writel_relaxed(reg, base + 0x50);
 }
 
 void __init imx_aips_allow_unprivileged_access(
diff --git a/arch/arm/mach-imx/epit.c b/arch/arm/mach-imx/epit.c
index 08ce20771bb3..125078789eb0 100644
--- a/arch/arm/mach-imx/epit.c
+++ b/arch/arm/mach-imx/epit.c
@@ -64,23 +64,23 @@ static inline void epit_irq_disable(void)
 {
 	u32 val;
 
-	val = __raw_readl(timer_base + EPITCR);
+	val = readl_relaxed(timer_base + EPITCR);
 	val &= ~EPITCR_OCIEN;
-	__raw_writel(val, timer_base + EPITCR);
+	writel_relaxed(val, timer_base + EPITCR);
 }
 
 static inline void epit_irq_enable(void)
 {
 	u32 val;
 
-	val = __raw_readl(timer_base + EPITCR);
+	val = readl_relaxed(timer_base + EPITCR);
 	val |= EPITCR_OCIEN;
-	__raw_writel(val, timer_base + EPITCR);
+	writel_relaxed(val, timer_base + EPITCR);
 }
 
 static void epit_irq_acknowledge(void)
 {
-	__raw_writel(EPITSR_OCIF, timer_base + EPITSR);
+	writel_relaxed(EPITSR_OCIF, timer_base + EPITSR);
 }
 
 static int __init epit_clocksource_init(struct clk *timer_clk)
@@ -98,9 +98,9 @@ static int epit_set_next_event(unsigned long evt,
 {
 	unsigned long tcmp;
 
-	tcmp = __raw_readl(timer_base + EPITCNR);
+	tcmp = readl_relaxed(timer_base + EPITCNR);
 
-	__raw_writel(tcmp - evt, timer_base + EPITCMPR);
+	writel_relaxed(tcmp - evt, timer_base + EPITCMPR);
 
 	return 0;
 }
@@ -213,11 +213,11 @@ void __init epit_timer_init(void __iomem *base, int irq)
 	/*
 	 * Initialise to a known state (all timers off, and timing reset)
 	 */
-	__raw_writel(0x0, timer_base + EPITCR);
+	writel_relaxed(0x0, timer_base + EPITCR);
 
-	__raw_writel(0xffffffff, timer_base + EPITLR);
-	__raw_writel(EPITCR_EN | EPITCR_CLKSRC_REF_HIGH | EPITCR_WAITEN,
-			timer_base + EPITCR);
+	writel_relaxed(0xffffffff, timer_base + EPITLR);
+	writel_relaxed(EPITCR_EN | EPITCR_CLKSRC_REF_HIGH | EPITCR_WAITEN,
+		       timer_base + EPITCR);
 
 	/* init and register the timer to the framework */
 	epit_clocksource_init(timer_clk);
diff --git a/arch/arm/mach-imx/iomux-imx31.c b/arch/arm/mach-imx/iomux-imx31.c
index 6dd22cabf4d3..93f0758c6abc 100644
--- a/arch/arm/mach-imx/iomux-imx31.c
+++ b/arch/arm/mach-imx/iomux-imx31.c
@@ -57,10 +57,10 @@ void mxc_iomux_mode(unsigned int pin_mode)
 
 	spin_lock(&gpio_mux_lock);
 
-	l = __raw_readl(reg);
+	l = readl_relaxed(reg);
 	l &= ~(0xff << (field * 8));
 	l |= mode << (field * 8);
-	__raw_writel(l, reg);
+	writel_relaxed(l, reg);
 
 	spin_unlock(&gpio_mux_lock);
 }
@@ -82,10 +82,10 @@ void mxc_iomux_set_pad(enum iomux_pins pin, u32 config)
 
 	spin_lock(&gpio_mux_lock);
 
-	l = __raw_readl(reg);
+	l = readl_relaxed(reg);
 	l &= ~(0x1ff << (field * 10));
 	l |= config << (field * 10);
-	__raw_writel(l, reg);
+	writel_relaxed(l, reg);
 
 	spin_unlock(&gpio_mux_lock);
 }
@@ -163,12 +163,12 @@ void mxc_iomux_set_gpr(enum iomux_gp_func gp, bool en)
 	u32 l;
 
 	spin_lock(&gpio_mux_lock);
-	l = __raw_readl(IOMUXGPR);
+	l = readl_relaxed(IOMUXGPR);
 	if (en)
 		l |= gp;
 	else
 		l &= ~gp;
 
-	__raw_writel(l, IOMUXGPR);
+	writel_relaxed(l, IOMUXGPR);
 	spin_unlock(&gpio_mux_lock);
 }
diff --git a/arch/arm/mach-imx/iomux-v1.c b/arch/arm/mach-imx/iomux-v1.c
index ecd543664644..b80141cfc89b 100644
--- a/arch/arm/mach-imx/iomux-v1.c
+++ b/arch/arm/mach-imx/iomux-v1.c
@@ -38,12 +38,12 @@ static unsigned imx_iomuxv1_numports;
 
 static inline unsigned long imx_iomuxv1_readl(unsigned offset)
 {
-	return __raw_readl(imx_iomuxv1_baseaddr + offset);
+	return readl_relaxed(imx_iomuxv1_baseaddr + offset);
 }
 
 static inline void imx_iomuxv1_writel(unsigned long val, unsigned offset)
 {
-	__raw_writel(val, imx_iomuxv1_baseaddr + offset);
+	writel_relaxed(val, imx_iomuxv1_baseaddr + offset);
 }
 
 static inline void imx_iomuxv1_rmwl(unsigned offset,
diff --git a/arch/arm/mach-imx/iomux-v3.c b/arch/arm/mach-imx/iomux-v3.c
index a53b2e64f98d..b08c01bf8002 100644
--- a/arch/arm/mach-imx/iomux-v3.c
+++ b/arch/arm/mach-imx/iomux-v3.c
@@ -45,13 +45,13 @@ int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t pad)
 	u32 pad_ctrl = (pad & MUX_PAD_CTRL_MASK) >> MUX_PAD_CTRL_SHIFT;
 
 	if (mux_ctrl_ofs)
-		__raw_writel(mux_mode, base + mux_ctrl_ofs);
+		writel_relaxed(mux_mode, base + mux_ctrl_ofs);
 
 	if (sel_input_ofs)
-		__raw_writel(sel_input, base + sel_input_ofs);
+		writel_relaxed(sel_input, base + sel_input_ofs);
 
 	if (!(pad_ctrl & NO_PAD_CTRL) && pad_ctrl_ofs)
-		__raw_writel(pad_ctrl, base + pad_ctrl_ofs);
+		writel_relaxed(pad_ctrl, base + pad_ctrl_ofs);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index f2060523ba48..b93479aeb568 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -525,8 +525,8 @@ static void __init armadillo5x0_init(void)
 	imx31_add_mxc_nand(&armadillo5x0_nand_board_info);
 
 	/* set NAND page size to 2k if not configured via boot mode pins */
-	__raw_writel(__raw_readl(mx3_ccm_base + MXC_CCM_RCSR) |
-					(1 << 30), mx3_ccm_base + MXC_CCM_RCSR);
+	writel_relaxed(readl_relaxed(mx3_ccm_base + MXC_CCM_RCSR) | (1 << 30),
+		       mx3_ccm_base + MXC_CCM_RCSR);
 
 	/* RTC */
 	/* Get RTC IRQ and register the chip */
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index b015129e4045..8d05778f21e9 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -40,11 +40,11 @@ static void __init imx51_ipu_mipi_setup(void)
 	WARN_ON(!hsc_addr);
 
 	/* setup MIPI module to legacy mode */
-	__raw_writel(0xf00, hsc_addr);
+	writel_relaxed(0xf00, hsc_addr);
 
 	/* CSI mode: reserved; DI control mode: legacy (from Freescale BSP) */
-	__raw_writel(__raw_readl(hsc_addr + 0x800) | 0x30ff,
-		hsc_addr + 0x800);
+	writel_relaxed(readl_relaxed(hsc_addr + 0x800) | 0x30ff,
+		       hsc_addr + 0x800);
 
 	iounmap(hsc_addr);
 }
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index eb1c3477c48a..8aaf70dcd8ee 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -202,9 +202,9 @@ static struct i2c_board_info mx27ads_i2c_devices[] = {
 static void vgpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	if (value)
-		__raw_writew(PBC_BCTRL1_LCDON, PBC_BCTRL1_SET_REG);
+		writew_relaxed(PBC_BCTRL1_LCDON, PBC_BCTRL1_SET_REG);
 	else
-		__raw_writew(PBC_BCTRL1_LCDON, PBC_BCTRL1_CLEAR_REG);
+		writew_relaxed(PBC_BCTRL1_LCDON, PBC_BCTRL1_CLEAR_REG);
 }
 
 static int vgpio_dir_out(struct gpio_chip *chip, unsigned offset, int value)
@@ -364,7 +364,7 @@ static void __init mx27ads_timer_init(void)
 {
 	unsigned long fref = 26000000;
 
-	if ((__raw_readw(PBC_VERSION_REG) & CKIH_27MHZ_BIT_SET) == 0)
+	if ((readw_relaxed(PBC_VERSION_REG) & CKIH_27MHZ_BIT_SET) == 0)
 		fref = 27000000;
 
 	mx27_clocks_init(fref);
diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index 2b147e4bf9c9..f8a5758eb673 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -160,8 +160,8 @@ static void mx31ads_expio_irq_handler(struct irq_desc *desc)
 	u32 int_valid;
 	u32 expio_irq;
 
-	imr_val = __raw_readw(PBC_INTMASK_SET_REG);
-	int_valid = __raw_readw(PBC_INTSTATUS_REG) & imr_val;
+	imr_val = readw_relaxed(PBC_INTMASK_SET_REG);
+	int_valid = readw_relaxed(PBC_INTSTATUS_REG) & imr_val;
 
 	expio_irq = 0;
 	for (; int_valid != 0; int_valid >>= 1, expio_irq++) {
@@ -180,8 +180,8 @@ static void expio_mask_irq(struct irq_data *d)
 {
 	u32 expio = d->hwirq;
 	/* mask the interrupt */
-	__raw_writew(1 << expio, PBC_INTMASK_CLEAR_REG);
-	__raw_readw(PBC_INTMASK_CLEAR_REG);
+	writew_relaxed(1 << expio, PBC_INTMASK_CLEAR_REG);
+	readw_relaxed(PBC_INTMASK_CLEAR_REG);
 }
 
 /*
@@ -192,7 +192,7 @@ static void expio_ack_irq(struct irq_data *d)
 {
 	u32 expio = d->hwirq;
 	/* clear the interrupt status */
-	__raw_writew(1 << expio, PBC_INTSTATUS_REG);
+	writew_relaxed(1 << expio, PBC_INTSTATUS_REG);
 }
 
 /*
@@ -203,7 +203,7 @@ static void expio_unmask_irq(struct irq_data *d)
 {
 	u32 expio = d->hwirq;
 	/* unmask the interrupt */
-	__raw_writew(1 << expio, PBC_INTMASK_SET_REG);
+	writew_relaxed(1 << expio, PBC_INTMASK_SET_REG);
 }
 
 static struct irq_chip expio_irq_chip = {
@@ -226,8 +226,8 @@ static void __init mx31ads_init_expio(void)
 	mxc_iomux_alloc_pin(IOMUX_MODE(MX31_PIN_GPIO1_4, IOMUX_CONFIG_GPIO), "expio");
 
 	/* disable the interrupt and clear the status */
-	__raw_writew(0xFFFF, PBC_INTMASK_CLEAR_REG);
-	__raw_writew(0xFFFF, PBC_INTSTATUS_REG);
+	writew_relaxed(0xFFFF, PBC_INTMASK_CLEAR_REG);
+	writew_relaxed(0xFFFF, PBC_INTSTATUS_REG);
 
 	irq_base = irq_alloc_descs(-1, 0, MXC_MAX_EXP_IO_LINES, numa_node_id());
 	WARN_ON(irq_base < 0);
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index bb6f8a52a6b8..c3d2b221ac19 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -509,7 +509,7 @@ static void mx31moboard_poweroff(void)
 
 	mxc_iomux_mode(MX31_PIN_WATCHDOG_RST__WATCHDOG_RST);
 
-	__raw_writew(1 << 6 | 1 << 2, MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
+	writew_relaxed(1 << 6 | 1 << 2, MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
 }
 
 static int mx31moboard_baseboard;
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index a213e7b9cb1c..c2a458da1920 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -190,9 +190,9 @@ static struct platform_device qong_nand_device = {
 static void __init qong_init_nand_mtd(void)
 {
 	/* init CS */
-	__raw_writel(0x00004f00, MX31_IO_ADDRESS(MX31_WEIM_CSCRxU(3)));
-	__raw_writel(0x20013b31, MX31_IO_ADDRESS(MX31_WEIM_CSCRxL(3)));
-	__raw_writel(0x00020800, MX31_IO_ADDRESS(MX31_WEIM_CSCRxA(3)));
+	writel_relaxed(0x00004f00, MX31_IO_ADDRESS(MX31_WEIM_CSCRxU(3)));
+	writel_relaxed(0x20013b31, MX31_IO_ADDRESS(MX31_WEIM_CSCRxL(3)));
+	writel_relaxed(0x00020800, MX31_IO_ADDRESS(MX31_WEIM_CSCRxA(3)));
 
 	mxc_iomux_set_gpr(MUX_SDCTL_CSD1_SEL, true);
 
diff --git a/arch/arm/mach-imx/pm-imx27.c b/arch/arm/mach-imx/pm-imx27.c
index 56d02d064fbf..54d269463ebf 100644
--- a/arch/arm/mach-imx/pm-imx27.c
+++ b/arch/arm/mach-imx/pm-imx27.c
@@ -19,9 +19,9 @@ static int mx27_suspend_enter(suspend_state_t state)
 	switch (state) {
 	case PM_SUSPEND_MEM:
 		/* Clear MPEN and SPEN to disable MPLL/SPLL */
-		cscr = __raw_readl(MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR));
+		cscr = readl_relaxed(MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR));
 		cscr &= 0xFFFFFFFC;
-		__raw_writel(cscr, MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR));
+		writel_relaxed(cscr, MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR));
 		/* Executes WFI */
 		cpu_do_idle();
 		break;
diff --git a/arch/arm/mach-imx/pm-imx3.c b/arch/arm/mach-imx/pm-imx3.c
index 6a07006ff0f4..2d8d24c42014 100644
--- a/arch/arm/mach-imx/pm-imx3.c
+++ b/arch/arm/mach-imx/pm-imx3.c
@@ -22,14 +22,14 @@
  */
 void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode)
 {
-	int reg = __raw_readl(mx3_ccm_base + MXC_CCM_CCMR);
+	int reg = readl_relaxed(mx3_ccm_base + MXC_CCM_CCMR);
 	reg &= ~MXC_CCM_CCMR_LPM_MASK;
 
 	switch (mode) {
 	case MX3_WAIT:
 		if (cpu_is_mx35())
 			reg |= MXC_CCM_CCMR_LPM_WAIT_MX35;
-		__raw_writel(reg, mx3_ccm_base + MXC_CCM_CCMR);
+		writel_relaxed(reg, mx3_ccm_base + MXC_CCM_CCMR);
 		break;
 	default:
 		pr_err("Unknown cpu power mode: %d\n", mode);
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index 532d4b08276d..843e2677126f 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -153,15 +153,15 @@ static void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
 	int stop_mode = 0;
 
 	/* always allow platform to issue a deep sleep mode request */
-	plat_lpc = __raw_readl(cortex_base + MXC_CORTEXA8_PLAT_LPC) &
+	plat_lpc = readl_relaxed(cortex_base + MXC_CORTEXA8_PLAT_LPC) &
 	    ~(MXC_CORTEXA8_PLAT_LPC_DSM);
-	ccm_clpcr = __raw_readl(ccm_base + MXC_CCM_CLPCR) &
+	ccm_clpcr = readl_relaxed(ccm_base + MXC_CCM_CLPCR) &
 		    ~(MXC_CCM_CLPCR_LPM_MASK);
-	arm_srpgcr = __raw_readl(gpc_base + MXC_SRPG_ARM_SRPGCR) &
+	arm_srpgcr = readl_relaxed(gpc_base + MXC_SRPG_ARM_SRPGCR) &
 		     ~(MXC_SRPGCR_PCR);
-	empgc0 = __raw_readl(gpc_base + MXC_SRPG_EMPGC0_SRPGCR) &
+	empgc0 = readl_relaxed(gpc_base + MXC_SRPG_EMPGC0_SRPGCR) &
 		 ~(MXC_SRPGCR_PCR);
-	empgc1 = __raw_readl(gpc_base + MXC_SRPG_EMPGC1_SRPGCR) &
+	empgc1 = readl_relaxed(gpc_base + MXC_SRPG_EMPGC1_SRPGCR) &
 		 ~(MXC_SRPGCR_PCR);
 
 	switch (mode) {
@@ -196,17 +196,17 @@ static void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
 		return;
 	}
 
-	__raw_writel(plat_lpc, cortex_base + MXC_CORTEXA8_PLAT_LPC);
-	__raw_writel(ccm_clpcr, ccm_base + MXC_CCM_CLPCR);
-	__raw_writel(arm_srpgcr, gpc_base + MXC_SRPG_ARM_SRPGCR);
-	__raw_writel(arm_srpgcr, gpc_base + MXC_SRPG_NEON_SRPGCR);
+	writel_relaxed(plat_lpc, cortex_base + MXC_CORTEXA8_PLAT_LPC);
+	writel_relaxed(ccm_clpcr, ccm_base + MXC_CCM_CLPCR);
+	writel_relaxed(arm_srpgcr, gpc_base + MXC_SRPG_ARM_SRPGCR);
+	writel_relaxed(arm_srpgcr, gpc_base + MXC_SRPG_NEON_SRPGCR);
 
 	if (stop_mode) {
 		empgc0 |= MXC_SRPGCR_PCR;
 		empgc1 |= MXC_SRPGCR_PCR;
 
-		__raw_writel(empgc0, gpc_base + MXC_SRPG_EMPGC0_SRPGCR);
-		__raw_writel(empgc1, gpc_base + MXC_SRPG_EMPGC1_SRPGCR);
+		writel_relaxed(empgc0, gpc_base + MXC_SRPG_EMPGC0_SRPGCR);
+		writel_relaxed(empgc1, gpc_base + MXC_SRPG_EMPGC1_SRPGCR);
 	}
 }
 
@@ -228,8 +228,8 @@ static int mx5_suspend_enter(suspend_state_t state)
 		flush_cache_all();
 
 		/*clear the EMPGC0/1 bits */
-		__raw_writel(0, gpc_base + MXC_SRPG_EMPGC0_SRPGCR);
-		__raw_writel(0, gpc_base + MXC_SRPG_EMPGC1_SRPGCR);
+		writel_relaxed(0, gpc_base + MXC_SRPG_EMPGC0_SRPGCR);
+		writel_relaxed(0, gpc_base + MXC_SRPG_EMPGC1_SRPGCR);
 
 		if (imx5_suspend_in_ocram_fn)
 			imx5_suspend_in_ocram_fn(suspend_ocram_base);
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 51c35013b673..d27e683e78c2 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -54,7 +54,7 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
 		wcr_enable = (1 << 2);
 
 	/* Assert SRS signal */
-	__raw_writew(wcr_enable, wdog_base);
+	writew_relaxed(wcr_enable, wdog_base);
 	/*
 	 * Due to imx6q errata ERR004346 (WDOG: WDOG SRS bit requires to be
 	 * written twice), we add another two writes to ensure there must be at
@@ -62,8 +62,8 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
 	 * the target check here, since the writes shouldn't be a huge burden
 	 * for other platforms.
 	 */
-	__raw_writew(wcr_enable, wdog_base);
-	__raw_writew(wcr_enable, wdog_base);
+	writew_relaxed(wcr_enable, wdog_base);
+	writew_relaxed(wcr_enable, wdog_base);
 
 	/* wait for reset to assert... */
 	mdelay(500);
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 4de65eeda1eb..b2f94586dc39 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -65,10 +65,10 @@ static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
 		return -EINVAL;
 	mask = 1U << (irq & 0x1F);
 
-	value = __raw_readl(tzic_base + TZIC_INTSEC0(index)) | mask;
+	value = readl_relaxed(tzic_base + TZIC_INTSEC0(index)) | mask;
 	if (type)
 		value &= ~mask;
-	__raw_writel(value, tzic_base + TZIC_INTSEC0(index));
+	writel_relaxed(value, tzic_base + TZIC_INTSEC0(index));
 
 	return 0;
 }
@@ -82,15 +82,15 @@ static void tzic_irq_suspend(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	int idx = d->hwirq >> 5;
 
-	__raw_writel(gc->wake_active, tzic_base + TZIC_WAKEUP0(idx));
+	writel_relaxed(gc->wake_active, tzic_base + TZIC_WAKEUP0(idx));
 }
 
 static void tzic_irq_resume(struct irq_data *d)
 {
 	int idx = d->hwirq >> 5;
 
-	__raw_writel(__raw_readl(tzic_base + TZIC_ENSET0(idx)),
-		     tzic_base + TZIC_WAKEUP0(idx));
+	writel_relaxed(readl_relaxed(tzic_base + TZIC_ENSET0(idx)),
+		       tzic_base + TZIC_WAKEUP0(idx));
 }
 
 #else
@@ -135,8 +135,8 @@ static void __exception_irq_entry tzic_handle_irq(struct pt_regs *regs)
 		handled = 0;
 
 		for (i = 0; i < 4; i++) {
-			stat = __raw_readl(tzic_base + TZIC_HIPND(i)) &
-				__raw_readl(tzic_base + TZIC_INTSEC0(i));
+			stat = readl_relaxed(tzic_base + TZIC_HIPND(i)) &
+				readl_relaxed(tzic_base + TZIC_INTSEC0(i));
 
 			while (stat) {
 				handled = 1;
@@ -166,18 +166,18 @@ void __init tzic_init_irq(void)
 	/* put the TZIC into the reset value with
 	 * all interrupts disabled
 	 */
-	i = __raw_readl(tzic_base + TZIC_INTCNTL);
+	i = readl_relaxed(tzic_base + TZIC_INTCNTL);
 
-	__raw_writel(0x80010001, tzic_base + TZIC_INTCNTL);
-	__raw_writel(0x1f, tzic_base + TZIC_PRIOMASK);
-	__raw_writel(0x02, tzic_base + TZIC_SYNCCTRL);
+	writel_relaxed(0x80010001, tzic_base + TZIC_INTCNTL);
+	writel_relaxed(0x1f, tzic_base + TZIC_PRIOMASK);
+	writel_relaxed(0x02, tzic_base + TZIC_SYNCCTRL);
 
 	for (i = 0; i < 4; i++)
-		__raw_writel(0xFFFFFFFF, tzic_base + TZIC_INTSEC0(i));
+		writel_relaxed(0xFFFFFFFF, tzic_base + TZIC_INTSEC0(i));
 
 	/* disable all interrupts */
 	for (i = 0; i < 4; i++)
-		__raw_writel(0xFFFFFFFF, tzic_base + TZIC_ENCLEAR0(i));
+		writel_relaxed(0xFFFFFFFF, tzic_base + TZIC_ENCLEAR0(i));
 
 	/* all IRQ no FIQ Warning :: No selection */
 
@@ -214,13 +214,13 @@ int tzic_enable_wake(void)
 {
 	unsigned int i;
 
-	__raw_writel(1, tzic_base + TZIC_DSMINT);
-	if (unlikely(__raw_readl(tzic_base + TZIC_DSMINT) == 0))
+	writel_relaxed(1, tzic_base + TZIC_DSMINT);
+	if (unlikely(readl_relaxed(tzic_base + TZIC_DSMINT) == 0))
 		return -EAGAIN;
 
 	for (i = 0; i < 4; i++)
-		__raw_writel(__raw_readl(tzic_base + TZIC_ENSET0(i)),
-			     tzic_base + TZIC_WAKEUP0(i));
+		writel_relaxed(readl_relaxed(tzic_base + TZIC_ENSET0(i)),
+			       tzic_base + TZIC_WAKEUP0(i));
 
 	return 0;
 }
-- 
2.6.2
