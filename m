From: zhengxing@rock-chips.com (Xing Zheng)
Date: Sat, 24 Oct 2015 18:46:00 +0800
Subject: [PATCH v4 6/8] ARM: rockchip: add support smp for rk3036
In-Reply-To: <1445682629-21632-1-git-send-email-zhengxing@rock-chips.com>
References: <1445682629-21632-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1445683560-21829-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko@sntech.de>

The dual-core Cortex A7 rk3036 is a bit special in that it does not allow
to control the actual powerdomain of the cpu cores, while the rest of the
smp-bringup like reset control and entry address handling stays the same.
Its bigger sibling, the quad-core rk3128 again allows powerdomain control.

So allow that case by introducing a separate smp-enable-method, that simply
disables powerdomain handling in the common code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v4: None

 Documentation/devicetree/bindings/arm/cpus.txt |    1 +
 arch/arm/mach-rockchip/platsmp.c               |   45 +++++++++++++++++-------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 91e6e5c..261cc27 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -198,6 +198,7 @@ nodes to be present and contain the properties described below.
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
+			    "rockchip,rk3036-smp"
 			    "rockchip,rk3066-smp"
 			    "ste,dbx500-smp"
 
diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 3e7a4b7..5c138f9 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -42,6 +42,7 @@ static int ncores;
 #define PMU_PWRDN_SCU		4
 
 static struct regmap *pmu;
+static int has_pmu = true;
 
 static int pmu_power_domain_is_on(int pd)
 {
@@ -89,20 +90,23 @@ static int pmu_set_power_domain(int pd, bool on)
 	if (!IS_ERR(rstc) && !on)
 		reset_control_assert(rstc);
 
-	ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
-	if (ret < 0) {
-		pr_err("%s: could not update power domain\n", __func__);
-		return ret;
-	}
-
-	ret = -1;
-	while (ret != on) {
-		ret = pmu_power_domain_is_on(pd);
+	if (has_pmu) {
+		ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
 		if (ret < 0) {
-			pr_err("%s: could not read power domain state\n",
+			pr_err("%s: could not update power domain\n",
 			       __func__);
 			return ret;
 		}
+
+		ret = -1;
+		while (ret != on) {
+			ret = pmu_power_domain_is_on(pd);
+			if (ret < 0) {
+				pr_err("%s: could not read power domain state\n",
+				       __func__);
+				return ret;
+			}
+		}
 	}
 
 	if (!IS_ERR(rstc)) {
@@ -122,7 +126,7 @@ static int rockchip_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	int ret;
 
-	if (!sram_base_addr || !pmu) {
+	if (!sram_base_addr || (has_pmu && !pmu)) {
 		pr_err("%s: sram or pmu missing for cpu boot\n", __func__);
 		return -ENXIO;
 	}
@@ -275,7 +279,7 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 		return;
 	}
 
-	if (rockchip_smp_prepare_pmu())
+	if (has_pmu && rockchip_smp_prepare_pmu())
 		return;
 
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
@@ -318,6 +322,13 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 		pmu_set_power_domain(0 + i, false);
 }
 
+static void __init rk3036_smp_prepare_cpus(unsigned int max_cpus)
+{
+	has_pmu = false;
+
+	rockchip_smp_prepare_cpus(max_cpus);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int rockchip_cpu_kill(unsigned int cpu)
 {
@@ -340,6 +351,15 @@ static void rockchip_cpu_die(unsigned int cpu)
 }
 #endif
 
+static struct smp_operations rk3036_smp_ops __initdata = {
+	.smp_prepare_cpus	= rk3036_smp_prepare_cpus,
+	.smp_boot_secondary	= rockchip_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= rockchip_cpu_kill,
+	.cpu_die		= rockchip_cpu_die,
+#endif
+};
+
 static struct smp_operations rockchip_smp_ops __initdata = {
 	.smp_prepare_cpus	= rockchip_smp_prepare_cpus,
 	.smp_boot_secondary	= rockchip_boot_secondary,
@@ -349,4 +369,5 @@ static struct smp_operations rockchip_smp_ops __initdata = {
 #endif
 };
 
+CPU_METHOD_OF_DECLARE(rk3036_smp, "rockchip,rk3036-smp", &rk3036_smp_ops);
 CPU_METHOD_OF_DECLARE(rk3066_smp, "rockchip,rk3066-smp", &rockchip_smp_ops);
-- 
1.7.9.5
