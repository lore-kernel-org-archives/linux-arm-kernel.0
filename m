From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 04 Jan 2013 10:37:37 -0500
Subject: [PATCH v3 2/7] vexpress: Match the "arm, sp810" DT entry for
 clock initialisation
In-Reply-To: <1357309041-6192-3-git-send-email-catalin.marinas@arm.com>
References: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
 <1357309041-6192-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <50E6F741.60804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 01/04/2013 09:17 AM, Catalin Marinas wrote:
> Currently the clk-vexpress.c implementation relies on the vexpress code
> to call the vexpress_clk_of_init() function which performs the SP810
> initialisation. This patch adds "arm,sp810" to the clock DT match array
> allowing of_clk_init() to call the vexpress_sp810_of_setup() function.
> In case of CONFIG_ARM64, make vexpress_clk_of_init() an arch_initcall().
> 
> Note that SP810 requires the fixed clocks to be already registered.
> Since the clock subsystem does not handle DT dependencies, the
> corresponding DT entries must be in the correct order.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> ---
>  drivers/clk/versatile/clk-vexpress.c | 28 +++++++++++++++++-----------
>  include/linux/vexpress.h             |  2 +-
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/versatile/clk-vexpress.c b/drivers/clk/versatile/clk-vexpress.c
> index 4f83ff9..a3754e7 100644
> --- a/drivers/clk/versatile/clk-vexpress.c
> +++ b/drivers/clk/versatile/clk-vexpress.c

[...]

> @@ -138,4 +128,20 @@ void __init vexpress_clk_of_init(void)
>  				"v2m-timer1", "sp804"));
>  }
>  
> +static const __initconst struct of_device_id vexpress_clk_match[] = {
> +	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
> +	{ .compatible = "arm,vexpress-osc", .data = vexpress_osc_of_setup, },
> +	{ .compatible = "arm,sp810", .data = vexpress_sp810_of_setup, },
> +	{}
> +};
> +
> +int __init vexpress_clk_of_init(void)
> +{
> +	of_clk_init(vexpress_clk_match);
> +	return 0;
> +}
> +#ifdef CONFIG_ARM64
> +arch_initcall(vexpress_clk_of_init);
> +#endif

Any way to avoid the ifdef? Is it intended to be a temporarily solution?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
