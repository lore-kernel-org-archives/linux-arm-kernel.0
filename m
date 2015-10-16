From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Fri, 16 Oct 2015 10:22:04 +0200
Subject: [PATCH 3/3] ARM: dts: Add basic support for isee igepv5
In-Reply-To: <1444756728-11185-3-git-send-email-tony@atomide.com>
References: <1444756728-11185-1-git-send-email-tony@atomide.com>
 <1444756728-11185-3-git-send-email-tony@atomide.com>
Message-ID: <CAFqH_52T8rPJp-8+Bb7Tjv-kcACU8FJGtqFWOhj02DzQ2yc7nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Many thanks for the patch

2015-10-13 19:18 GMT+02:00 Tony Lindgren <tony@atomide.com>:
> With omap5-board-common.dtsi, we can now easily add support for various omap5
> board variants. Let's add minimal support for isee igepv5.
>
> So far I've tested that basic things work, such as serial, USB Ethernet, HDMI
> and WLAN.
>
> Note that like omap5-uevm, these boards seem to need to reserve 16MB for a
> trap section as in commit 03178c66d289 ("ARM: dts: omap5-evm: Update
> available memory to 2032 MB") and also noted in a u-boot commit at
> http://marc.info/?l=u-boot&m=134376852603255 and also at
> http://patchwork.ozlabs.org/patch/159881/.
>
> Not sure why this is not needed for omap5-cm-t54.dts, maybe because of
> different u-boot configuration.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>
> Enric, can you please check if there are some critical pieces compared
> to omap5-uevm that should be updated for this patch?
>

Unfortunately I don't have the schematic and any IGEPv5 to verify your
patches. From a quick view I can say that it's ok but let me cc
Agust?, Eduard and Pau that will have access to the hardware and the
schematics.

Cheers,

Enric

> ---
>  arch/arm/boot/dts/Makefile           |  1 +
>  arch/arm/boot/dts/omap5-igep0050.dts | 54 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap5-igep0050.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e45d771..2c12411 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -471,6 +471,7 @@ dtb-$(CONFIG_SOC_AM43XX) += \
>         am437x-gp-evm.dtb
>  dtb-$(CONFIG_SOC_OMAP5) += \
>         omap5-cm-t54.dtb \
> +       omap5-igep0050.dtb \
>         omap5-sbc-t54.dtb \
>         omap5-uevm.dtb
>  dtb-$(CONFIG_SOC_DRA7XX) += \
> diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
> new file mode 100644
> index 0000000..46ecb1d
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap5-igep0050.dts
> @@ -0,0 +1,54 @@
> +/*
> + * Copyright (C) 2013 ISEE 2007 SL - http://www.isee.biz/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +#include "omap5-board-common.dtsi"
> +
> +/ {
> +       model = "IGEPv5";
> +       compatible = "isee,omap5-igep0050", "ti,omap5";
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x80000000 0x7f000000>; /* 2032 MB */
> +       };
> +};
> +
> +&hdmi {
> +       vdda-supply = <&ldo7_reg>;
> +};
> +
> +&i2c4 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&i2c4_pins>;
> +
> +       tca6416: tca6416 at 21 {
> +               compatible = "ti,tca6416";
> +               reg = <0x21>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +};
> +
> +&omap5_pmx_core {
> +       i2c4_pins: pinmux_i2c4_pins {
> +               pinctrl-single,pins = <
> +                       OMAP5_IOPAD(0x0f8, PIN_INPUT | MUX_MODE0)       /* i2c4_scl */
> +                       OMAP5_IOPAD(0x0fa, PIN_INPUT | MUX_MODE0)       /* i2c4_sda */
> +               >;
> +       };
> +};
> +
> +&tpd12s015 {
> +       gpios = <&tca6416 11 0>,        /* TCA6416 P01, CT_CP_HDP */
> +               <&tca6416 12 0>,        /* TCA6416 P00, LS_OE*/
> +               <&gpio7 1 0>,           /* 193, HPD */
> +               <&gpio7 2 0>,           /* 194, SCL */
> +               <&gpio7 3 0>;           /* 195, SDA */
> +};
> +
> --
> 2.1.4
>
