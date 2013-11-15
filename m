From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Nov 2013 14:52:56 +0100
Subject: [RFC PATCH v2] ARM: at91: add support for Cosino board series by
 HCE Engineering
In-Reply-To: <20131114185002.GM10964@enneenne.com>
References: <1383754767-5398-1-git-send-email-giometti@linux.it>
 <1384364070-32306-1-git-send-email-nicolas.ferre@atmel.com>
 <20131114162810.GJ28304@ns203013.ovh.net>
 <20131114185002.GM10964@enneenne.com>
Message-ID: <20131115135256.GP28304@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:50 Thu 14 Nov     , Rodolfo Giometti wrote:
> On Thu, Nov 14, 2013 at 05:28:10PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 18:34 Wed 13 Nov     , Nicolas Ferre wrote:
> > > From: Rodolfo Giometti <giometti@linux.it>
> > > 
> > > This patch adds the Cosino at91sam9g35 based CPU module and the
> > > Cosino Mega 2560 extension board.
> > > 
> > > Web site: http://www.cosino.it
> > > 
> > > Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> > > [nicolas.ferre at atmel.com: adapted to newer kernel, modified commit message]
> > > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > ---
> > > Rodolfo,
> > > 
> > > Can you please review this adaptation of your previous patch to newer kernel.
> > > I hope to integrate your board in upcoming 3.14.
> > > 
> > > You will see that I addressed the remarks by Jean-Christophe and Russell (about
> > > commit message). Please tell me if it is good on your side.
> > > 
> > > Ciao,
> > > 
> > > 
> > >  arch/arm/boot/dts/Makefile                 |   1 +
> > >  arch/arm/boot/dts/at91-cosino.dtsi         | 122 +++++++++++++++++++++++++++++
> > >  arch/arm/boot/dts/at91-cosino_mega2560.dts |  85 ++++++++++++++++++++
> > >  3 files changed, 208 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/at91-cosino.dtsi
> > >  create mode 100644 arch/arm/boot/dts/at91-cosino_mega2560.dts
> > > 
> > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > > index d57c1a6..772a30e 100644
> > > --- a/arch/arm/boot/dts/Makefile
> > > +++ b/arch/arm/boot/dts/Makefile
> > > @@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_AT91) += pm9g45.dtb
> > >  dtb-$(CONFIG_ARCH_AT91) += at91sam9n12ek.dtb
> > >  # sam9x5
> > >  dtb-$(CONFIG_ARCH_AT91) += at91-ariag25.dtb
> > > +dtb-$(CONFIG_ARCH_AT91) += at91-cosino_mega2560.dtb
> > >  dtb-$(CONFIG_ARCH_AT91) += at91sam9g15ek.dtb
> > >  dtb-$(CONFIG_ARCH_AT91) += at91sam9g25ek.dtb
> > >  dtb-$(CONFIG_ARCH_AT91) += at91sam9g35ek.dtb
> > > diff --git a/arch/arm/boot/dts/at91-cosino.dtsi b/arch/arm/boot/dts/at91-cosino.dtsi
> > > new file mode 100644
> > > index 0000000..53f2b01
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/at91-cosino.dtsi
> > > @@ -0,0 +1,122 @@
> > > +/*
> > > + * at91-cosino.dtsi - Device Tree file for Cosino core module
> > > + *
> > > + * Copyright (C) 2013 - Rodolfo Giometti <giometti@linux.it>
> > > + *			HCE Engineering
> > > + *
> > > + * Derived from at91sam9x5ek.dtsi by:
> > > + *	Copyright (C) 2012 Atmel,
> > > + *	2012 Nicolas Ferre <nicolas.ferre@atmel.com>
> > > + *
> > > + * Licensed under GPLv2 or later.
> > > + */
> > > +
> > > +#include "at91sam9g35.dtsi"
> > > +
> > > +/ {
> > > +	model = "HCE Cosino core module";
> > > +	compatible = "hce,cosino", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
> > is this really sam9xek compatible?
> 
> Well, the board is derived from ATMEL dev board... maybe I can remove
> these lines... :-/

compatible means you board is an extension and that the kernel + dtb will run
on both without modification
> 
> > > +
> > > +	chosen {
> > > +		bootargs = "console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait";
> > > +	};
> > > +
> > ...
> > > +/ {
> > > +	model = "HCE Cosino Mega 2560";
> > > +	compatible = "hce,cosino_mega2560", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
...
> +
> +	ahb {
> +		apb {
> +			mmc0: mmc at f0008000 {
> +				pinctrl-0 = <
> +					&pinctrl_board_mmc0
> +					&pinctrl_mmc0_slot0_clk_cmd_dat0
> +					&pinctrl_mmc0_slot0_dat1_3>;
> +				status = "okay";
> +				slot at 0 {
> +					reg = <0>;
> +					bus-width = <4>;
> +					cd-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
> +				};
> +			};
> +
...
> +
> +			mmc1: mmc at f000c000 {
> +				pinctrl-0 = <
> +					&pinctrl_board_mmc0
this will failled you can not have the same pux on 2 device
> +					&pinctrl_mmc1_slot0_clk_cmd_dat0
> +					&pinctrl_mmc1_slot0_dat1_3>;
> +				status = "okay";
> +				slot at 0 {
> +					reg = <0>;
> +					bus-width = <4>;
> +					non-removable;
> +				};
> +			};
> +		};
> +
Best Regards,
J.
