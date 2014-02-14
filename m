From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 14 Feb 2014 10:23:44 +0100
Subject: [PATCH 4/6] net: cpsw: Use cpsw-ctrl-macid driver
In-Reply-To: <20140213193702.GE17650@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <1387385242-1161-5-git-send-email-mpa@pengutronix.de>
 <20140213193702.GE17650@pengutronix.de>
Message-ID: <20140214092344.GM31787@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Feb 13, 2014 at 08:37:02PM +0100, Uwe Kleine-K?nig wrote:
> Hello Markus,
> 
> On Wed, Dec 18, 2013 at 05:47:20PM +0100, Markus Pargmann wrote:
> > Use ctrl-macid driver to obtain the macids stored in the processor. This
> > is only done when defined in DT.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/net/cpsw.txt |  5 +++++
> >  drivers/net/ethernet/ti/cpsw.c                 | 18 ++++++++++++++----
> >  drivers/net/ethernet/ti/cpsw.h                 |  2 ++
> >  3 files changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
> > index c39f077..b95c38b 100644
> > --- a/Documentation/devicetree/bindings/net/cpsw.txt
> > +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> > @@ -34,6 +34,11 @@ Required properties:
> >  Optional properties:
> >  - dual_emac_res_vlan	: Specifies VID to be used to segregate the ports
> >  - mac-address		: Specifies slave MAC address
> > +- ti,mac-address-ctrl	: When cpsw-ctrl-macid support is compiledin, this can
> > +			  be set to a phandle with one argument, see
> > +			  cpsw-ctrl-macid.txt. If this method fails, cpsw falls
> > +			  back to mac-address or random mac-address.
> > +
> >  
> >  Note: "ti,hwmods" field is used to fetch the base address and irq
> >  resources from TI, omap hwmod data base during device registration.
> > diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> > index 5120d9c..382d793 100644
> > --- a/drivers/net/ethernet/ti/cpsw.c
> > +++ b/drivers/net/ethernet/ti/cpsw.c
> > @@ -1804,9 +1804,16 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
> >  		snprintf(slave_data->phy_id, sizeof(slave_data->phy_id),
> >  			 PHY_ID_FMT, mdio->name, phyid);
> >  
> > -		mac_addr = of_get_mac_address(slave_node);
> > -		if (mac_addr)
> > -			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> > +		ret = cpsw_ctrl_macid_read(slave_node, slave_data->mac_addr);
> > +		if (ret) {
> > +			if (ret == -EPROBE_DEFER)
> > +				return ret;
> > +
> > +			mac_addr = of_get_mac_address(slave_node);
> > +			if (mac_addr)
> > +				memcpy(slave_data->mac_addr, mac_addr,
> > +						ETH_ALEN);
> > +		}
> I'd do it the other way round: Use the contents from an explicit
> "mac-address" or "local-mac-address" property (i.e. of_get_mac_address)
> and if that doesn't return anything use the mac-address-ctrl as
> fallback.

Yes you are right. In this case this wouldn't even influence any boots
with u-boot which already set the correct mac-address property.

I will fix this.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
