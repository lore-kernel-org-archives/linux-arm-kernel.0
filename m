From: geoff@infradead.org (Geoff Levand)
Date: Mon, 28 Jul 2014 15:55:59 -0700
Subject: [PATCH] arm64: Fix UP build warning in gic-v3
Message-ID: <1406588159.28348.41.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The static routines gic_write_sgi1r() and gic_peek_irq() are only used for SMP
builds, so move those two routines to within the defined(CONFIG_SMP)
preprocessor conditional.

Fixes build warnings like these when CONFIG_SMP=n:

  drivers/irqchip/irq-gic-v3.c: warning: ?gic_write_sgi1r? defined but not used
  drivers/irqchip/irq-gic-v3.c: warning: ?gic_peek_irq? defined but not used

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi Marc,

I'm not sure if this has gone upstream yet, but I get these warnings
with Catalin's current arm64/for-next/core branch.

Feel free to just fold this into your gic-v3 patch if you'll be sending out
a new version.

-Geoff

 drivers/irqchip/irq-gic-v3.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 57eaa5a..e9ee18a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -129,11 +129,6 @@ static void gic_write_grpen1(u64 val)
 	isb();
 }
 
-static void gic_write_sgi1r(u64 val)
-{
-	asm volatile("msr_s " __stringify(ICC_SGI1R_EL1) ", %0" : : "r" (val));
-}
-
 static void gic_enable_sre(void)
 {
 	u64 val;
@@ -200,19 +195,6 @@ static void gic_poke_irq(struct irq_data *d, u32 offset)
 	rwp_wait();
 }
 
-static int gic_peek_irq(struct irq_data *d, u32 offset)
-{
-	u32 mask = 1 << (gic_irq(d) % 32);
-	void __iomem *base;
-
-	if (gic_irq_in_rdist(d))
-		base = gic_data_rdist_sgi_base();
-	else
-		base = gic_data.dist_base;
-
-	return !!(readl_relaxed(base + offset + (gic_irq(d) / 32) * 4) & mask);
-}
-
 static void gic_mask_irq(struct irq_data *d)
 {
 	gic_poke_irq(d, GICD_ICENABLER);
@@ -401,6 +383,24 @@ static void gic_cpu_init(void)
 }
 
 #ifdef CONFIG_SMP
+static void gic_write_sgi1r(u64 val)
+{
+	asm volatile("msr_s " __stringify(ICC_SGI1R_EL1) ", %0" : : "r" (val));
+}
+
+static int gic_peek_irq(struct irq_data *d, u32 offset)
+{
+	u32 mask = 1 << (gic_irq(d) % 32);
+	void __iomem *base;
+
+	if (gic_irq_in_rdist(d))
+		base = gic_data_rdist_sgi_base();
+	else
+		base = gic_data.dist_base;
+
+	return !!(readl_relaxed(base + offset + (gic_irq(d) / 32) * 4) & mask);
+}
+
 static int gic_secondary_init(struct notifier_block *nfb,
 			      unsigned long action, void *hcpu)
 {
-- 
1.9.1
