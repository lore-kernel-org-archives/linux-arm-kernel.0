From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:09:55 +0900
Subject: [PATCH v6 09/13] ARM: dts: Use labels for overriding nodes in
 exynos4412-odroid
In-Reply-To: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431850195-9558-14-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

For thermal zones:
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 732 ++++++++++++------------
 arch/arm/boot/dts/exynos4412-odroidx.dts        |  16 +-
 2 files changed, 374 insertions(+), 374 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index d6b49e5b32e9..ca7d168d1dd6 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -38,16 +38,6 @@
 		};
 	};
 
-	i2s0: i2s at 03830000 {
-		pinctrl-0 = <&i2s0_bus>;
-		pinctrl-names = "default";
-		status = "okay";
-		clocks = <&clock_audss EXYNOS_I2S_BUS>,
-			 <&clock_audss EXYNOS_DOUT_AUD_BUS>,
-			 <&clock_audss EXYNOS_SCLK_I2S>;
-		clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
-	};
-
 	sound: sound {
 		compatible = "simple-audio-card";
 		assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
@@ -83,427 +73,437 @@
 		reset-gpios = <&gpk1 2 1>;
 	};
 
-	mmc at 12550000 {
-		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
-		pinctrl-names = "default";
-		vmmc-supply = <&ldo20_reg &buck8_reg>;
-		mmc-pwrseq = <&emmc_pwrseq>;
-		status = "okay";
-
-		num-slots = <1>;
-		broken-cd;
-		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
-		bus-width = <8>;
-		cap-mmc-highspeed;
-	};
-
-	watchdog at 10060000 {
-		status = "okay";
-	};
-
-	rtc at 10070000 {
-		status = "okay";
-		clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
-		clock-names = "rtc", "rtc_src";
-	};
-
-	g2d at 10800000 {
-		status = "okay";
-	};
-
 	camera {
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <>;
+	};
 
-		fimc_0: fimc at 11800000 {
-			status = "okay";
-			assigned-clocks = <&clock CLK_MOUT_FIMC0>,
-					<&clock CLK_SCLK_FIMC0>;
-			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
-			assigned-clock-rates = <0>, <176000000>;
-		};
-
-		fimc_1: fimc at 11810000 {
-			status = "okay";
-			assigned-clocks = <&clock CLK_MOUT_FIMC1>,
-					<&clock CLK_SCLK_FIMC1>;
-			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
-			assigned-clock-rates = <0>, <176000000>;
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <0>;
 		};
 
-		fimc_2: fimc at 11820000 {
-			status = "okay";
-			assigned-clocks = <&clock CLK_MOUT_FIMC2>,
-					<&clock CLK_SCLK_FIMC2>;
-			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
-			assigned-clock-rates = <0>, <176000000>;
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
 		};
+	};
 
-		fimc_3: fimc at 11830000 {
-			status = "okay";
-			assigned-clocks = <&clock CLK_MOUT_FIMC3>,
-					<&clock CLK_SCLK_FIMC3>;
-			assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
-			assigned-clock-rates = <0>, <176000000>;
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			cooling-maps {
+				map0 {
+				     /* Corresponds to 800MHz at freq_table */
+				     cooling-device = <&cpu0 7 7>;
+				};
+				map1 {
+				     /* Corresponds to 200MHz at freq_table */
+				     cooling-device = <&cpu0 13 13>;
+			       };
+		       };
 		};
 	};
+};
 
-	sdhci at 12530000 {
-		bus-width = <4>;
-		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-		pinctrl-names = "default";
-		vmmc-supply = <&ldo4_reg &ldo21_reg>;
-		cd-gpios = <&gpk2 2 0>;
-		cd-inverted;
-		status = "okay";
-	};
+/* RSTN signal for eMMC */
+&sd1_cd {
+	samsung,pin-pud = <0>;
+	samsung,pin-drv = <0>;
+};
 
