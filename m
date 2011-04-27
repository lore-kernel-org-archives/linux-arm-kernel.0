From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Apr 2011 12:44:54 +0100
Subject: [PATCH] ARM: tegra: consolidate GIC extension usage
In-Reply-To: <20110427083657.GI17290@n2100.arm.linux.org.uk>
References: <1303297104-18887-1-git-send-email-marc.zyngier@arm.com>
	<20110427083657.GI17290@n2100.arm.linux.org.uk>
Message-ID: <20110427124454.31470c8f@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Apr 2011 09:36:57 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Apr 20, 2011 at 11:58:24AM +0100, Marc Zyngier wrote:
> 
> A good follow-on step would be...
> 
> >  static void tegra_mask(struct irq_data *d)
> >  {
> > -	tegra_gic_mask_irq(d);
> >  	tegra_legacy_mask_irq(d->irq);
> >  }
> 
> ... arranging tegra_legacy_mask_irq() etc to take struct irq_data directly.
> These functions could then be removed entirely as they serve no useful
> purpose other than transforming the new API back to the old API.

How about the following patch? I haven't touched the gic_arch_extn part
as it would break Will's fastEOI patch set (which depends on this one),
but will prepare another patch cleaning up that part.

>From e11dc836ed12dd952b8152101e8417eb1de2ddc3 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Wed, 20 Apr 2011 11:58:24 +0100
Subject: [PATCH] ARM: tegra: consolidate GIC extension usage

Tegra uses its own GIC extension mechanism to drive another interrupt
controller, used as a wake-up source.

Move this functionality to the recently introduced gic_arch_extn.
Adding an eoi method also ensures that the knowledge of the interrupt
flow control is removed from the Tegra code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Colin Cross <ccross@google.com>
---
 arch/arm/mach-tegra/include/mach/legacy_irq.h |   16 ++++----
 arch/arm/mach-tegra/irq.c                     |   56 +++---------------------
 arch/arm/mach-tegra/legacy_irq.c              |   22 +++++++---
 3 files changed, 30 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/legacy_irq.h b/arch/arm/mach-tegra/include/mach/legacy_irq.h
index d898c0e..0f6a6a6 100644
--- a/arch/arm/mach-tegra/include/mach/legacy_irq.h
+++ b/arch/arm/mach-tegra/include/mach/legacy_irq.h
@@ -18,16 +18,16 @@
 #ifndef _ARCH_ARM_MACH_TEGRA_LEGARY_IRQ_H
 #define _ARCH_ARM_MACH_TEGRA_LEGARY_IRQ_H
 
-void tegra_legacy_mask_irq(unsigned int irq);
-void tegra_legacy_unmask_irq(unsigned int irq);
-void tegra_legacy_select_fiq(unsigned int irq, bool fiq);
-void tegra_legacy_force_irq_set(unsigned int irq);
-void tegra_legacy_force_irq_clr(unsigned int irq);
-int tegra_legacy_force_irq_status(unsigned int irq);
-void tegra_legacy_select_fiq(unsigned int irq, bool fiq);
+void tegra_legacy_mask_irq(struct irq_data *d);
+void tegra_legacy_unmask_irq(struct irq_data *d);
+void tegra_legacy_select_fiq(struct irq_data *d, bool fiq);
+void tegra_legacy_force_irq_set(struct irq_data *d);
+void tegra_legacy_force_irq_clr(struct irq_data *d);
+int tegra_legacy_force_irq_status(struct irq_data *d);
+void tegra_legacy_select_fiq(struct irq_data *d, bool fiq);
 unsigned long tegra_legacy_vfiq(int nr);
 unsigned long tegra_legacy_class(int nr);
-int tegra_legacy_irq_set_wake(int irq, int enable);
+int tegra_legacy_irq_set_wake(struct irq_data *d, int enable);
 void tegra_legacy_irq_set_lp1_wake_mask(void);
 void tegra_legacy_irq_restore_mask(void);
 void tegra_init_legacy_irq(void);
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 4330d89..e40cfb8 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -46,10 +46,6 @@ static u32 tegra_lp0_wake_enb;
 static u32 tegra_lp0_wake_level;
 static u32 tegra_lp0_wake_level_any;
 
-static void (*tegra_gic_mask_irq)(struct irq_data *d);
-static void (*tegra_gic_unmask_irq)(struct irq_data *d);
-static void (*tegra_gic_ack_irq)(struct irq_data *d);
-
 /* ensures that sufficient time is passed for a register write to
  * serialize into the 32KHz domain */
 static void pmc_32kwritel(u32 val, unsigned long offs)
@@ -101,60 +97,22 @@ void tegra_set_lp0_wake_pads(u32 wake_enb, u32 wake_level, u32 wake_any)
 	writel(wake_enb, pmc + PMC_WAKE_MASK);
 }
 
-static void tegra_mask(struct irq_data *d)
-{
-	tegra_gic_mask_irq(d);
-	tegra_legacy_mask_irq(d->irq);
-}
-
-static void tegra_unmask(struct irq_data *d)
-{
-	tegra_gic_unmask_irq(d);
-	tegra_legacy_unmask_irq(d->irq);
-}
-
-static void tegra_ack(struct irq_data *d)
-{
-	tegra_legacy_force_irq_clr(d->irq);
-	tegra_gic_ack_irq(d);
-}
-
 static int tegra_retrigger(struct irq_data *d)
 {
-	tegra_legacy_force_irq_set(d->irq);
+	tegra_legacy_force_irq_set(d);
 	return 1;
 }
 
