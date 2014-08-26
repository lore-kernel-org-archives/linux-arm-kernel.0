From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 26 Aug 2014 07:55:09 +0200
Subject: [PATCH v5 5/7] net: cpsw: Add am33xx MACID readout
In-Reply-To: <20140825160118.GG17254@atomide.com>
References: <1408947828-22316-1-git-send-email-mpa@pengutronix.de>
 <1408947828-22316-6-git-send-email-mpa@pengutronix.de>
 <20140825160118.GG17254@atomide.com>
Message-ID: <20140826055509.GB21770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 25, 2014 at 09:01:19AM -0700, Tony Lindgren wrote:
> > diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> > index 0bc2c2a2c236..7c94a0fb24bc 100644
> > --- a/drivers/net/ethernet/ti/cpsw.c
> > +++ b/drivers/net/ethernet/ti/cpsw.c
> > @@ -33,6 +33,8 @@
> >  #include <linux/of_net.h>
> >  #include <linux/of_device.h>
> >  #include <linux/if_vlan.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> >  
> >  #include <linux/pinctrl/consumer.h>
> >  
> > @@ -1816,6 +1818,39 @@ static void cpsw_slave_init(struct cpsw_slave *slave, struct cpsw_priv *priv,
> >  	slave->port_vlan = data->dual_emac_res_vlan;
> >  }
> >  
> > +#define AM33XX_CTRL_MAC_LO_REG(id) (0x630 + 0x8 * id)
> > +#define AM33XX_CTRL_MAC_HI_REG(id) (0x630 + 0x8 * id + 0x4)
> > +
> > +static int cpsw_am33xx_cm_get_macid(struct device *dev, int slave,
> > +		u8 *mac_addr)
> > +{
> > +	u32 macid_lo;
> > +	u32 macid_hi;
> > +	struct regmap *syscon;
> > +
> > +	if (!of_machine_is_compatible("ti,am33xx"))
> > +		return 0;
> > +
> > +	syscon = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
> > +	if (IS_ERR(syscon)) {
> > +		if (PTR_ERR(syscon) == -ENODEV)
> > +			return 0;
> > +		return PTR_ERR(syscon);
> > +	}
> > +
> > +	regmap_read(syscon, AM33XX_CTRL_MAC_LO_REG(slave), &macid_lo);
> > +	regmap_read(syscon, AM33XX_CTRL_MAC_HI_REG(slave), &macid_hi);
> > +
> > +	mac_addr[5] = (macid_lo >> 8) & 0xff;
> > +	mac_addr[4] = macid_lo & 0xff;
> > +	mac_addr[3] = (macid_hi >> 24) & 0xff;
> > +	mac_addr[2] = (macid_hi >> 16) & 0xff;
> > +	mac_addr[1] = (macid_hi >> 8) & 0xff;
> > +	mac_addr[0] = macid_hi & 0xff;
> > +
> > +	return 0;
> > +}
> 
> I think this only works for the first instance of the cpsw?

This works for both cpsw slaves on am335x. It does not work for multiple
cpsw drivers. But we don't have them on am335x. For other platforms this
function may be used in case they have the same register layout.

> 
> Can the other instances of cpsw use this too and just increment
> some value in it?
> 
> >  static int cpsw_probe_dt(struct cpsw_platform_data *data,
> >  			 struct platform_device *pdev)
> >  {
> > @@ -1928,8 +1963,14 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
> >  			 PHY_ID_FMT, mdio->name, phyid);
> >  
> >  		mac_addr = of_get_mac_address(slave_node);
> > -		if (mac_addr)
> > +		if (mac_addr) {
> >  			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> > +		} else {
> > +			ret = cpsw_am33xx_cm_get_macid(&pdev->dev, i,
> > +						       slave_data->mac_addr);
> > +			if (ret)
> > +				return ret;
> > +		}
> >  
> >  		slave_data->phy_if = of_get_phy_mode(slave_node);
> >  		if (slave_data->phy_if < 0) {
> 
> The cpsw_am33xx_cm_get_macid() should only get called based on the
> compatible flag to avoid random register access on other SoCs.
> 
> So how about add the of_machine_is_compatible("ti,am33xx")
> check here instead and skip calling cpsw_am33xx_cm_get_macid()
> otherwise?
> 
> That allows adding support for other omaps as we already have
> ti,am4372-cpsw and people have pointed out issues with dra7xx
> already.

Okay, I will move the machine check here instead.

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/d31b6a6e/attachment.sig>
