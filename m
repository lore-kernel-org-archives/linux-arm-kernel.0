From: kbeldan@baylibre.com (Karl Beldan)
Date: Thu, 4 Aug 2016 21:03:26 +0000
Subject: [PATCH] ARM: dts: da850: Add basic DTS for the L138/C6748 Dev Kit
In-Reply-To: <20160804182902.GA22499@rob-hp-laptop>
References: <20160804144332.4841-1-kbeldan@baylibre.com>
 <20160804182902.GA22499@rob-hp-laptop>
Message-ID: <20160804210326.GE15013@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 01:29:02PM -0500, Rob Herring wrote:
> On Thu, Aug 04, 2016 at 02:43:32PM +0000, Karl Beldan wrote:
> > The LCDK is the successor to the late Hawkboard and has the same machine
> > number.
> > Among the differences are the flash (16bits vs 8bits) and some pins
> > (MMC, LEDs, buttons, some external connectors), however the main
> > components remain the same (eth. PHY, Audio Codec, Video decoder and
> > DAC) except for the main PMIC, different and hard-wired on the LCDK (the
> > LDOs and DCDCs are always ON).
> > A DT-only boot with this addition gives functional uart, reboot via
> > watchdog, rtc, ethernet and MMC (I added the CD gpio for the MMC
> > although davinci_mmc doesn't call yet the mmc core OF facilities).
> > 
> > Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/arm/davinci.txt |  4 ++
> >  arch/arm/boot/dts/Makefile                        |  1 +
> >  arch/arm/boot/dts/omapl138-lcdk.dts               | 71 +++++++++++++++++++++++
> >  arch/arm/mach-davinci/da8xx-dt.c                  |  1 +
> >  4 files changed, 77 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/omapl138-lcdk.dts
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/davinci.txt b/Documentation/devicetree/bindings/arm/davinci.txt
> > index cfaeda4..1482c74 100644
> > --- a/Documentation/devicetree/bindings/arm/davinci.txt
> > +++ b/Documentation/devicetree/bindings/arm/davinci.txt
> > @@ -5,6 +5,10 @@ DA850/OMAP-L138/AM18x Evaluation Module (EVM) board
> >  Required root node properties:
> >      - compatible = "ti,da850-evm", "ti,da850";
> >  
> > +DA850/OMAP-L138/AM18x L138/C6748 Development Kit (LCDK) board
> > +Required root node properties:
> > +    - compatible = "ti,omapl138-lcdk", "ti,da850";
> > +
> >  EnBW AM1808 based CMC board
> >  Required root node properties:
> >      - compatible = "enbw,cmc", "ti,da850;
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 414b427..da3f69b 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -105,6 +105,7 @@ dtb-$(CONFIG_ARCH_BERLIN) += \
> >  dtb-$(CONFIG_ARCH_BRCMSTB) += \
> >  	bcm7445-bcm97445svmb.dtb
> >  dtb-$(CONFIG_ARCH_DAVINCI) += \
> > +	omapl138-lcdk.dtb \
> >  	da850-enbw-cmc.dtb \
> >  	da850-evm.dtb
> >  dtb-$(CONFIG_ARCH_DIGICOLOR) += \
> > diff --git a/arch/arm/boot/dts/omapl138-lcdk.dts b/arch/arm/boot/dts/omapl138-lcdk.dts
> > new file mode 100644
> > index 0000000..fad3b6d
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/omapl138-lcdk.dts
> > @@ -0,0 +1,71 @@
> > +/*
> > + * Copyright (c) 2016 BayLibre, Inc.
> > + *
> > + * Licensed under GPLv2 or later.
> > + */
> > +/dts-v1/;
> > +#include "da850.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +
> > +/ {
> > +	model = "DA850/AM1808/OMAP-L138 LCDK";
> > +	compatible = "ti,omapl138-lcdk", "ti,da850";
> > +
> > +	aliases {
> > +		serial2 = &serial2;
> > +	};
> > +
> > +	chosen {
> > +		bootargs = "console=ttyS2,115200n8 earlycon";
> 
> You don't need console with stdout-path set. And really, earlycon should 
> not be the default.
> 
Ok for earlycon.

For the console, I thought likewise .. until I _struggled_ to understand
why the console was disappearing under my feet.
It seemed even stranger when I started looking at the codepath because
drivers/of/base.c would properly add_preferred_console as expected after
the corresponding UART was added. But the reality was there, without it
the console was not like stdout-path.
Among the commits that could instill doubt as to whether stdout-path
rules is f64255b5072d:
"The assumption that at least 1 preferred console will be registered
when the stdout-path property is set is invalid, which can result in
_no_ consoles.", though it didn't answer my question.
I started looking whether tty0 was not getting in the way and in the end
I came up with setting console.
But you seem affirmative.
 
Karl
