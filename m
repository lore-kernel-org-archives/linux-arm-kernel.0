From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 13 Sep 2015 18:47:19 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: Add dtb for the Radxa Rock 2
 Square board
In-Reply-To: <1442011005-4828-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1442011005-4828-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1442011005-4828-2-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <2017541.TyKd5dqpTN@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sjoerd,

Am Samstag, 12. September 2015, 00:36:45 schrieb Sjoerd Simons:
> The Radxa Rock 2 Square board is a combination of the Radxa Rock 2 SoM
> with the Square baseboard. Add a dtsi for the SoM which can be included
> into the dts for the various baseboards (e.g. full and square) and a dts
> for the square board.
> 
> Currently supported are serial console, wired networking, hdmi output
> and USB.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> ---
> 
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/rk3288-rock2-som.dtsi   | 267
> ++++++++++++++++++++++++++++++ arch/arm/boot/dts/rk3288-rock2-square.dts |
> 164 ++++++++++++++++++ 3 files changed, 432 insertions(+)

please add an entry to Documentation/devicetree/arm/rockchip.txt for the new 
board too.

Some more nitpicks below:


>  create mode 100644 arch/arm/boot/dts/rk3288-rock2-som.dtsi
>  create mode 100644 arch/arm/boot/dts/rk3288-rock2-square.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 233159d..1ed8ec1 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -507,6 +507,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>  	rk3288-firefly-beta.dtb \
>  	rk3288-firefly.dtb \
>  	rk3288-r89.dtb \
> +	rk3288-rock2-square.dtb \
>  	rk3288-veyron-jerry.dtb \
>  	rk3288-veyron-minnie.dtb \
>  	rk3288-veyron-pinky.dtb \
> diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
> b/arch/arm/boot/dts/rk3288-rock2-som.dtsi new file mode 100644
> index 0000000..01e69e8
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
> @@ -0,0 +1,267 @@
> +/*
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <dt-bindings/pwm/pwm.h>
> +#include "rk3288.dtsi"
> +
> +/ {
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000>;

please swap those if possible. I try to keep the ordering like
- compatible
- reg
[alphabetic sorted]
- status

for ease of reading.


> +	};
> +
> +	ext_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "ext_gmac";
> +	};
> +
> +	vcc_sys: vsys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sys";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu0-supply = <&vdd_cpu>;
> +};
> +
> +

double empty line


> +&emmc {
> +	broken-cd;
[...]
> +	non-removable;

Documentation/devicetree/bindings/mmc/mmc.txt:
"Only one of the properties in this section should be supplied"

so I guess non-removable would be the most suitable


> +	num-slots = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
> +	vmmc-supply = <&vcc_io>;
> +	status = "okay";
> +};
> +
> +&gmac {
> +	assigned-clocks = <&cru SCLK_MAC>;
> +	assigned-clock-parents = <&ext_gmac>;
> +	clock_in_out = "input";
> +	phy-mode = "rgmii";
> +	phy-supply = <&vccio_pmu>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins &phy_rst>;
> +	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 10000 30000>;
> +	rx_delay = <0x10>;
> +	tx_delay = <0x30>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	act8846: act8846 at 5a {
> +		compatible = "active-semi,act8846";
> +		reg = <0x5a>;
> +		inl1-supply = <&vcc_io>;
> +		inl2-supply = <&vcc_sys>;
> +		inl3-supply = <&vcc_20>;
> +		vp1-supply = <&vcc_sys>;
> +		vp2-supply = <&vcc_sys>;
> +		vp3-supply = <&vcc_sys>;
> +		vp4-supply = <&vcc_sys>;
> +		status = "okay";

you're just adding it here, so I guess it doesn't necessarily need a "status 
okay"

[...]

> +	gmac {
> +		phy_rst: phy-rst {
> +			rockchip,pins = <RK_GPIO4 8 RK_FUNC_GPIO  &pcfg_output_high>;
> +		};
> +	};
> +};
> +
> +

double empty line


> +&vopb {
> +	status = "okay";
> +};
> +
> +&vopb_mmu {
> +	status = "okay";
> +};
> +
> +&vopl {
> +	status = "okay";
> +};
> +
> +&vopl_mmu {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts
> b/arch/arm/boot/dts/rk3288-rock2-square.dts new file mode 100644

[...]

> +	vcc_usb_host: vcc-host-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&host_vbus_drv>;
> +		/* Always on as the rockchip usb phy doesn't have a vbus-supply
> +		 * property */

comment style is off. Either one-line, like
	/* foo */
or multiline
	/*
	  * foo
	  */


Heiko
