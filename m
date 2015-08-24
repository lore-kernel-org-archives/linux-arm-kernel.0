From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Aug 2015 09:46:05 +0200
Subject: [PATCH] net: sun4i-emac: Claim emac sram
In-Reply-To: <1440354698-11144-1-git-send-email-hdegoede@redhat.com>
References: <1440354698-11144-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150824074605.GF2413@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Sun, Aug 23, 2015 at 08:31:38PM +0200, Hans de Goede wrote:
> Claim the emac sram ourselves, rather then relying on the bootloader
> having mapped the sram to the emac controller during boot.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/net/ethernet/allwinner/sun4i-emac.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
> index bab01c84..48ce83e 100644
> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
> @@ -28,6 +28,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy.h>
> +#include <linux/soc/sunxi/sunxi_sram.h>
>  
>  #include "sun4i-emac.h"
>  
> @@ -857,11 +858,17 @@ static int emac_probe(struct platform_device *pdev)
>  
>  	clk_prepare_enable(db->clk);
>  
> +	ret = sunxi_sram_claim(&pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error couldn't map SRAM to device\n");
> +		goto out;

Shouldn't you disable you clock too?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150824/2ab019ef/attachment.sig>
