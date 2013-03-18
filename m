From: Barry.Song@csr.com (Barry Song)
Date: Mon, 18 Mar 2013 15:04:39 +0800
Subject: [PATCH 2/2] ARM/dts: prima2: add .dtsi for atlas6 and .dts for
 atla6-evb board
In-Reply-To: <1363590279-5656-1-git-send-email-Barry.Song@csr.com>
References: <1363590279-5656-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1363590279-5656-3-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

atlas6.dtsi is basically a copy of prima2.dtsi as most components are
compatible with prima2 except that:
1. node of l2 cache is deleted
2. node multimedia engine is deleted
3. node of sata is deleted
4. node of sdmmc4 is deleted
5. powervr is moved to "powervr,sgx510"
6. pinctrl is moved to atlas6 as pinmux layout has big changes in
   atlas6
7. clock is moved to atlas6 as clock layout has changes in atlas6

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Jiansong Chen <Jiansong.Chen@csr.com>
---
 arch/arm/boot/dts/atlas6-evb.dts |   78 +++++
 arch/arm/boot/dts/atlas6.dtsi    |  668 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 746 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/atlas6-evb.dts
 create mode 100644 arch/arm/boot/dts/atlas6.dtsi

diff --git a/arch/arm/boot/dts/atlas6-evb.dts b/arch/arm/boot/dts/atlas6-evb.dts
new file mode 100644
index 0000000..ab042ca
--- /dev/null
+++ b/arch/arm/boot/dts/atlas6-evb.dts
@@ -0,0 +1,78 @@
+/*
+ * DTS file for CSR SiRFatlas6 Evaluation Board
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/dts-v1/;
+
+/include/ "atlas6.dtsi"
+
+/ {
+	model = "CSR SiRFatlas6 Evaluation Board";
+	compatible = "sirf,atlas6-cb", "sirf,atlas6";
+
+	memory {
+		reg = <0x00000000 0x20000000>;
+	};
+
+	axi {
+		peri-iobg {
+			uart at b0060000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart1_pins_a>;
+			};
+			spi at b00d0000 {
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi0_pins_a>;
+				spi at 0 {
+					compatible = "spidev";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+			spi at b0170000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi1_pins_a>;
+			};
+			i2c0: i2c at b00e0000 {
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				lcd at 40 {
+					compatible = "sirf,lcd";
+					reg = <0x40>;
+				};
+			};
+
+		};
+		disp-iobg {
+			lcd at 90010000 {
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&lcd_24pins_a>;
+			};
+		};
+	};
+	display: display at 0 {
+	    panels {
+		panel0: panel at 0 {
+			panel-name = "Innolux TFT";
+			hactive = <800>;
+			vactive = <480>;
+			left_margin = <20>;
+			right_margin = <234>;
+			upper_margin = <3>;
+			lower_margin = <41>;
+			hsync_len = <3>;
+			vsync_len = <2>;
+			pixclock = <33264000>;
+			sync = <3>;
+			timing = <0x88>;
+			};
+	    };
+	};
+};
diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
new file mode 100644
index 0000000..7d1a279
--- /dev/null
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -0,0 +1,668 @@
+/*
+ * DTS file for CSR SiRFatlas6 SoC
+ *
+ * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+/include/ "skeleton.dtsi"
+/ {
+	compatible = "sirf,atlas6";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			reg = <0x0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			/* from bootloader */
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	axi {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x40000000 0x40000000 0x80000000>;
+
+		intc: interrupt-controller at 80020000 {
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			compatible = "sirf,prima2-intc";
+			reg = <0x80020000 0x1000>;
+		};
+
+		sys-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x88000000 0x88000000 0x40000>;
+
+			clks: clock-controller at 88000000 {
+				compatible = "sirf,atlas6-clkc";
+				reg = <0x88000000 0x1000>;
+				interrupts = <3>;
+				#clock-cells = <1>;
+			};
+
+			reset-controller at 88010000 {
+				compatible = "sirf,prima2-rstc";
+				reg = <0x88010000 0x1000>;
+			};
+
+			rsc-controller at 88020000 {
+				compatible = "sirf,prima2-rsc";
+				reg = <0x88020000 0x1000>;
+			};
+		};
+
+		mem-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x90000000 0x90000000 0x10000>;
+
+			memory-controller at 90000000 {
+				compatible = "sirf,prima2-memc";
+				reg = <0x90000000 0x10000>;
+				interrupts = <27>;
+				clocks = <&clks 5>;
+			};
+		};
+
+		disp-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x90010000 0x90010000 0x30000>;
+
+			lcd at 90010000 {
+				compatible = "sirf,prima2-lcd";
+				reg = <0x90010000 0x20000>;
+				interrupts = <30>;
+				clocks = <&clks 34>;
+				display=<&display>;
+				/* later transfer to pwm */
+				bl-gpio = <&gpio 7 0>;
+				default-panel = <&panel0>;
+			};
+
+			vpp at 90020000 {
+				compatible = "sirf,prima2-vpp";
+				reg = <0x90020000 0x10000>;
+				interrupts = <31>;
+				clocks = <&clks 35>;
+			};
+		};
+
+		graphics-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x98000000 0x98000000 0x8000000>;
+
+			graphics at 98000000 {
+				compatible = "powervr,sgx510";
+				reg = <0x98000000 0x8000000>;
+				interrupts = <6>;
+				clocks = <&clks 32>;
+			};
+		};
+
+		dsp-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xa8000000 0xa8000000 0x2000000>;
+
+			dspif at a8000000 {
+				compatible = "sirf,prima2-dspif";
+				reg = <0xa8000000 0x10000>;
+				interrupts = <9>;
+			};
+
+			gps at a8010000 {
+				compatible = "sirf,prima2-gps";
+				reg = <0xa8010000 0x10000>;
+				interrupts = <7>;
+				clocks = <&clks 9>;
+			};
+
+			dsp at a9000000 {
+				compatible = "sirf,prima2-dsp";
+				reg = <0xa9000000 0x1000000>;
+				interrupts = <8>;
+				clocks = <&clks 8>;
+			};
+		};
+
+		peri-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xb0000000 0xb0000000 0x180000>,
+			       <0x56000000 0x56000000 0x1b00000>;
+
+			timer at b0020000 {
+				compatible = "sirf,prima2-tick";
+				reg = <0xb0020000 0x1000>;
+				interrupts = <0>;
+			};
+
+			nand at b0030000 {
+				compatible = "sirf,prima2-nand";
+				reg = <0xb0030000 0x10000>;
+				interrupts = <41>;
+				clocks = <&clks 26>;
+			};
+
+			audio at b0040000 {
+				compatible = "sirf,prima2-audio";
+				reg = <0xb0040000 0x10000>;
+				interrupts = <35>;
+				clocks = <&clks 27>;
+			};
+
+			uart0: uart at b0050000 {
+				cell-index = <0>;
+				compatible = "sirf,prima2-uart";
+				reg = <0xb0050000 0x1000>;
+				interrupts = <17>;
+				fifosize = <128>;
+				clocks = <&clks 13>;
+			};
+
+			uart1: uart at b0060000 {
+				cell-index = <1>;
+				compatible = "sirf,prima2-uart";
+				reg = <0xb0060000 0x1000>;
+				interrupts = <18>;
+				fifosize = <32>;
+				clocks = <&clks 14>;
+			};
+
+			uart2: uart at b0070000 {
+				cell-index = <2>;
+				compatible = "sirf,prima2-uart";
+				reg = <0xb0070000 0x1000>;
+				interrupts = <19>;
+				fifosize = <128>;
+				clocks = <&clks 15>;
+			};
+
+			usp0: usp at b0080000 {
+				cell-index = <0>;
+				compatible = "sirf,prima2-usp";
+				reg = <0xb0080000 0x10000>;
+				interrupts = <20>;
+				clocks = <&clks 28>;
+			};
+
+			usp1: usp at b0090000 {
+				cell-index = <1>;
+				compatible = "sirf,prima2-usp";
+				reg = <0xb0090000 0x10000>;
+				interrupts = <21>;
+				clocks = <&clks 29>;
+			};
+
+			dmac0: dma-controller at b00b0000 {
+				cell-index = <0>;
+				compatible = "sirf,prima2-dmac";
+				reg = <0xb00b0000 0x10000>;
+				interrupts = <12>;
+				clocks = <&clks 24>;
+			};
+
+			dmac1: dma-controller at b0160000 {
+				cell-index = <1>;
+				compatible = "sirf,prima2-dmac";
+				reg = <0xb0160000 0x10000>;
+				interrupts = <13>;
+				clocks = <&clks 25>;
+			};
+
+			vip at b00C0000 {
+				compatible = "sirf,prima2-vip";
+				reg = <0xb00C0000 0x10000>;
+				clocks = <&clks 31>;
+			};
+
+			spi0: spi at b00d0000 {
+				cell-index = <0>;
+				compatible = "sirf,prima2-spi";
+				reg = <0xb00d0000 0x10000>;
+				interrupts = <15>;
+				sirf,spi-num-chipselects = <1>;
+				cs-gpios = <&gpio 0 0>;
+				sirf,spi-dma-rx-channel = <25>;
+				sirf,spi-dma-tx-channel = <20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clks 19>;
+				status = "disabled";
+			};
+
+			spi1: spi at b0170000 {
+				cell-index = <1>;
+				compatible = "sirf,prima2-spi";
+				reg = <0xb0170000 0x10000>;
+				interrupts = <16>;
+				clocks = <&clks 20>;
+				status = "disabled";
+			};
+
+			i2c0: i2c at b00e0000 {
+				cell-index = <0>;
+				compatible = "sirf,prima2-i2c";
+				reg = <0xb00e0000 0x10000>;
+				interrupts = <24>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clks 17>;
+			};
+
+			i2c1: i2c at b00f0000 {
+				cell-index = <1>;
+				compatible = "sirf,prima2-i2c";
+				reg = <0xb00f0000 0x10000>;
+				interrupts = <25>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clks 18>;
+			};
+
+			tsc at b0110000 {
+				compatible = "sirf,prima2-tsc";
+				reg = <0xb0110000 0x10000>;
+				interrupts = <33>;
+				clocks = <&clks 16>;
+			};
+
+			gpio: pinctrl at b0120000 {
+				#gpio-cells = <2>;
+				#interrupt-cells = <2>;
+				compatible = "sirf,atlas6-pinctrl";
+				reg = <0xb0120000 0x10000>;
+				interrupts = <43 44 45 46 47>;
+				gpio-controller;
+				interrupt-controller;
+
+				lcd_16pins_a: lcd0 at 0 {
+					lcd {
+						sirf,pins = "lcd_16bitsgrp";
+						sirf,function = "lcd_16bits";
+					};
+				};
+				lcd_18pins_a: lcd0 at 1 {
+					lcd {
+						sirf,pins = "lcd_18bitsgrp";
+						sirf,function = "lcd_18bits";
+					};
+				};
+				lcd_24pins_a: lcd0 at 2 {
+					lcd {
+						sirf,pins = "lcd_24bitsgrp";
+						sirf,function = "lcd_24bits";
+					};
+				};
+				lcdrom_pins_a: lcdrom0 at 0 {
+					lcd {
+						sirf,pins = "lcdromgrp";
+						sirf,function = "lcdrom";
+					};
+				};
+				uart0_pins_a: uart0 at 0 {
+					uart {
+						sirf,pins = "uart0grp";
+						sirf,function = "uart0";
+					};
+				};
+				uart1_pins_a: uart1 at 0 {
+					uart {
+						sirf,pins = "uart1grp";
+						sirf,function = "uart1";
+					};
+				};
+				uart2_pins_a: uart2 at 0 {
+					uart {
+						sirf,pins = "uart2grp";
+						sirf,function = "uart2";
+					};
+				};
+				uart2_noflow_pins_a: uart2 at 1 {
+					uart {
+						sirf,pins = "uart2_nostreamctrlgrp";
+						sirf,function = "uart2_nostreamctrl";
+					};
+				};
+				spi0_pins_a: spi0 at 0 {
+					spi {
+						sirf,pins = "spi0grp";
+						sirf,function = "spi0";
+					};
+				};
+				spi1_pins_a: spi1 at 0 {
+					spi {
+						sirf,pins = "spi1grp";
+						sirf,function = "spi1";
+					};
+				};
+				i2c0_pins_a: i2c0 at 0 {
+					i2c {
+						sirf,pins = "i2c0grp";
+						sirf,function = "i2c0";
+					};
+				};
+				i2c1_pins_a: i2c1 at 0 {
+					i2c {
+						sirf,pins = "i2c1grp";
+						sirf,function = "i2c1";
+					};
+				};
+                                pwm0_pins_a: pwm0 at 0 {
+                                        pwm {
+                                                sirf,pins = "pwm0grp";
+                                                sirf,function = "pwm0";
+                                        };
+                                };
+                                pwm1_pins_a: pwm1 at 0 {
+                                        pwm {
+                                                sirf,pins = "pwm1grp";
+                                                sirf,function = "pwm1";
+                                        };
+                                };
+                                pwm2_pins_a: pwm2 at 0 {
+                                        pwm {
+                                                sirf,pins = "pwm2grp";
+                                                sirf,function = "pwm2";
+                                        };
+                                };
+                                pwm3_pins_a: pwm3 at 0 {
+                                        pwm {
+                                                sirf,pins = "pwm3grp";
+                                                sirf,function = "pwm3";
+                                        };
+                                };
+				pwm4_pins_a: pwm4 at 0 {
+                                        pwm {
+                                                sirf,pins = "pwm4grp";
+                                                sirf,function = "pwm4";
+                                        };
+                                };
+                                gps_pins_a: gps at 0 {
+                                        gps {
+                                                sirf,pins = "gpsgrp";
+                                                sirf,function = "gps";
+                                        };
+                                };
+                                vip_pins_a: vip at 0 {
+                                        vip {
+                                                sirf,pins = "vipgrp";
+                                                sirf,function = "vip";
+                                        };
+                                };
+                                sdmmc0_pins_a: sdmmc0 at 0 {
+                                        sdmmc0 {
+                                                sirf,pins = "sdmmc0grp";
+                                                sirf,function = "sdmmc0";
+                                        };
+                                };
+                                sdmmc1_pins_a: sdmmc1 at 0 {
+                                        sdmmc1 {
+                                                sirf,pins = "sdmmc1grp";
+                                                sirf,function = "sdmmc1";
+                                        };
+                                };
+                                sdmmc2_pins_a: sdmmc2 at 0 {
+                                        sdmmc2 {
+                                                sirf,pins = "sdmmc2grp";
+                                                sirf,function = "sdmmc2";
+                                        };
+                                };
+				sdmmc2_nowp_pins_a: sdmmc2_nowp at 0 {
+                                        sdmmc2_nowp {
+                                                sirf,pins = "sdmmc2_nowpgrp";
+                                                sirf,function = "sdmmc2_nowp";
+                                        };
+                                };
+                                sdmmc3_pins_a: sdmmc3 at 0 {
+                                        sdmmc3 {
+                                                sirf,pins = "sdmmc3grp";
+                                                sirf,function = "sdmmc3";
+                                        };
+                                };
+                                sdmmc5_pins_a: sdmmc5 at 0 {
+                                        sdmmc5 {
+                                                sirf,pins = "sdmmc5grp";
+                                                sirf,function = "sdmmc5";
+                                        };
+                                };
+                                i2s_pins_a: i2s at 0 {
+                                        i2s {
+                                                sirf,pins = "i2sgrp";
+                                                sirf,function = "i2s";
+                                        };
+                                };
+				i2s_no_din_pins_a: i2s_no_din at 0 {
+                                        i2s_no_din {
+                                                sirf,pins = "i2s_no_dingrp";
+                                                sirf,function = "i2s_no_din";
+                                        };
+                                };
+				i2s_6chn_pins_a: i2s_6chn at 0 {
+                                        i2s_6chn {
+                                                sirf,pins = "i2s_6chngrp";
+                                                sirf,function = "i2s_6chn";
+                                        };
+                                };
+                                ac97_pins_a: ac97 at 0 {
+                                        ac97 {
+                                                sirf,pins = "ac97grp";
+                                                sirf,function = "ac97";
+                                        };
+                                };
+                                nand_pins_a: nand at 0 {
+                                        nand {
+                                                sirf,pins = "nandgrp";
+                                                sirf,function = "nand";
+                                        };
+                                };
+                                usp0_pins_a: usp0 at 0 {
+                                        usp0 {
+                                                sirf,pins = "usp0grp";
+                                                sirf,function = "usp0";
+                                        };
+                                };
+                                usp1_pins_a: usp1 at 0 {
+                                        usp1 {
+                                                sirf,pins = "usp1grp";
+                                                sirf,function = "usp1";
+                                        };
+                                };
+                                usb0_upli_drvbus_pins_a: usb0_upli_drvbus at 0 {
+                                        usb0_upli_drvbus {
+                                                sirf,pins = "usb0_upli_drvbusgrp";
+                                                sirf,function = "usb0_upli_drvbus";
+                                        };
+                                };
+                                usb1_utmi_drvbus_pins_a: usb1_utmi_drvbus at 0 {
+                                        usb1_utmi_drvbus {
+                                                sirf,pins = "usb1_utmi_drvbusgrp";
+                                                sirf,function = "usb1_utmi_drvbus";
+                                        };
+                                };
+                                warm_rst_pins_a: warm_rst at 0 {
+                                        warm_rst {
+                                                sirf,pins = "warm_rstgrp";
+                                                sirf,function = "warm_rst";
+                                        };
+                                };
+                                pulse_count_pins_a: pulse_count at 0 {
+                                        pulse_count {
+                                                sirf,pins = "pulse_countgrp";
+                                                sirf,function = "pulse_count";
+                                        };
+                                };
+                                cko0_rst_pins_a: cko0_rst at 0 {
+                                        cko0_rst {
+                                                sirf,pins = "cko0_rstgrp";
+                                                sirf,function = "cko0_rst";
+                                        };
+                                };
+                                cko1_rst_pins_a: cko1_rst at 0 {
+                                        cko1_rst {
+                                                sirf,pins = "cko1_rstgrp";
+                                                sirf,function = "cko1_rst";
+                                        };
+                                };
+			};
+
+			pwm at b0130000 {
+				compatible = "sirf,prima2-pwm";
+				reg = <0xb0130000 0x10000>;
+				clocks = <&clks 21>;
+			};
+
+			efusesys at b0140000 {
+				compatible = "sirf,prima2-efuse";
+				reg = <0xb0140000 0x10000>;
+				clocks = <&clks 22>;
+			};
+
+			pulsec at b0150000 {
+				compatible = "sirf,prima2-pulsec";
+				reg = <0xb0150000 0x10000>;
+				interrupts = <48>;
+				clocks = <&clks 23>;
+			};
+
+			pci-iobg {
+				compatible = "sirf,prima2-pciiobg", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x56000000 0x56000000 0x1b00000>;
+
+				sd0: sdhci at 56000000 {
+					cell-index = <0>;
+					compatible = "sirf,prima2-sdhc";
+					reg = <0x56000000 0x100000>;
+					interrupts = <38>;
+					bus-width = <8>;
+					clocks = <&clks 36>;
+				};
+
+				sd1: sdhci at 56100000 {
+					cell-index = <1>;
+					compatible = "sirf,prima2-sdhc";
+					reg = <0x56100000 0x100000>;
+					interrupts = <38>;
+					status = "disabled";
+					clocks = <&clks 36>;
+				};
+
+				sd2: sdhci at 56200000 {
+					cell-index = <2>;
+					compatible = "sirf,prima2-sdhc";
+					reg = <0x56200000 0x100000>;
+					interrupts = <23>;
+					status = "disabled";
+					clocks = <&clks 37>;
+				};
+
+				sd3: sdhci at 56300000 {
+					cell-index = <3>;
+					compatible = "sirf,prima2-sdhc";
+					reg = <0x56300000 0x100000>;
+					interrupts = <23>;
+					status = "disabled";
+					clocks = <&clks 37>;
+				};
+
+				sd5: sdhci at 56500000 {
+					cell-index = <5>;
+					compatible = "sirf,prima2-sdhc";
+					reg = <0x56500000 0x100000>;
+					interrupts = <39>;
+					status = "disabled";
+					clocks = <&clks 38>;
+				};
+
+				pci-copy at 57900000 {
+					compatible = "sirf,prima2-pcicp";
+					reg = <0x57900000 0x100000>;
+					interrupts = <40>;
+				};
+
+				rom-interface at 57a00000 {
+					compatible = "sirf,prima2-romif";
+					reg = <0x57a00000 0x100000>;
+				};
+			};
+		};
+
+		rtc-iobg {
+			compatible = "sirf,prima2-rtciobg", "sirf-prima2-rtciobg-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x80030000 0x10000>;
+
+			gpsrtc at 1000 {
+				compatible = "sirf,prima2-gpsrtc";
+				reg = <0x1000 0x1000>;
+				interrupts = <55 56 57>;
+			};
+
+			sysrtc at 2000 {
+				compatible = "sirf,prima2-sysrtc";
+				reg = <0x2000 0x1000>;
+				interrupts = <52 53 54>;
+			};
+
+			pwrc at 3000 {
+				compatible = "sirf,prima2-pwrc";
+				reg = <0x3000 0x1000>;
+				interrupts = <32>;
+			};
+		};
+
+		uus-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xb8000000 0xb8000000 0x40000>;
+
+			usb0: usb at b00e0000 {
+				compatible = "chipidea,ci13611a-prima2";
+				reg = <0xb8000000 0x10000>;
+				interrupts = <10>;
+				clocks = <&clks 40>;
+			};
+
+			usb1: usb at b00f0000 {
+				compatible = "chipidea,ci13611a-prima2";
+				reg = <0xb8010000 0x10000>;
+				interrupts = <11>;
+				clocks = <&clks 41>;
+			};
+
+			security at b00f0000 {
+				compatible = "sirf,prima2-security";
+				reg = <0xb8030000 0x10000>;
+				interrupts = <42>;
+				clocks = <&clks 7>;
+			};
+		};
+	};
+};
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
