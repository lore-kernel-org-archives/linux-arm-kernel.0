From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 19 Jan 2015 19:50:43 +0100
Subject: [linux-sunxi] [PATCH] added sun7i-a20-inet-k970.dts
In-Reply-To: <3184462.M90eiSWZKq@x64.localnet>
References: <3184462.M90eiSWZKq@x64.localnet>
Message-ID: <54BD5203.90000@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 19-01-15 18:53, Lars Doelle wrote:
> Hi everyone,
>
> this patch adds the DT for the [[Inet-K970] tablet.
>
> Note that the wiki page has been renamed from [[Tristan-Auron-Planet-1]]
> after identifying the mainboard. Earlier patches concerning U-Boot and
> FEX have been filed under original name to this list and are now somewhat
> in limbo. FEX is checked in, U-Boot on hold to the best of my knowledge.
>
> Should I post a rename patch for the FEX and repost the unchanged U-boot
> patch for the device under the new name or how to proceed best?
>
> Kind regards, Lars

Thanks, we've recently moved over from using a full node
hierarchy to using label references in board dts files, see e.g. :

https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?h=sunxi/dt-for-3.20&id=327f121fea91fd79d6b71f47a8e1bc62a7fd86e5

Can you please respin this to follow that style (the nodes should
be sorted alphabetically).

Also like with the u-boot patch, when submitting patches for upstream
they should not be send to the linux-sunxi list, sunxi dts patches
should go to Maxime Ripard (added to the Cc) with the linux-arm and
devicetree lists both in the Cc (also added to the Cc) note you do
not need to be subscribed to these lists.

This makes me realize that we should probably write a manual on
how to add a new sunxi board to upstream u-boot / a dts to the
kernel. Since you've just gone through the process, could you
perhaps write a manual for this on linux-sunxi.org, it is a wiki
so you should be able to add an account and create a new page,
note I've also asked Aleksei Mamlin (also added to the Cc) to
create a manual for this, so if you do please coordinate with
him to avoid doing double work. Also note that me asking you
both is not an excuse for the both of you to look at the other
for doing this, but rather me hoping that at least one of you
will do it :)

Thanks & Regards,

Hans


