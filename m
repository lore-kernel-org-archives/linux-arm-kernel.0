From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 31 May 2016 20:39:04 +0200
Subject: [PATCH 5/6] ARM: dts: exynos: Configure PWM, usb3503,
 PMIC and thermal on Odroid XU board
In-Reply-To: <1464719945-3417-1-git-send-email-krzk@kernel.org>
References: <1464719945-3417-1-git-send-email-krzk@kernel.org>
Message-ID: <1464719945-3417-5-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the DTS for Exynos5410-based Odroid XU board with:
1. Proper PWM outputs,
2. usb3503 USB HUB (with integrated LAN9730 ethernet adapter (smsc95xx)),
3. Maxim 77802 PMIC (regulators, 32 kHz clocks, RTC),
4. CPU thermal (trip points are the same as in Odroid XU3/XU4 but
   cooling maps are different as there is no CPU freq and only one
   cluster available for now),
5. Regulator supplies for USB 3.0.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Sources:
1. XU schematics
2. Hardkernel kernel tree:
   https://github.com/hardkernel/linux.git
   branch: odroidxu-3.4.y
   file: arch/arm/mach-exynos/board-odroidxu-power.c

Still USB over-current is reported:
[    2.115186] usb usb3-port1: over-current condition
[    2.118555] usb usb4-port1: over-current condition
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 461 +++++++++++++++++++++++++++++-
 1 file changed, 460 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 9fe04500ecaf..d9499310a301 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -12,6 +12,7 @@
 
 /dts-v1/;
 #include "exynos5410.dtsi"
+#include <dt-bindings/clock/maxim,max77802.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include "exynos54xx-odroidxu-leds.dtsi"
@@ -57,6 +58,387 @@
 	};
 };
 
