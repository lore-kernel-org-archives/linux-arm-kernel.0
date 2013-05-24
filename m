From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 May 2013 11:23:14 +0200
Subject: [PATCHv3 6/6] ARM: sunxi: Add EMAC Controller to Hackberry dt
In-Reply-To: <1369387394-9453-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1369387394-9453-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1369387394-9453-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hackberry has a PHY that needs to be powered up through a GPIO, so
we need to use a fixed regulator here.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-hackberry.dts | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index b9efac1..3514b37 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -23,10 +23,51 @@
 	};
 
 	soc at 01c20000 {
+		emac: ethernet at 01c0b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&emac_pins_a>;
+			phy = <&phy0>;
+			status = "okay";
+		};
+
+		mdio at 01c0b080 {
+			phy-supply = <&reg_emac_3v3>;
+			status = "okay";
+
+			phy0: ethernet-phy at 0 {
+				reg = <0>;
+			};
+		};
+
+		pio: pinctrl at 01c20800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&hackberry_hogs>;
+
+			hackberry_hogs: hogs at 0 {
+				allwinner,pins = "PH19";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_emac_3v3: emac-3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "emac-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			enable-active-high;
+			gpio = <&pio 7 19 0>;
+		};
+	};
 };
-- 
1.8.1.2
