From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 31 Mar 2017 21:41:23 +0200
Subject: [PATCH] arm64: dts: rk3399: add support for firefly-rk3399 board
In-Reply-To: <9cfe8ee4-16bc-fa5a-78bc-1939d595101a@suse.de>
References: <1490954348-13889-1-git-send-email-kever.yang@rock-chips.com>
 <1860080.ebfBDdk4Fv@phil> <9cfe8ee4-16bc-fa5a-78bc-1939d595101a@suse.de>
Message-ID: <2267024.EkVhuakEXa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Freitag, 31. M?rz 2017, 18:59:49 CEST schrieb Andreas F?rber:
> Am 31.03.2017 um 14:56 schrieb Heiko Stuebner:
> > Hi Kever,
> > 
> > Am Freitag, 31. M?rz 2017, 17:59:07 CEST schrieb Kever Yang:
> >> Firefly-rk3399 is a bord from T-Firefly, you can find detail about
> >> it here:
> >> http://en.t-firefly.com/en/firenow/Firefly_RK3399/
> >>
> >> This patch add basic node for the board and make it able to bring
> >> up.
> > 
> > This more a first glance, I didn't check every binding, but already found
> > some dubious ones, so in general, please make sure to only include nodes
> > with approved bindings.
> > 
> > 
> > [...]
> > 
> >>  arch/arm64/boot/dts/rockchip/Makefile           |   1 +
> >>  arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 772 ++++++++++++++++++++++++
> > 
> > please provide a binding addition for the board in a separate patch as well.
> > 
> > 
> >>  2 files changed, 773 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> >> index 3a86289..dd3d550 100644
> >> --- a/arch/arm64/boot/dts/rockchip/Makefile
> >> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> >> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-orion-r68-meta.dtb
> >>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-px5-evb.dtb
> >>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
> >>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-evb.dtb
> >> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
> > 
> > if possible, please rebase on top of my for-next branch, as we also
> > have the first gru board in there now.
> > 
> >>  
> >>  always		:= $(dtb-y)
> >>  subdir-y	:= $(dts-dirs)
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> >> new file mode 100644
> >> index 0000000..686977b
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> >> @@ -0,0 +1,772 @@
> >> +/*
> >> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
> 
> "Ltd."?
> 
> >> + *
> >> + * This file is dual-licensed: you can use it either under the terms
> >> + * of the GPL or the X11 license, at your option. Note that this dual
> >> + * licensing only applies to this file, and not this project as a
> >> + * whole.
> >> + *
> >> + *  a) This file is free software; you can redistribute it and/or
> >> + *     modify it under the terms of the GNU General Public License as
> >> + *     published by the Free Software Foundation; either version 2 of the
> >> + *     License, or (at your option) any later version.
> >> + *
> >> + *     This file is distributed in the hope that it will be useful,
> >> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + *     GNU General Public License for more details.
> >> + *
> >> + * Or, alternatively,
> >> + *
> >> + *  b) Permission is hereby granted, free of charge, to any person
> >> + *     obtaining a copy of this software and associated documentation
> >> + *     files (the "Software"), to deal in the Software without
> >> + *     restriction, including without limitation the rights to use,
> >> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> >> + *     sell copies of the Software, and to permit persons to whom the
> >> + *     Software is furnished to do so, subject to the following
> >> + *     conditions:
> >> + *
> >> + *     The above copyright notice and this permission notice shall be
> >> + *     included in all copies or substantial portions of the Software.
> >> + *
> >> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> >> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> >> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> >> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >> + *     OTHER DEALINGS IN THE SOFTWARE.
> 
> This should be shorter: "SPDX-License-Identifier: GPL-2.0+ OR MIT"

I'm not sure about that. There was disagreement over using SPDX in some
other dts [0]. Sadly it doesn't look like it was resolved either way.

Asking armsoc people on IRC just now, there really isn't any decision one
way or another, so please stay with real license texts until there is an
actual consensus on using spdx tags instead of license texts.


[0] https://lkml.org/lkml/2017/2/28/750

> 
> >> + */
> >> +
> >> +/dts-v1/;
> >> +#include <dt-bindings/pwm/pwm.h>
> >> +#include "rk3399.dtsi"
> >> +
> >> +/ {
> >> +	model = "Rockchip RK3399 Firefly Board (Linux Opensource)";
> 
> "(Linux Opensource)" is not a hardware description, please drop.
> 
> >> +	compatible = "rockchip,rk3399-firefly-linux", "rockchip,rk3399";
> > 
> > Just to make sure, is this really a Rockchip board? I would've expected
> > to see something like "firefly,firefly-rk3399" here, like on the rk3288-
> > variant. Not a requirement, just a question to clarify who designed the
> > board please :-) .
> 
> +1, especially no -linux suffix please. The same device tree should in
> theory be usable with Linux, Android, FreeBSD or any other OS with
> drivers based on the official bindings.
> 
> >> +
> >> +	backlight: backlight {
> >> +		status = "okay";
> >> +		compatible = "pwm-backlight";
> >> +		enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> >> +		pwms = <&pwm0 0 25000 0>;
> >> +		brightness-levels = <
> >> +			  0   1   2   3   4   5   6   7
> >> +			  8   9  10  11  12  13  14  15
> >> +			 16  17  18  19  20  21  22  23
> >> +			 24  25  26  27  28  29  30  31
> >> +			 32  33  34  35  36  37  38  39
> >> +			 40  41  42  43  44  45  46  47
> >> +			 48  49  50  51  52  53  54  55
> >> +			 56  57  58  59  60  61  62  63
> >> +			 64  65  66  67  68  69  70  71
> >> +			 72  73  74  75  76  77  78  79
> >> +			 80  81  82  83  84  85  86  87
> >> +			 88  89  90  91  92  93  94  95
> >> +			 96  97  98  99 100 101 102 103
> >> +			104 105 106 107 108 109 110 111
> >> +			112 113 114 115 116 117 118 119
> >> +			120 121 122 123 124 125 126 127
> >> +			128 129 130 131 132 133 134 135
> >> +			136 137 138 139 140 141 142 143
> >> +			144 145 146 147 148 149 150 151
> >> +			152 153 154 155 156 157 158 159
> >> +			160 161 162 163 164 165 166 167
> >> +			168 169 170 171 172 173 174 175
> >> +			176 177 178 179 180 181 182 183
> >> +			184 185 186 187 188 189 190 191
> >> +			192 193 194 195 196 197 198 199
> >> +			200 201 202 203 204 205 206 207
> >> +			208 209 210 211 212 213 214 215
> >> +			216 217 218 219 220 221 222 223
> >> +			224 225 226 227 228 229 230 231
> >> +			232 233 234 235 236 237 238 239
> >> +			240 241 242 243 244 245 246 247
> >> +			248 249 250 251 252 253 254 255>;
> >> +		default-brightness-level = <200>;
> >> +	};
> >> +
> >> +	clkin_gmac: external-gmac-clock {
> >> +		compatible = "fixed-clock";
> >> +		clock-frequency = <125000000>;
> >> +		clock-output-names = "clkin_gmac";
> >> +		#clock-cells = <0>;
> >> +	};
> >> +
> >> +	rt5640-sound {
> 
> Drop rt5640- node prefix, or is there more than one?

There can be more, the dw_hdmi (once we support graphics) also brings its
sound node, if I remember correctly.


> 
> >> +		compatible = "simple-audio-card";
> >> +		simple-audio-card,format = "i2s";
> >> +		simple-audio-card,name = "rockchip,rt5640-codec";
> >> +		simple-audio-card,mclk-fs = <256>;
> >> +		simple-audio-card,widgets =
> >> +			"Microphone", "Mic Jack",
> >> +			"Headphone", "Headphone Jack";
> >> +		simple-audio-card,routing =
> >> +			"Mic Jack", "MICBIAS1",
> >> +			"IN1P", "Mic Jack",
> >> +			"Headphone Jack", "HPOL",
> >> +			"Headphone Jack", "HPOR";
> >> +		simple-audio-card,cpu {
> >> +			sound-dai = <&i2s1>;
> >> +		};
> >> +		simple-audio-card,codec {
> >> +			sound-dai = <&rt5640>;
> >> +		};
> 
> Insert while lines before these two nodes for readability?
> 
> >> +	};
> >> +
> >> +	sdio_pwrseq: sdio-pwrseq {
> >> +		compatible = "mmc-pwrseq-simple";
> >> +		clocks = <&rk808 1>;
> >> +		clock-names = "ext_clock";
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&wifi_enable_h>;
> >> +
> >> +		/*
> >> +		 * On the module itself this is one of these (depending
> >> +		 * on the actual card populated):
> >> +		 * - SDIO_RESET_L_WL_REG_ON
> >> +		 * - PDN (power down when low)
> >> +		 */
> >> +		reset-gpios = <&gpio0 10 GPIO_ACTIVE_LOW>; /* GPIO0_B2 */
> > 
> > Thanks to Andy's persistence, we have nice constants in the pinctrl-
> > binding-header now, like RK_PB2 for the above. So you can drop the
> > comment and use the constant instead for easier reading.
> > Same for other pins.
> > 
> > 
> >> +	};
> >> +
> >> +	vcc3v3_pcie: vcc3v3-pcie-regulator {
> >> +		compatible = "regulator-fixed";
> >> +		enable-active-high;
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +		gpio = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&pcie_drv>;
> >> +		regulator-name = "vcc3v3_pcie";
> >> +	};
> >> +
> >> +	vcc3v3_sys: vcc3v3-sys {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "vcc3v3_sys";
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +		regulator-min-microvolt = <3300000>;
> >> +		regulator-max-microvolt = <3300000>;
> >> +	};
> >> +
> >> +	vcc5v0_host: vcc5v0-host-regulator {
> >> +		compatible = "regulator-fixed";
> >> +		enable-active-high;
> >> +		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&host_vbus_drv>;
> >> +		regulator-name = "vcc5v0_host";
> >> +		regulator-always-on;
> >> +	};
> >> +
> >> +	vcc5v0_sys: vcc5v0-sys {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "vcc5v0_sys";
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +		regulator-min-microvolt = <5000000>;
> >> +		regulator-max-microvolt = <5000000>;
> >> +	};
> >> +
> >> +	vcc_phy: vcc-phy-regulator {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "vcc_phy";
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +	};
> >> +
> >> +	vdd_log: vdd-log {
> >> +		compatible = "pwm-regulator";
> >> +		pwms = <&pwm2 0 25000 1>;
> >> +		regulator-name = "vdd_log";
> >> +		regulator-min-microvolt = <800000>;
> >> +		regulator-max-microvolt = <1400000>;
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +
> >> +		/* for rockchip boot on */
> >> +		rockchip,pwm_id= <2>;
> >> +		rockchip,pwm_voltage = <1000000>;
> >> +	};
> >> +
> >> +	vccadc_ref: vccadc-ref {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "vcc1v8_sys";
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +		regulator-min-microvolt = <1800000>;
> >> +		regulator-max-microvolt = <1800000>;
> >> +	};
> >> +
> >> +	wireless-wlan {
> >> +		compatible = "wlan-platdata";
> >> +		rockchip,grf = <&grf>;
> >> +		wifi_chip_type = "ap6354";
> >> +		sdio_vref = <1800>;
> >> +		WIFI,host_wake_irq = <&gpio0 3 GPIO_ACTIVE_HIGH>; /* GPIO0_a3 */
> >> +		status = "okay";
> > 
> > that is not a valid binding, am I right? ;-)
> > So should be dropped.
> 
> ... or should be replaced by the proper binding (brcmfmac probably?).
> 
> > 
> >> +	};
> >> +
> >> +	wireless-bluetooth {
> >> +		compatible = "bluetooth-platdata";
> >> +		//wifi-bt-power-toggle;
> >> +		uart_rts_gpios = <&gpio2 19 GPIO_ACTIVE_LOW>; /* GPIO2_C3 */
> >> +		pinctrl-names = "default", "rts_gpio";
> >> +		pinctrl-0 = <&uart0_rts>;
> >> +		pinctrl-1 = <&uart0_gpios>;
> >> +		//BT,power_gpio  = <&gpio3 19 GPIO_ACTIVE_HIGH>; /* GPIOx_xx */
> >> +		BT,reset_gpio    = <&gpio0 9 GPIO_ACTIVE_HIGH>; /* GPIO0_B1 */
> >> +		BT,wake_gpio     = <&gpio2 26 GPIO_ACTIVE_HIGH>; /* GPIO2_D2 */
> >> +		BT,wake_host_irq = <&gpio0 4 GPIO_ACTIVE_HIGH>; /* GPIO0_A4 */
> >> +		status = "okay";
> >> +	};
> > 
> > same here
> 
> Move to corresponding uart node? (serdev bindings)

