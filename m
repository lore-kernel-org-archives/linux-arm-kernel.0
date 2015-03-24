From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Mar 2015 08:22:17 -0700
Subject: [PATCH 5/5] net: allwinner: emac: Claim our SRAM
In-Reply-To: <1426877569-11493-6-git-send-email-hdegoede@redhat.com>
References: <1426877569-11493-1-git-send-email-hdegoede@redhat.com>
 <1426877569-11493-6-git-send-email-hdegoede@redhat.com>
Message-ID: <20150324152217.GC4951@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 07:52:49PM +0100, Hans de Goede wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> The SRAM the EMAC is using might not have been mapped accordingly by the
> bootloader, preventing the EMAC to work properly.
> 
> Ask for that SRAM to be mapped at probe time to make sure that this never
> happens.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> [hdegoede at redhat.com: Make sure SUNXI_SRAM gets enabled in Kconfig]
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/net/ethernet/allwinner/sun4i-emac.c | 13 +++++++++++--
>  drivers/net/ethernet/stmicro/stmmac/Kconfig |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
> index f3470d9..9d0136b 100644
> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
> @@ -29,6 +29,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/phy.h>
>  
> +#include <linux/soc/sunxi/sunxi_sram.h>
> +
>  #include "sun4i-emac.h"
>  
>  #define DRV_NAME		"sun4i-emac"
> @@ -857,11 +859,15 @@ static int emac_probe(struct platform_device *pdev)
>  
>  	clk_prepare_enable(db->clk);
>  
> +	ret = sunxi_sram_claim(SUNXI_SRAM_EMAC, "emac");
> +	if (ret)
> +		dev_warn(&pdev->dev, "Couldn't map SRAM to device\n");
> +
>  	db->phy_node = of_parse_phandle(np, "phy", 0);
>  	if (!db->phy_node) {
>  		dev_err(&pdev->dev, "no associated PHY\n");
>  		ret = -ENODEV;
> -		goto out;
> +		goto out_release_sram;
>  	}
>  
>  	/* Read MAC-address from DT */
> @@ -893,7 +899,7 @@ static int emac_probe(struct platform_device *pdev)
>  	if (ret) {
>  		dev_err(&pdev->dev, "Registering netdev failed!\n");
>  		ret = -ENODEV;
> -		goto out;
> +		goto out_release_sram;
>  	}
>  
>  	dev_info(&pdev->dev, "%s: at %p, IRQ %d MAC: %pM\n",
> @@ -901,6 +907,8 @@ static int emac_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +out_release_sram:
> +	sunxi_sram_release(SUNXI_SRAM_EMAC);
>  out:
>  	dev_err(db->dev, "not found (%d).\n", ret);
>  
> @@ -914,6 +922,7 @@ static int emac_remove(struct platform_device *pdev)
>  	struct net_device *ndev = platform_get_drvdata(pdev);
>  
>  	unregister_netdev(ndev);
> +	sunxi_sram_release(SUNXI_SRAM_EMAC);
>  	free_netdev(ndev);
>  
>  	dev_dbg(&pdev->dev, "released and freed device\n");
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 7d3af19..785ca22 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -16,6 +16,7 @@ if STMMAC_ETH
>  config STMMAC_PLATFORM
>  	tristate "STMMAC Platform bus support"
>  	depends on STMMAC_ETH
> +	select SUNXI_SRAM if ARCH_SUNXI
>  	default y
>  	---help---
>  	  This selects the platform specific bus support for the stmmac driver.

Shouldn't that be in emac's Kconfig option instead?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/690d9728/attachment.sig>
