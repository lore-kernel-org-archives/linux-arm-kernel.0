From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 30 Mar 2017 09:08:33 +0200
Subject: [PATCH 2/2] soc/imx: add workaround for i.MX6QP to the GPC PD
 driver
In-Reply-To: <1490804026.29083.29.camel@pengutronix.de>
References: <20170323144418.30977-1-l.stach@pengutronix.de>
 <20170323144418.30977-3-l.stach@pengutronix.de>
 <DB5PR04MB1431A7CC91F55ECFE5BE31FB80350@DB5PR04MB1431.eurprd04.prod.outlook.com>
 <1490804026.29083.29.camel@pengutronix.de>
Message-ID: <20170330090833.09ac3c33@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 29 Mar 2017 18:13:46 +0200 Lucas Stach wrote:
> Am Mittwoch, den 29.03.2017, 16:08 +0000 schrieb A.S. Dong:
> > Hi Lucas,
> > 
> > > -----Original Message-----
> > > From: Lucas Stach [mailto:l.stach at pengutronix.de]
> > > Sent: Thursday, March 23, 2017 10:44 PM
> > > To: Shawn Guo
> > > Cc: Fabio Estevam; A.S. Dong; devicetree at vger.kernel.org; linux-arm-
> > > kernel at lists.infradead.org; kernel at pengutronix.de; patchwork-
> > > lst at pengutronix.de
> > > Subject: [PATCH 2/2] soc/imx: add workaround for i.MX6QP to the GPC PD
> > > driver
> > > 
> > > On i.MX6QP, due to hardware erratum ERR009619, the PRE clocks may be
> > > stalled during the power up sequencing of the PU power domain. As this may
> > > lead to a complete loss of display output, the recommended workaround is
> > > to keep the PU domain enabled during normal system operation.
> > > 
> > > Implement this by rejecting the domain power down request on the affected
> > > SoC.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  drivers/soc/imx/gpc.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c index
> > > 4294287e5f6c..599e1e46f694 100644
> > > --- a/drivers/soc/imx/gpc.c
> > > +++ b/drivers/soc/imx/gpc.c
> > > @@ -45,6 +45,7 @@ struct imx_pm_domain {
> > >  	unsigned int reg_offs;
> > >  	signed char cntr_pdn_bit;
> > >  	unsigned int ipg_rate_mhz;
> > > +	bool allow_dynamic_pd;
> > >  };
> > > 
> > >  static inline struct imx_pm_domain *
> > > @@ -59,6 +60,9 @@ static int imx6_pm_domain_power_off(struct
> > > generic_pm_domain *genpd)
> > >  	int iso, iso2sw;
> > >  	u32 val;
> > > 
> > > +	if (!pd->allow_dynamic_pd)
> > > +		return -EBUSY;
> > > +
> > >  	/* Read ISO and ISO2SW power down delays */
> > >  	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
> > >  	iso = val & 0x3f;
> > > @@ -255,6 +259,7 @@ static struct imx_pm_domain imx_gpc_domains[] = {
> > >  		},
> > >  		.reg_offs = 0x260,
> > >  		.cntr_pdn_bit = 0,
> > > +		.allow_dynamic_pd = true,
> > >  	}, {
> > >  		.base = {
> > >  			.name = "DISPLAY",
> > > @@ -263,23 +268,33 @@ static struct imx_pm_domain imx_gpc_domains[] = {
> > >  		},
> > >  		.reg_offs = 0x240,
> > >  		.cntr_pdn_bit = 4,
> > > +		.allow_dynamic_pd = true,
> > 
> > Just a Nitpick, besides shawn's comment in another mail,
> > if we use a domain flag like IMX_PD_ALWAYS_ON set by SoC errata flag,
> > then probably we can save all the default allow_dynamic_pd lines.
> > This also release the life when adding new domains.
> 
> If other things like that show up we can certainly switch to a flags
> field. In the meantime I like that the current style is more explicit
> about it.
> 
Since the purpose of the driver is all about dynamic power management,
I would rather add a 'disable_dynamic_pd' for the case(s) where it's
not allowed, rather than having to state the obvious over and over
again.


Lothar Wa?mann
