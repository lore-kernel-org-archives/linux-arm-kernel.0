From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Nov 2012 09:33:48 +0900
Subject: [PATCH 7/7] ARM: mach-shmobile: kzm9g: Reference DT implementation
In-Reply-To: <50B329B3.8000209@kmckk.co.jp>
References: <1353889014-17142-1-git-send-email-horms@verge.net.au>
 <1353889014-17142-8-git-send-email-horms@verge.net.au>
 <50B329B3.8000209@kmckk.co.jp>
Message-ID: <20121127003348.GD9724@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 05:34:59PM +0900, Tetsuyuki Kobayashi wrote:
> Hello Simon-san,
> 
> (2012/11/26 9:16), Simon Horman wrote:
> > Provide alternate board code for the kzm9g to demonstrate
> > how DT may be used given the current state of driver
> > device tree support. This is intended to act as a reference
> > for mach-shmobile developers.
> > 
> > Some notes:
> > 
> > * Brings up the GIC interrupt handler using device tree
> > * Brings up the following devices using device tree
> >    - ST1232 (Touchscreen)
> >    - MMCIF (MMC)
> >    - SDHI (MMC)
> > * Does not bring up the INTC interrupt controller at all,
> >    thus external devices may not be used
> > * Uses existing C code and not device tree to initialise the following,
> >    which are needed for a working board:
> >    - SCIF (Serial)
> >    - CMT (Clock)
> >    - PFC (GPIO)
> > 
> > To use this alternate board code instead of the normal board code,
> > CONFIG_MACH_KZM9G_REFERENCE should be selected in the kernel config.
> > And the sh73a0-kzm9g-reference.dtb flattened device tree blob should be used.
> > 
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >   arch/arm/boot/dts/Makefile                     |    3 +-
> >   arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |  153 ++++++++++++++++++++++++
> >   arch/arm/mach-shmobile/Kconfig                 |   10 ++
> >   arch/arm/mach-shmobile/Makefile                |    8 +-
> >   arch/arm/mach-shmobile/board-kzm9g-reference.c |  142 ++++++++++++++++++++++
> >   5 files changed, 314 insertions(+), 2 deletions(-)
> >   create mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> >   create mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index c1ce813..b6c4fa2 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -75,7 +75,8 @@ dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
> >   dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
> >   dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
> >   	r8a7740-armadillo800eva.dtb \
> > -	sh73a0-kzm9g.dtb
> > +	sh73a0-kzm9g.dtb \
> > +	sh73a0-kzm9g-reference.dtb
> >   dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
> >   	spear1340-evb.dtb
> >   dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
> > diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> > new file mode 100644
> > index 0000000..978892a
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> > @@ -0,0 +1,153 @@
> > +/*
> > + * Device Tree Source for the KZM-A9-GT board
> > + *
> > + * Copyright (C) 2012 Horms Solutions Ltd.
> > + *
> > + * Based on sh73a0-kzm9g.dts
> > + * Copyright (C) 2012 Renesas Solutions Corp.
> > + *
> > + * This file is licensed under the terms of the GNU General Public License
> > + * version 2.  This program is licensed "as is" without any warranty of any
> > + * kind, whether express or implied.
> > + */
> > +
> > +/dts-v1/;
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +	model = "KZM-A9-GT";
> > +	compatible = "renesas,kzm9g-reference", "renesas,sh73a0";
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x41000000 0x1e800000>;
> > +	};
> > +
> > +	gic: interrupt-controller at f0001000 {
> > +		compatible = "arm,cortex-a9-gic";
> > +		#interrupt-cells = <3>;
> > +		#address-cells = <1>;
> > +		interrupt-controller;
> > +		reg = <0xf0001000 0x1000>,
> > +		      <0xf0000100 0x100>;
> > +	};
> > +
> > +	i2c0: i2c at 0xe6820000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		compatible = "renesas,rmobile-iic";
> > +		reg = <0xe6820000 0x425>;
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <0 167 0x4
> > +			      0 170 0x4>;
> > +	};
> 
> I reported /dev/i2c-0 seems not working. I found the reason.
> About i2c0 interrupt, it should be:
> 
>  		interrupts = <0 167 0x4
> 			      0 168 0x4
> 			      0 169 0x4
>  			      0 170 0x4>;
> 
> The same as i2c1 - ic24. There are 4 interrupts each.

Thanks, sorry for missing that the first time around.
