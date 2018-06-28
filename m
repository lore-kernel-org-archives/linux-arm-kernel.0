From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 28 Jun 2018 14:09:15 -0700
Subject: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
In-Reply-To: <20180628210915.160893-1-mka@chromium.org>
References: <20180628210915.160893-1-mka@chromium.org>
Message-ID: <20180628210915.160893-3-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pm8998 thermal zone based on the examples in the spmi-temp-alarm
bindings.

Note: devices with the pm8998 need to have a 'thermal-zones' node (which
may be empty) with a label 'thermal_zones'.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index f2d39074ed74..d85ceb4f976b 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/thermal/thermal.h>
 
 &spmi_bus {
 	pm8998_lsid0: pmic at 0 {
@@ -59,3 +60,30 @@
 		#size-cells = <0>;
 	};
 };
+
+&thermal_zones {
+	pm8998 {
+		polling-delay-passive = <250>;
+		polling-delay = <1000>;
+
+		thermal-sensors = <&pm8998_temp>;
+
+		trips {
+			passive {
+				temperature = <1050000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+			alert {
+				temperature = <125000>;
+				hysteresis = <2000>;
+				type = "hot";
+			};
+			crit {
+				temperature = <145000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
+	};
+};
-- 
2.18.0.rc2.346.g013aa6912e-goog
