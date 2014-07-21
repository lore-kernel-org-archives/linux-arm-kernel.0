From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 21 Jul 2014 17:06:26 +0100
Subject: [PATCH v6 7/7] drivers: cpuidle: initialize Exynos driver through DT
In-Reply-To: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1405958786-17243-8-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of DT based idle states, CPUidle drivers for
ARM can now initialize idle states data through properties in the device
tree.

This patch adds code to the Exynos CPUidle driver to dynamically
initialize idle states data through the updated device tree source
files.

Cc: Chander Kashyap <chander.kashyap@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 11 +++++++++++
 arch/arm/boot/dts/exynos5250.dtsi | 11 +++++++++++
 drivers/cpuidle/Kconfig.arm       |  1 +
 drivers/cpuidle/cpuidle-exynos.c  | 37 ++++++++++++++++++++++++-------------
 4 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index bc2b444..0270100 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -39,12 +39,23 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x900>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 
 		cpu at 901 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x901>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
+		};
+
+		idle-states {
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				entry-latency-us = <1000>;
+				exit-latency-us = <300>;
+				min-residency-us = <100000>;
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 834fb5a..631906e 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -63,12 +63,23 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1700000000>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1700000000>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
+		};
+
+		idle-states {
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				entry-latency-us = <1000>;
+				exit-latency-us = <300>;
+				min-residency-us = <100000>;
+			};
 		};
 	};
 
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index a9b089c..d8a9cd2 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -60,5 +60,6 @@ config ARM_AT91_CPUIDLE
 config ARM_EXYNOS_CPUIDLE
 	bool "Cpu Idle Driver for the Exynos processors"
 	depends on ARCH_EXYNOS
+	select DT_IDLE_STATES
 	help
 	  Select this to enable cpuidle for Exynos processors
diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
index 7c01512..097c21d 100644
--- a/drivers/cpuidle/cpuidle-exynos.c
+++ b/drivers/cpuidle/cpuidle-exynos.c
@@ -13,11 +13,14 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
 #include <asm/cpuidle.h>
 
+#include "dt_idle_states.h"
+
 static void (*exynos_enter_aftr)(void);
 
 static int idle_finisher(unsigned long flags)
@@ -60,32 +63,40 @@ static struct cpuidle_driver exynos_idle_driver = {
 	.owner			= THIS_MODULE,
 	.states = {
 		[0] = ARM_CPUIDLE_WFI_STATE,
-		[1] = {
-			.enter			= exynos_enter_lowpower,
-			.exit_latency		= 300,
-			.target_residency	= 100000,
-			.flags			= CPUIDLE_FLAG_TIME_VALID,
-			.name			= "C1",
-			.desc			= "ARM power down",
-		},
 	},
-	.state_count = 2,
-	.safe_state_index = 0,
 };
 
 static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
-	int ret;
+	int ret, i;
+	struct cpuidle_driver *drv = &exynos_idle_driver;
 
 	exynos_enter_aftr = (void *)(pdev->dev.platform_data);
 
-	ret = cpuidle_register(&exynos_idle_driver, NULL);
+	drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
+	if (!drv->cpumask)
+		return -ENOMEM;
+
+	/* Start at index 1, index 0 standard WFI */
+	ret = dt_init_idle_driver(drv, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize idle states\n");
+		goto free_mem;
+	}
+
+	for (i = 1; i < drv->state_count; i++)
+		drv->states[i].enter = exynos_enter_lowpower;
+
+	ret = cpuidle_register(drv, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
-		return ret;
+		goto free_mem;
 	}
 
 	return 0;
+free_mem:
+	kfree(drv->cpumask);
+	return ret;
 }
 
 static struct platform_driver exynos_cpuidle_driver = {
-- 
1.9.1
