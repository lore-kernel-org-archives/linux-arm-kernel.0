From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 7 Nov 2011 22:55:34 +0100
Subject: [PATCH 3/3 V2] ARM: pxa: Add basic DTS files for PXA/Vpac270
 testing machine
In-Reply-To: <4EB85174.70801@gmail.com>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
 <1320701506-26812-4-git-send-email-marek.vasut@gmail.com>
 <4EB85174.70801@gmail.com>
Message-ID: <201111072255.35075.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 11/07/2011 03:31 PM, Marek Vasut wrote:
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Rob Herring <robherring2@gmail.com>
> > ---
> 
> Couple of minor things below. With those fixed:
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> >  arch/arm/boot/dts/pxa-vpac270.dts |   37 +++++++++++++++++++
> >  arch/arm/boot/dts/pxa.dtsi        |   71
> >  +++++++++++++++++++++++++++++++++++++ 2 files changed, 108
> >  insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/pxa-vpac270.dts
> >  create mode 100644 arch/arm/boot/dts/pxa.dtsi
> > 
> > V2: Fix typo -- rename alias -> aliases in the pxa270.dtsi
> > 
> >     Drop marvell,pxa250 option, instead leave all ports disable and let
> >     user select, which will be registered. This depends on the user not
> >     doing something stupid (like registering HWUART, which is available
> >     only on pxa250) on pxa320.
> 
> Should be a safe assumption. Only someone capable of implementing board
> support should create a dts...
> 
> > diff --git a/arch/arm/boot/dts/pxa-vpac270.dts
> > b/arch/arm/boot/dts/pxa-vpac270.dts new file mode 100644
> > index 0000000..48dd9e5
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/pxa-vpac270.dts
> > @@ -0,0 +1,37 @@
> > +/*
> > + * pxa-vpac270.dts - Device Tree file for Voipac PXA270 board
> > + *
> > + * Copyright (C) 2011 Marek Vasut <marek.vasut@gmail.com>
> > + *
> > + * Licensed under GPLv2 or later.
> > + */
> > +/dts-v1/;
> > +/include/ "pxa.dtsi"
> > +
> > +/ {
> > +	model = "Voipac VPAC270";
> > +	compatible = "voipac,vpac270";
> > +
> > +	chosen {
> > +		bootargs = "console=ttyS0,115200 mem=128M at 0xa0000000";
> 
> Isn't mem= redundant with the memory node below?

Yes it is, but ...

the board has 256MB or RAM, PXA assumes ram base at 0xa0000000, but the other 
node is at 0x80000000. U-Boot passes both nodes to kernel, kernel gets confused 
and crashes. Basically, we need to wait until uboot supports relative uImages 
(should be soon) and then we can drop this and use whole 256MB of RAM.

> 
> > +		linux,stdout-path = &ffuart;
> > +	};
> > +
> > +	memory at a0000000 {
> > +		reg = <0xa0000000 0x8000000>;
> > +	};
> > +
> > +	pxabus {
> > +		ffuart: uart at 40100000 {
> 
> These should be serial at ...

Thanks, but why ? Is there some rule about it ?
