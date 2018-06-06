From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 6 Jun 2018 10:28:36 +0000
Subject: [PATCH 4/4] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <AM0PR04MB4211FCC9F3902F14EBD28313806E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1524854776-14863-1-git-send-email-aisheng.dong@nxp.com>
 <1524854776-14863-5-git-send-email-aisheng.dong@nxp.com>
 <20180502100401.qmik5goglbuiqcaa@pengutronix.de>
 <AM0PR04MB421166CCB06610FF8AF25C2980800@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180503110611.wxwsjfszjdnovm2f@pengutronix.de>
 <AM0PR04MB42117041F226AD5E8501EC1080870@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180503124030.jkc7oox2vyjblk2y@pengutronix.de>
 <AM0PR04MB421169E44830A17D8A52D3F4806A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211FCC9F3902F14EBD28313806E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB4211F52A9447CF27EC78AFB780650@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> -----Original Message-----
> From: A.s. Dong
> Sent: Monday, May 28, 2018 5:25 PM
> To: 'Sascha Hauer' <s.hauer@pengutronix.de>
> Cc: 'linux-arm-kernel at lists.infradead.org' <linux-arm-
> kernel at lists.infradead.org>; 'dongas86 at gmail.com' <dongas86@gmail.com>;
> dl-linux-imx <linux-imx@nxp.com>; 'kernel at pengutronix.de'
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>;
> 'shawnguo at kernel.org' <shawnguo@kernel.org>
> Subject: RE: [PATCH 4/4] soc: imx: add SC firmware IPC and APIs
> 
...

> > > > > We discussed this internally and came to the conclusion that the
> > > > > SCU is not a generic user of a MU. The MU is designed to work
> > > > > together with a piece of SRAM to form a mailbox system. Instead
> > > > > of working as designed the SCU morses the messages through the
> > > > > doorbell (what the MU really is). For anything that uses the MU
> > > > > in the way it is designed I would suggest using the mailbox
> > > > > interface from drivers/mailbox/ along with the binding from
> > > Documentation/devicetree/bindings/mailbox/mailbox.txt.
> > > > >
> > > > > In the way I suggest there is no need for any MU ID.
> > > > >
> > > >
> > > > So you're suggesting switch to use mailbox instead of private MU
> > > > library function calls?
> > > > Something like:
> > > >         scu {
> > > >                 compatible = "nxp,imx8qxp-scu", "simple-bus";
> > > >                 mboxes = <&mailbox 0>;
> > > >         }
> > > > Then IPC is implemented based on mailbox?
> > > >
> > > > As I replied Oleksij Rempel in another mail in this thread, we've
> > > > tried mailbox but got performance regression issue and need more
> > > > time to investigate whether it's really quite suitable for i.MX
> > > > SCU firmware as SCU handling message quite fast in micro seconds.
> > > > (Mailbox polling method has much more latency than current MU
> > > > sample polling we
> > > > used) and we want to avoid the SCU firmware API changes.
> > >
> > > I am not suggesting to do mailboxing (using shared memory) for the SCU.
> > > I am also not suggesting any API update for the SCU communication.
> > > I am just mentioning that doing mailboxing is the way the MU was
> > > originally designed for. Looking at the reference manual I see many
> > > MUs on
> > the i.MX8.
> > > I guess most of them are for communication between the different
> > > cores on the system. For these it's probably worth writing some
> > > generic MU
> > driver.
> > > The way the MU is used for communication with the SCU though is so
> > > special that it's not worth writing a generic driver, so just
> > > integrate the MU access functions in the SCU code.
> > >
> >
> > I understand it.
> >
> > One problem of the way you suggested may be that:
> > If we doing like below, we may lose flexibility to change the MU used
> > for SCU firmware communication.
> > 	scu at 5d1b0000 {
> > 		compatible = "fsl,imx8qxp-scu";
> > 		reg = <0x0 0x5d1b0000 0x0 0x10000>;
> > 	};
> >
> > And current design is that the system supports multiple MU channels
> > used by various users at the same time, e.g. SCU, Power Domain, Clock and
> others.
> > User can flexibly change it under their nodes: And each MU channel is
> > protected by their private lock and not affect each others.
> >
> > e.g.
> >         scu {
> >                 compatible = "nxp,imx8qxp-scu", "simple-bus";
> >                 fsl,mu = <&lsio_mu0>;
> >
> >                 clk: clk {
> >                         compatible = "fsl,imx8qxp-clk";
> >                         #clock-cells = <1>;
> >                 };
> >
> >                 iomuxc: iomuxc {
> >                         compatible = "fsl,imx8qxp-iomuxc";
> >                         fsl,mu = <&lsio_mu3>;
> >                 };
> >
> >                 imx8qx-pm {
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> >                         fsl,mu = <&lsio_mu4>;
> > 	.............
> >         }
> >
> > The default code only uses MU0 which is used by SCU.
> >
> > The change may affect this design. Any ideas?
> > Do you think we can keep the current way?
> >
> 
> Any comments about this?
> 

Have you got a chance to help look at it?
We need identify the direction to go next.

Regards
Dong Aisheng

> Regards
> Dong Aisheng
> 
> > Regards
> > Dong Aisheng
> >
> > > Sascha
> > >
> > > --
> > > Pengutronix e.K.                           |                             |
> > > Industrial Linux Solutions                 |
> > >
> >
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> > >
> >
> w.pengutronix.de%2F&data=02%7C01%7Caisheng.dong%40nxp.com%7C266
> > >
> 24a5c38e5488a80b708d5b0f3107b%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> > >
> >
> 7C0%7C0%7C636609480354404338&sdata=XP%2BYdt9I7zURrQun2jRbempLhC
> > > XrYtMVMb3dEWrZuro%3D&reserved=0  |
> > > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
