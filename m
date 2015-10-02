From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Oct 2015 17:37:51 +0100
Subject: [PATCH 2/5] irqchip/gic-v3: Make gic_enable_sre an inline function
In-Reply-To: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
References: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443803874-9566-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for gic_enable_sre to be used by the arm64 core code,
move it to arm-gic-v3.h. As a bonus, we now also check if
system registers have been already enabled, and return early
if they have.

In all cases, the function now returns a boolean indicating if
the enabling has been successful.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c       | 32 +++++++++-----------------------
 include/linux/irqchip/arm-gic-v3.h | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 36ecfc8..bfb93c32 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -139,27 +139,6 @@ static void __maybe_unused gic_write_sgi1r(u64 val)
 	asm volatile("msr_s " __stringify(ICC_SGI1R_EL1) ", %0" : : "r" (val));
 }
 
-static void gic_enable_sre(void)
-{
-	u64 val;
-
-	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
-	val |= ICC_SRE_EL1_SRE;
-	asm volatile("msr_s " __stringify(ICC_SRE_EL1) ", %0" : : "r" (val));
-	isb();
-
-	/*
-	 * Need to check that the SRE bit has actually been set. If
-	 * not, it means that SRE is disabled at EL2. We're going to
-	 * die painfully, and there is nothing we can do about it.
-	 *
-	 * Kindly inform the luser.
-	 */
-	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
-	if (!(val & ICC_SRE_EL1_SRE))
-		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
-}
-
 static void gic_enable_redist(bool enable)
 {
 	void __iomem *rbase;
@@ -493,8 +472,15 @@ static int gic_populate_rdist(void)
 
 static void gic_cpu_sys_reg_init(void)
 {
-	/* Enable system registers */
-	gic_enable_sre();
+	/*
+	 * Need to check that the SRE bit has actually been set. If
+	 * not, it means that SRE is disabled at EL2. We're going to
+	 * die painfully, and there is nothing we can do about it.
+	 *
+	 * Kindly inform the luser.
+	 */
+	if (!gic_enable_sre())
+		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
 
 	/* Set priority mask register */
 	gic_write_pmr(DEFAULT_PMR_VALUE);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 9eeeb95..32891b6 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -397,6 +397,22 @@ static inline void gic_write_dir(u64 irq)
 	isb();
 }
 
+static inline bool gic_enable_sre(void)
+{
+	u64 val;
+
+	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
+	if (val & ICC_SRE_EL1_SRE)
+		return true;
+
+	val |= ICC_SRE_EL1_SRE;
+	asm volatile("msr_s " __stringify(ICC_SRE_EL1) ", %0" : : "r" (val));
+	isb();
+	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
+
+	return !!(val & ICC_SRE_EL1_SRE);
+}
+
 struct irq_domain;
 int its_cpu_init(void);
 int its_init(struct device_node *node, struct rdists *rdists,
-- 
2.1.4
