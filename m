From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 17 Jul 2013 11:17:26 -0400
Subject: [RESEND PATCH V1 7/9] arm: dts: add omap4430 thermal data
In-Reply-To: <1374074248-31690-1-git-send-email-eduardo.valentin@ti.com>
References: <1374074248-31690-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1374074248-31690-8-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the dtsi entry on omap4430 to contain
the thermal data. This data will enable the passive
cooling with CPUfreq cooling device at 100C and the
system will do a thermal shutdown at 125C.

Cc: "Beno?t Cousson" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index 4a4dcc3..27f0e0f 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/thermal/thermal.h>
 #include "omap4.dtsi"
 
 / {
@@ -27,8 +28,34 @@
 	};
 
 	bandgap {
-		reg = <0x4a002260 0x4
-		       0x4a00232C 0x4>;
+		reg = <0x4a002260 0x4 0x4a00232C 0x4>;
 		compatible = "ti,omap4430-bandgap";
+		thermal_zone {
+			type = "CPU";
+			mask = <0x03>; /* trips writability */
+			passive_delay = <250>; /* milliseconds */
+			polling_delay = <1000>; /* milliseconds */
+			governor = "step_wise";
+			trips {
+				alert at 100000{
+					temperature = <100000>; /* milliCelsius */
+					hysteresis = <2000>; /* milliCelsius */
+					type = <THERMAL_TRIP_PASSIVE>;
+				};
+				crit at 125000{
+					temperature = <125000>; /* milliCelsius */
+					hysteresis = <2000>; /* milliCelsius */
+					type = <THERMAL_TRIP_CRITICAL>;
+				};
+			};
+			bind_params {
+				action at 0{
+					cooling_device = "thermal-cpufreq";
+					weight = <100>; /* percentage */
+					mask = <0x01>;
+					/* no limits, using defaults */
+				};
+			};
+		};
 	};
 };
-- 
1.8.2.1.342.gfa7285d
