From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 25 Feb 2015 19:30:50 +0100
Subject: [PATCH v2] ARM: mvebu: Disable CPU Idle on Armada 38x
Message-ID: <1424889050-1008-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada 38x SoCs, under heavy I/O load, the system hangs when CPU
Idle is enabled. Waiting for a solution to this issue, this patch
disables the CPU Idle support for this SoC.

As CPU Hot plug support also uses some of the CPU Idle functions it is
also affected by the same issue. This patch disables it also for the
Armada 38x SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.17 +
---
Hi,

The previous code raised a warning about the unused
armada_38x_cpuidle_init() function. So I moved the warn message inside
the function itself and then I continued to call this function.

I also fixed a missing bracket.

And finally I only registered the cpuilde platform driver if there was
really something to register.

Gregory


 arch/arm/mach-mvebu/pmsu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 8b9f5e202ccf..2145f192662f 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -415,6 +415,9 @@ static __init int armada_38x_cpuidle_init(void)
 	void __iomem *mpsoc_base;
 	u32 reg;
 
+	pr_warn("CPU Idle is currently broken on Armada 38x: disabling");
+	return 0;
+
 	np = of_find_compatible_node(NULL, NULL,
 				     "marvell,armada-380-coherency-fabric");
 	if (!np)
@@ -469,13 +472,23 @@ static __init int armada_xp_cpuidle_init(void)
 static int __init mvebu_v7_cpu_pm_init(void)
 {
 	struct device_node *np;
-	int ret;
+	int ret = 0;
 
 	np = of_find_matching_node(NULL, of_pmsu_table);
 	if (!np)
 		return 0;
 	of_node_put(np);
 
+	/*
+	 * Currently the CPU Idle support for Armada 38x is broken, as
+	 * the CPU Hotplug uses some of the CPU Idle functions it is
+	 * broken too, so let's disable it
+	 */
+	if (of_machine_is_compatible("marvell,armada380")) {
+		cpu_hotplug_disable();
+		pr_warn("CPU Hotplug support is currently broken on Armada 38x: disabling");
+	}
+
 	if (of_machine_is_compatible("marvell,armadaxp"))
 		ret = armada_xp_cpuidle_init();
 	else if (of_machine_is_compatible("marvell,armada370"))
@@ -489,7 +502,8 @@ static int __init mvebu_v7_cpu_pm_init(void)
 		return ret;
 
 	mvebu_v7_pmsu_enable_l2_powerdown_onidle();
-	platform_device_register(&mvebu_v7_cpuidle_device);
+	if (mvebu_v7_cpuidle_device.name)
+		platform_device_register(&mvebu_v7_cpuidle_device);
 	cpu_pm_register_notifier(&mvebu_v7_cpu_pm_notifier);
 
 	return 0;
-- 
2.1.0
