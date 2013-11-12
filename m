From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Tue, 12 Nov 2013 15:46:11 -0400
Subject: [PATCHv5 09/20] arm: dts: add omap4 CPU thermal data
In-Reply-To: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1384285582-16933-10-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes a dtsi file to contain the thermal data
for MPU domain on OMAP4 and later SoCs. This data will
enable the passive cooling with CPUfreq cooling device
at 100C and the system will do a thermal shutdown at 125C.

This thermal data can be reused across TI SoC devices.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
Change from v4:
- Using string constants instead of macros on trip types

 arch/arm/boot/dts/omap4-cpu-thermal.dtsi | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-cpu-thermal.dtsi

diff --git a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
new file mode 100644
index 0000000..cb9458f
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
@@ -0,0 +1,41 @@
+/*
+ * Device Tree Source for OMAP4/5 SoC CPU thermal
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Contact: Eduardo Valentin <eduardo.valentin@ti.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+cpu_thermal: cpu_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <1000>; /* milliseconds */
+
+			/* sensor       ID */
+        thermal-sensors = <&bandgap     0>;
+
+        trips {
+                cpu_alert0: cpu_alert {
+                        temperature = <100000>; /* millicelsius */
+                        hysteresis = <2000>; /* millicelsius */
+                        type = "passive";
+                };
+                cpu_crit: cpu_crit {
+                        temperature = <125000>; /* millicelsius */
+                        hysteresis = <2000>; /* millicelsius */
+                        type = "critical";
+                };
+        };
+
+	cooling-maps {
+		map0 {
+			trip = <&cpu_alert0>;
+			cooling-device =
+				<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
-- 
1.8.2.1.342.gfa7285d
