From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon,  2 Jul 2018 11:10:05 -0700
Subject: [PATCH v2 2/2] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
In-Reply-To: <20180702181005.18247-1-mka@chromium.org>
References: <20180702181005.18247-1-mka@chromium.org>
Message-ID: <20180702181005.18247-2-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thermal zone uses spmi-temp-alarm as sensor. If the sensor is
configured without an IIO input it always reports 37?C for temperatures
below the first hardware trip point at 105?C. This hardware trip point
is configured as critical trip point, to initiate a system shutdown
before the temperature reaches the next hardware trip point at 125?C,
where the PMIC performs a partial shutdown.

The temperature of the critical trip point can be raised after adding
the die temperature ADC as IIO input for spmi-temp-alarm, which
significantly increases the precision of the temperature measurements.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- defined 'thermal-zones' node in pm8998.dtsi instead of using a label
  to refer to it
- use 105?C hardware trip point as critical trip point
- reduced number of trip points to 2
- lowered temperature of passive trip point
- updated trip point names and added labels
- updated commit message

 arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 2f4989e7ef68..e7caa334e6c7 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/thermal/thermal.h>
 
 &spmi_bus {
 	pm8998_lsid0: pmic at 0 {
@@ -60,3 +61,27 @@
 		#size-cells = <0>;
 	};
 };
+
+/ {
+	thermal-zones {
+		pm8998 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&pm8998_temp>;
+
+			trips {
+				pm8998_alert0: pm8998-alert0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				pm8998_crit: pm8998-crit {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
-- 
2.18.0.399.gad0ab374a1-goog
