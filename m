From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 4 Jul 2018 22:40:47 +0200
Subject: [PATCH net-next 2/5 v2] net: gemini: Improve connection prints
In-Reply-To: <20180704183324.10605-2-linus.walleij@linaro.org>
References: <20180704183324.10605-1-linus.walleij@linaro.org>
 <20180704183324.10605-2-linus.walleij@linaro.org>
Message-ID: <20180704204047.GD23469@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 08:33:21PM +0200, Linus Walleij wrote:
> Switch over to using a module parameter and debug prints
> that can be controlled by this or ethtool like everyone
> else. Depromote all other prints to debug messages.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Use a module parameter and the message levels like all
>   other drivers and stop trying to be special.
> ---
>  drivers/net/ethernet/cortina/gemini.c | 44 +++++++++++++++------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 8fc31723f700..f219208d2351 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -46,6 +46,11 @@
>  #define DRV_NAME		"gmac-gemini"
>  #define DRV_VERSION		"1.0"
>  
> +#define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
> +static int debug = -1;
> +module_param(debug, int, 0);
> +MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
> +
>  #define HSIZE_8			0x00
>  #define HSIZE_16		0x01
>  #define HSIZE_32		0x02
> @@ -300,23 +305,26 @@ static void gmac_speed_set(struct net_device *netdev)
>  		status.bits.speed = GMAC_SPEED_1000;
>  		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
>  			status.bits.mii_rmii = GMAC_PHY_RGMII_1000;
> -		netdev_info(netdev, "connect to RGMII @ 1Gbit\n");
> +		netdev_dbg(netdev, "connect %s to RGMII @ 1Gbit\n",
> +			   phydev_name(phydev));

Hi Linus

Since these are netdev_dbg, they will generally never be seen. So
could you add a call to phy_print_status() at the end of this
function. That is what most MAC drivers do.

> -	netdev_info(netdev, "connected to PHY \"%s\"\n",
> -		    phydev_name(phy));
> -	phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",
> -			   (unsigned long)phy->phy_id,
> -			   phy_modes(phy->interface));
> +	netdev_dbg(netdev, "connected to PHY \"%s\"\n",
> +		   phydev_name(phy));
>  

It would be nice to call phy_attached_info(), as most other MAC
drivers do.

	Andrew
