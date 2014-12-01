From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  1 Dec 2014 17:11:27 +0530
Subject: [RFC V1 6/8] cpufreq: zynq: reuse dt_device.c to create cpufreq
 platform device
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Message-ID: <8ce96bccf8b5f9165ddd09841bf7b3de73c5c68a.1417433163.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have a common interface for create platform device required to probe
cpufreq-dt driver (and others as well). Lets create devices from dt_device.c
instead of platform specific code.

For zynq, we are updating the blacklist instead of DT because the newer kernel
should be backwards compatible with older DT as well. We can update the
"compatible" property in DT but it wouldn't make a difference as we already have
imx in the blacklist.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-zynq/common.c | 2 --
 drivers/cpufreq/dt_device.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 26f92c2..add3647 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -110,7 +110,6 @@ static void __init zynq_init_late(void)
  */
 static void __init zynq_init_machine(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	struct device *parent = NULL;
@@ -145,7 +144,6 @@ static void __init zynq_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
 
 	platform_device_register(&zynq_cpuidle_device);
-	platform_device_register_full(&devinfo);
 
 	zynq_slcr_init();
 }
diff --git a/drivers/cpufreq/dt_device.c b/drivers/cpufreq/dt_device.c
index 85dc002..2075228 100644
--- a/drivers/cpufreq/dt_device.c
+++ b/drivers/cpufreq/dt_device.c
@@ -32,6 +32,8 @@ static const struct of_device_id compatible_machine_match[] = {
 	{ .compatible = "renesas,sh7372",	.data = "cpufreq-dt" },
 	{ .compatible = "renesas,sh73a0",	.data = "cpufreq-dt" },
 
+	{ .compatible = "xlnx,zynq-7000",	.data = "cpufreq-dt" },
+
 	/* BLACKLIST of existing users of arm-bL-cpufreq-dt below */
 
 	/* BLACKLIST of existing users of other drivers below */
-- 
2.0.3.693.g996b0fd
