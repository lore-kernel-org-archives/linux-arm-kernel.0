From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 9 Sep 2014 08:05:22 +0200
Subject: [PATCH v6 5/7] net: cpsw: Add am33xx MACID readout
In-Reply-To: <20140908165116.GH3238@atomide.com>
References: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
 <1410110375-3570-6-git-send-email-mpa@pengutronix.de>
 <20140908165116.GH3238@atomide.com>
Message-ID: <20140909060522.GD24081@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 09:51:17AM -0700, Tony Lindgren wrote:
> * Markus Pargmann <mpa@pengutronix.de> [140907 10:20]:
> > This patch adds a function to get the MACIDs from the am33xx SoC
> > control module registers which hold unique vendor MACIDs. This is only
> > used if of_get_mac_address() fails to get a valid mac address.
> ...
> 
> > @@ -1928,8 +1960,16 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
> >  			 PHY_ID_FMT, mdio->name, phyid);
> >  
> >  		mac_addr = of_get_mac_address(slave_node);
> > -		if (mac_addr)
> > +		if (mac_addr) {
> >  			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> > +		} else {
> > +			if (of_machine_is_compatible("ti,am33xx")) {
> > +				ret = cpsw_am33xx_cm_get_macid(&pdev->dev, i,
> > +							slave_data->mac_addr);
> > +				if (ret)
> > +					return ret;
> > +			}
> > +		}
> >  
> >  		slave_data->phy_if = of_get_phy_mode(slave_node);
> >  		if (slave_data->phy_if < 0) {
> 
> Thanks for updating this, this looks more future proof for adding
> the dra7 related patch.
> 
> For the long run, it probably makes sense to add SoC specific
> compatible values such as "ti,cpsw-am3350" and so on. Then the
> mac address functions can be initialized based on the of_device_id
> entry for .data. The wiring is cleary SoC specific here.

The hardware doesn't differ across the SoCs, so I thought it may be
better to keep one compatible and parse the machine compatible for the
MACID location. But different compatible values are also ok.

> 
> So for the purpose of this series, I'm fine with this series,
> please feel free to add for this patch:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/a3df3974/attachment.sig>
