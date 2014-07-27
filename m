From: broonie@kernel.org (Mark Brown)
Date: Sun, 27 Jul 2014 17:57:04 +0100
Subject: [PATCH] irqchip: gic-v3: Only define gic_peek_irq() when building SMP
Message-ID: <1406480224-24628-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

If building with CONFIG_SMP disbled (for example, with allnoconfig) then
GCC complains that the static function gic_peek_irq() is defined but not
used since the only reference is in the SMP initialisation code. Fix this
by moving the function definition inside the ifdef.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 81519bae0453..30130f955151 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -200,19 +200,6 @@ static void gic_poke_irq(struct irq_data *d, u32 offset)
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
@@ -401,6 +388,19 @@ static void gic_cpu_init(void)
 }
 
 #ifdef CONFIG_SMP
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
2.0.1
