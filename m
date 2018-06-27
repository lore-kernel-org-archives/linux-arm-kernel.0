From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 27 Jun 2018 17:01:50 +0200
Subject: [PATCH v3 2/2] ARM: dts: pxa: fix the rtc controller
In-Reply-To: <20180627150150.23951-1-robert.jarzmik@free.fr>
References: <20180627150150.23951-1-robert.jarzmik@free.fr>
Message-ID: <20180627150150.23951-2-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC controller is fed by an external fixed 32kHz clock. Yet the
driver wants to acquire this clock, even though it doesn't make any use
of it, ie. doesn't get the rate to make calculation.

Therefore, use the exported 32.768kHz clock in the PXA clock tree to
make the driver happy and working.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: change the dummy clock by the actual 32.768kHz
---
 arch/arm/boot/dts/pxa25x.dtsi | 4 ++++
 arch/arm/boot/dts/pxa27x.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
index 95d59be97213..78a413ea0e88 100644
--- a/arch/arm/boot/dts/pxa25x.dtsi
+++ b/arch/arm/boot/dts/pxa25x.dtsi
@@ -80,6 +80,10 @@
 			#pwm-cells = <1>;
 			clocks = <&clks CLK_PWM1>;
 		};
+
+		rtc at 40900000 {
+			clocks = <&clks CLK_OSC32k768>>;
+		};
 	};
 
 	timer at 40a00000 {
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 747f750f675d..2ab6986433c8 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -113,6 +113,10 @@
 
 			status = "disabled";
 		};
+
+		rtc at 40900000 {
+			clocks = <&clks CLK_OSC32k768>;
+		};
 	};
 
 	clocks {
-- 
2.11.0
