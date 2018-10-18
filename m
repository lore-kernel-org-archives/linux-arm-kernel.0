From: robh@kernel.org (Rob Herring)
Date: Wed, 17 Oct 2018 19:51:30 -0500
Subject: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
In-Reply-To: <AM0PR04MB4211ECC04FD48918E9DFBAB880FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
 <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5BEwNQy0HA80qOzm_w-c63tFK1eL+cOHNCxKYq9PHGsqw@mail.gmail.com>
 <AM0PR04MB4211ECC04FD48918E9DFBAB880FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20181018005130.GA8173@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 07:57:07AM +0000, A.s. Dong wrote:
> > -----Original Message-----
> > From: Fabio Estevam [mailto:festevam at gmail.com]
> > Sent: Monday, October 15, 2018 7:14 AM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> > <linux-arm-kernel@lists.infradead.org>; Dong Aisheng <dongas86@gmail.com>;
> > Sascha Hauer <kernel@pengutronix.de>; Shawn Guo <shawnguo@kernel.org>;
> > Fabio Estevam <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> > Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> > <will.deacon@arm.com>; dl-linux-imx <linux-imx@nxp.com>; Mark Rutland
> > <mark.rutland@arm.com>; open list:OPEN FIRMWARE AND FLATTENED
> > DEVICE TREE BINDINGS <devicetree@vger.kernel.org>
> > Subject: Re: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
> > 
> > Hi Dong,
> > 
> > On Sun, Oct 14, 2018 at 11:35 AM A.s. Dong <aisheng.dong@nxp.com> wrote:
> > >
> > > Add imx8qxp support
> > 
> > You could probably expand the commit log by explaining a bit of what im8qxp
> > means.
> > 
> 
> Got it, thanks for the suggestion.
> 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > new file mode 100644
> > > index 0000000..e1d2578
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > @@ -0,0 +1,861 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > > + * Copyright 2017~2018 NXP
> > 
> > I guess you meant "-" instead of "~".
> > 
> > > +       memory at 80000000 {
> > > +               device_type = "memory";
> > > +               reg = <0x00000000 0x80000000 0 0x40000000>;
> > > +       };
> > 
> > This should go to the board dts file instead as the memory size may vary from
> > board to board.
> > 
> 
> That's right. Will change it.
> 
> > > +               imx8qx-pm {
> > > +                       compatible = "fsl,scu-pd";
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <0>;
> > > +
> > > +                       pd_lsio: lsio-power-domain {
> > > +                               #power-domain-cells = <0>;
> > > +                               #address-cells = <1>;
> > > +                               #size-cells = <0>;
> > > +
> > > +                               pd_lsio_pwm0: lsio-pwm0 at 191 {
> > > +                                       reg = <191>;
> > 
> > The number after @ is in hex, so the reg property should be 0x191.
> 
> Thanks for the reminder.
> The PD ID is defined in DEC. So I will change them all into HEX later manually.
> 
> BTW, this seems like error prone and checkpatch can't report it.

checkpatch doesn't really check dts files.

But if it did would you have noticed? Because there is at least one 
checkpatch issue with your author name and S-o-b name not matching.

> And I notice many similar users in kernel with the same issue:
> arch/arm/boot/dts/tps65910.dtsi
> arch/arm/boot/dts/tegra124-nyan.dtsi
> arch/arm/boot/dts/rk3288.dtsi

At least I2C and SPI are now checked by dtc. 'simple-bus' children were 
too, but silently broke and only recently got fixed in upstream dtc. 
I've not pulled that into the kernel yet, but you can build dtbs using 
an external copy of dtc. And guess what, there are *lots* of warnings.

Rob
