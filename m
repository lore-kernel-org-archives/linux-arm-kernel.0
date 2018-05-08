From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 May 2018 12:53:32 +0100
Subject: [PATCH net-next v2 03/13] net: phy: sfp: warn the user when no
 tx_disable pin is available
In-Reply-To: <20180504135643.23466-4-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-4-antoine.tenart@bootlin.com>
Message-ID: <20180508115332.GG16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 03:56:33PM +0200, Antoine Tenart wrote:
> In case no Tx disable pin is available the SFP modules will always be
> emitting. This could be an issue when using modules using laser as their
> light source as we would have no way to disable it when the fiber is
> removed. This patch adds a warning when registering an SFP cage which do
> not have its tx_disable pin wired or available.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Looks fine, thanks.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

> ---
>  drivers/net/phy/sfp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 8e323a4b70da..d4f503b2e3e2 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -1093,6 +1093,15 @@ static int sfp_probe(struct platform_device *pdev)
>  	if (!sfp->gpio[GPIO_MODDEF0] && !sfp->gpio[GPIO_LOS])
>  		sfp->sm_dev_state = SFP_DEV_UNKNOWN;
>  
> +	/* We could have an issue in cases no Tx disable pin is available or
> +	 * wired as modules using a laser as their light source will continue to
> +	 * be active when the fiber is removed. This could be a safety issue and
> +	 * we should at least warn the user about that.
> +	 */
> +	if (!sfp->gpio[GPIO_TX_DISABLE])
> +		dev_warn(sfp->dev,
> +			 "No tx_disable pin: SFP modules will always be emitting.\n");
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
