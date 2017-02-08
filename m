From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed,  8 Feb 2017 15:39:33 -0600
Subject: [PATCH v4 1/2] irqchip/gicv3: Fix GICR_WAKE & GICD_IGROUPR accesses
 from non-secure
Message-ID: <1486589974-6184-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems where GIC support two security states, both the register
GICR_WAKE and GICD_IGROUPR accesses are RAZ/WI from non-secure.
The function gic_enable_redist() to wake/sleep redistributor is not
harmful at all, but it is confusing looking at the code. The current
code checks the single security state based on bit GICD_CTLR.DS which
is absolutely incorrect. The disable security bit GICD_CTLR.DS is RAZ
to non-secure. The GICD_TYPE.SecurityExtn indicates whether the GIC
implementation supports two security states or only one security
state.

Let's introduce a new helper function gic_has_security_extn() to
know GIC security state. Use this function to bypass the code that
is touching the registers GICR_WAKE and GICD_IGROUPR.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
Changes since v3:
    Do explicit writes to GICR_IGRPMODR0 if GIC security is disabled.
Changes since v1:
    Edit comments.
    Do explicit writes to IGRPMODR if GIC security is disabled.

 drivers/irqchip/irq-gic-v3.c       | 52 +++++++++++++++++++++++++++++---------
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c132f29..ff5265e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -130,12 +130,28 @@ static u64 __maybe_unused gic_read_iar(void)
 }
 #endif
 
+/**
+ * Check whether the GIC implementation supports two security
+ * states or only one security state.
+ * return true if it has two security states else return false.
+ */
+static bool gic_has_security_extn(void)
+{
+	u32 typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
+
+	return !!(typer & GICD_TYPER_SECURITY_EXTN);
+}
+
 static void gic_enable_redist(bool enable)
 {
 	void __iomem *rbase;
 	u32 count = 1000000;	/* 1s! */
 	u32 val;
 
+	/* On two security state system, GICR_WAKE is RAZ/WI to non-secure */
+	if (gic_has_security_extn())
+		return;
+
 	rbase = gic_data_rdist_rd_base();
 
 	val = readl_relaxed(rbase + GICR_WAKER);
@@ -399,14 +415,24 @@ static void __init gic_dist_init(void)
 
 	/*
 	 * Configure SPIs as non-secure Group-1. This will only matter
-	 * if the GIC only has a single security state. This will not
-	 * do the right thing if the kernel is running in secure mode,
-	 * but that's not the intended use case anyway.
+	 * if the GIC only has a single security state. This will do
+	 * the right thing if the kernel is running in secure mode and
+	 * with assumption all the SPIs are allocated to Linux, but
+	 * that's not the intended use case anyway.
+	 *
+	 * IGRPMODR  IGROUPR  Definition         ShortName
+	 *    0         0     Secure Group0      G0S
+	 *    0         1     Non-secure Group1  G1NS
+	 *    1         0     Secure Group1      G1S
+	 *    1         1     Reserved           treated as G1NS
 	 */
-	for (i = 32; i < gic_data.irq_nr; i += 32)
-		writel_relaxed(~0, base + GICD_IGROUPR + i / 8);
-
-	gic_dist_config(base, gic_data.irq_nr, gic_dist_wait_for_rwp);
+	if (!gic_has_security_extn()) {
+		for (i = 32; i < gic_data.irq_nr; i += 32) {
+			writel_relaxed(0, base + GICD_IGRPMODR + i / 8);
+			writel_relaxed(~0, base + GICD_IGROUPR + i / 8);
+		}
+		gic_dist_config(base, gic_data.irq_nr, gic_dist_wait_for_rwp);
+	}
 
 	/* Enable distributor with ARE, Group1 */
 	writel_relaxed(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1,
@@ -529,12 +555,14 @@ static void gic_cpu_init(void)
 
 	gic_enable_redist(true);
 
-	rbase = gic_data_rdist_sgi_base();
-
-	/* Configure SGIs/PPIs as non-secure Group-1 */
-	writel_relaxed(~0, rbase + GICR_IGROUPR0);
+	/* Configure SGIs/PPIs as non-secure Group-1 if security is disabled */
+	if (!gic_has_security_extn()) {
+		rbase = gic_data_rdist_sgi_base();
+		writel_relaxed(~0, rbase + GICR_IGROUPR0);
+		writel_relaxed(0, rbase + GICR_IGRPMODR0);
 
-	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
+		gic_cpu_config(rbase, gic_redist_wait_for_rwp);
+	}
 
 	/* Give LPIs a spin */
 	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index e808f8a..aab00e5 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -70,6 +70,7 @@
 
 #define GICD_TYPER_LPIS			(1U << 17)
 #define GICD_TYPER_MBIS			(1U << 16)
+#define GICD_TYPER_SECURITY_EXTN	(1U << 10)
 
 #define GICD_TYPER_ID_BITS(typer)	((((typer) >> 19) & 0x1f) + 1)
 #define GICD_TYPER_IRQS(typer)		((((typer) & 0x1f) + 1) * 32)
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