Oh, did this get merged, that would be pretty cool.


> >> +};
> >> +
> >> +&cpu_l0 {
> >> +	cpu-supply = <&vdd_cpu_l>;
> >> +};
> >> +
> >> +&cpu_l1 {
> >> +	cpu-supply = <&vdd_cpu_l>;
> >> +};
> >> +
> >> +&cpu_l2 {
> >> +	cpu-supply = <&vdd_cpu_l>;
> >> +};
> >> +
> >> +&cpu_l3 {
> >> +	cpu-supply = <&vdd_cpu_l>;
> >> +};
> >> +
> >> +&cpu_b0 {
> >> +	cpu-supply = <&vdd_cpu_b>;
> >> +};
> >> +
> >> +&cpu_b1 {
> >> +	cpu-supply = <&vdd_cpu_b>;
> >> +};
> >> +
> >> +&emmc_phy {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&gmac {
> >> +	assigned-clocks = <&cru SCLK_RMII_SRC>;
> >> +	assigned-clock-parents = <&clkin_gmac>;
> >> +	clock_in_out = "input";
> >> +	phy-supply = <&vcc_phy>;
> >> +	phy-mode = "rgmii";
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&rgmii_pins>;
> >> +	snps,reset-gpio = <&gpio3 15 GPIO_ACTIVE_LOW>;
> >> +	snps,reset-active-low;
> >> +	snps,reset-delays-us = <0 10000 50000>;
> >> +	tx_delay = <0x28>;
> >> +	rx_delay = <0x11>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&i2c0 {
> >> +	status = "okay";
> >> +	i2c-scl-rising-time-ns = <168>;
> >> +	i2c-scl-falling-time-ns = <4>;
> >> +	clock-frequency = <400000>;
> >> +
> >> +	vdd_cpu_b: syr827 at 40 {
> 
> Node name should not duplicate the model. pmic at 40?

Thanks Andreas for finding all these little bits :-)


Heiko
