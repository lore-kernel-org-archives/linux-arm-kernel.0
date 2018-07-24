From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 24 Jul 2018 02:13:46 +0000
Subject: [PATCH v6 5/5] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <846bb908-f75e-1988-8f30-e49a537c7969@mleia.com>
References: <20180722063923.30222-1-o.rempel@pengutronix.de>
 <20180722063923.30222-6-o.rempel@pengutronix.de>
 <846bb908-f75e-1988-8f30-e49a537c7969@mleia.com>
Message-ID: <AM0PR04MB4211F061FEF93A0B651C73BC80550@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Vladimir Zapolskiy [mailto:vz at mleia.com]
> Sent: Tuesday, July 24, 2018 7:31 AM
> To: Oleksij Rempel <o.rempel@pengutronix.de>; Shawn Guo
> <shawnguo@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; A.s.
> Dong <aisheng.dong@nxp.com>; Vladimir Zapolskiy
> <vladimir_zapolskiy@mentor.com>
> Cc: kernel at pengutronix.de; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v6 5/5] mailbox: Add support for i.MX7D messaging unit
> 
> Hi Oleksij,
> 
> On 07/22/2018 09:39 AM, Oleksij Rempel wrote:
> > The Mailbox controller is able to send messages (up to 4 32 bit words)
> > between the endpoints.
> >
> > This driver was tested using the mailbox-test driver sending messages
> > between the Cortex-A7 and the Cortex-M4.
> >
> > Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [snip]
> 
> > +static int imx_mu_startup(struct mbox_chan *chan) {
> > +	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> > +	struct imx_mu_con_priv *cp = chan->con_priv;
> > +	int ret;
> > +
> > +	cp->irq_desc = devm_kasprintf(priv->dev, GFP_KERNEL,
> "imx_mu_chan[%i]",
> > +				      cp->idx);
> > +	if (!cp->irq_desc)
> > +		return -ENOMEM;
> > +
> 
> Again I would suggest to move this allocation to the loop in .probe function.
> 
> [snip]
> 

+1
Good point.

> > +
> > +	for (i = 0; i < IMX_MU_CHANS; i++) {
> > +		struct imx_mu_con_priv *cp = &priv->con_priv[i];
> > +
> > +		cp->idx = i;
> > +		cp->irq = irq;
> 
> ^^^^ right over here.
> 
> > +		priv->mbox_chans[i].con_priv = cp;
> > +	}
> > +
> 
> please feel free to add my technical side review tag to the next version:
> 
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> 
> FWIW I find that review comments from Lucas are pretty valid, I would
> recommend to incorporate them.

+1

Regards
Dong Aisheng

> 
> --
> Best wishes,
> Vladimir