>
> ---
>   arch/arm/boot/dts/sun7i-a20-inet-k970.dts | 249 ++++++++++++++++++++++++++++++
>   1 file changed, 249 insertions(+)
>   create mode 100644 arch/arm/boot/dts/sun7i-a20-inet-k970.dts
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-inet-k970.dts b/arch/arm/boot/dts/sun7i-a20-inet-k970.dts
> new file mode 100644
> index 0000000..5a34082
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-inet-k970.dts
> @@ -0,0 +1,249 @@
> +/*
> + * Copyright 2014 - Iain Paton <ipaton0@gmail.com>
> + * Copyright 2015 - Lars D?lle <lars.doelle@on-line.de>
> + *
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
> + *     You should have received a copy of the GNU General Public
> + *     License along with this file; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
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
> +/dts-v1/;
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
> +
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Inet A20-Inet-K970";
> +
> +	compatible = "inet,a20-inet-k970", "allwinner,sun7i-a20";
> +
> +	soc at 01c00000 {
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +			vmmc-supply = <&reg_vcc3v3>;
> +			bus-width = <4>;
> +			cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> +			cd-inverted;
> +			status = "okay";
> +		};
> +
> +		usbphy: phy at 01c13400 {
> +			usb1_vbus-supply = <&reg_usb1_vbus>;
> +			usb2_vbus-supply = <&reg_usb2_vbus>;
> +			status = "okay";
> +		};
> +
> +		ehci0: usb at 01c14000 {
> +			status = "okay";
> +		};
> +
> +		ohci0: usb at 01c14400 {
> +			status = "okay";
> +		};
> +
> +		ehci1: usb at 01c1c000 {
> +			status = "okay";
> +		};
> +
> +		ohci1: usb at 01c1c400 {
> +			status = "okay";
> +		};
> +
> +		uart0: serial at 01c28000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		i2c0: i2c at 01c2ac00 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pins_a>;
> +			status = "okay";
> +
> +			axp209: pmic at 34 {
> +				compatible = "x-powers,axp209";
> +				reg = <0x34>;
> +				interrupt-parent = <&nmi_intc>;
> +				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +
> +				acin-supply = <&reg_axp_ipsout>;
> +				vin2-supply = <&reg_axp_ipsout>;
> +				vin3-supply = <&reg_axp_ipsout>;
> +				ldo24in-supply = <&reg_axp_ipsout>;
> +				ldo3in-supply = <&reg_axp_ipsout>;
> +
> +				regulators {
> +					vdd_rtc: ldo1 {
> +						regulator-min-microvolt = <1300000>;
> +						regulator-max-microvolt = <1300000>;
> +						regulator-always-on;
> +					};
> +
> +					avcc: ldo2 {
> +						regulator-min-microvolt = <1800000>;
> +						regulator-max-microvolt = <3300000>;
> +						regulator-always-on;
> +					};
> +
> +					vcc_csi0: ldo3 {
> +						regulator-min-microvolt = <700000>;
> +						regulator-max-microvolt = <3500000>;
> +						regulator-always-on;
> +					};
> +
> +					vcc_csi1: ldo4 {
> +						regulator-min-microvolt = <1250000>;
> +						regulator-max-microvolt = <3300000>;
> +						regulator-always-on;
> +					};
> +
> +					vdd_cpu: dcdc2 {
> +						regulator-min-microvolt = <700000>;
> +						regulator-max-microvolt = <2275000>;
> +						regulator-always-on;
> +					};
> +
> +					vdd_int: dcdc3 {
> +						regulator-min-microvolt = <700000>;
> +						regulator-max-microvolt = <3500000>;
> +						regulator-always-on;
> +					};
> +				};
> +			};
> +		};
> +
> +                i2c1: i2c at 01c2b000 {
> +                        pinctrl-names = "default";
> +                        pinctrl-0 = <&i2c1_pins_a>;
> +                        status = "okay";
> +
> +                        // accelerometer mma865x on 0x1d
> +                };
> +
> +		pio: pinctrl at 01c20800 {
> +
> +			edt_ft5x06_pins_a: ft5 at 0 { // interrupt
> +				allwinner,pins     = "PH21";
> +				allwinner,function = "irq";
> +  				allwinner,drive    = <SUN4I_PINCTRL_20_MA>;
> +  				allwinner,pull     = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +			edt_ft5x06_pins_b: ft5 at 1 { // power
> +				allwinner,pins     = "PH22";
> +  				allwinner,function = "gpio_out";
> +  				allwinner,drive    = <SUN4I_PINCTRL_20_MA>;
> +  				allwinner,pull     = <SUN4I_PINCTRL_NO_PULL>;
> +                                output_high;
> +			};
> +		};
> +
> +                i2c2: i2c at 01c2b400 {
> +                        pinctrl-names = "default";
> +                        pinctrl-0 = <&i2c2_pins_a>;
> +                        status = "okay";
> +
> +			polytouch: edt-ft5x06 at 38 {
> +				compatible = "edt,edt-ft5x06";
> +				reg = <0x38>;
> +				pinctrl-names = "default";
> +  				pinctrl-0 = <&edt_ft5x06_pins_a &edt_ft5x06_pins_b>;
> +  				interrupt-parent = <&pio>;
> +  				interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
> +                                // wakeup spelled in script.bin. not operational, here
> +			};
> +                };
> +
> +		lradc: lradc at 01c22800 {
> +
> +			vref-supply = <&reg_vcc3v0>;
> +	              	status = "okay";
> +
> +                	// The driver picks the closest voltage.
> +
> +			button at 158 {
> +				label = "Volume Up";
> +				linux,code = <KEY_VOLUMEUP>;
> +				channel = <0>;
> +				voltage = <158730>;
> +			};
> +
> +			button at 952 {
> +				label = "Volume Down";
> +				linux,code = <KEY_VOLUMEDOWN>;
> +				channel = <0>;
> +				voltage = <952380>;
> +			};
> +
> +			button at 1142 {
> +				label = "Menu"; // labeled ESC on the back cover
> +				linux,code = <KEY_MENU>;
> +				channel = <0>;
> +				voltage = <1142857>;
> +			};
> +		};
> +	};
> +
> +	reg_usb1_vbus: usb1-vbus {
> +		status = "okay";
> +	};
> +
> +	reg_usb2_vbus: usb2-vbus {
> +		status = "okay";
> +	};
> +
> +	reg_axp_ipsout: axp_ipsout {
> +		compatible = "regulator-fixed";
> +		regulator-name = "axp-ipsout";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +};
>