-static struct irq_chip tegra_irq = {
-	.name			= "PPI",
-	.irq_ack		= tegra_ack,
-	.irq_mask		= tegra_mask,
-	.irq_unmask		= tegra_unmask,
-	.irq_retrigger		= tegra_retrigger,
-};
-
 void __init tegra_init_irq(void)
 {
-	struct irq_chip *gic;
-	unsigned int i;
-	int irq;
-
 	tegra_init_legacy_irq();
 
+	gic_arch_extn.irq_eoi		= tegra_legacy_force_irq_clr;
+	gic_arch_extn.irq_ack		= tegra_legacy_force_irq_clr;
+	gic_arch_extn.irq_mask		= tegra_legacy_mask_irq;
+	gic_arch_extn.irq_unmask	= tegra_legacy_unmask_irq;
+	gic_arch_extn.irq_retrigger	= tegra_retrigger;
+
 	gic_init(0, 29, IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE),
 		 IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
-
-	gic = irq_get_chip(29);
-	tegra_gic_unmask_irq = gic->irq_unmask;
-	tegra_gic_mask_irq = gic->irq_mask;
-	tegra_gic_ack_irq = gic->irq_ack;
-#ifdef CONFIG_SMP
-	tegra_irq.irq_set_affinity = gic->irq_set_affinity;
-#endif
-
-	for (i = 0; i < INT_MAIN_NR; i++) {
-		irq = INT_PRI_BASE + i;
-		irq_set_chip_and_handler(irq, &tegra_irq, handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID);
-	}
 }
diff --git a/arch/arm/mach-tegra/legacy_irq.c b/arch/arm/mach-tegra/legacy_irq.c
index 38eb719..6aee681 100644
--- a/arch/arm/mach-tegra/legacy_irq.c
+++ b/arch/arm/mach-tegra/legacy_irq.c
@@ -17,6 +17,7 @@
 
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/irq.h>
 #include <mach/iomap.h>
 #include <mach/irqs.h>
 #include <mach/legacy_irq.h>
@@ -55,8 +56,9 @@ static u32 tegra_legacy_saved_mask[4];
 /* When going into deep sleep, the CPU is powered down, taking the GIC with it
    In order to wake, the wake interrupts need to be enabled in the legacy
    interrupt controller. */
-void tegra_legacy_unmask_irq(unsigned int irq)
+void tegra_legacy_unmask_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
 	void __iomem *base;
 	pr_debug("%s: %d\n", __func__, irq);
 
@@ -65,8 +67,9 @@ void tegra_legacy_unmask_irq(unsigned int irq)
 	writel(1 << (irq & 31), base + ICTLR_CPU_IER_SET);
 }
 
-void tegra_legacy_mask_irq(unsigned int irq)
+void tegra_legacy_mask_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
 	void __iomem *base;
 	pr_debug("%s: %d\n", __func__, irq);
 
@@ -75,8 +78,9 @@ void tegra_legacy_mask_irq(unsigned int irq)
 	writel(1 << (irq & 31), base + ICTLR_CPU_IER_CLR);
 }
 
-void tegra_legacy_force_irq_set(unsigned int irq)
+void tegra_legacy_force_irq_set(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
 	void __iomem *base;
 	pr_debug("%s: %d\n", __func__, irq);
 
@@ -85,8 +89,9 @@ void tegra_legacy_force_irq_set(unsigned int irq)
 	writel(1 << (irq & 31), base + ICTLR_CPU_IEP_FIR_SET);
 }
 
-void tegra_legacy_force_irq_clr(unsigned int irq)
+void tegra_legacy_force_irq_clr(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
 	void __iomem *base;
 	pr_debug("%s: %d\n", __func__, irq);
 
@@ -95,8 +100,9 @@ void tegra_legacy_force_irq_clr(unsigned int irq)
 	writel(1 << (irq & 31), base + ICTLR_CPU_IEP_FIR_CLR);
 }
 
-int tegra_legacy_force_irq_status(unsigned int irq)
+int tegra_legacy_force_irq_status(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
 	void __iomem *base;
 	pr_debug("%s: %d\n", __func__, irq);
 
@@ -105,8 +111,9 @@ int tegra_legacy_force_irq_status(unsigned int irq)
 	return !!(readl(base + ICTLR_CPU_IEP_FIR) & (1 << (irq & 31)));
 }
 
-void tegra_legacy_select_fiq(unsigned int irq, bool fiq)
+void tegra_legacy_select_fiq(struct irq_data *d, bool fiq)
 {
+	unsigned int irq = d->irq;
 	void __iomem *base;
 	pr_debug("%s: %d\n", __func__, irq);
 
@@ -129,8 +136,9 @@ unsigned long tegra_legacy_class(int nr)
 	return readl(base + ICTLR_CPU_IEP_CLASS);
 }
 
-int tegra_legacy_irq_set_wake(int irq, int enable)
+int tegra_legacy_irq_set_wake(struct irq_data *d, int enable)
 {
+	unsigned int irq = d->irq;
 	irq -= 32;
 	if (enable)
 		tegra_legacy_wake_mask[irq >> 5] |= 1 << (irq & 31);
-- 
1.7.4.5


-- 
I'm the slime oozin' out from your TV set...