+&cpu0_thermal {
+	thermal-sensors = <&tmu_cpu0 0>;
+	polling-delay-passive = <0>;
+	polling-delay = <0>;
+
+	trips {
+		cpu_alert0: cpu-alert-0 {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <5000>; /* millicelsius */
+			type = "active";
+		};
+		cpu_alert1: cpu-alert-1 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <5000>; /* millicelsius */
+			type = "active";
+		};
+		cpu_alert2: cpu-alert-2 {
+			temperature = <70000>; /* millicelsius */
+			hysteresis = <5000>; /* millicelsius */
+			type = "active";
+		};
+		cpu_crit0: cpu-crit-0 {
+			temperature = <120000>; /* millicelsius */
+			hysteresis = <0>; /* millicelsius */
+			type = "critical";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cpu_alert0>;
+			cooling-device = <&fan0 0 1>;
+		};
+		map1 {
+			trip = <&cpu_alert1>;
+			cooling-device = <&fan0 1 2>;
+		};
+		map2 {
+			trip = <&cpu_alert2>;
+			cooling-device = <&fan0 2 3>;
+		};
+	};
+};
+
+&hsi2c_4 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-max-bus-freq = <400000>;
+	status = "okay";
+
+	usb3503: usb-hub at 08 {
+		compatible = "smsc,usb3503";
+		reg = <0x08>;
+
+		intn-gpios = <&gpx0 7 GPIO_ACTIVE_HIGH>;
+		connect-gpios = <&gpx0 6 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpx1 4 GPIO_ACTIVE_HIGH>;
+		initial-mode = <1>;
+
+		clock-names = "refclk";
+		clocks = <&pmu_system_controller 0>;
+		refclk-frequency = <24000000>;
+	};
+
+	max77802: pmic at 09 {
+		compatible = "maxim,max77802";
+		reg = <0x9>;
+		interrupt-parent = <&gpx0>;
+		interrupts = <4 IRQ_TYPE_NONE>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&max77802_irq>, <&pmic_dvs_1>, <&pmic_dvs_2>,
+			    <&pmic_dvs_3>;
+		#clock-cells = <1>;
+
+		inl1-supply = <&buck5_reg>;
+		inl2-supply = <&buck7_reg>;
+		inl3-supply = <&buck9_reg>;
+		inl4-supply = <&buck9_reg>;
+		inl5-supply = <&buck9_reg>;
+		inl6-supply = <&buck10_reg>;
+		inl7-supply = <&buck9_reg>;
+		/* inl9 supply is BOOST, not configured here */
+		inl10-supply = <&buck7_reg>;
+
+		regulators {
+			buck1_reg: BUCK1 {
+				regulator-name = "vdd_mif";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck2_reg: BUCK2 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck3_reg: BUCK3 {
+				regulator-name = "vdd_int";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck4_reg: BUCK4 {
+				regulator-name = "vdd_g3d";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck5_reg: BUCK5 {
+				regulator-name = "vdd_mem";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck6_reg: BUCK6 {
+				regulator-name = "vdd_kfc";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck7_reg: BUCK7 {
+				regulator-name = "buck7";
+				regulator-min-microvolt = <1300000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck8_reg: BUCK8 {
+				/* vdd_mmc0 */
+				regulator-name = "vddf_2v85";
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <2850000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck9_reg: BUCK9 {
+				regulator-name = "buck9";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			buck10_reg: BUCK10 {
+				regulator-name = "buck10";
+				regulator-min-microvolt = <2950000>;
+				regulator-max-microvolt = <2950000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo1_reg: LDO1 {
+				regulator-name = "vdd_alive";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			ldo2_reg: LDO2 {
+				regulator-name = "vddq_m1_m2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+			};
+
+			ldo3_reg: LDO3 {
+				regulator-name = "vddq_gpio";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo4_reg: LDO4 {
+				regulator-name = "vddq_mmc2";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3000000>;
+				/* Having it off prevents reboot */
+				regulator-always-on;
+			};
+
+			ldo5_reg: LDO5 {
+				regulator-name = "vdd18_hsic";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo6_reg: LDO6 {
+				regulator-name = "vdd18_bpll";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo7_reg: LDO7 {
+				regulator-name = "vddq_lcd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			ldo8_reg: LDO8 {
+				regulator-name = "vdd10_hdmi";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			ldo9_reg: LDO9 {
+				regulator-name = "ldo9";
+			};
+
+			ldo10_reg: LDO10 {
+				regulator-name = "vdd18_mipi";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo11_reg: LDO11 {
+				regulator-name = "vddq_mmc01";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				/*
+				 * Having it off prevents accessing MMC after
+				 * reboot with error:
+				 * MMC Device 1: Clock OFF has been failed.
+				 */
+				regulator-always-on;
+			};
+
+			ldo12_reg: LDO12 {
+				regulator-name = "vdd33_usb3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			ldo13_reg: LDO13 {
+				regulator-name = "vddq_abbg0";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo14_reg: LDO14 {
+				regulator-name = "vddq_abbg1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			ldo15_reg: LDO15 {
+				regulator-name = "vdd10_usb3";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
+			ldo16_reg: LDO16 {
+				regulator-name = "ldo16";
+			};
+
+			ldo17_reg: LDO17 {
+				regulator-name = "cam_sensor_core";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			ldo18_reg: LDO18 {
+				regulator-name = "ldo18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			ldo19_reg: LDO19 {
+				regulator-name = "ldo19";
+			};
+
+			ldo20_reg: LDO20 {
+				regulator-name = "vdd_mmc0";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			ldo21_reg: LDO21 {
+				/* vdd_mmc2 */
+				regulator-name = "vddf_2v8";
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <2850000>;
+			};
+
+			ldo22_reg: LDO22 {
+				regulator-name = "ldo22";
+			};
+
+			ldo23_reg: LDO23 {
+				regulator-name = "dp_p3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			ldo24_reg: LDO24 {
+				regulator-name = "cam_af";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+			};
+
+			ldo25_reg: LDO25 {
+				regulator-name = "eth_p3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			ldo26_reg: LDO26 {
+				regulator-name = "usb30_extclk";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			ldo27_reg: LDO27 {
+				regulator-name = "ldo27";
+			};
+
+			ldo28_reg: LDO28 {
+				regulator-name = "ldo28";
+			};
+
+			ldo29_reg: LDO29 {
+				regulator-name = "ldo29";
+			};
+
+			ldo30_reg: LDO30 {
+				regulator-name = "vddq_e1_e2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+			};
+
+			ldo31_reg: LDO31 {
+				regulator-name = "ldo31";
+			};
+
+			/* On revisions with ti,ina231 this is sensor VS */
+			ldo32_reg: LDO32 {
+				regulator-name = "vs_power_meter";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo33_reg: LDO33 {
+				regulator-name = "ldo33";
+			};
+
+			ldo34_reg: LDO34 {
+				regulator-name = "ldo34";
+			};
+
+			ldo35_reg: LDO35 {
+				regulator-name = "ldo35";
+			};
+		};
+	};
+};
+
 &mmc_0 {
 	status = "okay";
 	mmc-pwrseq = <&emmc_pwrseq>;
@@ -73,6 +455,8 @@
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
+	vmmc-supply = <&ldo20_reg>;
+	vqmmc-supply = <&ldo11_reg>;
 };
 
 &mmc_2 {
@@ -85,17 +469,66 @@
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
 	cap-sd-highspeed;
+	vmmc-supply = <&ldo21_reg>;
+	vqmmc-supply = <&ldo4_reg>;
 };
 
 &pinctrl_0 {
 	emmc_nrst_pin: emmc-nrst {
 		samsung,pins = "gpd1-0";
-		samsung,pin-function = <0>;
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	pmic_dvs_3: pmic-dvs-3 {
+		samsung,pins = "gpx0-0";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	pmic_dvs_2: pmic-dvs-2 {
+		samsung,pins = "gpx0-1";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	pmic_dvs_1: pmic-dvs-1 {
+		samsung,pins = "gpx0-2";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+		samsung,pin-val = <1>;
+	};
+
+	max77802_irq: max77802-irq {
+		samsung,pins = "gpx0-4";
+		samsung,pin-function = <0xf>;
 		samsung,pin-pud = <0>;
 		samsung,pin-drv = <0>;
 	};
 };
 
+&pwm {
+	/*
+	 * PWM 0 -- fan
+	 * PWM 1 -- Green LED
+	 * PWM 2 -- Blue LED
+	 * PWM 3 -- on MIPI connector for backlight
+	 */
+	pinctrl-0 = <&pwm0_out &pwm1_out &pwm2_out &pwm3_out>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+	clocks = <&clock CLK_RTC>, <&max77802 MAX77802_CLK_32K_AP>;
+	clock-names = "rtc", "rtc_src";
+};
+
 &serial_0 {
 	status = "okay";
 };
@@ -112,6 +545,22 @@
 	status = "okay";
 };
 
+&tmu_cpu0 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu1 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu2 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
+&tmu_cpu3 {
+	vtmu-supply = <&ldo10_reg>;
+};
+
 &usbdrd_dwc3_0 {
 	dr_mode = "host";
 };
@@ -119,3 +568,13 @@
 &usbdrd_dwc3_1 {
 	dr_mode = "peripheral";
 };
+
+&usbdrd3_0 {
+	vdd33-supply = <&ldo12_reg>;
+	vdd10-supply = <&ldo15_reg>;
+};
+
+&usbdrd3_1 {
+	vdd33-supply = <&ldo12_reg>;
+	vdd10-supply = <&ldo15_reg>;
+};
-- 
2.7.4
