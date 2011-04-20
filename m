From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Apr 2011 11:58:24 +0100
Subject: [PATCH] ARM: tegra: consolidate GIC extension usage
Message-ID: <1303297104-18887-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra uses its own GIC extension mechanism to drive another interrupt
controller, used as a wake-up source.

Move this functionality to the recently introduced gic_arch_extn.
Adding an eoi method also ensures that the knowledge of the interrupt
flow control is removed from the Tegra code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Colin Cross <ccross@google.com>
---
 arch/arm/mach-tegra/irq.c |   44 +++++++++++---------------------------------
 1 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 4330d89..30b7313 100644
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
@@ -103,20 +99,22 @@ void tegra_set_lp0_wake_pads(u32 wake_enb, u32 wake_level, u32 wake_any)
 
 static void tegra_mask(struct irq_data *d)
 {
-	tegra_gic_mask_irq(d);
 	tegra_legacy_mask_irq(d->irq);
 }
 
 static void tegra_unmask(struct irq_data *d)
 {
-	tegra_gic_unmask_irq(d);
 	tegra_legacy_unmask_irq(d->irq);
 }
 
 static void tegra_ack(struct irq_data *d)
 {
 	tegra_legacy_force_irq_clr(d->irq);
-	tegra_gic_ack_irq(d);
+}
+
+static void tegra_eoi(struct irq_data *d)
+{
+	tegra_legacy_force_irq_clr(d->irq);
 }
 
 static int tegra_retrigger(struct irq_data *d)
@@ -125,36 +123,16 @@ static int tegra_retrigger(struct irq_data *d)
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
 
+	gic_arch_extn.irq_eoi		= tegra_eoi;
+	gic_arch_extn.irq_ack		= tegra_ack;
+	gic_arch_extn.irq_mask		= tegra_mask;
+	gic_arch_extn.irq_unmask	= tegra_unmask;
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
-- 
1.7.0.4
