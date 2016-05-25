From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 25 May 2016 10:19:40 +0200
Subject: [PATCH 1/3] clk: samsung: exynos5433: prepare for adding CPU
 clocks
In-Reply-To: <1464095957-25851-2-git-send-email-b.zolnierkie@samsung.com>
References: <1464095957-25851-1-git-send-email-b.zolnierkie@samsung.com>
 <1464095957-25851-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <5745601C.6000806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2016 03:19 PM, Bartlomiej Zolnierkiewicz wrote:
> Open-code samsung_cmu_register_one() calls for CMU_APOLLO and
> CMU_ATLAS setup code as a preparation for adding CPU clocks
> support for Exynos5433.
> 
> There should be no functional change resulting from this patch.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 85 +++++++++++++++++++++++-------------
>  drivers/clk/samsung/clk.c            | 12 ++---
>  drivers/clk/samsung/clk.h            |  4 ++
>  3 files changed, 65 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index 128527b..6dd81ed 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  
>  #include <dt-bindings/clock/exynos5433.h>
>  
> @@ -3594,23 +3595,35 @@ static struct samsung_gate_clock apollo_gate_clks[] __initdata = {
>  			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
>  };
>  
> -static struct samsung_cmu_info apollo_cmu_info __initdata = {
> -	.pll_clks		= apollo_pll_clks,
> -	.nr_pll_clks		= ARRAY_SIZE(apollo_pll_clks),
> -	.mux_clks		= apollo_mux_clks,
> -	.nr_mux_clks		= ARRAY_SIZE(apollo_mux_clks),
> -	.div_clks		= apollo_div_clks,
> -	.nr_div_clks		= ARRAY_SIZE(apollo_div_clks),
> -	.gate_clks		= apollo_gate_clks,
> -	.nr_gate_clks		= ARRAY_SIZE(apollo_gate_clks),
> -	.nr_clk_ids		= APOLLO_NR_CLK,
> -	.clk_regs		= apollo_clk_regs,
> -	.nr_clk_regs		= ARRAY_SIZE(apollo_clk_regs),
> -};
> -
>  static void __init exynos5433_cmu_apollo_init(struct device_node *np)
>  {
> -	samsung_cmu_register_one(np, &apollo_cmu_info);
> +	void __iomem *reg_base;
> +	struct samsung_clk_provider *ctx;
> +
> +	reg_base = of_iomap(np, 0);
> +	if (!reg_base) {
> +		panic("%s: failed to map registers\n", __func__);
> +		return;
> +	}
> +
> +	ctx = samsung_clk_init(np, reg_base, APOLLO_NR_CLK);
> +	if (!ctx) {
> +		panic("%s: unable to allocate ctx\n", __func__);
> +		return;
> +	}
> +
> +	samsung_clk_register_pll(ctx, apollo_pll_clks,
> +				 ARRAY_SIZE(apollo_pll_clks), reg_base);
> +	samsung_clk_register_mux(ctx, apollo_mux_clks,
> +				 ARRAY_SIZE(apollo_mux_clks));
> +	samsung_clk_register_div(ctx, apollo_div_clks,
> +				 ARRAY_SIZE(apollo_div_clks));
> +	samsung_clk_register_gate(ctx, apollo_gate_clks,
> +				  ARRAY_SIZE(apollo_gate_clks));
> +	samsung_clk_sleep_init(reg_base, apollo_clk_regs,
> +			       ARRAY_SIZE(apollo_clk_regs));
> +
> +	samsung_clk_of_add_provider(np, ctx);
>  }
>  CLK_OF_DECLARE(exynos5433_cmu_apollo, "samsung,exynos5433-cmu-apollo",
>  		exynos5433_cmu_apollo_init);
> @@ -3806,23 +3819,35 @@ static struct samsung_gate_clock atlas_gate_clks[] __initdata = {
>  			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
>  };
>  
> -static struct samsung_cmu_info atlas_cmu_info __initdata = {
> -	.pll_clks		= atlas_pll_clks,
> -	.nr_pll_clks		= ARRAY_SIZE(atlas_pll_clks),
> -	.mux_clks		= atlas_mux_clks,
> -	.nr_mux_clks		= ARRAY_SIZE(atlas_mux_clks),
> -	.div_clks		= atlas_div_clks,
> -	.nr_div_clks		= ARRAY_SIZE(atlas_div_clks),
> -	.gate_clks		= atlas_gate_clks,
> -	.nr_gate_clks		= ARRAY_SIZE(atlas_gate_clks),
> -	.nr_clk_ids		= ATLAS_NR_CLK,
> -	.clk_regs		= atlas_clk_regs,
> -	.nr_clk_regs		= ARRAY_SIZE(atlas_clk_regs),
> -};
> -
>  static void __init exynos5433_cmu_atlas_init(struct device_node *np)
>  {
> -	samsung_cmu_register_one(np, &atlas_cmu_info);
> +	void __iomem *reg_base;
> +	struct samsung_clk_provider *ctx;
> +
> +	reg_base = of_iomap(np, 0);
> +	if (!reg_base) {
> +		panic("%s: failed to map registers\n", __func__);
> +		return;

Return is useless here.

> +	}
> +
> +	ctx = samsung_clk_init(np, reg_base, ATLAS_NR_CLK);
> +	if (!ctx) {
> +		panic("%s: unable to allocate ctx\n", __func__);
> +		return;
> +	}

This entire if() is useless. The samsung_clk_init() already panics. I
recently tried to make it consistent across our drivers:
http://www.spinics.net/lists/arm-kernel/msg503014.html

Beside that, looks fine.

Best regards,
Krzysztof
