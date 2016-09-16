From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 09:23:01 +0200
Subject: [PATCH v6 2/3] ARM: dts: add TOPEET itop elite based board
In-Reply-To: <1473285535-21996-3-git-send-email-ayaka@soulik.info>
References: <1473285535-21996-1-git-send-email-ayaka@soulik.info>
 <1473285535-21996-3-git-send-email-ayaka@soulik.info>
 <CGME20160916072303eucas1p2941ba2907605055f5ea5abb2e6891d77@eucas1p2.samsung.com>
Message-ID: <6bd9905d-0818-a917-8b8e-6abce134a3d3@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2016 11:58 PM, Randy Li wrote:
> The TOPEET itop exynos 4412 have three versions base board. The
> Elite version is the cheap one without too much peripheral devices
> on it.
> 
> Currently supported are serial console, wired networking(USB),
> USB OTG in peripheral mode, USB host, SD storage, GPIO buttons,
> PWM beeper, ADC and LEDs. The WM8960 analog audio codec is also
> enabled.
> 
> The FIMC is not used for camera currently, I enabled it just for a
> colorspace convertor.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/exynos4412-itop-elite.dts        | 239 +++++++++++++++++++++
>  3 files changed, 243 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4412-itop-elite.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index 0ea7f14..c7159ac 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -22,6 +22,9 @@ Required root node properties:
>    * FriendlyARM
>  	- "friendlyarm,tiny4412"  - for Exynos4412-based FriendlyARM
>  				    TINY4412 board.
> +  * TOPEET
> +	- "topeet,itop4412-elite" - for Exynos4412-based TOPEET
> +                                    Elite base board.                             
>  
>    * Google
>  	- "google,pi"		- for Exynos5800-based Google Peach Pi
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 207f96f..0b39d00 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -130,6 +130,7 @@ dtb-$(CONFIG_ARCH_EXYNOS4) += \
>  	exynos4210-smdkv310.dtb \
>  	exynos4210-trats.dtb \
>  	exynos4210-universal_c210.dtb \
> +	exynos4412-itop-elite.dtb \
>  	exynos4412-odroidu3.dtb \
>  	exynos4412-odroidx.dtb \
>  	exynos4412-odroidx2.dtb \
> diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> new file mode 100644
> index 0000000..dd83689
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> @@ -0,0 +1,239 @@
> +/*
> + * TOPEET's Exynos4412 based itop board device tree source
> + *
> + * Copyright (c) 2016 SUMOMO Computer Association
> + *			https://www.sumomo.mobi
> + *			Randy Li <ayaka@soulik.info>
> + *			
> + * Device tree source file for TOPEET iTop Exynos 4412 core board 
> + * which is based on Samsung's Exynos4412 SoC.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +/dts-v1/;
> +#include <dt-bindings/sound/samsung-i2s.h>
> +#include "exynos4412-itop-scp-core.dtsi"
> +
> +/ {
> +	model = "TOPEET iTop 4412 Elite board based on Exynos4412";
> +	compatible = "topeet,itop4412-elite", "samsung,exynos4412", "samsung,exynos4";
> +
> +	chosen {
> +		bootargs = "root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait";
> +		stdout-path = "serial2:115200n8";
> +	};
> +	
> +	leds {
> +		compatible = "gpio-leds";
> +		
> +		led2 {
> +			label = "red:system";
> +			gpios = <&gpx1 0 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led3 {
> +			label = "red:user";
> +			gpios = <&gpk1 1 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		
> +		home {
> +			label = "GPIO Key Home";
> +			linux,code = <KEY_HOME>;
> +			gpios = <&gpx1 1 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		back {
> +			label = "GPIO Key Back";
> +			linux,code = <KEY_BACK>;
> +			gpios = <&gpx1 2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		sleep {
> +			label = "GPIO Key Sleep";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpx3 3 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		vol-up {
> +			label = "GPIO Key Vol+";
> +			linux,code = <KEY_UP>;
> +			gpios = <&gpx2 1 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		vol-down {
> +			label = "GPIO Key Vol-";
> +			linux,code = <KEY_DOWN>;
> +			gpios = <&gpx2 0 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "wm-sound";
> +
> +		assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
> +				<&clock_audss EXYNOS_MOUT_I2S>,
> +				<&clock_audss EXYNOS_DOUT_SRP>,
> +				<&clock_audss EXYNOS_DOUT_AUD_BUS>;
> +		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
> +				<&clock_audss EXYNOS_MOUT_AUDSS>;
> +		assigned-clock-rates = <0>,
> +				<0>,
> +				<112896000>,
> +				<11289600>;
> +
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&link0_codec>;
> +		simple-audio-card,frame-master = <&link0_codec>;
> +
> +		simple-audio-card,widgets =
> +			"Microphone", "Mic Jack",
> +			"Line", "Line In",
> +			"Line", "Line Out",
> +			"Speaker", "Speaker",
> +			"Headphone", "Headphone Jack";
> +		simple-audio-card,routing =
> +			"Headphone Jack", "HP_L",
> +			"Headphone Jack", "HP_R",
> +			"Speaker", "SPK_LP",
> +			"Speaker", "SPK_LN",
> +			"Speaker", "SPK_RP",
> +			"Speaker", "SPK_RN",
> +			"LINPUT1", "Mic Jack",
> +			"LINPUT3", "Mic Jack",
> +			"RINPUT1", "Mic Jack",
> +			"RINPUT2", "Mic Jack";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s0 0>;
> +		};
> +
> +		link0_codec: simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +			clocks = <&i2s0 CLK_I2S_CDCLK>;
> +			system-clock-frequency = <11289600>;
> +		};
> +	};
> +	
> +	beep {
> +		compatible = "pwm-beeper";
> +		pwms = <&pwm 0 4000000 PWM_POLARITY_INVERTED>;

I have serious doubts that you run this code... if it does not even
compile. Sorry, I cannot accept code that does not compile and was not
tested.

Please, test your DTS on top of current Linux tree, which would be one of:
1. Linus' master branch: v4.8-rc6,
2. one of my branches (for-next, next/dt etc),
3. recent linux-next.

Best regards,
Krzysztof
