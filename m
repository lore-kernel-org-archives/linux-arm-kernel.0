From: megous@megous.com (megous at megous.com)
Date: Thu, 23 Jun 2016 21:21:04 +0200
Subject: [PATCH 14/14] ARM: dts: sun8i: Enable DVFS on Orange Pi One
In-Reply-To: <20160623192104.18720-1-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
Message-ID: <20160623192104.18720-15-megous@megous.com>
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
index ce4ba91..6bd4367 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -107,6 +107,45 @@
 	};
 };
 
+&cpu0 {
+	clocks = <&cpu>;
+	clock-latency = <244144>; /* 8 32k periods */
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
 };
 
 &ehci1 {
-- 
2.9.0
