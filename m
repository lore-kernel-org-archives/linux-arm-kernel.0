From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri, 27 Jul 2018 11:06:59 +0200
Subject: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
In-Reply-To: <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
 <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <1532680211.32306.36.camel@pengutronix.de>
 <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Message-ID: <20180727090659.6nbfrhaliyt7kyhx@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 08:58:22AM +0000, Robin Gong wrote:
> 
> 
> > -----Original Message-----
> > From: Lucas Stach [mailto:l.stach at pengutronix.de]
> > Sent: 2018?7?27? 16:30
> > To: Robin Gong <yibin.gong@nxp.com>; Oleksij Rempel
> > <o.rempel@pengutronix.de>; Shawn Guo <shawnguo@kernel.org>; Mark
> > Brown <broonie@kernel.org>; Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>; devicetree at vger.kernel.org;
> > Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> > <sboyd@codeaurora.org>; linux-kernel at vger.kernel.org; Liam Girdwood
> > <lgirdwood@gmail.com>; Rob Herring <robh+dt@kernel.org>; dl-linux-imx
> > <linux-imx@nxp.com>; kernel at pengutronix.de; A.s. Dong
> > <aisheng.dong@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>; Russell
> > King <linux@armlinux.org.uk>; Andrew Morton <akpm@linux-foundation.org>;
> > Leonard Crestez <leonard.crestez@nxp.com>; linux-clk at vger.kernel.org;
> > linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
> > fsl,pmic-stby-poweroff property
> > 
> > Hi Robin,
> > 
> > Am Freitag, den 27.07.2018, 01:51 +0000 schrieb Robin Gong:
> > [...]
> > > > > > ---
> > > > > > ?Documentation/devicetree/bindings/clock/imx6q-clock.txt | 8
> > > > > > ++++++++
> > > > > > ?1 file changed, 8 insertions(+)
> > > > > >
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > > > b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > > > index a45ca67a9d5f..e1308346e00d 100644
> > > > > > --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > > > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > > > @@ -6,6 +6,14 @@ Required properties:
> > > > > > ?- interrupts: Should contain CCM interrupt
> > > > > > ?- #clock-cells: Should be <1>
> > > > > >
> > > > > > +Optional properties:
> > > > > > +- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ
> > > > > > +signal
> > > > > > +??on power off.
> > > > > > +??Use this property if the SoC should be powered off by
> > > > > > +external power
> > > > > > +??management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> > > > >
> > > > > PMIC_ON_REQ didn't connect to any pin of PMIC in your case?
> > > >
> > > > No. First, it was only one customer specific issue. After some
> > > > research I found even publicly available boards (for example
> > > > RioTboard) which has same/similar design. After seeing this in imx6
> > > > documentation as valid power off way, I have no doubts - there should be
> > even more devices doin this in the wild.
> > >
> > > Not sure why the customer didn't follow reference design, since
> > > PMIC_ON_REQ can provide power off/on feature by pressing ONOFF key
> > > which connected ONOFF pin of i.mx6(ONOFF will toggle PMIC_ON_REQ to
> > > power off/on PMIC). The official power off/on way (PMIC_ON_REQ) can
> > > also power off all power rails of PFUZE except snvs as your patch did
> > > on PMIC_STBY_REQ.??PMIC_STBY_REQ is used to notify pmic switch power
> > > mode (PFM/APS) or decrease voltage to save power in kernel suspend, not
> > power off....I am not sure if we need this patchset to 'workaround' the board
> > issue.
> > >
> > Not all boards follow the reference design, that's a fact of life.
> > 
> > Please look at the i.MX6Q reference manual. The sequence implemented in this
> > patchset can be found as a valid way to power off the system in
> > "60.4.3 Power mode transitions" "Normal ON to OFF with external PMIC", so
> > there is hardly any way to argue that this is a board specific quirk. This is one of
> > the Freescale/NXP recommended sequences to turn off the system.
> Okay, but could you add one more comment for this solution? RTC alarm and ONOFF
> Button wakeup feature can't be support in this case.

Sure, at least it will power off. It make no sense to have power off
functionality which use same amount of power as power on system.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180727/d9058557/attachment.sig>
