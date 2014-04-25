From: balbi@ti.com (Felipe Balbi)
Date: Fri, 25 Apr 2014 10:02:19 -0500
Subject: [PATCH v2 02/18] usb: host: xhci-plat: Add clocks support
In-Reply-To: <1398434836-18908-3-git-send-email-gregory.clement@free-electrons.com>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
 <1398434836-18908-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140425150218.GC29632@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 25, 2014 at 04:07:00PM +0200, Gregory CLEMENT wrote:
> Some platform (such as the Armada 38x ones) can gate the clock of
> their USB controller. This patch add the support for the clock, by
> enabling them during probe and disabling them on remove.
> 
> As not all platforms have clock support then enabling and disabling
> the clocks have been placed in separate functions. Then if the clocks
> are not supported we still can use the same calls, and there is no
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/usb/host/xhci-plat.c | 52 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index f5351af4b2c5..bb5d563f729c 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -11,6 +11,7 @@
>   * version 2 as published by the Free Software Foundation.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -85,6 +86,42 @@ static const struct hc_driver xhci_plat_xhci_driver = {
>  	.bus_resume =		xhci_bus_resume,
>  };
>  
> +#if defined(CONFIG_HAVE_CLK)

I don't think this ifdef is necessary, clk api provides stubs.

> +static int try_enable_clk(struct platform_device *pdev)

prepend this with xhci_plat_ as all other definitions here.

> +{
> +	struct clk *clk = devm_clk_get(&pdev->dev, NULL);

you need to create a private xhci_plat structure and save a clock
pointer there.

> +
> +	/* Not all platforms have a clk so it is not an error if the clock
> +	   does not exists. */

comment style is wrong.

> +	if (!IS_ERR(clk))

even though some don't like it, the clk API is safe against NULL
pointers, one trick you could use is to set the clk pointer to NULL when
you fail to get it, then you'll have a single place where you check for
IS_ERR().

> +		if (clk_prepare_enable(clk))
> +			return  -ENODEV;
> +	return 0;

these three lines could be rewritten as:

	return clk_prepare_enable(clk);

> +}
> +
> +static int try_disable_clk(struct platform_device *pdev)
> +{
> +	struct clk *clk = devm_clk_get(&pdev->dev, NULL);
> +
> +	/* Not all platforms have a clk so it is not an error if the clock
> +	   does not exists. */
> +	if (!IS_ERR(clk))
> +		clk_disable_unprepare(clk);

similar comments to previous function.

>  static int xhci_plat_probe(struct platform_device *pdev)
>  {
>  	const struct hc_driver	*driver;
> @@ -107,6 +144,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	if (!res)
>  		return -ENODEV;
>  
> +	ret = try_enable_clk(pdev);
> +	if (ret)
> +		return ret;
> +
>  	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
>  	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>  	if (ret)
> @@ -117,8 +158,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  		dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
>  
>  	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
> -	if (!hcd)
> -		return -ENOMEM;
> +	if (!hcd) {
> +		ret = -ENOMEM;
> +		goto disable_clk;
> +	}
>  
>  	hcd->rsrc_start = res->start;
>  	hcd->rsrc_len = resource_size(res);
> @@ -182,6 +225,9 @@ release_mem_region:
>  put_hcd:
>  	usb_put_hcd(hcd);
>  
> +disable_clk:
> +	try_disable_clk(pdev);
> +
>  	return ret;
>  }
>  
> @@ -199,6 +245,8 @@ static int xhci_plat_remove(struct platform_device *dev)
>  	usb_put_hcd(hcd);
>  	kfree(xhci);
>  
> +	try_disable_clk(dev);

you never call clk_put(). what gives ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/23ffa785/attachment.sig>
