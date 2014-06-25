From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 25 Jun 2014 15:10:20 +0100
Subject: [PATCH v5 7/8] drivers: cpuidle: initialize Exynos driver through DT
In-Reply-To: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1403705421-17597-8-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of DT based idle states, CPUidle drivers for
ARM can now initialize idle states data through properties in the device
tree.

This patch adds code to the Exynos CPUidle driver to dynamically
initialize idle states data through the updated device tree source
files.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
Compile tested, I am not sure I patched the right dts files, please check.

 .../devicetree/bindings/arm/exynos/idle-states.txt | 27 ++++++++++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi                  | 16 ++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  | 15 +++++++++++
 arch/arm/boot/dts/exynos5410.dtsi                  | 17 +++++++++++++
 drivers/cpuidle/Kconfig.arm                        |  1 +
 drivers/cpuidle/cpuidle-exynos.c                   | 29 +++++++++++++---------
 6 files changed, 93 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/exynos/idle-states.txt

diff --git a/Documentation/devicetree/bindings/arm/exynos/idle-states.txt b/Documentation/devicetree/bindings/arm/exynos/idle-states.txt
new file mode 100644
index 0000000..342ecb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/exynos/idle-states.txt
@@ -0,0 +1,27 @@
+idle-states node
+----------------
+
+On Exynos platforms with power management capabilities, the device
+tree source file must contain the idle-states node[1]. As defined in [1] the
+idle-states node must contain an entry-method property that for Exynos
+platforms can be one of:
+
+	- "samsung,exynos"
+
+Exynos idle-states nodes example:
+
+	idle-states {
+		entry-method = "samsung,exynos";
+
+		CLUSTER_SLEEP_0: cluster-sleep-0 {
+			compatible = "arm,idle-state";
+			timer-state-retained;
+			power-rank = <0>;
+			entry-latency-us = <1000>;
+			exit-latency-us = <300>;
+			min-residency-us = <100000>;
+		};
+	};
+
+[1] ARM Linux Kernel documentation - Idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 3e678fa..b0ccfca 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -45,11 +45,26 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "samsung,exynos";
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				timer-state-retained;
+				power-rank = <0>;
+				entry-latency-us = <1000>;
+				exit-latency-us = <300>;
+				min-residency-us = <100000>;
+			};
+
+		};
+
 		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 
 		cpu1: cpu at 1 {
@@ -57,6 +72,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 834fb5a..b806653 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -58,17 +58,32 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "samsung,exynos";
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				timer-state-retained;
+				power-rank = <0>;
+				entry-latency-us = <1000>;
+				exit-latency-us = <300>;
+				min-residency-us = <100000>;
+			};
+		};
+
 		cpu at 0 {
 			device_type = "cpu";
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
 		};
 	};
 
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 3839c26..82e4b7b 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -24,28 +24,45 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "samsung,exynos";
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				timer-state-retained;
+				power-rank = <0>;
+				entry-latency-us = <1000>;
+				exit-latency-us = <300>;
+				min-residency-us = <100000>;
+			};
+		};
+
 		CPU0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 
 		CPU1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x1>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 
 		CPU2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x2>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 
 		CPU3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x3>;
+			cpu-idle-states = <&CLUSTER_SLEEP_0>;
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
index 7c01512..d76af54 100644
--- a/drivers/cpuidle/cpuidle-exynos.c
+++ b/drivers/cpuidle/cpuidle-exynos.c
@@ -18,6 +18,8 @@
 #include <asm/suspend.h>
 #include <asm/cpuidle.h>
 
+#include "dt_idle_states.h"
+
 static void (*exynos_enter_aftr)(void);
 
 static int idle_finisher(unsigned long flags)
@@ -60,26 +62,29 @@ static struct cpuidle_driver exynos_idle_driver = {
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
+	drv->cpumask = (struct cpumask *) cpu_possible_mask;
+
+	/* Start at index 1, index 0 standard WFI */
+	ret = dt_init_idle_driver(drv, NULL, 1, false);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize idle states\n");
+		return ret;
+	}
+
+	for (i = 1; i < drv->state_count; i++)
+		drv->states[i].enter = exynos_enter_lowpower;
+
+	ret = cpuidle_register(drv, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
 		return ret;
-- 
1.9.1
