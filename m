From: mka@chromium.org (Matthias Kaehlcke)
Date: Tue, 31 Jul 2018 11:59:14 -0700
Subject: [PATCH v6 2/5] dt-bindings: thermal: qcom-spmi-temp-alarm: Improve
 thermal zone in example
In-Reply-To: <20180731185917.176074-1-mka@chromium.org>
References: <20180731185917.176074-1-mka@chromium.org>
Message-ID: <20180731185917.176074-2-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current example for a thermal zone isn't very useful as reference
since it would result in a hardware shutdown at 145?C, instead of
allowing the system to try to shutdown gracefully. Without an ADC
channel a maximum of two trip points is useful in practice for this
sensor, with temperatures corresponding to the stage 1 and stage 2
'hardware trip points'. A critical trip point at stage 2 may allow the
system to shutdown before a hardware shutdown at stage 3 kicks in. It
should be noted though that by default the chip performs a 'partial
shutdown' when the temperature reaches stage 2, which may prevent an
orderly shutdown. The 'partial shutdown' can be disabled by software.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v6:
- patch added to the series
---
 .../bindings/thermal/qcom-spmi-temp-alarm.txt         | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
index 86fb41fe772f..0273a92a2a84 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
@@ -35,19 +35,14 @@ Example:
 			thermal-sensors = <&pm8941_temp>;
 
 			trips {
-				passive {
-					temperature = <1050000>;
+				stage1 {
+					temperature = <105000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				alert {
+				stage2 {
 					temperature = <125000>;
 					hysteresis = <2000>;
-					type = "hot";
-				};
-				crit {
-					temperature = <145000>;
-					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
-- 
2.18.0.345.g5c9ce644c3-goog
