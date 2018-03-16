From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Mar 2018 15:53:07 +0000
Subject: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface
 to use in-band negotiation
In-Reply-To: <20180316103351.16616-3-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
Message-ID: <20180316155307.GQ9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 11:33:43AM +0100, Antoine Tenart wrote:
> The PHY mode 10GKR can use in-band negotiation. This patches allows this
> mode to be used with MLO_AN_INBAND in phylink.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/phy/phylink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 51a011a349fe..7224b005f0dd 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -768,7 +768,8 @@ int phylink_of_phy_connect(struct phylink *pl, struct device_node *dn,
>  	/* Fixed links and 802.3z are handled without needing a PHY */
>  	if (pl->link_an_mode == MLO_AN_FIXED ||
>  	    (pl->link_an_mode == MLO_AN_INBAND &&
> -	     phy_interface_mode_is_8023z(pl->link_interface)))
> +	     (phy_interface_mode_is_8023z(pl->link_interface) ||
> +	      pl->link_interface == PHY_INTERFACE_MODE_10GKR)))

There is no inband negotiation like there is with 802.3z or SGMII,
so this makes no sense.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
