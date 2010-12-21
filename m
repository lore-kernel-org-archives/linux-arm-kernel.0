From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 21 Dec 2010 09:30:48 +0100
Subject: [PATCH 1/2] ARM i.MX53: Some bug fix about MX53 MSL code
In-Reply-To: <1292902651-26636-1-git-send-email-yong.shen@freescale.com>
References: <1292902651-26636-1-git-send-email-yong.shen@freescale.com>
Message-ID: <20101221083048.GF14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Dec 21, 2010 at 11:37:30AM +0800, yong.shen at freescale.com wrote:
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
hmm, I'd like to have MX53_CCM_VBASE_ADDR (or similar) here.
MX53_CCM_BASE doesn't show the difference to MX53_CCM_BASE_ADDR.  (And
yes, I saw that MX53_DPLL4_BASE is already there.)
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
This is OK, though it could use CONFIG_SOC_MX53.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
