From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 7 Aug 2013 12:38:46 +0200
Subject: [PATCH] ARM: at91/dt: split sam9x5 peripheral definitions
In-Reply-To: <1375870466-1093-1-git-send-email-b.brezillon@overkiz.com>
References: <1375870466-1093-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <CACQ1gAjsPvHkpUuO_3jK3HfnDBQDoJmO7z1Gj5YkAmybHB_zmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/7 Boris BREZILLON <b.brezillon@overkiz.com>:
> This patch splits the sam9x5 peripheral definitions into:
> - a common base for all sam9x5 SoCs (at91sam9x5.dtsi)
> - several optional peripheral definitions which will be included by specific
>   sam9x5 SoCs (at91sam9x5_'periph name'.dtsi)
>
> This provides a better representation of the real hardware (drop unneeded
> dt nodes) and avoids future peripheral id conflict (lcdc and isi both use
> peripheral id 25).
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>  arch/arm/boot/dts/at91sam9g25.dtsi       |    2 +
>  arch/arm/boot/dts/at91sam9g35.dtsi       |    1 +
>  arch/arm/boot/dts/at91sam9x25.dtsi       |   24 ++---------
>  arch/arm/boot/dts/at91sam9x35.dtsi       |    1 +
>  arch/arm/boot/dts/at91sam9x5.dtsi        |   67 ------------------------------
>  arch/arm/boot/dts/at91sam9x5_macb0.dtsi  |   56 +++++++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9x5_macb1.dtsi  |   44 ++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9x5_usart3.dtsi |   51 +++++++++++++++++++++++
>  8 files changed, 158 insertions(+), 88 deletions(-)
>  create mode 100644 arch/arm/boot/dts/at91sam9x5_macb0.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9x5_macb1.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9x5_usart3.dtsi
>
[snip]
> diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
> new file mode 100644
> index 0000000..5589579
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
> @@ -0,0 +1,51 @@
> +/*
> + * at91sam9x5_lcdc.dtsi - Device Tree Include file for AT91SAM9x5 SoC with
> + * 4 USART.
One minor comment mistake here !

> + *
> + * Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
> + *
> + * Licensed under GPLv2.
> + */
> +
> +#include <dt-bindings/pinctrl/at91.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +       ahb {
> +               apb {
> +                       pinctrl at fffff400 {
> +                               usart3 {
> +                                       pinctrl_usart3: usart3-0 {
> +                                               atmel,pins =
> +                                                       <AT91_PIOC 22 AT91_PERIPH_B AT91_PINCTRL_PULL_UP        /* PC22 periph B with pullup */
> +                                                        AT91_PIOC 23 AT91_PERIPH_B AT91_PINCTRL_NONE>;         /* PC23 periph B */
> +                                       };
> +
> +                                       pinctrl_usart3_rts: usart3_rts-0 {
> +                                               atmel,pins =
> +                                                       <AT91_PIOC 24 AT91_PERIPH_B AT91_PINCTRL_NONE>;         /* PC24 periph B */
> +                                       };
> +
> +                                       pinctrl_usart3_cts: usart3_cts-0 {
> +                                               atmel,pins =
> +                                                       <AT91_PIOC 25 AT91_PERIPH_B AT91_PINCTRL_NONE>;         /* PC25 periph B */
> +                                       };
> +
> +                                       pinctrl_usart3_sck: usart3_sck-0 {
> +                                               atmel,pins =
> +                                                       <AT91_PIOC 26 AT91_PERIPH_B AT91_PINCTRL_NONE>;         /* PC26 periph B */
> +                                       };
> +                               };
> +                       };
> +
> +                       usart3: serial at f8028000 {
> +                               compatible = "atmel,at91sam9260-usart";
> +                               reg = <0xf8028000 0x200>;
> +                               interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_usart3>;
> +                               status = "disabled";
> +                       };
> +               };
> +       };
> +};
> --
> 1.7.9.5
>



-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
