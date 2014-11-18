From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 19 Nov 2014 00:02:11 +0100
Subject: [PATCHv4 04/10] arm: mvebu: move Armada 370/XP pinctrl node
 definition armada-370-xp.dtsi
In-Reply-To: <cover.1416351425.git.arno@natisbad.org>
References: <cover.1416351425.git.arno@natisbad.org>
Message-ID: <f4b15c942f543b0c0becd7c82bce07e9e0b603cf.1416351426.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


What was done by Sebastian in 264a05e19bf5 ("ARM: mvebu: armada-xp:
Add node alias to pinctrl and add base address") and 01c434225ee6
("ARM: mvebu: armada-xp: Use pinctrl node alias") can also be done for
Armada 370, i.e.

 - Rename Armada 370 pinctrl node to pin-ctrl with its address encoded
 - Add a node alias to access the pinctrl node easily.
 - use the newly available alias in existing Armada 370 .dts files

We can even go a bit further by putting the pinctrl node definition in
armada-370-xp.dtsi, with only its reg property defined. This allows us
to then also use the newly defined node alias in armada-xp.dtsi,
armada-370.dtsi.

Suggested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370-db.dts            |  48 +++++-----
 arch/arm/boot/dts/armada-370-mirabox.dts       |  25 ++---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts |  84 ++++++++---------
 arch/arm/boot/dts/armada-370-netgear-rn104.dts |  64 ++++++-------
 arch/arm/boot/dts/armada-370-rd.dts            |  24 ++---
 arch/arm/boot/dts/armada-370-xp.dtsi           |   4 +
 arch/arm/boot/dts/armada-370.dtsi              | 121 ++++++++++++-------------
 arch/arm/boot/dts/armada-xp.dtsi               |  72 +++++++--------
 8 files changed, 222 insertions(+), 220 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index a495e5821ab8..29f1c8c0369f 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -102,30 +102,6 @@
 				broken-cd;
 			};
 
-			pinctrl {
-				/*
-				 * These pins might be muxed as I2S by
-				 * the bootloader, but it conflicts
-				 * with the real I2S pins that are
-				 * muxed using i2s_pins. We must mux
-				 * those pins to a function other than
-				 * I2S.
-				 */
-				pinctrl-0 = <&hog_pins1 &hog_pins2>;
-				pinctrl-names = "default";
-
-				hog_pins1: hog-pins1 {
-					marvell,pins = "mpp6",  "mpp8", "mpp10",
-						       "mpp12", "mpp13";
-					marvell,function = "gpio";
-				};
-
-				hog_pins2: hog-pins2 {
-					marvell,pins = "mpp5", "mpp7", "mpp9";
-					marvell,function = "gpo";
-				};
-			};
-
 			usb at 50000 {
 				status = "okay";
 			};
@@ -181,3 +157,27 @@
 	      compatible = "linux,spdif-dir";
 	};
 };
+
+&pinctrl {
+	/*
+	 * These pins might be muxed as I2S by
+	 * the bootloader, but it conflicts
+	 * with the real I2S pins that are
+	 * muxed using i2s_pins. We must mux
+	 * those pins to a function other than
+	 * I2S.
+	 */
+	pinctrl-0 = <&hog_pins1 &hog_pins2>;
+	pinctrl-names = "default";
+
+	hog_pins1: hog-pins1 {
+		marvell,pins = "mpp6",  "mpp8", "mpp10",
+			       "mpp12", "mpp13";
+		marvell,function = "gpio";
+	};
+
+	hog_pins2: hog-pins2 {
+		marvell,pins = "mpp5", "mpp7", "mpp9";
+		marvell,function = "gpo";
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 2b6d24e0d1e8..e1b0eb6b091f 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -54,18 +54,6 @@
 				status = "okay";
 			};
 
-			pinctrl {
-				pwr_led_pin: pwr-led-pin {
-					marvell,pins = "mpp63";
-					marvell,function = "gpo";
-				};
-
-				stat_led_pins: stat-led-pins {
-					marvell,pins = "mpp64", "mpp65";
-					marvell,function = "gpio";
-				};
-			};
-
 			gpio_leds {
 				compatible = "gpio-leds";
 				pinctrl-names = "default";
@@ -169,3 +157,16 @@
 		};
 	};
 };
+
+&pinctrl {
+	pwr_led_pin: pwr-led-pin {
+		marvell,pins = "mpp63";
+		marvell,function = "gpo";
+	};
+
+	stat_led_pins: stat-led-pins {
+		marvell,pins = "mpp64", "mpp65";
+		marvell,function = "gpio";
+	};
+};
+
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 1e38628f4060..4e24932c6e30 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -59,48 +59,6 @@
 				status = "okay";
 			};
 
