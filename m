From: mka@chromium.org (Matthias Kaehlcke)
Date: Tue, 24 Jul 2018 16:46:36 -0700
Subject: [PATCH v5 3/3] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
In-Reply-To: <20180724234636.57137-1-mka@chromium.org>
References: <20180724234636.57137-1-mka@chromium.org>
Message-ID: <20180724234636.57137-3-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thermal zone uses spmi-temp-alarm as sensor, the trip points
correspond to the PMIC thermal stages 1 and 2. The critical trip
point at 125?C disables the partial PMIC shutdown at stage 2.

Without an IIO input the sensor only reports a limited number of
temperatures:

- 37?C for temperatures below 105?C
- 107?C for temperatures >= 105?C and < 125?C
- 127?C for temperatures >= 125?C

(the numbers correspond to a stage 1 threshold of 105?C)

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v5:
- removed 'stage2-shutdown-disabled' property from spmi-temp-alarm
- updated commit message

Changes in v4:
- updated trip point temperatures to match stage 1 and 2 ones
- disabled stage 2 shutdown
- updated commit message

Changes in v3:
- moved 'thermal-zones' node to the beginning of the .dtsi

Changes in v2:
- defined 'thermal-zones' node in pm8998.dtsi instead of using a label
  to refer to it
- use 105?C hardware trip point as critical trip point
- reduced number of trip points to 2
- lowered temperature of passive trip point
- updated trip point names and added labels
- updated commit message
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 7eea94701b23..34c259ba3919 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -3,6 +3,31 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/thermal/thermal.h>
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
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				pm8998_crit: pm8998-crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
 
 &spmi_bus {
 	pm8998_lsid0: pmic at 0 {
-- 
2.18.0.233.g985f88cf7e-goog
