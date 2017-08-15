From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 Aug 2017 12:07:30 +0800
Subject: [PATCH v3] arm64: allwinner: a64: Add A64-OLinuXino initial
 support
In-Reply-To: <1502707564-16703-1-git-send-email-jteki@openedev.com>
References: <1502707564-16703-1-git-send-email-jteki@openedev.com>
Message-ID: <CAGb2v64+j-irO9UgYfNnoWg-Vc-o1hS8E7gzLiYjpxK=qZGDag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 6:46 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>
> OLimex A64-OLinuXino is an open-source hardware board
> using the Allwinner A64 SOC.
>
> OLimex A64-OLinuXino has
> - A64 Quad-core Cortex-A53 64bit
> - 1GB or 2GB RAM DDR3L @ 672Mhz
> - microSD slot and 4/8/16GB eMMC
> - Debug TTL UART
> - HDMI
> - LCD
> - IR receiver
> - 5V DC power supply
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - Droped i2c1, not found on schmatic
> - Updated vddfb-cpux regulator volt range 1.04 ~ 1.3 V
> - Removed poly-phased DCDC3 regulator node and added comment
> - Update DLDO4 regulator name as vcc-wifi-io
> - Moved uart0 below regulators
> Changes for v2:
> - Tested on board
> - Added AXP803 regulator
>
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    | 199 +++++++++++++++++++++
>  2 files changed, 200 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index c997b5c..19c3fbd 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -1,5 +1,6 @@
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> new file mode 100644
> index 0000000..b86ac1a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> @@ -0,0 +1,199 @@
> +/*
> + * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
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
> +/dts-v1/;
> +
> +#include "sun50i-a64.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       model = "Olimex A64-Olinuxino";
> +       compatible = "olimex,a64-olinuxino", "allwinner,sun50i-a64";
> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +};
> +
> +&mmc0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc0_pins>;
> +       vmmc-supply = <&reg_dcdc1>;
> +       cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
> +       cd-inverted;
> +       disable-wp;
> +       bus-width = <4>;
> +       status = "okay";
> +};
> +
> +&r_rsb {
> +       status = "okay";
> +
> +       axp803: pmic at 3a3 {
> +               compatible = "x-powers,axp803";
> +               reg = <0x3a3>;
> +               interrupt-parent = <&r_intc>;
> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +};
> +
> +#include "axp803.dtsi"
> +
> +&reg_aldo1 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <2800000>;
> +       regulator-max-microvolt = <2800000>;
> +       regulator-name = "vcc-pe";
> +};
> +
> +&reg_aldo2 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <3300000>;
> +       regulator-max-microvolt = <3300000>;
> +       regulator-name = "vcc-pl";
> +};
> +
> +&reg_aldo3 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <3000000>;
> +       regulator-max-microvolt = <3000000>;
> +       regulator-name = "vcc-pll-avcc";
> +};
> +
> +&reg_dcdc1 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <3300000>;
> +       regulator-max-microvolt = <3300000>;
> +       regulator-name = "vcc-3v3";
> +};
> +
> +&reg_dcdc2 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <1040000>;
> +       regulator-max-microvolt = <1300000>;
> +       regulator-name = "vddfb-cpux";

This should be "vdd-cpux". vddfb-cpux is a feedback pin
back to the regulator.

Fixed and applied.

ChenYu
