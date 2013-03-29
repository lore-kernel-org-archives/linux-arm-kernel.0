From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 29 Mar 2013 11:31:30 +0100
Subject: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization
In-Reply-To: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is initialized several times. This is wrong and if the
return code of the function was checked, it will return -EINVAL.

Move this initialization out of the loop.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index f4b1b23..3d33b8a 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -210,6 +210,7 @@ int __init omap4_idle_init(void)
 {
 	struct cpuidle_device *dev;
 	unsigned int cpu_id = 0;
+	int ret;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
@@ -222,14 +223,18 @@ int __init omap4_idle_init(void)
 	if (!cpu_clkdm[0] || !cpu_clkdm[1])
 		return -ENODEV;
 
+	ret = cpuidle_register_driver(&omap4_idle_driver);
+	if (ret) {
+		printk(KERN_ERR "failed to register the idle driver\n");
+		return ret;
+	}
+
 	for_each_cpu(cpu_id, cpu_online_mask) {
 		dev = &per_cpu(omap4_idle_dev, cpu_id);
 		dev->cpu = cpu_id;
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 		dev->coupled_cpus = *cpu_online_mask;
 #endif
-		cpuidle_register_driver(&omap4_idle_driver);
-
 		if (cpuidle_register_device(dev)) {
 			pr_err("%s: CPUidle register failed\n", __func__);
 			return -EIO;
-- 
1.7.9.5
