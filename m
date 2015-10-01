From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:52 +0200
Subject: [PATCH 15/16] ARM: dts: lpc4350-hitex-eval: add i2c0 and devices
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-16-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Add the I2C0 bus and the some of the I2C devices on the Hitex
LPC4350 eval board.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4350-hitex-eval.dts | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
index c1dd76e5fc45..5c529f45947b 100644
--- a/arch/arm/boot/dts/lpc4350-hitex-eval.dts
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -186,6 +186,14 @@
 		};
 	};
 
+	i2c0_pins: i2c0-pins {
+		i2c0_pins_cfg {
+			pins = "i2c0_scl", "i2c0_sda";
+			function = "i2c0";
+			input-enable;
+		};
+	};
+
 	spifi_pins: spifi-pins {
 		spifi_clk_cfg {
 			pins = "p3_3";
@@ -300,6 +308,31 @@
 	clock-frequency = <25000000>;
 };
 
+&i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	clock-frequency = <400000>;
+
+	/* NXP SE97BTP with temperature sensor + eeprom */
+	sensor at 18 {
+		compatible = "nxp,jc42";
+		reg = <0x18>;
+	};
+
+	eeprom at 50 {
+		compatible = "nxp,24c02";
+		reg = <0x50>;
+	};
+
+	pca_gpio: gpio at 24 {
+		compatible = "nxp,pca9673";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &mac {
 	status = "okay";
 	phy-mode = "mii";
-- 
1.8.0
