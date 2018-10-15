From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Oct 2018 11:40:53 +0200
Subject: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
In-Reply-To: <AM0PR04MB421179CEB214D46BCDE6ACF280FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
 <1539527419-23613-3-git-send-email-aisheng.dong@nxp.com>
 <20181015065859.lxevjroly435hlaq@pengutronix.de>
 <AM0PR04MB42117867A50BB18D8127BE8080FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181015082751.ytuleg67p5pgtnov@pengutronix.de>
 <AM0PR04MB421179CEB214D46BCDE6ACF280FD0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20181015094053.7bpydkdhyds25n3u@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 09:03:04AM +0000, A.s. Dong wrote:
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Monday, October 15, 2018 4:28 PM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; Mark Rutland
> > <mark.rutland@arm.com>; dongas86 at gmail.com; devicetree at vger.kernel.org;
> > catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
> > dl-linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> > <fabio.estevam@nxp.com>; shawnguo at kernel.org
> > Subject: Re: [PATCH V2 2/4] arm64: dts: imx: add imx8qxp support
> > 
> > On Mon, Oct 15, 2018 at 08:08:31AM +0000, A.s. Dong wrote:
> > > > > +		imx8qx-pm {
> > > > > +			compatible = "fsl,scu-pd";
> > > >
> > > > I missed this earlier, but there should be a i.MX8qp specific
> > > > compatible as the SCU API might change for future SoCs.
> > > >
> > >
> > > We still do not see that requirement up till now. Not sure if it would
> > > be possible in the future. I see low possibilities.
> > > SCU IPC is designed to be generic to all MX8 SCU firmwares.
> > 
> > And i.MX9? i.MX10?
> > 
> 
> MX8DM MX8DXP

I was not talking about existing SoCs, I was talking about future SoCs.

> 
> > > Even it changes, SCU firmware version control may helps.
> > 
> > It's not the first time that the position of the version field changes with a
> > newer version.
> > 
> 
> I understand your worry. 
> Up till now all SCU firmware based SoCs are all using one generic IPC driver internally.
> And I have not heard a possible changing in the future.
> I double checked the SCU firmware implementation that the IPC
> Is deigned to be platform independent. So it's less to be changed.
> So I wonder if this could be over worried.
> Even it is changed, (quite less probility), we still can user version
> To distinguish them, just like arm,scpi , arm,scmi. Right?

You can still add and use a generic compatible, but does it hurt when
you add a SoC specific one that you *can* use should you have to?

> 
> > >
> > > > > +			compatible = "fsl,imx7ulp-lpuart";
> > > > > +			compatible = "fsl,imx7ulp-lpi2c";
> > > > > +			compatible = "fsl,imx7d-usdhc";
> > > >
> > > > All these lack the most specific imx8qp compatible.
> > > >
> > >
> > > Adding them requires binding doc update as well.
> > > S I suppose they could be added later when the QXP specific features
> > > are really supported by the drivers.
> > > Do you think it's okay?
> > 
> > Newer Kernels should work with older device trees, so once you roll out these
> > compatibles it's too late already.
> > 
> 
> The backwards compatible string is used to guarantee a basic function.
> Even we add qxp specific compatible string later, it still can work with
> backwards function. So I'm not quite get what the real problem is.
> And this is the initial support that we don't expect the full features
> with such an early device tree, right?

By not adding a SoC compatible you lose the possibility to add a SoC
specific fixup without changing the device tree or you have to work with
quirks like:

https://elixir.bootlin.com/linux/latest/source/drivers/clocksource/timer-imx-gpt.c#L521

or

https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-imx.c#L1182

So far we have added new compatibles with each new SoC type for good
reasons, so why should we change this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
