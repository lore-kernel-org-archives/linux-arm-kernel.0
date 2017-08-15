From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 Aug 2017 11:44:21 +0800
Subject: [linux-sunxi] [PATCH v6] arm64: allwinner: a64: Add initial
 NanoPi A64 support
In-Reply-To: <1502707013-16422-1-git-send-email-jteki@openedev.com>
References: <1502707013-16422-1-git-send-email-jteki@openedev.com>
Message-ID: <CAGb2v64gsJ0R1AU6LJ74WMgrdvMz2ykZaXvAp00rUn6X6rHzSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 6:36 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>
> NanoPi A64 is a new board of high performance with low cost
> designed by FriendlyElec., using the Allwinner A64 SOC.
>
> Nanopi A64 features
> - Allwinner A64, 64-bit Quad-core Cortex-A53 at 648MHz to 1.152GHz, DVFS
> - 1GB DDR3 RAM
> - MicroSD
> - Gigabit Ethernet (RTL8211E)
> - Wi-Fi 802.11b/g/n
> - IR receiver
> - Audio In/Out
> - Video In/Out
> - Serial Debug Port
> - microUSB 5V 2A DC power-supply
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v6:
> - Moved uart0 below regulators
> - Add comment for i2c1
> - Update vdd-cpux volt range 1.04 ~ 1.3 V
> - ehci0 detection https://paste.ubuntu.com/25311593/

Thanks. This confirms the hardware default is OK for host-only
usage.

> - Remove space before usbphy
> - Removed unused DLD02
> - Add comment for DLD01 regulator-name to vcc-dsi since
>   it's connected along with vcc-hdmi
> - Add regulator node for DLD04 for vcc-pg
> Changes for v5:
> - Add AXP803 PMIC regulator support.
> Changes for v4:
> - Rebased and droped wi-fi related nodes, since it require
>   other changes to taken care.
> Changes for v3:
> - Fix to use mmc1 for SDIO instead of mmc2
> - Replace buswidth by 4 instead of 8 mmc1
> - Drop cap-mmc-hw-reset for mmc1
> Changes for v2:
> - Added ohci0, ehci0, ohic1, ehci1, usbphy.
> - Tested on A64
>
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   | 209 +++++++++++++++++++++
>  2 files changed, 210 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 108f12c..c997b5c 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> new file mode 100644
> index 0000000..c2bbc75
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> @@ -0,0 +1,209 @@
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
> +       model = "FriendlyARM NanoPi A64";
> +       compatible = "friendlyarm,nanopi-a64", "allwinner,sun50i-a64";
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
> +&ehci0 {
> +       status = "okay";
> +};
> +
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +/* i2c1 connected with gpio headers like pine64, bananapi */
> +&i2c1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c1_pins>;
> +       status = "okay";

So I rechecked some of the current dts files we have. We typically
don't enable peripherals by default if they are on some generic
expansion header. We do however allow listing them with an explicit

    status = "disabled";

Users are free to enable it themselves. The listing lets them enable
it from U-boot with a single fdt command.

> +};
> +
> +&i2c1_pins {
> +       bias-pull-up;
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
> +&ohci0 {
> +       status = "okay";
> +};
> +
> +&ohci1 {
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
> +&reg_aldo2 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <1800000>;
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
> +       regulator-min-microvolt = <3000000>;
> +       regulator-max-microvolt = <3000000>;
> +       regulator-name = "vcc-3v";
> +};
> +
> +&reg_dcdc2 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <1040000>;
> +       regulator-max-microvolt = <1300000>;
> +       regulator-name = "vdd-cpux";
> +};
> +
> +/* DCDC3 is polyphased with DCDC2 */
> +
> +&reg_dcdc5 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <1500000>;
> +       regulator-max-microvolt = <1500000>;
> +       regulator-name = "vcc-dram";
> +};
> +
> +&reg_dcdc6 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <1100000>;
> +       regulator-max-microvolt = <1100000>;
> +       regulator-name = "vdd-sys";
> +};
> +
> +&reg_dldo1 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <3300000>;
> +       regulator-max-microvolt = <3300000>;
> +       /* Same used for vcc-dsi */
> +       regulator-name = "vcc-hdmi";

We normally just tack on all the consumers to the name, so
"vcc-hdmi-dsi" in this case.

> +};
> +
> +&reg_dldo4 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <3000000>;
> +       regulator-max-microvolt = <3000000>;
> +       /* Same used for vdd_wifi-io */
> +       regulator-name = "vcc-pg";

And "vcc-pg-wifi-io" here.

I can fix up these bits when applying, if you are OK with the changes.

Thanks
ChenYu
