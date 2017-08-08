From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 8 Aug 2017 20:25:59 +0200
Subject: [PATCH] mfd: exynos-lpass: Handle return value of
 clk_prepare_enable
In-Reply-To: <0e52a230fce95714a12b72aeb1ee9be0490de2a6.1502192959.git.arvind.yadav.cs@gmail.com>
References: <0e52a230fce95714a12b72aeb1ee9be0490de2a6.1502192959.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170808182559.b5muiyk5vmurtznc@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 05:20:55PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> we must call pm_runtime_disable() and pm_runtime_set_suspended(),
> If exynos_lpass_probe is not successful.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

This is not a trivial change so please mark all such patches as RFT.
Submit checklist mentions testing in multiple steps and last time your
ASoC changes were not tested.

> ---
>  drivers/mfd/exynos-lpass.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
> index ca829f8..c74ff62 100644
> --- a/drivers/mfd/exynos-lpass.c
> +++ b/drivers/mfd/exynos-lpass.c
> @@ -73,9 +73,13 @@ static void exynos_lpass_core_sw_reset(struct exynos_lpass *lpass, int mask)
>  	regmap_write(lpass->top, SFR_LPASS_CORE_SW_RESET, val);
>  }
>  
> -static void exynos_lpass_enable(struct exynos_lpass *lpass)
> +static int exynos_lpass_enable(struct exynos_lpass *lpass)
>  {
> -	clk_prepare_enable(lpass->sfr0_clk);
> +	int ret;
> +
> +	ret = clk_prepare_enable(lpass->sfr0_clk);
> +	if (ret)
> +		return ret;
>  
>  	/* Unmask SFR, DMA and I2S interrupt */
>  	regmap_write(lpass->top, SFR_LPASS_INTR_CA5_MASK,
> @@ -87,6 +91,8 @@ static void exynos_lpass_enable(struct exynos_lpass *lpass)
>  	exynos_lpass_core_sw_reset(lpass, LPASS_I2S_SW_RESET);
>  	exynos_lpass_core_sw_reset(lpass, LPASS_DMA_SW_RESET);
>  	exynos_lpass_core_sw_reset(lpass, LPASS_MEM_SW_RESET);
> +
> +	return 0;
>  }
>  
>  static void exynos_lpass_disable(struct exynos_lpass *lpass)
> @@ -112,6 +118,7 @@ static int exynos_lpass_probe(struct platform_device *pdev)
>  	struct exynos_lpass *lpass;
>  	void __iomem *base_top;
>  	struct resource *res;
> +	int ret;
>  
>  	lpass = devm_kzalloc(dev, sizeof(*lpass), GFP_KERNEL);
>  	if (!lpass)
> @@ -136,8 +143,12 @@ static int exynos_lpass_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, lpass);
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> -	exynos_lpass_enable(lpass);
> -
> +	ret = exynos_lpass_enable(lpass);
> +	if (ret) {
> +		pm_runtime_disable(dev);
> +		pm_runtime_set_suspended(dev);

You need also regmap_exit().

> +		return ret;
> +	}

Leave one blank line before return.

Best regards,
Krzysztof
