From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 16 Jul 2016 18:44:13 +0200
Subject: [PATCH v0 08/10] net: phy: Try looking for a phy-handle property
 to find the OF node
In-Reply-To: <1468679348-10522-9-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1468679348-10522-9-git-send-email-jm@lentin.co.uk>
Message-ID: <20160716164413.GJ1777@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2016 at 03:29:06PM +0100, Jamie Lentin wrote:
> If PHY is registered via. a DSA switch, the MDIO bus the phy is on does
> not exist in devicetree, but there may be a reference to the PHY node
> on the physical MDIO bus to use.

O.K, i see what you are trying to achieve, it makes sense, but sorry,
NACK.

There is however a nice solution :-)

If you look in net-next, you will notice a big change to DSA. There is
a new binding, and the mv88e6xxx driver now exports the switch
internal MDIO bus just like any other MDIO bus. So you can have a phy
on the MDIO bus, and that phy can have "marvell,reg-init" properties.

     Andrew

> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  drivers/net/phy/marvell.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index 280e879..c2ca347 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -302,14 +302,24 @@ static int marvell_config_aneg(struct phy_device *phydev)
>   */
>  static int marvell_of_reg_init(struct phy_device *phydev)
>  {
> -	const __be32 *paddr;
> +	const __be32 *paddr = NULL;
>  	int len, i, saved_page, current_page, page_changed, ret;
> +	struct device_node *phy_dn;
> +
> +	if (phydev->mdio.dev.of_node)
> +		paddr = of_get_property(phydev->mdio.dev.of_node,
> +					"marvell,reg-init", &len);
> +	else if (phydev->attached_dev->dev.of_node) {
> +		/* A DSA slave-mii-bus has no OF node, but the PHY might */
> +		phy_dn = of_parse_phandle(phydev->attached_dev->dev.of_node,
> +					  "phy-handle", 0);
> +		if (phy_dn) {
> +			paddr = of_get_property(phy_dn,
> +						"marvell,reg-init", &len);
> +			of_node_put(phy_dn);
> +		}
> +	}
>  
> -	if (!phydev->mdio.dev.of_node)
> -		return 0;
> -
> -	paddr = of_get_property(phydev->mdio.dev.of_node,
> -				"marvell,reg-init", &len);
>  	if (!paddr || len < (4 * sizeof(*paddr)))
>  		return 0;
>  
> -- 
> 2.8.1
> 
