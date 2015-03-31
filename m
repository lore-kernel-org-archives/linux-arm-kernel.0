From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 31 Mar 2015 18:46:18 +0200
Subject: [PATCH v3] ARM: mvebu: Disable CPU Idle on Armada 38x
Message-ID: <1427820378-13415-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada 38x SoCs, under heavy I/O load, the system hangs when CPU
Idle is enabled. Waiting for a solution to this issue, this patch
disables the CPU Idle support for this SoC.

As CPU Hot plug support also uses some of the CPU Idle functions it is
also affected by the same issue. This patch disables it also for the
Armada 38x SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.17 +
---
Hi,

In this version I removed the unneeded initialization of the ret
variable, I also fixed the warning message, and finally I added the
Tested-by from Thomas.

Gregory

 arch/arm/mach-mvebu/pmsu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 8b9f5e202ccf..4f4e22206ae5 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -415,6 +415,9 @@ static __init int armada_38x_cpuidle_init(void)
 	void __iomem *mpsoc_base;
 	u32 reg;
 
+	pr_warn("CPU idle is currently broken on Armada 38x: disabling");
+	return 0;
+
 	np = of_find_compatible_node(NULL, NULL,
 				     "marvell,armada-380-coherency-fabric");
 	if (!np)
@@ -476,6 +479,16 @@ static int __init mvebu_v7_cpu_pm_init(void)
 		return 0;
 	of_node_put(np);
 
+	/*
+	 * Currently the CPU idle support for Armada 38x is broken, as
+	 * the CPU hotplug uses some of the CPU idle functions it is
+	 * broken too, so let's disable it
+	 */
+	if (of_machine_is_compatible("marvell,armada380")) {
+		cpu_hotplug_disable();
+		pr_warn("CPU hotplug support is currently broken on Armada 38x: disabling");
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
