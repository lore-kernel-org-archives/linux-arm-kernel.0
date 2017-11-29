From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 29 Nov 2017 22:06:12 +0800
Subject: [PATCH] ARM: imx: don't abort MMDC probe if power saving status
 doesn't match
In-Reply-To: <20171127121139.15584-1-l.stach@pengutronix.de>
References: <20171127121139.15584-1-l.stach@pengutronix.de>
Message-ID: <20171129140610.GM9376@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 01:11:39PM +0100, Lucas Stach wrote:
> The power saving status bit will not signal if the MMDC is under load,
> which is likely during kernel boot.

What is exactly the condition of MMDC is under load?  If it's likely
hit during kernel boot, why have we not heard any report regarding to
it before?

Shawn

> There is no point in checking this
> bit and aborting the probe, as there is nothing depending on power
> saving being enabled, so we can trust the memory controller to enable
> power saving when we allow it.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/mach-imx/mmdc.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
> index 78262899a590..5fb1d2254b5e 100644
> --- a/arch/arm/mach-imx/mmdc.c
> +++ b/arch/arm/mach-imx/mmdc.c
> @@ -547,7 +547,6 @@ static int imx_mmdc_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	void __iomem *mmdc_base, *reg;
>  	u32 val;
> -	int timeout = 0x400;
>  
>  	mmdc_base = of_iomap(np, 0);
>  	WARN_ON(!mmdc_base);
> @@ -565,16 +564,6 @@ static int imx_mmdc_probe(struct platform_device *pdev)
>  	val &= ~(1 << BP_MMDC_MAPSR_PSD);
>  	writel_relaxed(val, reg);
>  
> -	/* Ensure it's successfully enabled */
> -	while (!(readl_relaxed(reg) & 1 << BP_MMDC_MAPSR_PSS) && --timeout)
> -		cpu_relax();
> -
> -	if (unlikely(!timeout)) {
> -		pr_warn("%s: failed to enable automatic power saving\n",
> -			__func__);
> -		return -EBUSY;
> -	}
> -
>  	return imx_mmdc_perf_init(pdev, mmdc_base);
>  }
>  
> -- 
> 2.11.0
> 
