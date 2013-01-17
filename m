From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 14:12:02 +0800
Subject: [PATCH 6/7] ARM i.MX5: Add System Reset Controller (SRC) support
 for i.MX51 and i.MX53
In-Reply-To: <1358352787-15441-7-git-send-email-p.zabel@pengutronix.de>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
 <1358352787-15441-7-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130117061200.GK26179@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 05:13:06PM +0100, Philipp Zabel wrote:
> The SRC in i.MX51 and i.MX53 is similar to the one in i.MX6q minus
> the IPU2 reset line and multi core CPU reset/enable bits.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  arch/arm/mach-imx/Kconfig      |    1 +
>  arch/arm/mach-imx/common.h     |    3 ++-
>  arch/arm/mach-imx/mach-imx6q.c |    2 +-
>  arch/arm/mach-imx/mm-imx5.c    |    2 ++
>  arch/arm/mach-imx/src.c        |   14 +++++++++++++-
>  5 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 3e628fd..d7924e5 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -829,6 +829,7 @@ config	SOC_IMX53
>  	select ARCH_MX53
>  	select HAVE_CAN_FLEXCAN if CAN
>  	select IMX_HAVE_PLATFORM_IMX2_WDT
> +	select HAVE_IMX_SRC

Please sort it in name.  Should we manage to have it selected for imx51
too, since you have code added for imx51 below?

>  	select PINCTRL
>  	select PINCTRL_IMX53
>  	select SOC_IMX5
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 7191ab4..f36be3c 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -133,7 +133,8 @@ static inline void imx_smp_prepare(void) {}
>  #endif
>  extern void imx_enable_cpu(int cpu, bool enable);
>  extern void imx_set_cpu_jump(int cpu, void *jump_addr);
> -extern void imx_src_init(void);
> +extern void imx5_src_init(void);
> +extern void imx6q_src_init(void);
>  extern void imx_src_prepare_restart(void);
>  extern void imx_gpc_init(void);
>  extern void imx_gpc_pre_suspend(void);
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index cd277a0..b1e076c 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -229,7 +229,7 @@ static const struct of_device_id imx6q_irq_match[] __initconst = {
>  static void __init imx6q_init_irq(void)
>  {
>  	l2x0_of_init(0, ~0UL);
> -	imx_src_init();
> +	imx6q_src_init();

I'm not sure this is necessary.  See below ...

>  	imx_gpc_init();
>  	of_irq_init(imx6q_irq_match);
>  }
> diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
> index 79d71cf..53f87be 100644
> --- a/arch/arm/mach-imx/mm-imx5.c
> +++ b/arch/arm/mach-imx/mm-imx5.c
> @@ -106,6 +106,7 @@ void __init imx51_init_early(void)
>  	mxc_set_cpu_type(MXC_CPU_MX51);
>  	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
>  	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG1_BASE_ADDR));
> +	imx5_src_init();
>  }
>  
>  void __init imx53_init_early(void)
> @@ -113,6 +114,7 @@ void __init imx53_init_early(void)
>  	mxc_set_cpu_type(MXC_CPU_MX53);
>  	mxc_iomux_v3_init(MX53_IO_ADDRESS(MX53_IOMUXC_BASE_ADDR));
>  	mxc_arch_reset_init(MX53_IO_ADDRESS(MX53_WDOG1_BASE_ADDR));
> +	imx5_src_init();
>  }
>  
>  void __init mx50_init_irq(void)
> diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
> index 41687c6..e350250 100644
> --- a/arch/arm/mach-imx/src.c
> +++ b/arch/arm/mach-imx/src.c
> @@ -125,7 +125,19 @@ void imx_src_prepare_restart(void)
>  	writel_relaxed(0, src_base + SRC_GPR1);
>  }
>  
> -void __init imx_src_init(void)
> +void __init imx5_src_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx5-src");

In fsl,imx-src.txt, we have 

  compatible: Should be "fsl,<chip>-src"

But imx5 is not a chip name.  I would suggest we have the imx-src driver
only look for compatible "fsl,imx51-src", and for dts

  imx51: compatible = "fsl,imx51-src";
  imx53: compatible = "fsl,imx53-src", "fsl,imx51-src";
  imx6q: compatible = "fsl,imx6q-src", "fsl,imx51-src";

so that we do not need imx5_src_init and imx6q_src_init which are
basically doing the same thing.

> +	src_base = of_iomap(np, 0);
> +	WARN_ON(!src_base);

As imx51 still supports non-DT boot, we should have a check on np.
If np is NULL, mostly likely it's a non-DT boot on imx51, and we
should bail out instead of giving a fat warning.

Shawn

> +
> +	imx_reset_controller.of_node = np;
> +	reset_controller_register(&imx_reset_controller);
> +}
> +
> +void __init imx6q_src_init(void)
>  {
>  	struct device_node *np;
>  	u32 val;
> -- 
> 1.7.10.4
> 
