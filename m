From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Sat, 21 Apr 2018 16:10:46 -0700
Subject: [PATCH] Enable the clock before calling clk_get_rate().
In-Reply-To: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
Message-ID: <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Jonas,

On 04/19/2018 06:03 AM, Stefan Potyra wrote:
> Found by Linux Driver Verification project (linuxtesting.org).

Please use a commit subject which matches what was used before:

git log --no-merges --oneline drivers/spi/spi-bcm63xx-hsspi.c
378da4a65f3a spi/bcm63xx-hspi: fix error return code in
bcm63xx_hsspi_probe()
c3c25ea712c9 spi/bcm63xx-hspi: Fix checkpatch warnings
0b85a8421790 spi: bcm63xx-hsspi: Export OF device ID table as module aliases
7ab2463550e2 spi/bcm63xx-hsspi: allow for probing through devicetree
ff18e1ef04e2 spi/bcm63xx-hsspi: allow providing clock rate through a
second clock
f4d862237715 spi/bcm63xx-hsspi: add support for dual spi read/write
14ac00e033c5 spi: drop owner assignment from platform_drivers
e4745fef5595 spi: Remove unneeded include of linux/workqueue.h
1480916ebd6f spi: bcm63xx-hsspi: Use SIMPLE_DEV_PM_OPS macro
aa0fe82629f1 spi: Use reinit_completion at appropriate places
937ebf9cd34a spi/bcm63xx-hsspi: fix pm sleep support
7d255695804f spi/bcm63xx-hsspi: use devm_register_master()
dea5de1b37c0 spi/bcm63xx-hsspi: check result of clk_prepare_enable
b1bdd4f883e1 spi: bcm63xx-hsspi: Use devm_clk_get()
87917528cc92 spi: bcm63xx-hsspi: checking for ERR_PTR instead of NULL
142168eba9dc spi: bcm63xx-hsspi: add bcm63xx HSSPI driver

> 
> Fixes: 142168eba9dc spi: bcm63xx-hsspi: add bcm63xx HSSPI driver

Please include the commit title in ("<title>") as is indicated in the
SubmittingPatches document.

Thank you

> Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
> ---
>  drivers/spi/spi-bcm63xx-hsspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
> index cbcba614b253..46cd9b683d22 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -352,6 +352,10 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return ret;
> +
>  	rate = clk_get_rate(clk);
>  	if (!rate) {
>  		struct clk *pll_clk = devm_clk_get(dev, "pll");
> @@ -364,10 +368,6 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>  			return -EINVAL;
>  	}
>  
> -	ret = clk_prepare_enable(clk);
> -	if (ret)
> -		return ret;
> -
>  	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
>  	if (!master) {
>  		ret = -ENOMEM;
> 

-- 
Florian
