From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 15 May 2017 18:59:07 +0800
Subject: [PATCH 2/5] pinctrl: imx: add soc specific mux_mode mask and
 shift property
In-Reply-To: <AM3PR04MB306F70328E49CB7EE68E2C380E10@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
 <1494592686-30967-3-git-send-email-aisheng.dong@nxp.com>
 <20170515085236.GM8471@dragon>
 <AM3PR04MB306F70328E49CB7EE68E2C380E10@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <20170515105906.GO8471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 09:00:32AM +0000, A.S. Dong wrote:
> > > @@ -432,7 +432,7 @@ static int imx_pinconf_get(struct pinctrl_dev
> > *pctldev,
> > >  	*config = readl(ipctl->base + pin_reg->conf_reg);
> > >
> > >  	if (info->flags & SHARE_MUX_CONF_REG)
> > > -		*config &= 0xffff;
> > > +		*config &= ~info->mux_mask;
> > 
> > It changes the way how code works.  We need a note in the commit log
> > explaining why it's safe.
> > 
> 
> Well, that's Vybrid tricks that BIT[15-0] are all configs part.
> So it hardcoded 0xffff there.
> 
> But it's not true in ULP, so use mux_mask instead to address
> the difference.

So you make the assumption that for all SHARE_MUX_CONF_REG SoCs, all
bits in the register except mux ones are config bits.  You at least need
to mention that in the commit log, IMO.

Shawn
