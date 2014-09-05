From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri,  5 Sep 2014 18:34:57 +0100
Subject: [PATCH v9 8/8] drivers: cpuidle: initialize Exynos driver through DT
In-Reply-To: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1409938498-17984-9-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of DT based idle states, CPUidle drivers for
ARM can now initialize idle states data through properties in the device
tree.

This patch adds code to the Exynos CPUidle driver to dynamically
initialize idle states data through the updated device tree source
files.

Cc: Chander Kashyap <k.chander@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 11 +++++++++++
 arch/arm/boot/dts/exynos5250.dtsi | 11 +++++++++++
 drivers/cpuidle/Kconfig.arm       |  1 +
 drivers/cpuidle/cpuidle-exynos.c  | 18 +++++++++++++++++-
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index eab7c7b..69fd1a0 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -48,12 +48,23 @@
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
index 492e1ef..3a758ff 100644
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
index e339c7f..04cc229 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -55,6 +55,7 @@ config ARM_AT91_CPUIDLE
 config ARM_EXYNOS_CPUIDLE
 	bool "Cpu Idle Driver for the Exynos processors"
 	depends on ARCH_EXYNOS
+	select DT_IDLE_STATES
 	help
 	  Select this to enable cpuidle for Exynos processors
 
diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpuidle-exynos.c
index ba9b34b..e66a426 100644
--- a/drivers/cpuidle/cpuidle-exynos.c
+++ b/drivers/cpuidle/cpuidle-exynos.c
@@ -18,6 +18,8 @@
 #include <asm/suspend.h>
 #include <asm/cpuidle.h>
 
+#include "dt_idle_states.h"
+
 static void (*exynos_enter_aftr)(void);
 
 static int exynos_enter_lowpower(struct cpuidle_device *dev,
@@ -56,13 +58,27 @@ static struct cpuidle_driver exynos_idle_driver = {
 	.safe_state_index = 0,
 };
 
+static const struct of_device_id exynos_idle_state_match[] __initconst = {
+	{ .compatible = "arm,idle-state",
+	  .data = exynos_enter_lowpower },
+	{ },
+};
+
 static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct cpuidle_driver *drv = &exynos_idle_driver;
 
 	exynos_enter_aftr = (void *)(pdev->dev.platform_data);
 
-	ret = cpuidle_register(&exynos_idle_driver, NULL);
+	/* Start at index 1, index 0 standard WFI */
+	ret = dt_init_idle_driver(drv, exynos_idle_state_match, 1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to initialize idle states\n");
+		return ret;
+	}
+
+	ret = cpuidle_register(drv, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
 		return ret;
-- 
1.9.1
