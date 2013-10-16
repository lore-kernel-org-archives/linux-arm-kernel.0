From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 16 Oct 2013 14:14:55 +0200
Subject: [PATCH] at91: serial: add usart3 in separat dtsi
In-Reply-To: <1381913705-16098-1-git-send-email-jiri.prchal@aksignal.cz>
References: <1381913705-16098-1-git-send-email-jiri.prchal@aksignal.cz>
Message-ID: <525E833F.40206@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jiri,

On 16/10/2013 10:55, Jiri Prchal wrote:
> This patch adds usart3 for AT91SAM9G25 and X25.
> Based on sugescion of Nicolas Ferre it's in separated dtsi file included in both
> g25 and x25 files.
>
> Signed-off-by:  <jiri.prchal@aksignal.cz>
> ---
>   arch/arm/boot/dts/at91sam9g25.dtsi       |    1 +
>   arch/arm/boot/dts/at91sam9x25.dtsi       |    1 +
>   arch/arm/boot/dts/at91sam9x5-usart3.dtsi |   27 +++++++++++++++++++++++++++
>   3 files changed, 29 insertions(+)
>   create mode 100644 arch/arm/boot/dts/at91sam9x5-usart3.dtsi
>
> diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
> index b4ec6fe..980e9a7 100644
> --- a/arch/arm/boot/dts/at91sam9g25.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g25.dtsi
> @@ -7,6 +7,7 @@
>    */
>   
>   #include "at91sam9x5.dtsi"
> +#include "at91sam9x5-usart3.dtsi"
>   
>   / {
>   	model = "Atmel AT91SAM9G25 SoC";
> diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/at91sam9x25.dtsi
> index 49e94ab..3ac17ee 100644
> --- a/arch/arm/boot/dts/at91sam9x25.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x25.dtsi
> @@ -7,6 +7,7 @@
>    */
>   
>   #include "at91sam9x5.dtsi"
> +#include "at91sam9x5-usart3.dtsi"
>   
>   / {
>   	model = "Atmel AT91SAM9X25 SoC";
> diff --git a/arch/arm/boot/dts/at91sam9x5-usart3.dtsi b/arch/arm/boot/dts/at91sam9x5-usart3.dtsi
> new file mode 100644
> index 0000000..f5b6979
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9x5-usart3.dtsi
> @@ -0,0 +1,27 @@
> +/*
> + * at91sam9x5-usert3.dtsi - Device Tree Include file for AT91SAM9G25 or
typo here : at91sam9x5-usert3.dtsi -> at91sam9x5-usart3.dts.

I won't complain about this, but some at91 dts(i) names already use "_" 
instead of "-":
- at91sam9g20ek_common.dtsi
- at91sam9g20ek_2mmc.dts

I personally prefer the hypen version, but I think it's up to Atmel 
maintainers to decide which name sould be used.

> + * AT91SAM9X25 SoC
> + *
> + * Copyright (C) 2013 Jiri Prchal <jiri.prchal@aksignal.cz>
> + *
> + * Licensed under GPLv2.
> + */
> +
> +/ {
> +	aliases {
> +		serial4 = &usart3;
> +	};
> +
> +	ahb {
> +		apb {
> +			usart3: serial at f8028000 {
> +				compatible = "atmel,at91sam9260-usart";
> +				reg = <0xf8028000 0x200>;
> +				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_usart3>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +};
I would have moved the the pinctrl definition in this file too.
In fact, that's what I did in my patch ( 
https://lkml.org/lkml/2013/8/7/252).

Anyway, I'm not sure, but I think Nicolas already applied my patch in 
his at91-3.13-cleanup branch.

If this is not the case, I'll be pleased to add my Acked-by after you've 
added the pinctrl definitions
and fixed the the typo.

Best Regards,

Boris
