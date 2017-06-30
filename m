From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Fri, 30 Jun 2017 14:57:53 +0200
Subject: [PATCH 4/5] ARM: dts: at91: at91-sama5d27_som1: add sama5d27
 SoM1 support
In-Reply-To: <4452aad8-1bb4-f937-02b8-e5960f2aadc2@microchip.com>
References: <1498736674-9233-1-git-send-email-claudiu.beznea@microchip.com>
 <1498736674-9233-5-git-send-email-claudiu.beznea@microchip.com>
 <20170629145841.srpjgcdw7jo2f6as@rfolt0960.corp.atmel.com>
 <4452aad8-1bb4-f937-02b8-e5960f2aadc2@microchip.com>
Message-ID: <20170630125753.hx6nv46gjjgww3dy@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 03:38:22PM +0300, m18063 wrote:
> Hi Ludovic,
> 
> On 29.06.2017 17:58, Ludovic Desroches wrote:
> > On Thu, Jun 29, 2017 at 02:44:33PM +0300, Claudiu Beznea wrote:
> >> Add specific DTS file and bindings for sama5d27 SoM1 board.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> >> ---
> >>  arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 178 ++++++++++++++++++++++++++++++
> >>  1 file changed, 178 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1.dtsi
> >>
> >> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
> >> new file mode 100644
> >> index 0000000..b3af4d4
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
> >> @@ -0,0 +1,178 @@
> >> +/*
> >> + * at91-sama5d27_som1.dtsi - Device Tree file for SAMA5D27 SoM1 board
> >> + *
> >> + *  Copyright (c) 2017, Microchip Technology Inc.
> >> + *                2017 Cristian Birsan <cristian.birsan@microchip.com>
> >> + *                2017 Claudiu Beznea <claudiu.beznea@microchip.com>
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
> >> + */
> >> +#include "sama5d2.dtsi"
> >> +#include "sama5d2-pinfunc.h"
> >> +
> >> +/ {
> >> +	model = "Atmel SAMA5D27 SoM1";
> >> +	compatible = "atmel,sama5d27-som1", "atmel,sama5d27", "atmel,sama5d2", "atmel,sama5";
> >> +
> >> +	clocks {
> >> +		slow_xtal {
> >> +			clock-frequency = <32768>;
> >> +		};
> >> +
> >> +		main_xtal {
> >> +			clock-frequency = <24000000>;
> >> +		};
> >> +	};
> >> +
> >> +	ahb {
> >> +		apb {
> >> +			qspi1: spi at f0024000 {
> >> +				pinctrl-names = "default";
> >> +				pinctrl-0 = <&pinctrl_qspi1_default>;
> >> +				flash at 0 {
> >> +					#address-cells = <1>;
> >> +					#size-cells = <1>;
> >> +					compatible = "jedec,spi-nor";
> >> +					reg = <0>;
> >> +					spi-max-frequency = <83000000>;
> >> +					m25p,fast-read;
> >> +
> >> +					at91bootstrap at 00000000 {
> >> +						label = "at91bootstrap";
> >> +						reg = <0x00000000 0x00010000>;
> >> +					};
> >> +
> >> +					bootloaderenv at 00010000 {
> >> +						label = "bootloader env";
> >> +						reg = <0x00010000 0x00010000>;
> >> +					};
> >> +
> >> +					bootloader at 00020000 {
> >> +						label = "bootloader";
> >> +						reg = <0x00020000 0x00050000>;
> >> +					};
> >> +
> >> +					dtb at 00070000 {
> >> +						label = "device tree";
> >> +						reg = <0x00070000 0x00010000>;
> >> +					};
> >> +
> >> +					kernel at 00080000 {
> >> +						label = "kernel";
> >> +						reg = <0x00080000 0x00380000>;
> >> +					};
> > 
> > I am wondering if it's a good idea to give the flash map here. If we
> > take a kernel generated by a sama5_defconfig, it is about 3.8 MB.
> The flash size here is 8MB. With kernel image of 3.8M, bootloader of 18KB,
> u-boot of 2.2MB, dtb of 31K it will still fit.

Right it can fit, I mean the description gives about 3.5 MB for the kernel so
you can extend it.

Regards

Ludovic

> > 
> >> +				};
> >> +			};
> >> +
> >> +			macb0: ethernet at f8008000 {
> >> +				pinctrl-names = "default";
> >> +				pinctrl-0 = <&pinctrl_macb0_default>;
> >> +				phy-mode = "rmii";
> >> +
> >> +				ethernet-phy at 1 {
> >> +					reg = <0x1>;
> >> +					interrupt-parent = <&pioA>;
> >> +					interrupts = <73 IRQ_TYPE_LEVEL_LOW>;
> > 
> > Are you sure about this value? pinctrl tells PD31 so 127. By the way, it
> > is better to use macros: PIN_PD31.
> Yes, here is a mistake. It has to be PIN_PD31. I will fix it in v2.
> 
> Thank you,
> Claudiu
> > 
> > Regards
> > 
> > Ludovic
> > 
> >> +					pinctrl-names = "default";
> >> +					pinctrl-0 = <&pinctrl_macb0_phy_irq>;
> >> +				};
> >> +			};
> >> +
> >> +			i2c0: i2c at f8028000 {
> >> +				dmas = <0>, <0>;
> >> +				pinctrl-names = "default";
> >> +				pinctrl-0 = <&pinctrl_i2c0_default>;
> >> +				i2c-sda-hold-time-ns = <350>;
> >> +				status = "disabled";
> >> +
> >> +				24aa at 50 {
> >> +					compatible = "24mac602";
> >> +					reg = <0x50>;
> >> +					pagesize = <8>;
> >> +					start-offset = /bits/ 8 <0xf8>;
> >> +					read-only;
> >> +				};
> >> +			};
> >> +
> >> +			pinctrl at fc038000 {
> >> +
> >> +				pinctrl_i2c0_default: i2c0_default {
> >> +					pinmux = <PIN_PD21__TWD0>,
> >> +						 <PIN_PD22__TWCK0>;
> >> +					bias-disable;
> >> +				};
> >> +
> >> +				pinctrl_macb0_default: macb0_default {
> >> +					pinmux = <PIN_PD9__GTXCK>,
> >> +						 <PIN_PD10__GTXEN>,
> >> +						 <PIN_PD11__GRXDV>,
> >> +						 <PIN_PD12__GRXER>,
> >> +						 <PIN_PD13__GRX0>,
> >> +						 <PIN_PD14__GRX1>,
> >> +						 <PIN_PD15__GTX0>,
> >> +						 <PIN_PD16__GTX1>,
> >> +						 <PIN_PD17__GMDC>,
> >> +						 <PIN_PD18__GMDIO>;
> >> +					bias-disable;
> >> +				};
> >> +
> >> +				pinctrl_macb0_phy_irq: macb0_phy_irq {
> >> +					pinmux = <PIN_PD31__GPIO>;
> >> +					bias-disable;
> >> +				};
> >> +
> >> +				pinctrl_qspi1_default: qspi1_default {
> >> +					sck_cs {
> >> +						pinmux = <PIN_PB5__QSPI1_SCK>,
> >> +							 <PIN_PB6__QSPI1_CS>;
> >> +						bias-disable;
> >> +					};
> >> +
> >> +					data {
> >> +						pinmux = <PIN_PB7__QSPI1_IO0>,
> >> +							 <PIN_PB8__QSPI1_IO1>,
> >> +							 <PIN_PB9__QSPI1_IO2>,
> >> +							 <PIN_PB10__QSPI1_IO3>;
> >> +						bias-pull-up;
> >> +					};
> >> +				};
> >> +			};
> >> +		};
> >> +	};
> >> +};
> >> -- 
> >> 2.7.4
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
