From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue,  2 Sep 2014 18:40:43 +0300
Subject: [PATCH v2 3/3] ARM: dts: qcom: Add SDHC nodes for APQ8084 platform
In-Reply-To: <1409672443-4289-1-git-send-email-gdjakov@mm-sol.com>
References: <1409672443-4289-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <1409672443-4289-4-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for the two SD host controllers on the APQ8084 platform
by adding the required nodes to the DT files.
On the IFC6540 board, the first controller is connected to the onboard
eMMC and the second is connected to a micro-SD card slot.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts |   11 +++++++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi        |   23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
index e41cb8a..c9ff108 100644
--- a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
+++ b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
@@ -8,5 +8,16 @@
 		serial at f995e000 {
 			status = "okay";
 		};
+
+		sdhci at f9824900 {
+			bus-width = <8>;
+			non-removable;
+			status = "okay";
+		};
+
+		sdhci at f98a4900 {
+			cd-gpios = <&tlmm 122 GPIO_ACTIVE_LOW>;
+			bus-width = <4>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 21d01e5..1f130bc 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -3,6 +3,7 @@
 #include "skeleton.dtsi"
 
 #include <dt-bindings/clock/qcom,gcc-apq8084.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Qualcomm APQ 8084";
@@ -203,5 +204,27 @@
 			clock-names = "core", "iface";
 			status = "disabled";
 		};
+
+		sdhci at f9824900 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
+			reg-names = "hc_mem", "core_mem";
+			interrupts = <0 123 0>, <0 138 0>;
+			interrupt-names = "hc_irq", "pwr_irq";
+			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		sdhci at f98a4900 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
+			reg-names = "hc_mem", "core_mem";
+			interrupts = <0 125 0>, <0 221 0>;
+			interrupt-names = "hc_irq", "pwr_irq";
+			clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
