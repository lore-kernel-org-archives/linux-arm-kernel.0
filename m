From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 08 Jan 2013 17:29:07 +0000
Subject: [PATCH v3 2/7] vexpress: Match the "arm, sp810" DT entry for
 clock initialisation
In-Reply-To: <1357309041-6192-3-git-send-email-catalin.marinas@arm.com>
References: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
 <1357309041-6192-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <1357666147.24697.27.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-04 at 14:17 +0000, Catalin Marinas wrote:
> Currently the clk-vexpress.c implementation relies on the vexpress code
> to call the vexpress_clk_of_init() function which performs the SP810
> initialisation. This patch adds "arm,sp810" to the clock DT match array
> allowing of_clk_init() to call the vexpress_sp810_of_setup() function.
> In case of CONFIG_ARM64, make vexpress_clk_of_init() an arch_initcall().
> 
> Note that SP810 requires the fixed clocks to be already registered.
> Since the clock subsystem does not handle DT dependencies, the
> corresponding DT entries must be in the correct order.

Which they aren't on 32-bit vexpress ;-) leading to:

  ERROR: could not get clock /smb/motherboard/iofpga at 3,00000000/sysctl at 020000:refclk(0)
  ERROR: could not get clock /smb/motherboard/iofpga at 3,00000000/sysctl at 020000:timclk(1)
  ------------[ cut here ]------------
  WARNING: at drivers/clk/versatile/clk-vexpress.c:112 vexpress_sp810_of_setup+0x43/0xc8()
  Modules linked in:
  [<c0011cbd>] (unwind_backtrace+0x1/0x9c) from [<c001c1a9>] (warn_slowpath_common+0x39/0x50)
  [<c001c1a9>] (warn_slowpath_common+0x39/0x50) from [<c001c1d7>] (warn_slowpath_null+0x17/0x1c)
  [<c001c1d7>] (warn_slowpath_null+0x17/0x1c) from [<c05b4fab>] (vexpress_sp810_of_setup+0x43/0xc8)
  [<c05b4fab>] (vexpress_sp810_of_setup+0x43/0xc8) from [<c05b4e67>] (of_clk_init+0x1f/0x34)
  [<c05b4e67>] (of_clk_init+0x1f/0x34) from [<c05b515d>] (vexpress_clk_of_init+0x9/0x10)
  [<c05b515d>] (vexpress_clk_of_init+0x9/0x10) from [<c05a7d2b>] (v2m_dt_timer_init+0x7/0x78)
  [<c05a7d2b>] (v2m_dt_timer_init+0x7/0x78) from [<c05a4d09>] (time_init+0x11/0x20)
  [<c05a4d09>] (time_init+0x11/0x20) from [<c05a24fb>] (start_kernel+0x113/0x214)
  [<c05a24fb>] (start_kernel+0x113/0x214) from [<8000807f>] (0x8000807f)
  ---[ end trace 1b75b31a2719ed1c ]---

After moving all "fixed-clock" nodes to be the first devices in
arch/arm/boot/dts/vexpress-v2m{-rs1,}.dtsi then all appears well. (I am
only trying out patches 1-3 of this set at the moment).

-- 
Tixy

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
> @@ -98,21 +98,11 @@ struct clk *vexpress_sp810_of_get(struct of_phandle_args *clkspec, void *data)
>  	return vexpress_sp810_timerclken[clkspec->args[0]];
>  }
>  
> -static const __initconst struct of_device_id vexpress_fixed_clk_match[] = {
> -	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
> -	{ .compatible = "arm,vexpress-osc", .data = vexpress_osc_of_setup, },
> -	{}
> -};
> -
> -void __init vexpress_clk_of_init(void)
> +static void __init vexpress_sp810_of_setup(struct device_node *node)
>  {
> -	struct device_node *node;
>  	struct clk *clk;
>  	struct clk *refclk, *timclk;
>  
> -	of_clk_init(vexpress_fixed_clk_match);
> -
> -	node = of_find_compatible_node(NULL, NULL, "arm,sp810");
>  	vexpress_sp810_init(of_iomap(node, 0));
>  	of_clk_add_provider(node, vexpress_sp810_of_get, NULL);
>  
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
> +
>  #endif
> diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
> index c52215f..b55ae6a 100644
> --- a/include/linux/vexpress.h
> +++ b/include/linux/vexpress.h
> @@ -116,6 +116,6 @@ struct clk *vexpress_osc_setup(struct device *dev);
>  void vexpress_osc_of_setup(struct device_node *node);
>  
>  void vexpress_clk_init(void __iomem *sp810_base);
> -void vexpress_clk_of_init(void);
> +int vexpress_clk_of_init(void);
>  
>  #endif
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
