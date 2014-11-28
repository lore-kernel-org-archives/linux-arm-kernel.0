From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 28 Nov 2014 17:26:45 +0000
Subject: [PATCH 1/9] ARM: tegra: irq: fix buggy usage of irq_data irq field
In-Reply-To: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
References: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417195613-8447-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The crazy gic_arch_extn thing that Tegra uses contains multiple
references to the irq field in struct irq_data, and uses this
to directly poke hardware register.

But irq is the *virtual* irq number, something that has nothing
to do with the actual HW irq (stored in the hwirq field). And once
we put the stacked domain code in action, the whole thing explodes,
as these two values are *very* different:

root at bacon-fat:~# cat /proc/interrupts
            CPU0       CPU1
 16:      25801       2075       GIC  29  twd
 17:          0          0       GIC  73  timer0
112:          0          0      GPIO  58  c8000600.sdhci cd
123:          0          0      GPIO  69  c8000200.sdhci cd
279:       1126          0       GIC 122  serial
281:          0          0       GIC  70  7000c000.i2c
282:          0          0       GIC 116  7000c400.i2c
283:          0          0       GIC 124  7000c500.i2c
284:        300          0       GIC  85  7000d000.i2c
[...]

Just replacing all instances of irq with hwirq fixes the issue.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/irq.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index da7be13..ab95f53 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -99,42 +99,42 @@ static inline void tegra_irq_write_mask(unsigned int irq, unsigned long reg)
 
 static void tegra_mask(struct irq_data *d)
 {
-	if (d->irq < FIRST_LEGACY_IRQ)
+	if (d->hwirq < FIRST_LEGACY_IRQ)
 		return;
 
-	tegra_irq_write_mask(d->irq, ICTLR_CPU_IER_CLR);
+	tegra_irq_write_mask(d->hwirq, ICTLR_CPU_IER_CLR);
 }
 
 static void tegra_unmask(struct irq_data *d)
 {
-	if (d->irq < FIRST_LEGACY_IRQ)
+	if (d->hwirq < FIRST_LEGACY_IRQ)
 		return;
 
-	tegra_irq_write_mask(d->irq, ICTLR_CPU_IER_SET);
+	tegra_irq_write_mask(d->hwirq, ICTLR_CPU_IER_SET);
 }
 
 static void tegra_ack(struct irq_data *d)
 {
-	if (d->irq < FIRST_LEGACY_IRQ)
+	if (d->hwirq < FIRST_LEGACY_IRQ)
 		return;
 
-	tegra_irq_write_mask(d->irq, ICTLR_CPU_IEP_FIR_CLR);
+	tegra_irq_write_mask(d->hwirq, ICTLR_CPU_IEP_FIR_CLR);
 }
 
 static void tegra_eoi(struct irq_data *d)
 {
-	if (d->irq < FIRST_LEGACY_IRQ)
+	if (d->hwirq < FIRST_LEGACY_IRQ)
 		return;
 
-	tegra_irq_write_mask(d->irq, ICTLR_CPU_IEP_FIR_CLR);
+	tegra_irq_write_mask(d->hwirq, ICTLR_CPU_IEP_FIR_CLR);
 }
 
 static int tegra_retrigger(struct irq_data *d)
 {
-	if (d->irq < FIRST_LEGACY_IRQ)
+	if (d->hwirq < FIRST_LEGACY_IRQ)
 		return 0;
 
-	tegra_irq_write_mask(d->irq, ICTLR_CPU_IEP_FIR_SET);
+	tegra_irq_write_mask(d->hwirq, ICTLR_CPU_IEP_FIR_SET);
 
 	return 1;
 }
@@ -142,7 +142,7 @@ static int tegra_retrigger(struct irq_data *d)
 #ifdef CONFIG_PM_SLEEP
 static int tegra_set_wake(struct irq_data *d, unsigned int enable)
 {
-	u32 irq = d->irq;
+	u32 irq = d->hwirq;
 	u32 index, mask;
 
 	if (irq < FIRST_LEGACY_IRQ ||
-- 
2.1.3
