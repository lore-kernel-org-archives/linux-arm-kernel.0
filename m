From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 25 Apr 2014 17:47:46 +0200
Subject: [PATCH v2 02/18] usb: host: xhci-plat: Add clocks support
In-Reply-To: <1398434836-18908-3-git-send-email-gregory.clement@free-electrons.com>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
 <1398434836-18908-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140425154746.GB12472@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Hi Gregory

You probably don't need to do this conditional on CONFIG_HAVE_CLK.
There are stub functions in clk.h for when CONFIG_HAVE_CLK is not
defined. So the compiler knows devm_clk_get() will return NULL, it can
evaluate IS_ERR is false, clk_prepare() returns 0 and so the whole
function collapses to "return 0;"

> +static int try_enable_clk(struct platform_device *pdev)
> +{
> +	struct clk *clk = devm_clk_get(&pdev->dev, NULL);
> +
> +	/* Not all platforms have a clk so it is not an error if the clock
> +	   does not exists. */
> +	if (!IS_ERR(clk))
> +		if (clk_prepare_enable(clk))
> +			return  -ENODEV;

Is ENODEV the correct error code? It would probably be better to
return the return value of clk_prepare_enable()

> +	return 0;
> +}