-			pinctrl {
-				power_led_pin: power-led-pin {
-					marvell,pins = "mpp57";
-					marvell,function = "gpio";
-				};
-
-				sata1_led_pin: sata1-led-pin {
-					marvell,pins = "mpp15";
-					marvell,function = "gpio";
-				};
-
-				sata2_led_pin: sata2-led-pin {
-					marvell,pins = "mpp14";
-					marvell,function = "gpio";
-				};
-
-				backup_led_pin: backup-led-pin {
-					marvell,pins = "mpp56";
-					marvell,function = "gpio";
-				};
-
-				backup_button_pin: backup-button-pin {
-					marvell,pins = "mpp58";
-					marvell,function = "gpio";
-				};
-
-				power_button_pin: power-button-pin {
-					marvell,pins = "mpp62";
-					marvell,function = "gpio";
-				};
-
-				reset_button_pin: reset-button-pin {
-					marvell,pins = "mpp6";
-					marvell,function = "gpio";
-				};
-
-				poweroff: poweroff {
-					marvell,pins = "mpp8";
-					marvell,function = "gpio";
-				};
-			};
-
 			mdio {
 				pinctrl-0 = <&mdio_pins>;
 				pinctrl-names = "default";
@@ -257,3 +215,45 @@
 		gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
 	};
 };
+
+&pinctrl {
+	power_led_pin: power-led-pin {
+		marvell,pins = "mpp57";
+		marvell,function = "gpio";
+	};
+
+	sata1_led_pin: sata1-led-pin {
+		marvell,pins = "mpp15";
+		marvell,function = "gpio";
+	};
+
+	sata2_led_pin: sata2-led-pin {
+		marvell,pins = "mpp14";
+		marvell,function = "gpio";
+	};
+
+	backup_led_pin: backup-led-pin {
+		marvell,pins = "mpp56";
+		marvell,function = "gpio";
+	};
+
+	backup_button_pin: backup-button-pin {
+		marvell,pins = "mpp58";
+		marvell,function = "gpio";
+	};
+
+	power_button_pin: power-button-pin {
+		marvell,pins = "mpp62";
+		marvell,function = "gpio";
+	};
+
+	reset_button_pin: reset-button-pin {
+		marvell,pins = "mpp6";
+		marvell,function = "gpio";
+	};
+
+	poweroff: poweroff {
+		marvell,pins = "mpp8";
+		marvell,function = "gpio";
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index c2f414bb9aba..30586e47986a 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -53,38 +53,6 @@
 				status = "okay";
 			};
 
-			pinctrl {
-				poweroff: poweroff {
-					marvell,pins = "mpp60";
-					marvell,function = "gpio";
-				};
-
-				backup_button_pin: backup-button-pin {
-					marvell,pins = "mpp52";
-					marvell,function = "gpio";
-				};
-
-				power_button_pin: power-button-pin {
-					marvell,pins = "mpp62";
-					marvell,function = "gpio";
-				};
-
-				backup_led_pin: backup-led-pin {
-					marvell,pins = "mpp63";
-					marvell,function = "gpo";
-				};
-
-				power_led_pin: power-led-pin {
-					marvell,pins = "mpp64";
-					marvell,function = "gpio";
-				};
-
-				reset_button_pin: reset-button-pin {
-					marvell,pins = "mpp65";
-					marvell,function = "gpio";
-				};
-			};
-
 			mdio {
 				pinctrl-0 = <&mdio_pins>;
 				pinctrl-names = "default";
@@ -269,3 +237,35 @@
 		gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
 	};
 };
+
+&pinctrl {
+	poweroff: poweroff {
+		marvell,pins = "mpp60";
+		marvell,function = "gpio";
+	};
+
+	backup_button_pin: backup-button-pin {
+		marvell,pins = "mpp52";
+		marvell,function = "gpio";
+	};
+
+	power_button_pin: power-button-pin {
+		marvell,pins = "mpp62";
+		marvell,function = "gpio";
+	};
+
+	backup_led_pin: backup-led-pin {
+		marvell,pins = "mpp63";
+		marvell,function = "gpo";
+	};
+
+	power_led_pin: power-led-pin {
+		marvell,pins = "mpp64";
+		marvell,function = "gpio";
+	};
+
+	reset_button_pin: reset-button-pin {
+		marvell,pins = "mpp65";
+		marvell,function = "gpio";
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index f57a8f841498..f427c8109813 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -59,18 +59,6 @@
 		};
 
 		internal-regs {
-			pinctrl {
-				fan_pins: fan-pins {
-					marvell,pins = "mpp8";
-					marvell,function = "gpio";
-				};
-
-				led_pins: led-pins {
-					marvell,pins = "mpp32";
-					marvell,function = "gpio";
-				};
-			};
-
 			serial at 12000 {
 				status = "okay";
 			};
@@ -174,3 +162,15 @@
 		};
 	};
  };
