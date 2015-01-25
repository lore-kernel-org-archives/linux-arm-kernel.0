From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 Jan 2015 17:25:11 +0100
Subject: [PATCH 3/3] net: allwinner: sun4i-emac: fix emac SRAM mapping
In-Reply-To: <1422200959-1717-4-git-send-email-jenskuske@gmail.com>
References: <1422200959-1717-1-git-send-email-jenskuske@gmail.com>
 <1422200959-1717-4-git-send-email-jenskuske@gmail.com>
Message-ID: <20150125162510.GK8470@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

On Sun, Jan 25, 2015 at 04:49:19PM +0100, Jens Kuske wrote:
> The EMAC needs SRAM block A3_A4 being mapped to EMAC peripheral to
> work. This is done by the bootloader most of the time, but U-Boot
> Falcon Mode, for example, skips emac initialization and SRAM would
> stay mapped to the CPU.

Thanks for reviving this.

> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> ---
>  drivers/net/ethernet/allwinner/Kconfig      |  1 +
>  drivers/net/ethernet/allwinner/sun4i-emac.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/net/ethernet/allwinner/Kconfig b/drivers/net/ethernet/allwinner/Kconfig
> index d8d95d4..508a288 100644
> --- a/drivers/net/ethernet/allwinner/Kconfig
> +++ b/drivers/net/ethernet/allwinner/Kconfig
> @@ -28,6 +28,7 @@ config SUN4I_EMAC
>  	select MII
>  	select PHYLIB
>  	select MDIO_SUN4I
> +	select MFD_SYSCON
>          ---help---
>            Support for Allwinner A10 EMAC ethernet driver.
>  
> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
> index 1fcd556..86c891d 100644
> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
> @@ -18,6 +18,8 @@
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/sun4i-sc.h>
>  #include <linux/mii.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> @@ -28,6 +30,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy.h>
> +#include <linux/regmap.h>
>  
>  #include "sun4i-emac.h"
>  
> @@ -78,6 +81,7 @@ struct emac_board_info {
>  
>  	struct phy_device	*phy_dev;
>  	struct device_node	*phy_node;
> +	struct regmap		*sc;
>  	unsigned int		link;
>  	unsigned int		speed;
>  	unsigned int		duplex;
> @@ -862,6 +866,18 @@ static int emac_probe(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> +	/* Map SRAM_A3_A4 to EMAC */
> +	db->sc = syscon_regmap_lookup_by_compatible(
> +						"allwinner,sun4i-a10-syscon");
> +	if (IS_ERR(db->sc)) {
> +		dev_err(&pdev->dev, "failed to find syscon regmap\n");
> +		ret = PTR_ERR(db->sc);
> +		goto out;
> +	}
> +
> +	regmap_update_bits(db->sc, SUN4I_SC1, SUN4I_SC1_SRAM_A3_A4_MAP_MASK,
> +						SUN4I_SC1_SRAM_A3_A4_MAP_EMAC);
> +

I don't think that using a syscon is the right solution here.

All this SRAM mapping thing is mutually exclusive, and will possibly
impact other drivers as well.

I think this is a more a case for a small driver in drivers/soc that
would take care of this, and make sure that client drivers don't step
on each other's toe.

Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/c2a153bc/attachment.sig>
