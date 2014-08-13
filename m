From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 13 Aug 2014 16:52:06 +0100
Subject: [PATCH v7 7/8] drivers: cpuidle: initialize big.LITTLE driver through
 DT
In-Reply-To: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1407945127-27554-8-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of DT based idle states, CPUidle drivers for ARM
can now initialize idle states data through properties in the device tree.

This patch adds code to the big.LITTLE CPUidle driver to dynamically
initialize idle states data through the updated device tree source file.

Cc: Chander Kashyap <k.chander@samsung.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 23 +++++++++++++++++++++++
 drivers/cpuidle/Kconfig.arm                |  1 +
 drivers/cpuidle/cpuidle-big_little.c       | 23 ++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index a25c262..322fd15 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -38,6 +38,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			cci-control-port = <&cci_control1>;
+			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
 		};
 
 		cpu1: cpu at 1 {
@@ -45,6 +46,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			cci-control-port = <&cci_control1>;
+			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
 		};
 
 		cpu2: cpu at 2 {
@@ -52,6 +54,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			cci-control-port = <&cci_control2>;
+			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
 		};
 
 		cpu3: cpu at 3 {
@@ -59,6 +62,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			cci-control-port = <&cci_control2>;
+			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
 		};
 
 		cpu4: cpu at 4 {
@@ -66,6 +70,25 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			cci-control-port = <&cci_control2>;
+			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+		};
+
+		idle-states {
+			CLUSTER_SLEEP_BIG: cluster-sleep-big {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <1000>;
+				exit-latency-us = <700>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_SLEEP_LITTLE: cluster-sleep-little {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <1000>;
+				exit-latency-us = <500>;
+				min-residency-us = <2500>;
+			};
 		};
 	};
 
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 38cff69..e339c7f 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -7,6 +7,7 @@ config ARM_BIG_LITTLE_CPUIDLE
 	depends on MCPM
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
+	select DT_IDLE_STATES
 	help
 	  Select this option to enable CPU idle driver for big.LITTLE based
 	  ARM systems. Driver manages CPUs coordination through MCPM and
diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index 344d79fa..38bdd28 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -24,6 +24,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#include "dt_idle_states.h"
+
 static int bl_enter_powerdown(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int idx);
 
@@ -171,7 +173,8 @@ static const struct of_device_id compatible_machine_match[] = {
 
 static int __init bl_idle_init(void)
 {
-	int ret;
+	int ret, i;
+	struct cpuidle_driver *drv;
 	struct device_node *root = of_find_node_by_path("/");
 
 	if (!root)
@@ -197,6 +200,24 @@ static int __init bl_idle_init(void)
 	if (ret)
 		goto out_uninit_little;
 
+	/* Start at index 1, index 0 standard WFI */
+	ret = dt_init_idle_driver(&bl_idle_big_driver, 1);
+	if (ret < 0)
+		goto out_uninit_big;
+
+	/* Start@index 1, index 0 standard WFI */
+	ret = dt_init_idle_driver(&bl_idle_little_driver, 1);
+	if (ret < 0)
+		goto out_uninit_big;
+
+	drv = &bl_idle_big_driver;
+	for (i = 1; i < drv->state_count; i++)
+		drv->states[i].enter = bl_enter_powerdown;
+
+	drv = &bl_idle_little_driver;
+	for (i = 1; i < drv->state_count; i++)
+		drv->states[i].enter = bl_enter_powerdown;
+
 	ret = cpuidle_register(&bl_idle_little_driver, NULL);
 	if (ret)
 		goto out_uninit_big;
-- 
1.9.1
