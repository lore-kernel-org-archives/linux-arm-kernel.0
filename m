From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 23 Jan 2014 19:24:01 +0100
Subject: [PATCH V2 04/10] clk/samsung: add support for multiple clock
 providers
In-Reply-To: <1389099548-14649-5-git-send-email-rahul.sharma@samsung.com>
References: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
 <1389099548-14649-5-git-send-email-rahul.sharma@samsung.com>
Message-ID: <52E15E41.7020600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

The patch looks mostly fine now, but I still have one inline comment.

On 07.01.2014 13:59, Rahul Sharma wrote:
> Samsung CCF helper functions do not provide support to
> register multiple Clock Providers for a given SoC. Due to
> this limitation SoC platforms are not able to use these
> helpers for registering multiple clock providers and are
> forced to bypass this layer.
>
> This layer is modified accordingly to enable the support.
>
> Clock file for exynos4, exynos5250, exynos5420, exynos5440
[snip]
>   /* setup the essentials required to support clock lookup using ccf */
> -void __init samsung_clk_init(struct device_node *np, void __iomem *base,
> -			     unsigned long nr_clks)
> +struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
> +			void __iomem *base, unsigned long nr_clks)
>   {
> -	reg_base = base;
> +	struct samsung_clk_provider *ctx;
> +	struct clk **clk_table;
> +	int ret;
> +
> +	ctx = kzalloc(sizeof(struct samsung_clk_provider), GFP_KERNEL);
> +	if (!ctx)
> +		panic("could not allocate clock provider context.\n");
>
>   	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
>   	if (!clk_table)
>   		panic("could not allocate clock lookup table\n");
>
> +	ctx->reg_base = base;
> +	ctx->clk_data.clks = clk_table;
> +	ctx->clk_data.clk_num = nr_clks;
> +	ctx->lock = __SPIN_LOCK_UNLOCKED(lock);

spin_lock_init(&ctx->lock);

Best regards,
Tomasz