+
+&pinctrl {
+	fan_pins: fan-pins {
+		marvell,pins = "mpp8";
+		marvell,function = "gpio";
+	};
+
+	led_pins: led-pins {
+		marvell,pins = "mpp32";
+		marvell,function = "gpio";
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 2be9723bcdf3..8e65abf46fba 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -103,6 +103,10 @@
 			#size-cells = <1>;
 			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
 
+			pinctrl: pin-ctrl at 18000 {
+				reg = <0x18000 0x38>;
+			};
+
 			rtc at 10300 {
 				compatible = "marvell,orion-rtc";
 				reg = <0x10300 0x20>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 7851942e244a..90e1286d414f 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -112,67 +112,6 @@
 				reg = <0x18200 0x100>;
 			};
 
-			pinctrl {
-				compatible = "marvell,mv88f6710-pinctrl";
-				reg = <0x18000 0x38>;
-
-				sdio_pins1: sdio-pins1 {
-					marvell,pins = "mpp9",  "mpp11", "mpp12",
-							"mpp13", "mpp14", "mpp15";
-					marvell,function = "sd0";
-				};
-
-				sdio_pins2: sdio-pins2 {
-					marvell,pins = "mpp47", "mpp48", "mpp49",
-							"mpp50", "mpp51", "mpp52";
-					marvell,function = "sd0";
-				};
-
-				sdio_pins3: sdio-pins3 {
-					marvell,pins = "mpp48", "mpp49", "mpp50",
-							"mpp51", "mpp52", "mpp53";
-					marvell,function = "sd0";
-				};
-
-				i2c0_pins: i2c0-pins {
-					marvell,pins = "mpp2", "mpp3";
-					marvell,function = "i2c0";
-				};
-
-				i2s_pins1: i2s-pins1 {
-					marvell,pins = "mpp5", "mpp6", "mpp7",
-						       "mpp8", "mpp9", "mpp10",
-						       "mpp12", "mpp13";
-					marvell,function = "audio";
-				};
-
-				i2s_pins2: i2s-pins2 {
-					marvell,pins = "mpp49", "mpp47", "mpp50",
-						       "mpp59", "mpp57", "mpp61",
-						       "mpp62", "mpp60", "mpp58";
-					marvell,function = "audio";
-				};
-
-				mdio_pins: mdio-pins {
-					marvell,pins = "mpp17", "mpp18";
-					marvell,function = "ge";
-				};
-
-				ge0_rgmii_pins: ge0-rgmii-pins {
-					marvell,pins = "mpp5", "mpp6", "mpp7", "mpp8",
-						       "mpp9", "mpp10", "mpp11", "mpp12",
-						       "mpp13", "mpp14", "mpp15", "mpp16";
-					marvell,function = "ge0";
-				};
-
-				ge1_rgmii_pins: ge1-rgmii-pins {
-					marvell,pins = "mpp19", "mpp20", "mpp21", "mpp22",
-						       "mpp23", "mpp24", "mpp25", "mpp26",
-						       "mpp27", "mpp28", "mpp29", "mpp30";
-					marvell,function = "ge1";
-				};
-			};
-
 			gpio0: gpio at 18100 {
 				compatible = "marvell,orion-gpio";
 				reg = <0x18100 0x40>;
@@ -306,3 +245,63 @@
 		};
 	};
 };
