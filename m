From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  1 Dec 2014 17:11:24 +0530
Subject: [RFC V1 3/8] cpufreq: imx: reuse dt_device.c to create cpufreq
 platform device
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Message-ID: <67cc9759ae6634bd3059352644b693247afcb1be.1417433163.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have a common interface for create platform device required to probe
cpufreq-dt driver (and others as well). Lets create devices from dt_device.c
instead of platform specific code.

For imx, we are updating the blacklist instead of DT because the newer kernel
should be backwards compatible with older DT as well. We can update the
"compatible" property in DT but it wouldn't make a difference as we already have
imx in the blacklist.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-imx/imx27-dt.c   | 4 ----
 arch/arm/mach-imx/mach-imx51.c | 3 ---
 drivers/cpufreq/dt_device.c    | 2 ++
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index dc8f1a6..f12fe83 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -20,13 +20,9 @@
 
 static void __init imx27_dt_init(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
-
 	mxc_arch_reset_init_dt();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
-	platform_device_register_full(&devinfo);
 }
 
 static const char * const imx27_dt_board_compat[] __initconst = {
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 2c5fcaf..17d16a6 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -51,14 +51,11 @@ static void __init imx51_ipu_mipi_setup(void)
 
 static void __init imx51_dt_init(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
-
 	mxc_arch_reset_init_dt();
 	imx51_ipu_mipi_setup();
 	imx_src_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	platform_device_register_full(&devinfo);
 }
 
 static void __init imx51_init_late(void)
diff --git a/drivers/cpufreq/dt_device.c b/drivers/cpufreq/dt_device.c
index 7800968..cf01bed 100644
--- a/drivers/cpufreq/dt_device.c
+++ b/drivers/cpufreq/dt_device.c
@@ -24,6 +24,8 @@ static const struct of_device_id compatible_machine_match[] = {
 	{ .compatible = "arm-bL-cpufreq-dt",	.data = "arm-bL-cpufreq-dt" },
 
 	/* BLACKLIST of existing users of cpufreq-dt below */
+	{ .compatible = "fsl,imx27",		.data = "cpufreq-dt" },
+	{ .compatible = "fsl,imx51",		.data = "cpufreq-dt" },
 
 	/* BLACKLIST of existing users of arm-bL-cpufreq-dt below */
 
-- 
2.0.3.693.g996b0fd