-	serial at 13800000 {
-		status = "okay";
+&pinctrl_1 {
+	gpio_power_key: power_key {
+		samsung,pins = "gpx1-3";
+		samsung,pin-pud = <0>;
 	};
 
-	serial at 13810000 {
-		status = "okay";
+	max77686_irq: max77686-irq {
+		samsung,pins = "gpx3-2";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
 	};
 
-	fixed-rate-clocks {
-		xxti {
-			compatible = "samsung,clock-xxti";
-			clock-frequency = <0>;
-		};
-
-		xusbxti {
-			compatible = "samsung,clock-xusbxti";
-			clock-frequency = <24000000>;
-		};
+	hdmi_hpd: hdmi-hpd {
+		samsung,pins = "gpx3-7";
+		samsung,pin-pud = <1>;
 	};
+};
 
-	i2c at 13860000 {
-		pinctrl-0 = <&i2c0_bus>;
-		pinctrl-names = "default";
-		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <400000>;
-		status = "okay";
+&ehci {
+	status = "okay";
+};
 
-		usb3503: usb3503 at 08 {
-			compatible = "smsc,usb3503";
-			reg = <0x08>;
+&exynos_usbphy {
+	status = "okay";
+};
 
-			intn-gpios = <&gpx3 0 0>;
-			connect-gpios = <&gpx3 4 0>;
-			reset-gpios = <&gpx3 5 0>;
-			initial-mode = <1>;
-		};
+&fimc_0 {
+	status = "okay";
+	assigned-clocks = <&clock CLK_MOUT_FIMC0>,
+			<&clock CLK_SCLK_FIMC0>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+};
 
-		max77686: pmic at 09 {
-			compatible = "maxim,max77686";
-			interrupt-parent = <&gpx3>;
-			interrupts = <2 0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&max77686_irq>;
-			reg = <0x09>;
-			#clock-cells = <1>;
-
-			voltage-regulators {
-				ldo1_reg: LDO1 {
-					regulator-name = "VDD_ALIVE_1.0V";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
+&fimc_1 {
+	status = "okay";
+	assigned-clocks = <&clock CLK_MOUT_FIMC1>,
+			<&clock CLK_SCLK_FIMC1>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+};
 
-				ldo2_reg: LDO2 {
-					regulator-name = "VDDQ_M1_2_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
+&fimc_2 {
+	status = "okay";
+	assigned-clocks = <&clock CLK_MOUT_FIMC2>,
+			<&clock CLK_SCLK_FIMC2>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+};
 
-				ldo3_reg: LDO3 {
-					regulator-name = "VDDQ_EXT_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
+&fimc_3 {
+	status = "okay";
+	assigned-clocks = <&clock CLK_MOUT_FIMC3>,
+			<&clock CLK_SCLK_FIMC3>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+};
 
-				ldo4_reg: LDO4 {
-					regulator-name = "VDDQ_MMC2_2.8V";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+&g2d {
+	status = "okay";
+};
 
-				ldo5_reg: LDO5 {
-					regulator-name = "VDDQ_MMC1_3_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+&hdmi {
+	hpd-gpio = <&gpx3 7 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_hpd>;
+	vdd-supply = <&ldo8_reg>;
+	vdd_osc-supply = <&ldo10_reg>;
+	vdd_pll-supply = <&ldo8_reg>;
+	ddc = <&i2c_2>;
+	status = "okay";
+};
 
-				ldo6_reg: LDO6 {
-					regulator-name = "VDD10_MPLL_1.0V";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
+&hsotg {
+	dr_mode = "peripheral";
+	status = "okay";
+	vusb_d-supply = <&ldo15_reg>;
+	vusb_a-supply = <&ldo12_reg>;
+};
 
-				ldo7_reg: LDO7 {
-					regulator-name = "VDD10_XPLL_1.0V";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
+&i2c_0 {
+	pinctrl-0 = <&i2c0_bus>;
+	pinctrl-names = "default";
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-max-bus-freq = <400000>;
+	status = "okay";
+
+	usb3503: usb3503 at 08 {
+		compatible = "smsc,usb3503";
+		reg = <0x08>;
+
+		intn-gpios = <&gpx3 0 0>;
+		connect-gpios = <&gpx3 4 0>;
+		reset-gpios = <&gpx3 5 0>;
+		initial-mode = <1>;
+	};
 
-				ldo8_reg: ldo at 8 {
-					regulator-compatible = "LDO8";
-					regulator-name = "VDD10_HDMI_1.0V";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-				};
+	max77686: pmic at 09 {
+		compatible = "maxim,max77686";
+		interrupt-parent = <&gpx3>;
+		interrupts = <2 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&max77686_irq>;
+		reg = <0x09>;
+		#clock-cells = <1>;
+
+		voltage-regulators {
+			ldo1_reg: LDO1 {
+				regulator-name = "VDD_ALIVE_1.0V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
 
-				ldo10_reg: ldo at 10 {
-					regulator-compatible = "LDO10";
-					regulator-name = "VDDQ_MIPIHSI_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
+			ldo2_reg: LDO2 {
+				regulator-name = "VDDQ_M1_2_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
 
-				ldo11_reg: LDO11 {
-					regulator-name = "VDD18_ABB1_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
+			ldo3_reg: LDO3 {
+				regulator-name = "VDDQ_EXT_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
 
-				ldo12_reg: LDO12 {
-					regulator-name = "VDD33_USB_3.3V";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo4_reg: LDO4 {
+				regulator-name = "VDDQ_MMC2_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-				ldo13_reg: LDO13 {
-					regulator-name = "VDDQ_C2C_W_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo5_reg: LDO5 {
+				regulator-name = "VDDQ_MMC1_3_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-				ldo14_reg: LDO14 {
-					regulator-name = "VDD18_ABB0_2_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo6_reg: LDO6 {
+				regulator-name = "VDD10_MPLL_1.0V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
 
-				ldo15_reg: LDO15 {
-					regulator-name = "VDD10_HSIC_1.0V";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo7_reg: LDO7 {
+				regulator-name = "VDD10_XPLL_1.0V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
 
-				ldo16_reg: LDO16 {
-					regulator-name = "VDD18_HSIC_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo8_reg: ldo at 8 {
+				regulator-compatible = "LDO8";
+				regulator-name = "VDD10_HDMI_1.0V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+			};
 
-				ldo20_reg: LDO20 {
-					regulator-name = "LDO20_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-boot-on;
-				};
+			ldo10_reg: ldo at 10 {
+				regulator-compatible = "LDO10";
+				regulator-name = "VDDQ_MIPIHSI_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
 
-				ldo21_reg: LDO21 {
-					regulator-name = "LDO21_3.3V";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo11_reg: LDO11 {
+				regulator-name = "VDD18_ABB1_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
 
-				ldo25_reg: LDO25 {
-					regulator-name = "VDDQ_LCD_1.8V";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo12_reg: LDO12 {
+				regulator-name = "VDD33_USB_3.3V";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-				buck1_reg: BUCK1 {
-					regulator-name = "vdd_mif";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo13_reg: LDO13 {
+				regulator-name = "VDDQ_C2C_W_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-				buck2_reg: BUCK2 {
-					regulator-name = "vdd_arm";
-					regulator-min-microvolt = <900000>;
-					regulator-max-microvolt = <1350000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo14_reg: LDO14 {
+				regulator-name = "VDD18_ABB0_2_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-				buck3_reg: BUCK3 {
-					regulator-name = "vdd_int";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo15_reg: LDO15 {
+				regulator-name = "VDD10_HSIC_1.0V";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-				buck4_reg: BUCK4 {
-					regulator-name = "vdd_g3d";
-					regulator-min-microvolt = <900000>;
-					regulator-max-microvolt = <1100000>;
-					regulator-microvolt-offset = <50000>;
-				};
+			ldo16_reg: LDO16 {
+				regulator-name = "VDD18_HSIC_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-				buck5_reg: BUCK5 {
-					regulator-name = "VDDQ_CKEM1_2_1.2V";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo20_reg: LDO20 {
+				regulator-name = "LDO20_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+			};
 
-				buck6_reg: BUCK6 {
-					regulator-name = "BUCK6_1.35V";
-					regulator-min-microvolt = <1350000>;
-					regulator-max-microvolt = <1350000>;
-					regulator-always-on;
-					regulator-boot-on;
-				};
+			ldo21_reg: LDO21 {
+				regulator-name = "LDO21_3.3V";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-				buck7_reg: BUCK7 {
-					regulator-name = "BUCK7_2.0V";
-					regulator-min-microvolt = <2000000>;
-					regulator-max-microvolt = <2000000>;
-					regulator-always-on;
-				};
+			ldo25_reg: LDO25 {
+				regulator-name = "VDDQ_LCD_1.8V";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-				buck8_reg: BUCK8 {
-					regulator-name = "BUCK8_2.8V";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <2800000>;
-				};
+			buck1_reg: BUCK1 {
+				regulator-name = "vdd_mif";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
 			};
-		};
-	};
 
-	i2c at 13870000 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c1_bus>;
-		status = "okay";
-		max98090: max98090 at 10 {
-			compatible = "maxim,max98090";
-			reg = <0x10>;
-			interrupt-parent = <&gpx0>;
-			interrupts = <0 0>;
-			clocks = <&i2s0 CLK_I2S_CDCLK>;
-			clock-names = "mclk";
-			#sound-dai-cells = <0>;
-		};
-	};
+			buck2_reg: BUCK2 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-	exynos-usbphy at 125B0000 {
-		status = "okay";
-	};
+			buck3_reg: BUCK3 {
+				regulator-name = "vdd_int";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-	hsotg at 12480000 {
-		dr_mode = "peripheral";
-		status = "okay";
-		vusb_d-supply = <&ldo15_reg>;
-		vusb_a-supply = <&ldo12_reg>;
-	};
+			buck4_reg: BUCK4 {
+				regulator-name = "vdd_g3d";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-microvolt-offset = <50000>;
+			};
 
-	ehci: ehci at 12580000 {
-		status = "okay";
-	};
+			buck5_reg: BUCK5 {
+				regulator-name = "VDDQ_CKEM1_2_1.2V";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-	tmu at 100C0000 {
-		vtmu-supply = <&ldo10_reg>;
-		status = "okay";
-	};
+			buck6_reg: BUCK6 {
+				regulator-name = "BUCK6_1.35V";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
 
-	thermal-zones {
-		cpu_thermal: cpu-thermal {
-			cooling-maps {
-				map0 {
-				     /* Corresponds to 800MHz at freq_table */
-				     cooling-device = <&cpu0 7 7>;
-				};
-				map1 {
-				     /* Corresponds to 200MHz at freq_table */
-				     cooling-device = <&cpu0 13 13>;
-			       };
-		       };
+			buck7_reg: BUCK7 {
+				regulator-name = "BUCK7_2.0V";
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-always-on;
+			};
+
+			buck8_reg: BUCK8 {
+				regulator-name = "BUCK8_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+			};
 		};
 	};
+};
 
-	mixer: mixer at 12C10000 {
-		status = "okay";
+&i2c_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_bus>;
+	status = "okay";
+	max98090: max98090 at 10 {
+		compatible = "maxim,max98090";
+		reg = <0x10>;
+		interrupt-parent = <&gpx0>;
+		interrupts = <0 0>;
+		clocks = <&i2s0 CLK_I2S_CDCLK>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
 	};
+};
 
-	hdmi at 12D00000 {
-		hpd-gpio = <&gpx3 7 0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&hdmi_hpd>;
-		vdd-supply = <&ldo8_reg>;
-		vdd_osc-supply = <&ldo10_reg>;
-		vdd_pll-supply = <&ldo8_reg>;
-		ddc = <&hdmi_ddc>;
-		status = "okay";
-	};
+&i2c_2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_bus>;
+};
 
-	hdmi_ddc: i2c at 13880000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_bus>;
-	};
+&i2c_8 {
+	status = "okay";
+};
 
-	i2c at 138E0000 {
-		status = "okay";
-	};
+&i2s0 {
+	pinctrl-0 = <&i2s0_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+	clocks = <&clock_audss EXYNOS_I2S_BUS>,
+		 <&clock_audss EXYNOS_DOUT_AUD_BUS>,
+		 <&clock_audss EXYNOS_SCLK_I2S>;
+	clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
 };
 
-/* RSTN signal for eMMC */
-&sd1_cd {
-	samsung,pin-pud = <0>;
-	samsung,pin-drv = <0>;
+&mixer {
+	status = "okay";
 };
 
-&pinctrl_1 {
-	gpio_power_key: power_key {
-		samsung,pins = "gpx1-3";
-		samsung,pin-pud = <0>;
-	};
+&mshc_0 {
+	pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
+	pinctrl-names = "default";
+	vmmc-supply = <&ldo20_reg &buck8_reg>;
+	mmc-pwrseq = <&emmc_pwrseq>;
+	status = "okay";
+
+	num-slots = <1>;
+	broken-cd;
+	card-detect-delay = <200>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <2 3>;
+	samsung,dw-mshc-ddr-timing = <1 2>;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+};
 
-	max77686_irq: max77686-irq {
-		samsung,pins = "gpx3-2";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
-	};
+&rtc {
+	status = "okay";
+	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
+	clock-names = "rtc", "rtc_src";
+};
 
-	hdmi_hpd: hdmi-hpd {
-		samsung,pins = "gpx3-7";
-		samsung,pin-pud = <1>;
-	};
+&sdhci_2 {
+	bus-width = <4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
+	pinctrl-names = "default";
+	vmmc-supply = <&ldo4_reg &ldo21_reg>;
+	cd-gpios = <&gpk2 2 0>;
+	cd-inverted;
+	status = "okay";
+};
+
+&serial_0 {
+	status = "okay";
+};
+
+&serial_1 {
+	status = "okay";
+};
+
+&tmu {
+	vtmu-supply = <&ldo10_reg>;
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index cb1cfe7239c4..679ac103ebf6 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -38,14 +38,6 @@
 		};
 	};
 
-	serial at 13820000 {
-		status = "okay";
-	};
-
-	serial at 13830000 {
-		status = "okay";
-	};
-
 	gpio_keys {
 		pinctrl-0 = <&gpio_power_key &gpio_home_key>;
 
@@ -83,3 +75,11 @@
 		samsung,pin-pud = <0>;
 	};
 };
+
+&serial_2 {
+	status = "okay";
+};
+
+&serial_3 {
+	status = "okay";
+};
-- 
2.1.4