+
+&pinctrl {
+	compatible = "marvell,mv88f6710-pinctrl";
+
+	sdio_pins1: sdio-pins1 {
+		marvell,pins = "mpp9",  "mpp11", "mpp12",
+				"mpp13", "mpp14", "mpp15";
+		marvell,function = "sd0";
+	};
+
+	sdio_pins2: sdio-pins2 {
+		marvell,pins = "mpp47", "mpp48", "mpp49",
+				"mpp50", "mpp51", "mpp52";
+		marvell,function = "sd0";
+	};
+
+	sdio_pins3: sdio-pins3 {
+		marvell,pins = "mpp48", "mpp49", "mpp50",
+				"mpp51", "mpp52", "mpp53";
+		marvell,function = "sd0";
+	};
+
+	i2c0_pins: i2c0-pins {
+		marvell,pins = "mpp2", "mpp3";
+		marvell,function = "i2c0";
+	};
+
+	i2s_pins1: i2s-pins1 {
+		marvell,pins = "mpp5", "mpp6", "mpp7",
+			       "mpp8", "mpp9", "mpp10",
+			       "mpp12", "mpp13";
+		marvell,function = "audio";
+	};
+
+	i2s_pins2: i2s-pins2 {
+		marvell,pins = "mpp49", "mpp47", "mpp50",
+			       "mpp59", "mpp57", "mpp61",
+			       "mpp62", "mpp60", "mpp58";
+		marvell,function = "audio";
+	};
+
+	mdio_pins: mdio-pins {
+		marvell,pins = "mpp17", "mpp18";
+		marvell,function = "ge";
+	};
+
+	ge0_rgmii_pins: ge0-rgmii-pins {
+		marvell,pins = "mpp5", "mpp6", "mpp7", "mpp8",
+			       "mpp9", "mpp10", "mpp11", "mpp12",
+			       "mpp13", "mpp14", "mpp15", "mpp16";
+		marvell,function = "ge0";
+	};
+
+	ge1_rgmii_pins: ge1-rgmii-pins {
+		marvell,pins = "mpp19", "mpp20", "mpp21", "mpp22",
+			       "mpp23", "mpp24", "mpp25", "mpp26",
+			       "mpp27", "mpp28", "mpp29", "mpp30";
+		marvell,function = "ge1";
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index e4ba27ef109b..dcfef0311a88 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -73,43 +73,6 @@
 				status = "disabled";
 			};
 
-			pinctrl: pin-ctrl at 18000 {
-				reg = <0x18000 0x38>;
-
-				pmx_ge0_gmii: pmx-ge0-gmii {
-					marvell,pins =
-					     "mpp0",  "mpp1",  "mpp2",  "mpp3",
-					     "mpp4",  "mpp5",  "mpp6",  "mpp7",
-					     "mpp8",  "mpp9",  "mpp10", "mpp11",
-					     "mpp12", "mpp13", "mpp14", "mpp15",
-					     "mpp16", "mpp17", "mpp18", "mpp19",
-					     "mpp20", "mpp21", "mpp22", "mpp23";
-					marvell,function = "ge0";
-				};
-
-				pmx_ge0_rgmii: pmx-ge0-rgmii {
-					marvell,pins =
-					     "mpp0", "mpp1", "mpp2", "mpp3",
-					     "mpp4", "mpp5", "mpp6", "mpp7",
-					     "mpp8", "mpp9", "mpp10", "mpp11";
-					marvell,function = "ge0";
-				};
-
-				pmx_ge1_rgmii: pmx-ge1-rgmii {
-					marvell,pins =
-					     "mpp12", "mpp13", "mpp14", "mpp15",
-					     "mpp16", "mpp17", "mpp18", "mpp19",
-					     "mpp20", "mpp21", "mpp22", "mpp23";
-					marvell,function = "ge1";
-				};
-
-				sdio_pins: sdio-pins {
-					marvell,pins = "mpp30", "mpp31", "mpp32",
-						       "mpp33", "mpp34", "mpp35";
-					marvell,function = "sd0";
-				};
-			};
-
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
 				reg = <0x18200 0x500>;
@@ -238,3 +201,38 @@
 		};
 	};
 };
+
+&pinctrl {
+	pmx_ge0_gmii: pmx-ge0-gmii {
+		marvell,pins =
+		     "mpp0",  "mpp1",  "mpp2",  "mpp3",
+		     "mpp4",  "mpp5",  "mpp6",  "mpp7",
+		     "mpp8",  "mpp9",  "mpp10", "mpp11",
+		     "mpp12", "mpp13", "mpp14", "mpp15",
+		     "mpp16", "mpp17", "mpp18", "mpp19",
+		     "mpp20", "mpp21", "mpp22", "mpp23";
+		marvell,function = "ge0";
+	};
+
+	pmx_ge0_rgmii: pmx-ge0-rgmii {
+		marvell,pins =
+		     "mpp0", "mpp1", "mpp2", "mpp3",
+		     "mpp4", "mpp5", "mpp6", "mpp7",
+		     "mpp8", "mpp9", "mpp10", "mpp11";
+		marvell,function = "ge0";
+	};
+
+	pmx_ge1_rgmii: pmx-ge1-rgmii {
+		marvell,pins =
+		     "mpp12", "mpp13", "mpp14", "mpp15",
+		     "mpp16", "mpp17", "mpp18", "mpp19",
+		     "mpp20", "mpp21", "mpp22", "mpp23";
+		marvell,function = "ge1";
+	};
+
+	sdio_pins: sdio-pins {
+		marvell,pins = "mpp30", "mpp31", "mpp32",
+			       "mpp33", "mpp34", "mpp35";
+		marvell,function = "sd0";
+	};
+};
\ No newline at end of file
-- 
2.1.1
