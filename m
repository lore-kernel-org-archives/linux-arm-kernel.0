From: megous@megous.com (megous at megous.com)
Date: Sat, 25 Jun 2016 05:45:11 +0200
Subject: [PATCH v2 14/14] ARM: dts: sun8i: Enable DVFS on Orange Pi One
In-Reply-To: <20160625034511.7966-1-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
Message-ID: <20160625034511.7966-15-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

Use Xulong Orange Pi One GPIO based regulator for
passive cooling and thermal management.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 39 +++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index b1bd6b0..a38d871 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -109,6 +109,45 @@
 	};
 };
 
+&cpu0 {
+	operating-points = <
+		/* kHz	  uV */
+		1296000	1300000
+		1200000	1300000
+		624000	1100000
+		480000	1100000
+		312000	1100000
+		240000	1100000
+		>;
+	#cooling-cells = <2>;
+	cooling-min-level = <0>;
+	cooling-max-level = <5>;
+	cpu0-supply = <&vdd_soc>;
+};
+
+&cpu_thermal {
+	cooling-maps {
+		map0 {
+			trip = <&cpu_alert0>;
+			cooling-device = <&cpu0 (-1) (-1)>;
+		};
+	};
+
+	trips {
+		cpu_alert0: cpu_alert0 {
+			temperature = <80000>;
+			hysteresis = <2000>;
+			type = "passive";
+		};
+
+		cpu_crit: cpu_crit {
+			temperature = <100000>;
+			hysteresis = <2000>;
+			type = "critical";
+		};
+	};
+};
+
 &ehci1 {
 	status = "okay";
 };
-- 
2.9.0
