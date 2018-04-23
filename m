From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 23 Apr 2018 12:27:52 +0200
Subject: [PATCH v3 2/2] ARM: dts: nes: add Nintendo NES/SuperNES Classic
 Edition support
In-Reply-To: <20180423072403.4ip5seys4xyll3yr@flea>
References: <20180421164246.8477-1-miquel.raynal@bootlin.com>
 <20180421164246.8477-3-miquel.raynal@bootlin.com>
 <20180423072403.4ip5seys4xyll3yr@flea>
Message-ID: <20180423122752.364ee649@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, 23 Apr 2018 09:24:03 +0200, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:

> Hi,
> 
> On Sat, Apr 21, 2018 at 06:42:46PM +0200, Miquel Raynal wrote:
> > The Nintendo NES/SuperNES features an R16 already well supported in
> > mainline.
> > 
> > The console over UART0 may be wired on two ports of the R16, both
> > available on the NES Classic PCB.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  arch/arm/boot/dts/Makefile                         |  2 +
> >  arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  2 +
> >  .../boot/dts/sun8i-r16-nintendo-nes-classic.dts    | 56 ++++++++++++++++++++++
> >  .../dts/sun8i-r16-nintendo-super-nes-classic.dts   | 19 ++++++++
> >  4 files changed, 79 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
> >  create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-super-nes-classic.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 7e2424957809..6813abc8399a 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1010,6 +1010,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
> >  	sun8i-h3-orangepi-plus.dtb \
> >  	sun8i-h3-orangepi-plus2e.dtb \
> >  	sun8i-r16-bananapi-m2m.dtb \
> > +	sun8i-r16-nintendo-nes-classic.dtb \
> > +	sun8i-r16-nintendo-supernes-classic.dtb \  
> 
> This doesn't match your DTS name :)

Ooooops /o\

> 
> >  	sun8i-r16-parrot.dtb \
> >  	sun8i-r40-bananapi-m2-ultra.dtb \
> >  	sun8i-v3s-licheepi-zero.dtb \
> > diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> > index 6b9e85b4ba0f..44f3cad3de75 100644
> > --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> > @@ -198,6 +198,8 @@
> >  			clock-names = "ahb", "mod";
> >  			resets = <&ccu RST_BUS_NAND>;
> >  			reset-names = "ahb";
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&nand_pins &nand_pins_cs0 &nand_pins_rb0>;  
> 
> This should be in your first patch I guess?

Actually I think this should not be there but instead, because it is
board-related, these two lines should be in the nes-classic.dts' nfc
node, right? Other a23/a33/r16 based designs could use the second set
of CS/RB pins.

> 
> > diff --git a/arch/arm/boot/dts/sun8i-r16-nintendo-super-nes-classic.dts b/arch/arm/boot/dts/sun8i-r16-nintendo-super-nes-classic.dts
> > new file mode 100644
> > index 000000000000..9cbe058feb6f
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun8i-r16-nintendo-super-nes-classic.dts
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR X11
> > +/* Copyright (c) 2018 Miqu?l RAYNAL <miquel.raynal@bootlin.com> */
> > +
> > +/dts-v1/;
> > +#include "sun8i-r16-nintendo-nes-classic.dts"
> > +
> > +/ {
> > +	model = "Nintendo SuperNES Classic Edition";
> > +	compatible = "nintendo,supernes-classic", "allwinner,sun8i-r16",  
> 
> 
> We should have the same split in the compatible (ie,
> super-nes-classic) and we should probably add the nes-classic
> compatible in there as well.

Sure.

> 
> > +		     "allwinner,sun8i-a33";
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";  
> 
> Isn't that part of the NES DTSI already?

Right, I was not sure if those two should be kept or not. Removed.

> 
> Maxime
> 

Thanks,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
