From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Thu, 21 Apr 2016 11:58:12 +0800
Subject: [PATCH] ARM64: dts: rockchip: add core dtsi file for RK3399 SoCs
In-Reply-To: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds rk3399.dtsi for rk3399 found on Rockchip
RK3399 SoCs, also add rk3399-evb.dts for Rockchip RK3399
Evaluation Board.

Patch is tested on RK3399 evb.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/Makefile       |    1 +
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts |  537 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi    | 1757 +++++++++++++++++++++++++++
 3 files changed, 2295 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index df37865..7037a16 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -1,6 +1,7 @@
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-geekbox.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-evb.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
new file mode 100644
index 0000000..4cb0028
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -0,0 +1,537 @@
+/*
+ * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/pwm/pwm.h>
+#include "rk3399.dtsi"
+
+/ {
+	model = "Rockchip RK3399 Evaluation Board";
+	compatible = "rockchip,evb", "rockchip,rk3399-evb";
+
+	chosen {
+		bootargs = "console=uart,mmio32,0xff1a0000";
+	};
+
+	ramoops_mem: ramoops_mem {
+		reg = <0x0 0x100000 0x0 0x100000>;
+		reg-names = "ramoops_mem";
+	};
+
+	ramoops {
+		compatible = "ramoops";
+		record-size = <0x0 0x20000>;
+		console-size = <0x0 0x80000>;
+		ftrace-size = <0x0 0x10000>;
+		pmsg-size = <0x0 0x50000>;
+		memory-region = <&ramoops_mem>;
+	};
+
+	vcc3v3_sys: vcc3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vcc_phy: vcc-phy-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_phy";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 25000 0>;
+		brightness-levels = <
+			  0   1   2   3   4   5   6   7
+			  8   9  10  11  12  13  14  15
+			 16  17  18  19  20  21  22  23
+			 24  25  26  27  28  29  30  31
+			 32  33  34  35  36  37  38  39
+			 40  41  42  43  44  45  46  47
+			 48  49  50  51  52  53  54  55
+			 56  57  58  59  60  61  62  63
+			 64  65  66  67  68  69  70  71
+			 72  73  74  75  76  77  78  79
+			 80  81  82  83  84  85  86  87
+			 88  89  90  91  92  93  94  95
+			 96  97  98  99 100 101 102 103
+			104 105 106 107 108 109 110 111
+			112 113 114 115 116 117 118 119
+			120 121 122 123 124 125 126 127
+			128 129 130 131 132 133 134 135
+			136 137 138 139 140 141 142 143
+			144 145 146 147 148 149 150 151
+			152 153 154 155 156 157 158 159
+			160 161 162 163 164 165 166 167
+			168 169 170 171 172 173 174 175
+			176 177 178 179 180 181 182 183
+			184 185 186 187 188 189 190 191
+			192 193 194 195 196 197 198 199
+			200 201 202 203 204 205 206 207
+			208 209 210 211 212 213 214 215
+			216 217 218 219 220 221 222 223
+			224 225 226 227 228 229 230 231
+			232 233 234 235 236 237 238 239
+			240 241 242 243 244 245 246 247
+			248 249 250 251 252 253 254 255>;
+		default-brightness-level = <200>;
+		enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+	};
+
+	io-domains {
+		compatible = "rockchip,rk3399-io-voltage-domain";
+		rockchip,grf = <&grf>;
+
+		bt656-supply = <&vcc1v8_dvp>;
+		audio-supply = <&vcca1v8_codec>;
+		sdmmc-supply = <&vcc_sd>;
+		gpio1830-supply = <&vcc_3v0>;
+	};
+
+	pmu-io-domains {
+		compatible = "rockchip,rk3399-pmu-io-voltage-domain";
+		rockchip,grf = <&pmugrf>;
+
+		pmu1830-supply = <&vcc1v8_pmu>;
+	};
+
+	es8316-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "rockchip,es8316-codec";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Mic Jack", "MICBIAS1",
+			"IN1P", "Mic Jack",
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR";
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&es8316>;
+		};
+	};
+
+	spdif-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "rockchip,spdif";
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_b>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_b>;
+};
+
+&emmc_phy {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	i2c-scl-rising-time-ns = <450>;
+	i2c-scl-falling-time-ns = <15>;
+
+	rk808: pmic at 1b {
+		compatible = "rockchip,rk808";
+		reg = <0x1b>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l &pmic_dvs2>;
+		rockchip,system-power-controller;
+		wakeup-source;
+		#clock-cells = <1>;
+		clock-output-names = "xin32k", "rk808-clkout2";
+
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+		vcc10-supply = <&vcc3v3_sys>;
+		vcc11-supply = <&vcc3v3_sys>;
+		vcc12-supply = <&vcc3v3_sys>;
+		vddio-supply = <&vcc1v8_pmu>;
+
+		regulators {
+			vdd_cpu_b: DCDC_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-name = "vdd_cpu_b";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_l: DCDC_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-name = "vdd_cpu_l";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc_ddr";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc1v8_dvp: LDO_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8_dvp";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc3v0_tp: LDO_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc3v0_tp";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc1v8_pmu: LDO_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc_sd: LDO_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_sd";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcca3v0_codec: LDO_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcca3v0_codec";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc_1v5: LDO_REG6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-name = "vcc_1v5";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1500000>;
+				};
+			};
+
+			vcca1v8_codec: LDO_REG7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_codec";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc_3v0: LDO_REG8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc_3v0";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc3v3_s3: SWITCH_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc3v3_s3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc3v3_s0: SWITCH_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc3v3_s0";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+	i2c-scl-rising-time-ns = <600>;
+	i2c-scl-falling-time-ns = <20>;
+
+	gt9xx: gt9xx at 14 {
+		compatible = "goodix,gt9xx";
+		reg = <0x14>;
+		touch-gpio = <&gpio1 20 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpio = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+		max-x = <1200>;
+		max-y = <1900>;
+		tp-size = <911>;
+		tp-supply = <&vcc3v0_tp>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	i2c-scl-rising-time-ns = <300>;
+	i2c-scl-falling-time-ns = <15>;
+
+	es8316: es8316 at 10 {
+		#sound-dai-cells = <0>;
+		compatible = "everest,es8316";
+		reg = <0x10>;
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
+		clock-names = "mclk";
+		spk-con-gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+		hp-det-gpio = <&gpio4 28 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&i2s0 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+	rockchip,i2s-broken-burst-len;
+	rockchip,playback-channels = <8>;
+	rockchip,capture-channels = <8>;
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&sdhci {
+	status = "okay";
+	bus-width = <8>;
+	supports-emmc;
+	non-removable;
+	max-frequency = <50000000>;
+};
+
+&sdmmc {
+	status = "okay";
+	clock-frequency = <37500000>;
+	clock-freq-min-max = <400000 37500000>;
+	supports-sd;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+};
+
+&spdif {
+	status = "okay";
+	#sound-dai-cells = <0>;
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb2phy {
+	vbus_drv-gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
+};
+
+&usb_host0_echi {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_echi {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usbdrd3_0 {
+	status = "okay";
+};
+
+&usbdrd3_1 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	status = "okay";
+};
+
+&pinctrl {
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins =
+				<1 21 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pmic_dvs2: pmic-dvs2 {
+			rockchip,pins =
+				<1 18 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
new file mode 100644
index 0000000..7c3015c
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -0,0 +1,1757 @@
+/*
+ * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <dt-bindings/clock/rk3399-cru.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/power/rk3399-power.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	compatible = "rockchip,rk3399";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_l0>;
+				};
+				core1 {
+					cpu = <&cpu_l1>;
+				};
+				core2 {
+					cpu = <&cpu_l2>;
+				};
+				core3 {
+					cpu = <&cpu_l3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_b0>;
+				};
+				core1 {
+					cpu = <&cpu_b1>;
+				};
+			};
+		};
+
+		cpu_l0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			#cooling-cells = <2>; /* min followed by max */
+			clocks = <&cru ARMCLKL>;
+		};
+
+		cpu_l1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			clocks = <&cru ARMCLKL>;
+		};
+
+		cpu_l2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			clocks = <&cru ARMCLKL>;
+		};
+
+		cpu_l3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			clocks = <&cru ARMCLKL>;
+		};
+
+		cpu_b0: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			#cooling-cells = <2>; /* min followed by max */
+			clocks = <&cru ARMCLKB>;
+		};
+
+		cpu_b1: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			clocks = <&cru ARMCLKB>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	arm-pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	xin24m: xin24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "xin24m";
+	};
+
+	amba {
+		compatible = "arm,amba-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		dmac_bus: dma-controller at ff6d0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0xff6d0000 0x0 0x4000>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&cru ACLK_DMAC0_PERILP>;
+			clock-names = "apb_pclk";
+		};
+
+		dmac_peri: dma-controller at ff6e0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0xff6e0000 0x0 0x4000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&cru ACLK_DMAC1_PERILP>;
+			clock-names = "apb_pclk";
+		};
+	};
+
+	gmac: eth at fe300000 {
+		compatible = "rockchip,rk3399-gmac";
+		reg = <0x0 0xfe300000 0x0 0x10000>;
+		rockchip,grf = <&grf>;
+		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq";
+		clocks = <&cru SCLK_MAC>, <&cru SCLK_MAC_RX>,
+			 <&cru SCLK_MAC_TX>, <&cru SCLK_MACREF>,
+			 <&cru SCLK_MACREF_OUT>, <&cru ACLK_GMAC>,
+			 <&cru PCLK_GMAC>;
+		clock-names = "stmmaceth", "mac_clk_rx",
+			      "mac_clk_tx", "clk_mac_ref",
+			      "clk_mac_refout", "aclk_mac",
+			      "pclk_mac";
+		resets = <&cru SRST_A_GMAC>;
+		reset-names = "stmmaceth";
+		status = "disabled";
+	};
+
+	emmc_phy: phy {
+		compatible = "rockchip,rk3399-emmc-phy";
+		reg-offset = <0xf780>;
+		#phy-cells = <0>;
+		rockchip,grf = <&grf>;
+		status = "disabled";
+	};
+
+	sdio0: dwmmc at fe310000 {
+		compatible = "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x0 0xfe310000 0x0 0x4000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		clock-freq-min-max = <400000 150000000>;
+		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
+			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		fifo-depth = <0x100>;
+		status = "disabled";
+	};
+
+	sdmmc: dwmmc at fe320000 {
+		compatible = "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x0 0xfe320000 0x0 0x4000>;
+		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+		clock-freq-min-max = <400000 150000000>;
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
+			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		fifo-depth = <0x100>;
+		status = "disabled";
+	};
+
+	sdhci: sdhci at fe330000 {
+		compatible = "arasan,sdhci-5.1";
+		reg = <0x0 0xfe330000 0x0 0x10000>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
+		clock-names = "clk_xin", "clk_ahb";
+		phys = <&emmc_phy>;
+		phy-names = "phy_arasan";
+		status = "disabled";
+	};
+
+	usb2phy: usb2phy {
+		compatible = "rockchip,rk3399-usb-phy";
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb2phy0: usb2-phy0 {
+			#phy-cells = <0>;
+			#clock-cells = <0>;
+			reg = <0xe458>;
+		};
+
+		usb2phy1: usb2-phy1 {
+			#phy-cells = <0>;
+			#clock-cells = <0>;
+			reg = <0xe468>;
+		};
+	};
+
+	usb_host0_echi: usb at fe380000 {
+		compatible = "generic-ehci";
+		reg = <0x0 0xfe380000 0x0 0x20000>;
+		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>;
+		clock-names = "hclk_host0", "hclk_host0_arb";
+		phys = <&usb2phy0>;
+		phy-names = "usb2_phy0";
+		status = "disabled";
+	};
+
+	usb_host0_ohci: usb at fe3a0000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xfe3a0000 0x0 0x20000>;
+		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>;
+		clock-names = "hclk_host0", "hclk_host0_arb";
+		status = "disabled";
+	};
+
+	usb_host1_echi: usb at fe3c0000 {
+		compatible = "generic-ehci";
+		reg = <0x0 0xfe3c0000 0x0 0x20000>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>;
+		clock-names = "hclk_host1", "hclk_host1_arb";
+		phys = <&usb2phy1>;
+		phy-names = "usb2_phy1";
+		status = "disabled";
+	};
+
+	usb_host1_ohci: usb at fe3e0000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xfe3e0000 0x0 0x20000>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>;
+		clock-names = "hclk_host1", "hclk_host1_arb";
+		status = "disabled";
+	};
+
+	usbdrd3_0: usb at fe800000 {
+		compatible = "rockchip,dwc3";
+		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
+			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
+			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
+		clock-names = "clk_usb3otg0_ref", "clk_usb3otg0_suspend",
+			      "aclk_usb3otg0", "aclk_usb3_rksoc_axi_perf",
+			      "aclk_usb3", "aclk_usb3_grf";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+		usbdrd_dwc3_0: dwc3 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xfe800000 0x0 0x100000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "otg";
+			tx-fifo-resize;
+			snps,dis_enblslpm_quirk;
+			snps,phyif_utmi_16_bits;
+			snps,dis_u2_freeclk_exists_quirk;
+			snps,dis_del_phy_power_chg_quirk;
+			status = "disabled";
+		};
+	};
+
+	usbdrd3_1: usb at fe900000 {
+		compatible = "rockchip,dwc3";
+		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
+			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
+			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
+		clock-names = "clk_usb3otg1_ref", "clk_usb3otg1_suspend",
+			      "aclk_usb3otg1", "aclk_usb3_rksoc_axi_perf",
+			      "aclk_usb3", "aclk_usb3_grf";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+		usbdrd_dwc3_1: dwc3 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xfe900000 0x0 0x100000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "otg";
+			tx-fifo-resize;
+			snps,dis_enblslpm_quirk;
+			snps,phyif_utmi_16_bits;
+			snps,dis_u2_freeclk_exists_quirk;
+			snps,dis_del_phy_power_chg_quirk;
+			status = "disabled";
+		};
+	};
+
+	gic: interrupt-controller at fee00000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+
+		reg = <0x0 0xfee00000 0 0x10000>, /* GICD */
+		      <0x0 0xfef00000 0 0xc0000>, /* GICR */
+		      <0x0 0xfff00000 0 0x10000>, /* GICC */
+		      <0x0 0xfff10000 0 0x10000>, /* GICH */
+		      <0x0 0xfff20000 0 0x10000>; /* GICV */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		its: interrupt-controller at fee20000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0xfee20000 0x0 0x20000>;
+		};
+	};
+
+	saradc: saradc at ff100000 {
+		compatible = "rockchip,rk3399-saradc";
+		reg = <0x0 0xff100000 0x0 0x100>;
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		#io-channel-cells = <1>;
+		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
+		clock-names = "saradc", "apb_pclk";
+		status = "disabled";
+	};
+
+	i2c1: i2c at ff110000 {
+		compatible = "rockchip,rk3399-i2c";
+		reg = <0x0 0xff110000 0x0 0x1000>;
+		clocks = <&cru SCLK_I2C1>, <&cru PCLK_I2C1>;
+		clock-names = "i2c", "pclk";
+		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_xfer>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c2: i2c at ff120000 {
+		compatible = "rockchip,rk3399-i2c";
+		reg = <0x0 0xff120000 0x0 0x1000>;
+		clocks = <&cru SCLK_I2C2>, <&cru PCLK_I2C2>;
+		clock-names = "i2c", "pclk";
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c2_xfer>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c3: i2c at ff130000 {
+		compatible = "rockchip,rk3399-i2c";
+		reg = <0x0 0xff130000 0x0 0x1000>;
+		clocks = <&cru SCLK_I2C3>, <&cru PCLK_I2C3>;
+		clock-names = "i2c", "pclk";
+		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c3_xfer>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c5: i2c at ff140000 {
+		compatible = "rockchip,rk3399-i2c";
+		reg = <0x0 0xff140000 0x0 0x1000>;
+		clocks = <&cru SCLK_I2C5>, <&cru PCLK_I2C5>;
+		clock-names = "i2c", "pclk";
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c5_xfer>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c6: i2c at ff150000 {
+		compatible = "rockchip,rk3399-i2c";
+		reg = <0x0 0xff150000 0x0 0x1000>;
+		clocks = <&cru SCLK_I2C6>, <&cru PCLK_I2C6>;
+		clock-names = "i2c", "pclk";
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c6_xfer>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c7: i2c at ff160000 {
+		compatible = "rockchip,rk3399-i2c";
+		reg = <0x0 0xff160000 0x0 0x1000>;
+		clocks = <&cru SCLK_I2C7>, <&cru PCLK_I2C7>;
+		clock-names = "i2c", "pclk";
+		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c7_xfer>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	uart0: serial at ff180000 {
+		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xff180000 0x0 0x100>;
+		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
+		clock-names = "baudclk", "apb_pclk";
+		interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+                pinctrl-names = "default";
+                pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
+		status = "disabled";
+	};
+
+	uart1: serial at ff190000 {
+		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xff190000 0x0 0x100>;
+		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
+		clock-names = "baudclk", "apb_pclk";
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+                pinctrl-names = "default";
+                pinctrl-0 = <&uart1_xfer>;
+		status = "disabled";
+	};
+
+	uart2: serial at ff1a0000 {
+		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xff1a0000 0x0 0x100>;
+		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
+		clock-names = "baudclk", "apb_pclk";
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+                pinctrl-names = "default";
+                pinctrl-0 = <&uart2c_xfer>;
+		status = "disabled";
+	};
+
+	uart3: serial at ff1b0000 {
+		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xff1b0000 0x0 0x100>;
+		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
+		clock-names = "baudclk", "apb_pclk";
+		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+                pinctrl-names = "default";
+                pinctrl-0 = <&uart3_xfer &uart3_cts &uart3_rts>;
+		status = "disabled";
+	};
+
+	spi0: spi at ff1c0000 {
+		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xff1c0000 0x0 0x1000>;
+		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
+		clock-names = "spiclk", "apb_pclk";
+		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi1: spi at ff1d0000 {
+		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xff1d0000 0x0 0x1000>;
+		clocks = <&cru SCLK_SPI1>, <&cru PCLK_SPI1>;
+		clock-names = "spiclk", "apb_pclk";
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi2: spi at ff1e0000 {
+		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xff1e0000 0x0 0x1000>;
+		clocks = <&cru SCLK_SPI2>, <&cru PCLK_SPI2>;
+		clock-names = "spiclk", "apb_pclk";
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi2_clk &spi2_tx &spi2_rx &spi2_cs0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi4: spi at ff1f0000 {
+		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xff1f0000 0x0 0x1000>;
+		clocks = <&cru SCLK_SPI4>, <&cru PCLK_SPI4>;
+		clock-names = "spiclk", "apb_pclk";
+		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi4_clk &spi4_tx &spi4_rx &spi4_cs0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi5: spi at ff200000 {
+		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xff200000 0x0 0x1000>;
+		clocks = <&cru SCLK_SPI5>, <&cru PCLK_SPI5>;
+		clock-names = "spiclk", "apb_pclk";
+		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi5_clk &spi5_tx &spi5_rx &spi5_cs0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	thermal-zones {
+		cpu {
+			polling-delay-passive = <100>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+
+			thermal-sensors = <&tsadc 0>;
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					temperature = <70000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_alert1: cpu_alert1 {
+					temperature = <75000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_crit: cpu_crit {
+					temperature = <95000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device =
+						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_alert1>;
+					cooling-device =
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu {
+			polling-delay-passive = <100>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+
+			thermal-sensors = <&tsadc 1>;
+
+			trips {
+				gpu_alert0: gpu_alert0 {
+					temperature = <75000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				gpu_crit: gpu_crit {
+					temperature = <950000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert0>;
+					cooling-device =
+						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
+	tsadc: tsadc at ff260000 {
+		compatible = "rockchip,rk3399-tsadc";
+		reg = <0x0 0xff260000 0x0 0x100>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,grf = <&grf>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		resets = <&cru SRST_TSADC>;
+		reset-names = "tsadc-apb";
+		pinctrl-names = "init", "default", "sleep";
+		pinctrl-0 = <&otp_gpio>;
+		pinctrl-1 = <&otp_out>;
+		pinctrl-2 = <&otp_gpio>;
+		#thermal-sensor-cells = <1>;
+		rockchip,hw-tshut-temp = <95000>;
+		status = "disabled";
+	};
+
+	pmu: power-management at ff31000 {
+		compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
+		reg = <0x0 0xff310000 0x0 0x1000>;
+
+		power: power-controller {
+			compatible = "rockchip,rk3399-power-controller";
+			#power-domain-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pd_center {
+				reg = <RK3399_PD_CENTER>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_vdu {
+					reg = <RK3399_PD_VDU>;
+				};
+				pd_vcodec {
+					reg = <RK3399_PD_VCODEC>;
+				};
+				pd_iep {
+					reg = <RK3399_PD_IEP>;
+				};
+				pd_rga {
+					reg = <RK3399_PD_RGA>;
+				};
+			};
+			pd_vio {
+				reg = <RK3399_PD_VIO>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_isp0 {
+					reg = <RK3399_PD_ISP0>;
+				};
+				pd_isp1 {
+					reg = <RK3399_PD_ISP1>;
+				};
+				pd_hdcp {
+					reg = <RK3399_PD_HDCP>;
+				};
+				pd_vo {
+					reg = <RK3399_PD_VO>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pd_vopb {
+						reg = <RK3399_PD_VOPB>;
+					};
+					pd_vopl {
+						reg = <RK3399_PD_VOPL>;
+					};
+				};
+			};
+			pd_gpu {
+				reg = <RK3399_PD_GPU>;
+			};
+		};
+	};
+
+	pmugrf: syscon at ff320000 {
+		compatible = "rockchip,rk3399-pmugrf", "syscon";
+		reg = <0x0 0xff320000 0x0 0x1000>;
+	};
+
+	spi3: spi at ff350000 {
+		compatible = "rockchip,rk3399-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xff350000 0x0 0x1000>;
+		clocks = <&pmucru SCLK_SPI3_PMU>, <&pmucru PCLK_SPI3_PMU>;
+		clock-names = "spiclk", "apb_pclk";
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi3_clk &spi3_tx &spi3_rx &spi3_cs0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	uart4: serial at ff370000 {
+		compatible = "rockchip,rk3399-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xff370000 0x0 0x100>;
+		clocks = <&pmucru SCLK_UART4_PMU>, <&pmucru PCLK_UART4_PMU>;
+		clock-names = "baudclk", "apb_pclk";
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart4_xfer>;
+		status = "disabled";
+	};
+
+	i2c0: i2c at ff3c0000 {
+		compatible = "rockchip,rk3399-i2c";
+		reg = <0x0 0xff3c0000 0x0 0x1000>;
+		clocks =  <&pmucru SCLK_I2C0_PMU>, <&pmucru PCLK_I2C0_PMU>;
+		clock-names = "i2c", "pclk";
+		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_xfer>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c4: i2c at ff3d0000 {
+		compatible = "rockchip,rk3399-i2c";
+		reg = <0x0 0xff3d0000 0x0 0x1000>;
+		clocks = <&pmucru SCLK_I2C4_PMU>, <&pmucru PCLK_I2C4_PMU>;
+		clock-names = "i2c", "pclk";
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c4_xfer>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c8: i2c at ff3e0000 {
+		compatible = "rockchip,rk3399-i2c";
+		reg = <0x0 0xff3e0000 0x0 0x1000>;
+		clocks = <&pmucru SCLK_I2C8_PMU>, <&pmucru PCLK_I2C8_PMU>;
+		clock-names = "i2c", "pclk";
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c8_xfer>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	pwm0: pwm at ff420000 {
+		compatible = "rockchip,rk3399-pwm", "rockchip,rk3288-pwm";
+		reg = <0x0 0xff420000 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0_pin>;
+		clocks = <&pmucru PCLK_RKPWM_PMU>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
+	pwm1: pwm at ff420010 {
+		compatible = "rockchip,rk3399-pwm", "rockchip,rk3288-pwm";
+		reg = <0x0 0xff420010 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm1_pin>;
+		clocks = <&pmucru PCLK_RKPWM_PMU>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
+	pwm2: pwm at ff420020 {
+		compatible = "rockchip,rk3399-pwm", "rockchip,rk3288-pwm";
+		reg = <0x0 0xff420020 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm2_pin>;
+		clocks = <&pmucru PCLK_RKPWM_PMU>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
+	pwm3: pwm at ff420030 {
+		compatible = "rockchip,rk3399-pwm", "rockchip,rk3288-pwm";
+		reg = <0x0 0xff420030 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm3a_pin>;
+		clocks = <&pmucru PCLK_RKPWM_PMU>;
+		clock-names = "pwm";
+		status = "disabled";
+	};
+
+	rga: rga at ff680000 {
+		compatible = "rockchip,rk3399-rga";
+		reg = <0x0 0xff680000 0x0 0x10000>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "rga";
+		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA_CORE>;
+		clock-names = "aclk", "hclk", "sclk";
+		resets = <&cru SRST_RGA_CORE>, <&cru SRST_A_RGA>, <&cru SRST_H_RGA>;
+		reset-names = "core", "axi", "ahb";
+		status = "disabled";
+	};
+
+	pmucru: pmu-clock-controller at ff750000 {
+		compatible = "rockchip,rk3399-pmucru";
+		reg = <0x0 0xff750000 0x0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	cru: clock-controller at ff760000 {
+		compatible = "rockchip,rk3399-cru";
+		reg = <0x0 0xff760000 0x0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	grf: syscon at ff770000 {
+		compatible = "rockchip,rk3399-grf", "syscon";
+		reg = <0x0 0xff770000 0x0 0x10000>;
+	};
+
+	wdt0: watchdog at ff840000 {
+		compatible = "snps,dw-wdt";
+		reg = <0x0 0xff840000 0x0 0x100>;
+		clocks = <&cru PCLK_WDT>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	spdif: spdif at ff870000 {
+		compatible = "rockchip,rk3399-spdif";
+		reg = <0x0 0xff870000 0x0 0x1000>;
+		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+		dmas = <&dmac_bus 7>;
+		dma-names = "tx";
+		clock-names = "mclk", "hclk";
+		clocks = <&cru SCLK_SPDIF_8CH>, <&cru HCLK_SPDIF>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_bus>;
+		status = "disabled";
+	};
+
+	i2s0: i2s at ff880000 {
+		compatible = "rockchip,rk3399-i2s", "rockchip,rk3066-i2s";
+		reg = <0x0 0xff880000 0x0 0x1000>;
+		rockchip,grf = <&grf>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		dmas = <&dmac_bus 0>, <&dmac_bus 1>;
+		dma-names = "tx", "rx";
+		clock-names = "i2s_clk", "i2s_hclk";
+		clocks = <&cru SCLK_I2S0_8CH>, <&cru HCLK_I2S0_8CH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_8ch_bus>;
+		status = "disabled";
+	};
+
+	i2s1: i2s at ff890000 {
+		compatible = "rockchip,rk3399-i2s", "rockchip,rk3066-i2s";
+		reg = <0x0 0xff890000 0x0 0x1000>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		dmas = <&dmac_bus 2>, <&dmac_bus 3>;
+		dma-names = "tx", "rx";
+		clock-names = "i2s_clk", "i2s_hclk";
+		clocks = <&cru SCLK_I2S1_8CH>, <&cru HCLK_I2S1_8CH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s1_2ch_bus>;
+		status = "disabled";
+	};
+
+	i2s2: i2s at ff8a0000 {
+		compatible = "rockchip,rk3399-i2s", "rockchip,rk3066-i2s";
+		reg = <0x0 0xff8a0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		dmas = <&dmac_bus 4>, <&dmac_bus 5>;
+		dma-names = "tx", "rx";
+		clock-names = "i2s_clk", "i2s_hclk";
+		clocks = <&cru SCLK_I2S2_8CH>, <&cru HCLK_I2S2_8CH>;
+		status = "disabled";
+	};
+
+	gpu: gpu at ff9a0000 {
+		compatible = "arm,malit860",
+			     "arm,malit86x",
+			     "arm,malit8xx",
+			     "arm,mali-midgard";
+		reg = <0x0 0xff9a0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "GPU", "JOB", "MMU";
+
+		clocks = <&cru ACLK_GPU>;
+		clock-names = "clk_mali";
+		#cooling-cells = <2>; /* min followed by max */
+		status = "disabled";
+	};
+
+	vopl: vop at ff8f0000 {
+		compatible = "rockchip,rk3399-vop-lit";
+		reg = <0x0 0xff8f0000 0x0 0x3efc>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		resets = <&cru SRST_A_VOP1>, <&cru SRST_H_VOP1>, <&cru SRST_D_VOP1>;
+		reset-names = "axi", "ahb", "dclk";
+		iommus = <&vopl_mmu>;
+		status = "disabled";
+
+		vopl_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			vopl_out_mipi: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&mipi_in_vopl>;
+			};
+
+			vopl_out_edp: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&edp_in_vopl>;
+			};
+		};
+	};
+
+	vopl_mmu: iommu at ff8f3f00 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff8f3f00 0x0 0x100>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vopl_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vopb: vop at ff900000 {
+		compatible = "rockchip,rk3399-vop-big";
+		reg = <0x0 0xff900000 0x0 0x3efc>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		resets = <&cru SRST_A_VOP0>, <&cru SRST_H_VOP0>, <&cru SRST_D_VOP0>;
+		reset-names = "axi", "ahb", "dclk";
+		iommus = <&vopb_mmu>;
+		status = "disabled";
+
+		vopb_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			vopb_out_edp: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&edp_in_vopb>;
+			};
+
+			vopb_out_mipi: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&mipi_in_vopb>;
+			};
+		};
+	};
+
+	vopb_mmu: iommu at ff903f00 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff903f00 0x0 0x100>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vopb_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	mipi_dsi: mipi at ff960000 {
+		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
+		reg = <0x0 0xff960000 0x0 0x8000>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_MIPIDPHY_REF>, <&cru PCLK_MIPI_DSI0>,
+			 <&cru SCLK_DPHY_TX0_CFG>;
+		clock-names = "ref", "pclk", "phy_cfg";
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			mipi_in: port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mipi_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_mipi>;
+				};
+				mipi_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_mipi>;
+				};
+			};
+		};
+	};
+
+	edp: edp at ff970000 {
+		compatible = "rockchip,rk3399-edp";
+		reg = <0x0 0xff970000 0x0 0x8000>;
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_EDP>, <&cru PCLK_EDP_CTRL>;
+		clock-names = "dp", "pclk";
+		resets = <&cru SRST_P_EDP_CTRL>;
+		reset-names = "dp";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_hpd>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp_in: port at 0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				edp_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_edp>;
+				};
+
+				edp_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_edp>;
+				};
+			};
+		};
+	};
+
+	display_subsystem: display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vopl_out>, <&vopb_out>;
+		status = "disabled";
+	};
+
+	pinctrl: pinctrl {
+		compatible = "rockchip,rk3399-pinctrl";
+		rockchip,grf = <&grf>;
+		rockchip,pmu = <&pmugrf>;
+		#address-cells = <0x2>;
+		#size-cells = <0x2>;
+		ranges;
+
+		gpio0: gpio0 at ff720000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x0 0xff720000 0x0 0x100>;
+			clocks = <&pmucru PCLK_GPIO0_PMU>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+
+			gpio-controller;
+			#gpio-cells = <0x2>;
+
+			interrupt-controller;
+			#interrupt-cells = <0x2>;
+		};
+
+		gpio1: gpio1 at ff730000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x0 0xff730000 0x0 0x100>;
+			clocks = <&pmucru PCLK_GPIO1_PMU>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+
+			gpio-controller;
+			#gpio-cells = <0x2>;
+
+			interrupt-controller;
+			#interrupt-cells = <0x2>;
+		};
+
+		gpio2: gpio2 at ff780000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x0 0xff780000 0x0 0x100>;
+			clocks = <&cru PCLK_GPIO2>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+
+			gpio-controller;
+			#gpio-cells = <0x2>;
+
+			interrupt-controller;
+			#interrupt-cells = <0x2>;
+		};
+
+		gpio3: gpio3 at ff788000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x0 0xff788000 0x0 0x100>;
+			clocks = <&cru PCLK_GPIO3>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+
+			gpio-controller;
+			#gpio-cells = <0x2>;
+
+			interrupt-controller;
+			#interrupt-cells = <0x2>;
+		};
+
+		gpio4: gpio4 at ff790000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x0 0xff790000 0x0 0x100>;
+			clocks = <&cru PCLK_GPIO4>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+
+			gpio-controller;
+			#gpio-cells = <0x2>;
+
+			interrupt-controller;
+			#interrupt-cells = <0x2>;
+		};
+
+		pcfg_pull_up: pcfg-pull-up {
+			bias-pull-up;
+		};
+
+		pcfg_pull_down: pcfg-pull-down {
+			bias-pull-down;
+		};
+
+		pcfg_pull_none: pcfg-pull-none {
+			bias-disable;
+		};
+
+		pcfg_pull_none_12ma: pcfg-pull-none-12ma {
+			bias-disable;
+			drive-strength = <12>;
+		};
+
+		pcfg_pull_up_8ma: pcfg-pull-up-8ma {
+			bias-pull-up;
+			drive-strength = <8>;
+		};
+
+		pcfg_pull_down_4ma: pcfg-pull-down-4ma {
+			bias-pull-down;
+			drive-strength = <4>;
+		};
+
+		pcfg_pull_up_2ma: pcfg-pull-up-2ma {
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		pcfg_pull_down_12ma: pcfg-pull-down-12ma {
+			bias-pull-down;
+			drive-strength = <12>;
+		};
+
+		pcfg_pull_none_13ma: pcfg-pull-none-13ma {
+			bias-disable;
+			drive-strength = <13>;
+		};
+
+		edp {
+			edp_hpd: edp-hpd {
+				rockchip,pins =
+					<4 23 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		emmc {
+			emmc_pwr: emmc-pwr {
+				rockchip,pins =
+					<0 5 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
+		gmac {
+			rgmii_pins: rgmii-pins {
+				rockchip,pins =
+					/* mac_txclk */
+					<3 17 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_rxclk */
+					<3 14 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_mdio */
+					<3 13 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_txen */
+					<3 12 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_clk */
+					<3 11 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxdv */
+					<3 9 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_mdc */
+					<3 8 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxd1 */
+					<3 7 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxd0 */
+					<3 6 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_txd1 */
+					<3 5 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_txd0 */
+					<3 4 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_rxd3 */
+					<3 3 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxd2 */
+					<3 2 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_txd3 */
+					<3 1 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_txd2 */
+					<3 0 RK_FUNC_1 &pcfg_pull_none_13ma>;
+			};
+
+			rmii_pins: rmii-pins {
+				rockchip,pins =
+					/* mac_mdio */
+					<3 13 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_txen */
+					<3 12 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_clk */
+					<3 11 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxer */
+					<3 10 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxdv */
+					<3 9 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_mdc */
+					<3 8 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxd1 */
+					<3 7 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxd0 */
+					<3 6 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_txd1 */
+					<3 5 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_txd0 */
+					<3 4 RK_FUNC_1 &pcfg_pull_none_13ma>;
+			};
+		};
+
+		i2c0 {
+			i2c0_xfer: i2c0-xfer {
+				rockchip,pins =
+					<1 15 RK_FUNC_2 &pcfg_pull_none>,
+					<1 16 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		i2c1 {
+			i2c1_xfer: i2c1-xfer {
+				rockchip,pins =
+					<4 2 RK_FUNC_1 &pcfg_pull_none>,
+					<4 1 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c2 {
+			i2c2_xfer: i2c2-xfer {
+				rockchip,pins =
+					<2 1 RK_FUNC_2 &pcfg_pull_none_12ma>,
+					<2 0 RK_FUNC_2 &pcfg_pull_none_12ma>;
+			};
+		};
+
+		i2c3 {
+			i2c3_xfer: i2c3-xfer {
+				rockchip,pins =
+					<4 17 RK_FUNC_1 &pcfg_pull_none>,
+					<4 16 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c4 {
+			i2c4_xfer: i2c4-xfer {
+				rockchip,pins =
+					<1 12 RK_FUNC_1 &pcfg_pull_none>,
+					<1 11 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2c5 {
+			i2c5_xfer: i2c5-xfer {
+				rockchip,pins =
+					<3 11 RK_FUNC_2 &pcfg_pull_none>,
+					<3 10 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		i2c6 {
+			i2c6_xfer: i2c6-xfer {
+				rockchip,pins =
+					<2 10 RK_FUNC_2 &pcfg_pull_none>,
+					<2 9 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		i2c7 {
+			i2c7_xfer: i2c7-xfer {
+				rockchip,pins =
+					<2 8 RK_FUNC_2 &pcfg_pull_none>,
+					<2 7 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		i2c8 {
+			i2c8_xfer: i2c8-xfer {
+				rockchip,pins =
+					<1 21 RK_FUNC_1 &pcfg_pull_none>,
+					<1 20 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2s0 {
+			i2s0_8ch_bus: i2s0-8ch-bus {
+				rockchip,pins =
+					<3 24 RK_FUNC_1 &pcfg_pull_none>,
+					<3 25 RK_FUNC_1 &pcfg_pull_none>,
+					<3 26 RK_FUNC_1 &pcfg_pull_none>,
+					<3 27 RK_FUNC_1 &pcfg_pull_none>,
+					<3 28 RK_FUNC_1 &pcfg_pull_none>,
+					<3 29 RK_FUNC_1 &pcfg_pull_none>,
+					<3 30 RK_FUNC_1 &pcfg_pull_none>,
+					<3 31 RK_FUNC_1 &pcfg_pull_none>,
+					<4 0 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		i2s1 {
+			i2s1_2ch_bus: i2s1-2ch-bus {
+				rockchip,pins =
+					<4 3 RK_FUNC_1 &pcfg_pull_none>,
+					<4 4 RK_FUNC_1 &pcfg_pull_none>,
+					<4 5 RK_FUNC_1 &pcfg_pull_none>,
+					<4 6 RK_FUNC_1 &pcfg_pull_none>,
+					<4 7 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm0 {
+			pwm0_pin: pwm0-pin {
+				rockchip,pins =
+					<4 18 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			vop0_pwm_pin: vop0-pwm-pin {
+				rockchip,pins =
+					<4 18 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		pwm1 {
+			pwm1_pin: pwm1-pin {
+				rockchip,pins =
+					<4 22 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			vop1_pwm_pin: vop1-pwm-pin {
+				rockchip,pins =
+					<4 18 RK_FUNC_3 &pcfg_pull_none>;
+			};
+		};
+
+		pwm2 {
+			pwm2_pin: pwm2-pin {
+				rockchip,pins =
+					<1 19 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm3a {
+			pwm3a_pin: pwm3a-pin {
+				rockchip,pins =
+					<0 6 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm3b {
+			pwm3b_pin: pwm3b-pin {
+				rockchip,pins =
+					<1 14 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		sdio0 {
+			sdio0_bus1: sdio0-bus1 {
+				rockchip,pins =
+					<2 20 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_bus4: sdio0-bus4 {
+				rockchip,pins =
+					<2 20 RK_FUNC_1 &pcfg_pull_up>,
+					<2 21 RK_FUNC_1 &pcfg_pull_up>,
+					<2 22 RK_FUNC_1 &pcfg_pull_up>,
+					<2 23 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_cmd: sdio0-cmd {
+				rockchip,pins =
+					<2 24 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_clk: sdio0-clk {
+				rockchip,pins =
+					<2 25 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			sdio0_cd: sdio0-cd {
+				rockchip,pins =
+					<2 26 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_pwr: sdio0-pwr {
+				rockchip,pins =
+					<2 27 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_bkpwr: sdio0-bkpwr {
+				rockchip,pins =
+					<2 28 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_wp: sdio0-wp {
+				rockchip,pins =
+					<0 3 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdio0_int: sdio0-int {
+				rockchip,pins =
+					<0 4 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
+		sdmmc {
+			sdmmc_bus1: sdmmc-bus1 {
+				rockchip,pins =
+					<4 8 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdmmc_bus4: sdmmc-bus4 {
+				rockchip,pins =
+					<4 8 RK_FUNC_1 &pcfg_pull_up>,
+					<4 9 RK_FUNC_1 &pcfg_pull_up>,
+					<4 10 RK_FUNC_1 &pcfg_pull_up>,
+					<4 11 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdmmc_clk: sdmmc-clk {
+				rockchip,pins =
+					<4 12 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			sdmmc_cmd: sdmmc-cmd {
+				rockchip,pins =
+					<4 13 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdmmc_cd: sdmcc-cd {
+				rockchip,pins =
+					<0 7 RK_FUNC_1 &pcfg_pull_up>;
+			};
+
+			sdmmc_wp: sdmmc-wp {
+				rockchip,pins =
+					<0 8 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
+		spdif {
+			spdif_bus: spdif-bus {
+				rockchip,pins =
+					<4 21 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		spi0 {
+			spi0_clk: spi0-clk {
+				rockchip,pins =
+					<3 6 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_cs0: spi0-cs0 {
+				rockchip,pins =
+					<3 7 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_cs1: spi0-cs1 {
+				rockchip,pins =
+					<3 8 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_tx: spi0-tx {
+				rockchip,pins =
+					<3 5 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi0_rx: spi0-rx {
+				rockchip,pins =
+					<3 4 RK_FUNC_2 &pcfg_pull_up>;
+			};
+		};
+
+		spi1 {
+			spi1_clk: spi1-clk {
+				rockchip,pins =
+					<1 9 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi1_cs0: spi1-cs0 {
+				rockchip,pins =
+					<1 10 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi1_rx: spi1-rx {
+				rockchip,pins =
+					<1 7 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi1_tx: spi1-tx {
+				rockchip,pins =
+					<1 8 RK_FUNC_2 &pcfg_pull_up>;
+			};
+		};
+
+		spi2 {
+			spi2_clk: spi2-clk {
+				rockchip,pins =
+					<2 11 RK_FUNC_1 &pcfg_pull_up>;
+			};
+			spi2_cs0: spi2-cs0 {
+				rockchip,pins =
+					<2 12 RK_FUNC_1 &pcfg_pull_up>;
+			};
+			spi2_rx: spi2-rx {
+				rockchip,pins =
+					<2 9 RK_FUNC_1 &pcfg_pull_up>;
+			};
+			spi2_tx: spi2-tx {
+				rockchip,pins =
+					<2 10 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
+		spi3 {
+			spi3_clk: spi3-clk {
+				rockchip,pins =
+					<1 17 RK_FUNC_1 &pcfg_pull_up>;
+			};
+			spi3_cs0: spi3-cs0 {
+				rockchip,pins =
+					<1 18 RK_FUNC_1 &pcfg_pull_up>;
+			};
+			spi3_rx: spi3-rx {
+				rockchip,pins =
+					<1 15 RK_FUNC_1 &pcfg_pull_up>;
+			};
+			spi3_tx: spi3-tx {
+				rockchip,pins =
+					<1 16 RK_FUNC_1 &pcfg_pull_up>;
+			};
+		};
+
+		spi4 {
+			spi4_clk: spi4-clk {
+				rockchip,pins =
+					<3 2 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi4_cs0: spi4-cs0 {
+				rockchip,pins =
+					<3 3 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi4_rx: spi4-rx {
+				rockchip,pins =
+					<3 0 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi4_tx: spi4-tx {
+				rockchip,pins =
+					<3 1 RK_FUNC_2 &pcfg_pull_up>;
+			};
+		};
+
+		spi5 {
+			spi5_clk: spi5-clk {
+				rockchip,pins =
+					<2 22 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi5_cs0: spi5-cs0 {
+				rockchip,pins =
+					<2 23 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi5_rx: spi5-rx {
+				rockchip,pins =
+					<2 20 RK_FUNC_2 &pcfg_pull_up>;
+			};
+			spi5_tx: spi5-tx {
+				rockchip,pins =
+					<2 21 RK_FUNC_2 &pcfg_pull_up>;
+			};
+		};
+
+		tsadc {
+			otp_gpio: otp-gpio {
+				rockchip,pins = <1 6 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+
+			otp_out: otp-out {
+				rockchip,pins = <1 6 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		uart0 {
+			uart0_xfer: uart0-xfer {
+				rockchip,pins =
+					<2 16 RK_FUNC_1 &pcfg_pull_up>,
+					<2 17 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			uart0_cts: uart0-cts {
+				rockchip,pins =
+					<2 18 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			uart0_rts: uart0-rts {
+				rockchip,pins =
+					<2 19 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		uart1 {
+			uart1_xfer: uart1-xfer {
+				rockchip,pins =
+					<3 12 RK_FUNC_2 &pcfg_pull_up>,
+					<3 13 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		uart2a {
+			uart2a_xfer: uart2a-xfer {
+				rockchip,pins =
+					<4 8 RK_FUNC_2 &pcfg_pull_up>,
+					<4 9 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		uart2b {
+			uart2b_xfer: uart2b-xfer {
+				rockchip,pins =
+					<4 16 RK_FUNC_2 &pcfg_pull_up>,
+					<4 17 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		uart2c {
+			uart2c_xfer: uart2c-xfer {
+				rockchip,pins =
+					<4 19 RK_FUNC_1 &pcfg_pull_up>,
+					<4 20 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		uart3 {
+			uart3_xfer: uart3-xfer {
+				rockchip,pins =
+					<3 14 RK_FUNC_2 &pcfg_pull_up>,
+					<3 15 RK_FUNC_2 &pcfg_pull_none>;
+			};
+
+			uart3_cts: uart3-cts {
+				rockchip,pins =
+					<3 18 RK_FUNC_2 &pcfg_pull_none>;
+			};
+
+			uart3_rts: uart3-rts {
+				rockchip,pins =
+					<3 19 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		uart4 {
+			uart4_xfer: uart4-xfer {
+				rockchip,pins =
+					<1 7 RK_FUNC_1 &pcfg_pull_up>,
+					<1 8 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		uarthdcp {
+			uarthdcp_xfer: uarthdcp-xfer {
+				rockchip,pins =
+					<4 21 RK_FUNC_2 &pcfg_pull_up>,
+					<4 22 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+	};
+};
-- 
1.9.1
