From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed, 30 Sep 2015 11:10:42 +0200
Subject: [PATCH v4 1/5] ARM: mvebu: add broken-idle option
In-Reply-To: <1443604246-29844-1-git-send-email-simon.guinot@sequanux.org>
References: <1443604246-29844-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1443604246-29844-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vincent Donnefort <vdonnefort@gmail.com>

The broken-idle option can be activated from the coherency-fabric DT
node. This property allows to disable the idle capability, when the
hardware doesn't support it, like the Seagate Personal Cloud boards.

Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
---
 .../devicetree/bindings/arm/coherency-fabric.txt   |  4 +++
 arch/arm/mach-mvebu/pmsu.c                         | 32 ++++++++++++++++++----
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coherency-fabric.txt b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
index 8dd46617c889..1b6268dbe477 100644
--- a/Documentation/devicetree/bindings/arm/coherency-fabric.txt
+++ b/Documentation/devicetree/bindings/arm/coherency-fabric.txt
@@ -27,6 +27,10 @@ Required properties:
  * For "marvell,armada-380-coherency-fabric", only one pair is needed
    for the per-CPU fabric registers.
 
+Optional properties:
+
+- broken-idle: Must be set when the Idle mode is not supported by the hardware.
+
 Examples:
 
 coherency-fabric at d0020200 {
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index e8fdb9ceedf0..953ab62f0593 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -379,6 +379,16 @@ static struct notifier_block mvebu_v7_cpu_pm_notifier = {
 
 static struct platform_device mvebu_v7_cpuidle_device;
 
+static int broken_idle(struct device_node *np)
+{
+	if (of_get_property(np, "broken-idle", NULL)) {
+		pr_warn("CPU idle is currently broken: disabling");
+		return 0;
+	}
+
+	return 1;
+}
+
 static __init int armada_370_cpuidle_init(void)
 {
 	struct device_node *np;
@@ -387,7 +397,9 @@ static __init int armada_370_cpuidle_init(void)
 	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
 	if (!np)
 		return -ENODEV;
-	of_node_put(np);
+
+	if (!broken_idle(np))
+		goto end;
 
 	/*
 	 * On Armada 370, there is "a slow exit process from the deep
@@ -406,6 +418,8 @@ static __init int armada_370_cpuidle_init(void)
 	mvebu_v7_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
 	mvebu_v7_cpuidle_device.name = "cpuidle-armada-370";
 
+end:
+	of_node_put(np);
 	return 0;
 }
 
@@ -415,13 +429,14 @@ static __init int armada_38x_cpuidle_init(void)
 	void __iomem *mpsoc_base;
 	u32 reg;
 
-	pr_warn("CPU idle is currently broken on Armada 38x: disabling\n");
-	return 0;
-
 	np = of_find_compatible_node(NULL, NULL,
 				     "marvell,armada-380-coherency-fabric");
 	if (!np)
 		return -ENODEV;
+
+	if (!broken_idle(np))
+		goto end;
+
 	of_node_put(np);
 
 	np = of_find_compatible_node(NULL, NULL,
@@ -430,7 +445,6 @@ static __init int armada_38x_cpuidle_init(void)
 		return -ENODEV;
 	mpsoc_base = of_iomap(np, 0);
 	BUG_ON(!mpsoc_base);
-	of_node_put(np);
 
 	/* Set up reset mask when powering down the cpus */
 	reg = readl(mpsoc_base + MPCORE_RESET_CTL);
@@ -450,6 +464,8 @@ static __init int armada_38x_cpuidle_init(void)
 	mvebu_v7_cpuidle_device.dev.platform_data = armada_38x_cpu_suspend;
 	mvebu_v7_cpuidle_device.name = "cpuidle-armada-38x";
 
+end:
+	of_node_put(np);
 	return 0;
 }
 
@@ -460,12 +476,16 @@ static __init int armada_xp_cpuidle_init(void)
 	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
 	if (!np)
 		return -ENODEV;
-	of_node_put(np);
+
+	if (!broken_idle(np))
+		goto end;
 
 	mvebu_cpu_resume = armada_370_xp_cpu_resume;
 	mvebu_v7_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
 	mvebu_v7_cpuidle_device.name = "cpuidle-armada-xp";
 
+end:
+	of_node_put(np);
 	return 0;
 }
 
-- 
2.1.4
