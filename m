From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 27 Jan 2015 16:50:47 +0100
Subject: [PATCH 2/9] mtd: pxa3xx_nand: add a non mandatory ECC clock
In-Reply-To: <1422367816-4257-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
 <1422367816-4257-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150127155047.GB16546@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 03:10:09PM +0100, Antoine Tenart wrote:
> Some controllers (as the coming Berlin nand controller) need to enable
> an ECC clock. Add support for this clock in the pxa3xx nand driver, and
> leave it as non mandatory.

Hi Antoine

It would be good to document this clock in the device tree binding.

> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index d00ac392d1c4..2681ec4abafa 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -180,7 +180,7 @@ struct pxa3xx_nand_info {
>  	struct nand_hw_control	controller;
>  	struct platform_device	 *pdev;
>  
> -	struct clk		*clk;
> +	struct clk		*clk, *ecc_clk;
>  	void __iomem		*mmio_base;
>  	unsigned long		mmio_phys;
>  	struct completion	cmd_complete, dev_ready;
> @@ -1608,7 +1608,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
>  
>  	spin_lock_init(&chip->controller->lock);
>  	init_waitqueue_head(&chip->controller->wq);
> -	info->clk = devm_clk_get(&pdev->dev, NULL);
> +	info->clk = devm_clk_get(&pdev->dev, "nfc");

Does this keep backwards compatibility? Not all the existing users
have there clocks named. What i think happens here is that
of_clk_get_by_name() calls of_property_match_string(np, "clock-names",
name); That returns -EINVAL, and then we ask of_clk_get() to get the
-EINVAL'th clock. I don't think that is going to end well.

I think you need to keep the NULL here, but should use "ecc" for the
second clock and require the use of the clock-names property when an
ecc clock is required.

    Andrew
