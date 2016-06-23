From: megous@megous.com (megous at megous.com)
Date: Thu, 23 Jun 2016 21:21:03 +0200
Subject: [PATCH 13/14] ARM: dts: sun8i: Add gpio-regulator used on Orange Pi
 One
In-Reply-To: <20160623192104.18720-1-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
Message-ID: <20160623192104.18720-14-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

Xulong Orange Pi One uses GPIO based regulator that
switches between two voltages: 1.1V and 1.3V. The
regulator is controlled from the PL6 pin.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 0adf932..ce4ba91 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -88,6 +88,25 @@
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	vdd_soc: gpio-regulator {
+		compatible = "regulator-gpio";
+
+		regulator-name = "soc-vdd-supply";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-boot-on;
+		regulator-type = "voltage";
+
+		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>;
+		states = <1100000 0x0
+			  1300000 0x1>;
+
+		startup-delay-us = <100000>;
+		enable-active-high;
+	};
+};
+
 };
 
 &ehci1 {
@@ -131,6 +150,13 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	soc_reg0: soc_reg at 0 {
+		allwinner,pins = "PL6";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &uart0 {
-- 
2.9.0
