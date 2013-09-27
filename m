From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 27 Sep 2013 10:17:47 +0200
Subject: [PATCH 2/2] ARM: zynq: cpuidle: convert to platform driver
In-Reply-To: <1380269867-18336-1-git-send-email-daniel.lezcano@linaro.org>
References: <1380269867-18336-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1380269867-18336-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the ux500 and the kirkwood driver, make the zynq driver a platform driver

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-zynq/common.c    |    6 ++++++
 drivers/cpuidle/cpuidle-zynq.c |   13 +++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 5f25256..9a7bd13 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -44,6 +44,10 @@ static struct of_device_id zynq_of_bus_ids[] __initdata = {
 	{}
 };
 
+static struct platform_device zynq_cpuidle_device = {
+	.name = "cpuidle-zynq",
+};
+
 /**
  * zynq_init_machine - System specific initialization, intended to be
  *		       called from board specific initialization.
@@ -56,6 +60,8 @@ static void __init zynq_init_machine(void)
 	l2x0_of_init(0x02060000, 0xF0F0FFFF);
 
 	of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
+
+	platform_device_register(&zynq_cpuidle_device);
 }
 
 static void __init zynq_timer_init(void)
diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
index ab6c4b4..2ea3ebe 100644
--- a/drivers/cpuidle/cpuidle-zynq.c
+++ b/drivers/cpuidle/cpuidle-zynq.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/cpu_pm.h>
 #include <linux/cpuidle.h>
+#include <linux/platform_device.h>
 #include <asm/proc-fns.h>
 #include <asm/cpuidle.h>
 
@@ -69,11 +70,19 @@ static struct cpuidle_driver zynq_idle_driver = {
 };
 
 /* Initialize CPU idle by registering the idle states */
-static int __init zynq_cpuidle_init(void)
+static int __init zynq_cpuidle_probe(struct platform_device *pdev)
 {
 	pr_info("Xilinx Zynq CpuIdle Driver started\n");
 
 	return cpuidle_register(&zynq_idle_driver, NULL);
 }
 
-device_initcall(zynq_cpuidle_init);
+static struct platform_driver zynq_cpuidle_driver = {
+	.driver = {
+		.name = "cpuidle-zynq",
+		.owner = THIS_MODULE,
+	},
+	.probe = zynq_cpuidle_probe,
+};
+
+module_platform_driver(zynq_cpuidle_driver);
-- 
1.7.9.5
