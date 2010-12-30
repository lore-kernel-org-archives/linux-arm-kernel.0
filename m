From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Dec 2010 10:54:01 +0100
Subject: [PATCH v2 1/2] ARM i.MX53: Some bug fix about MX53 MSL code
In-Reply-To: <1293686881-15046-2-git-send-email-yong.shen@freescale.com>
References: <1293686881-15046-1-git-send-email-yong.shen@freescale.com>
	<1293686881-15046-2-git-send-email-yong.shen@freescale.com>
Message-ID: <20101230095401.GW14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 30, 2010 at 01:28:00PM +0800, yong.shen at freescale.com wrote:
> From: Yong Shen <yong.shen@linaro.org>
> 
> 1. pll_base address should return right value
> 2. uart parent clk is from pll3
> 3. add cpu_is_mx53 definition
> 
> Signed-off-by: Yong Shen <yong.shen@linaro.org>
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c  |    7 ++++---
>  arch/arm/mach-mx5/crm_regs.h         |    4 ++++
>  arch/arm/plat-mxc/include/mach/mxc.h |   15 +++++++++++++--
>  3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 9fc65bb..6db69db 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -127,11 +127,11 @@ static inline u32 _get_mux(struct clk *parent, struct clk *m0,
>  static inline void __iomem *_get_pll_base(struct clk *pll)
>  {
>  	if (pll == &pll1_main_clk)
> -		return MX51_DPLL1_BASE;
> +		return cpu_is_mx51() ? MX51_DPLL1_BASE : MX53_DPLL1_BASE;
>  	else if (pll == &pll2_sw_clk)
> -		return MX51_DPLL2_BASE;
> +		return cpu_is_mx51() ? MX51_DPLL2_BASE : MX53_DPLL2_BASE;
>  	else if (pll == &pll3_sw_clk)
> -		return MX51_DPLL3_BASE;
> +		return cpu_is_mx51() ? MX51_DPLL3_BASE : MX53_DPLL3_BASE;
>  	else if (pll == &mx53_pll4_sw_clk)
>  		return MX53_DPLL4_BASE;
>  	else
hmmm, not nice.  I assume Sascha won't take that.

> @@ -1202,6 +1202,7 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
>  
>  	clk_tree_init();
>  
> +	clk_set_parent(&uart_root_clk, &pll3_sw_clk);
>  	clk_enable(&cpu_clk);
>  	clk_enable(&main_bus_clk);
>  
> diff --git a/arch/arm/mach-mx5/crm_regs.h b/arch/arm/mach-mx5/crm_regs.h
> index 51ff9bb..b462c22 100644
> --- a/arch/arm/mach-mx5/crm_regs.h
> +++ b/arch/arm/mach-mx5/crm_regs.h
> @@ -19,6 +19,10 @@
>  #define MX51_GPC_BASE		MX51_IO_ADDRESS(MX51_GPC_BASE_ADDR)
>  
>  /*MX53*/
> +#define MX53_CCM_BASE		MX53_IO_ADDRESS(MX53_CCM_BASE_ADDR)
> +#define MX53_DPLL1_BASE		MX53_IO_ADDRESS(MX53_PLL1_BASE_ADDR)
> +#define MX53_DPLL2_BASE		MX53_IO_ADDRESS(MX53_PLL2_BASE_ADDR)
> +#define MX53_DPLL3_BASE		MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
>  #define MX53_DPLL4_BASE		MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
>  
>  /* PLL Register Offsets */
> diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
> index 4abbdd1..eca8f83 100644
> --- a/arch/arm/plat-mxc/include/mach/mxc.h
> +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> @@ -126,7 +126,7 @@ extern unsigned int __mxc_cpu_type;
>  # define cpu_is_mx35()		(0)
>  #endif
>  
> -#ifdef CONFIG_ARCH_MX5
> +#ifdef CONFIG_ARCH_MX51
>  # ifdef mxc_cpu_type
>  #  undef mxc_cpu_type
>  #  define mxc_cpu_type __mxc_cpu_type
> @@ -134,11 +134,22 @@ extern unsigned int __mxc_cpu_type;
>  #  define mxc_cpu_type MXC_CPU_MX51
>  # endif
>  # define cpu_is_mx51()		(mxc_cpu_type == MXC_CPU_MX51)
> -# define cpu_is_mx53()		(mxc_cpu_type == MXC_CPU_MX53)
>  #else
>  # define cpu_is_mx51()		(0)
>  #endif
>  
> +#ifdef CONFIG_ARCH_MX53
> +# ifdef mxc_cpu_type
> +#  undef mxc_cpu_type
> +#  define mxc_cpu_type __mxc_cpu_type
> +# else
> +#  define mxc_cpu_type MXC_CPU_MX53
> +# endif
> +# define cpu_is_mx53()		(mxc_cpu_type == MXC_CPU_MX53)
> +#else
> +# define cpu_is_mx53()		(0)
> +#endif
> +
>  #ifdef CONFIG_ARCH_MXC91231
>  # ifdef mxc_cpu_type
>  #  undef mxc_cpu_type
This hunk is also included in one of Richard's patches for mx50.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
