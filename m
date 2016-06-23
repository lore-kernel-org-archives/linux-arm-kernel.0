From: megous@megous.com (megous at megous.com)
Date: Thu, 23 Jun 2016 21:21:02 +0200
Subject: [PATCH 12/14] ARM: dts: sun8i: Setup CPU operating points for Onrage
 PI PC
In-Reply-To: <20160623192104.18720-1-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
Message-ID: <20160623192104.18720-13-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

Orange PI PC uses SY8106A regulator for fine grained CPUX voltage
regulation. Setup appropriate operating points for the board.
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 7e04017..e85fe91 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -90,6 +90,56 @@
 	};
 };
 
+&cpu0 {
+	clocks = <&cpu>;
+	clock-latency = <244144>; /* 8 32k periods */
+	operating-points = <
+		/* kHz	  uV */
+		1512000	1400000
+		1440000	1400000
+		1368000	1340000
+		1344000	1340000
+		1296000	1340000
+		1248000	1300000
+		1224000	1300000
+		1200000	1300000
+		1104000	1200000
+		1008000	1140000
+		960000	1100000
+		648000	1100000
+		480000	1100000
+		240000	1100000
+		120000	1100000
+		>;
+	#cooling-cells = <2>;
+	cooling-min-level = <0>;
+	cooling-max-level = <14>;
+	cpu0-supply = <&vdd_cpu>;
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
 &r_twi {
 	status = "okay";
 
-- 
2.9.0
