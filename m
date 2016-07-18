From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 18 Jul 2016 13:24:20 +0200
Subject: [PATCH] ARM: dts: add rk3288-firefly-reload
In-Reply-To: <1468769937-23387-2-git-send-email-ayaka@soulik.info>
References: <5614243.tqTyZoc945@phil>
 <1468769937-23387-1-git-send-email-ayaka@soulik.info>
 <1468769937-23387-2-git-send-email-ayaka@soulik.info>
Message-ID: <1549971.ctkvOGm2xW@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

Am Sonntag, 17. Juli 2016, 23:38:57 schrieb Randy Li:
> The Firefly RK3288 Reload is a combination Firefly rk3288 core board
> with the Reload baseboard. Add a dtsi for the Firefly rk3288 core
> which can be included into the dts for the various baseboards
> in the future and dts for Reload base board.
> 
> Currently supported are serial console, wired networking, eMMC and
> SD storage, SPFIF, IR receiver, LEDs, SDIO wifi and USB. But only
> the OTG could work on the host mode now, the other USB host can't
> work now, additional patches are required.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>

looks mostly good, two small issues below. While I could replace the
io-domain node with the newer variant myself, the licensing issue will
require a resend anyway.

Please also carry over Rob's Ack in your resend as well.


> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  | 304
> ++++++++++++++++++++ arch/arm/boot/dts/rk3288-firefly-reload.dts        |
> 320 +++++++++++++++++++++ 4 files changed, 629 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
>  create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt
> b/Documentation/devicetree/bindings/arm/rockchip.txt index
> 715d960..3380212c 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -31,6 +31,10 @@ Rockchip platforms device tree bindings
>      or
>        - compatible = "firefly,firefly-rk3288-beta", "rockchip,rk3288";
> 
> +- Firefly Firefly-RK3288 Reload board:
> +    Required root node properties:
> +      - compatible = "firefly,firefly-rk3288-reload", "rockchip,rk3288";
> +
>  - ChipSPARK PopMetal-RK3288 board:
>      Required root node properties:
>        - compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 414b427..8173e77 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -606,6 +606,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>  	rk3288-evb-rk808.dtb \
>  	rk3288-firefly-beta.dtb \
>  	rk3288-firefly.dtb \
> +	rk3288-firefly-reload.dtb \
>  	rk3288-miqi.dtb \
>  	rk3288-popmetal.dtb \
>  	rk3288-r89.dtb \
> diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
> b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi new file mode 100644
> index 0000000..039ae16
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
> @@ -0,0 +1,304 @@
> +/*
> + * Device tree file for Firefly Rockchip RK3288 Core board
> + * Copyright (c) 2016 Randy Li <ayaka@soulik.info>
> + *
> + * Licensed under GPLv2 or later.
> + */

please allow licensing under GPL and MIT licenses ... see license headers
of the other Rockchip boards. Same for the dts file below.


> +#include <dt-bindings/input/input.h>
> +#include "rk3288.dtsi"
> +
> +/ {
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0x80000000>;
> +	};
> +
> +	dovdd_1v8: dovdd-1v8-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dovdd_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc28_dvp>;
> +	};
> +
> +	ext_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "ext_gmac";
> +	};
> +
> +	io_domains: io-domains {
> +		compatible = "rockchip,rk3288-io-voltage-domain";
> +		rockchip,grf = <&grf>;
> +
> +		audio-supply = <&vcca_33>;
> +		bb-supply = <&vcc_io>;
> +		dvp-supply = <&dovdd_1v8>;
> +		flash0-supply = <&vcc_flash>;
> +		flash1-supply = <&vcc_lan>;
> +		gpio30-supply = <&vcc_io>;
> +		gpio1830-supply = <&vcc_io>;
> +		lcdc-supply = <&vcc_io>;
> +		sdcard-supply = <&vccio_sd>;
> +		wifi-supply = <&vccio_wl>;
> +	};

io-domains are now a sub-device of the GRF, see
https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.8-armsoc/dts32&id=3445b2fae55f1a232e6e4843f4f74de074d8c07f

Heiko
