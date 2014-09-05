From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri,  5 Sep 2014 18:34:56 +0100
Subject: [PATCH v9 7/8] drivers: cpuidle: initialize big.LITTLE driver through
 DT
In-Reply-To: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1409938498-17984-8-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of DT based idle states, CPUidle drivers for ARM
can now initialize idle states data through properties in the device tree.

This patch adds code to the big.LITTLE CPUidle driver to dynamically
initialize idle states data through the updated device tree source file.

Cc: Chander Kashyap <k.chander@samsung.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 23 +++++++++++++++++++++++
 drivers/cpuidle/Kconfig.arm                |  1 +
 drivers/cpuidle/cpuidle-big_little.c       | 19 +++++++++++++++++++
 3 files changed, 43 insertions(+)

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
index ef94c3b..85d09bc 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -24,6 +24,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#include "dt_idle_states.h"
+
 static int bl_enter_powerdown(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int idx);
 
@@ -73,6 +75,12 @@ static struct cpuidle_driver bl_idle_little_driver = {
 	.state_count = 2,
 };
 
+static const struct of_device_id bl_idle_state_match[] __initconst = {
+	{ .compatible = "arm,idle-state",
+	  .data = bl_enter_powerdown },
+	{ },
+};
+
 static struct cpuidle_driver bl_idle_big_driver = {
 	.name = "big_idle",
 	.owner = THIS_MODULE,
@@ -190,6 +198,17 @@ static int __init bl_idle_init(void)
 	if (ret)
 		goto out_uninit_little;
 
+	/* Start at index 1, index 0 standard WFI */
+	ret = dt_init_idle_driver(&bl_idle_big_driver, bl_idle_state_match, 1);
+	if (ret < 0)
+		goto out_uninit_big;
+
+	/* Start@index 1, index 0 standard WFI */
+	ret = dt_init_idle_driver(&bl_idle_little_driver,
+				  bl_idle_state_match, 1);
+	if (ret < 0)
+		goto out_uninit_big;
+
 	ret = cpuidle_register(&bl_idle_little_driver, NULL);
 	if (ret)
 		goto out_uninit_big;
-- 
1.9.1
