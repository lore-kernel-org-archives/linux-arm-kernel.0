From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 02 Sep 2014 21:06:25 +0200
Subject: [PATCH v2 1/4] clk: rockchip: protect critical clocks from
 getting disabled
In-Reply-To: <1758693.xu8myGIhjQ@diego>
References: <3132019.Q6dzkQ3ylK@diego> <1758693.xu8myGIhjQ@diego>
Message-ID: <2295814.bdy3ybS178@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Am Donnerstag, 14. August 2014, 23:00:26 schrieb Heiko St?bner:
> The clock-tree contains clocks that should never get disabled automatically.
> One example are the base ACLKs, the base supplies for all peripherals.
> 
> Therefore add a structure similar to the sunxi clock-tree to protect these
> special clocks from being disabled.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Kever Yang <kever.yang@rock-chips.com>
> ---

from the discussions in v1 I remember there were no showstoppers for this 
change, so could take a look into applying this one patch, so we can 
sucessfully enable the dma controllers :-)


Thanks
Heiko


> no change since v1
> 
>  drivers/clk/rockchip/clk-rk3188.c |  7 +++++++
>  drivers/clk/rockchip/clk-rk3288.c |  7 +++++++
>  drivers/clk/rockchip/clk.c        | 13 +++++++++++++
>  drivers/clk/rockchip/clk.h        |  1 +
>  4 files changed, 28 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3188.c
> b/drivers/clk/rockchip/clk-rk3188.c index a83a6d8..732118e 100644
> --- a/drivers/clk/rockchip/clk-rk3188.c
> +++ b/drivers/clk/rockchip/clk-rk3188.c
> @@ -599,6 +599,11 @@ static struct rockchip_clk_branch rk3188_clk_branches[]
> __initdata = { GATE(ACLK_GPS, "aclk_gps", "aclk_peri", 0,
> RK2928_CLKGATE_CON(8), 13, GFLAGS), };
> 
> +static const char *rk3188_critical_clocks[] __initconst = {
> +	"aclk_cpu",
> +	"aclk_peri",
> +};
> +
>  static void __init rk3188_common_clk_init(struct device_node *np)
>  {
>  	void __iomem *reg_base;
> @@ -628,6 +633,8 @@ static void __init rk3188_common_clk_init(struct
> device_node *np) RK3188_GRF_SOC_STATUS);
>  	rockchip_clk_register_branches(common_clk_branches,
>  				  ARRAY_SIZE(common_clk_branches));
> +	rockchip_clk_protect_critical(rk3188_critical_clocks,
> +				      ARRAY_SIZE(rk3188_critical_clocks));
> 
>  	rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CON(0),
>  				  ROCKCHIP_SOFTRST_HIWORD_MASK);
> diff --git a/drivers/clk/rockchip/clk-rk3288.c
> b/drivers/clk/rockchip/clk-rk3288.c index 0d8c6c5..038b1aa 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -680,6 +680,11 @@ static struct rockchip_clk_branch rk3288_clk_branches[]
> __initdata = { GATE(0, "pclk_isp_in", "ext_isp", 0, RK3288_CLKGATE_CON(16),
> 3, GFLAGS), };
> 
> +static const char *rk3288_critical_clocks[] __initconst = {
> +	"aclk_cpu",
> +	"aclk_peri",
> +};
> +
>  static void __init rk3288_clk_init(struct device_node *np)
>  {
>  	void __iomem *reg_base;
> @@ -710,6 +715,8 @@ static void __init rk3288_clk_init(struct device_node
> *np) RK3288_GRF_SOC_STATUS);
>  	rockchip_clk_register_branches(rk3288_clk_branches,
>  				  ARRAY_SIZE(rk3288_clk_branches));
> +	rockchip_clk_protect_critical(rk3288_critical_clocks,
> +				      ARRAY_SIZE(rk3288_critical_clocks));
> 
>  	rockchip_register_softrst(np, 9, reg_base + RK3288_SOFTRST_CON(0),
>  				  ROCKCHIP_SOFTRST_HIWORD_MASK);
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 278cf9d..9189f1b 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -242,3 +242,16 @@ void __init rockchip_clk_register_branches(
>  		rockchip_clk_add_lookup(clk, list->id);
>  	}
>  }
> +
> +void __init rockchip_clk_protect_critical(const char *clocks[], int
> nclocks) +{
> +	int i;
> +
> +	/* Protect the clocks that needs to stay on */
> +	for (i = 0; i < nclocks; i++) {
> +		struct clk *clk = __clk_lookup(clocks[i]);
> +
> +		if (clk)
> +			clk_prepare_enable(clk);
> +	}
> +}
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index 887cbde..2b0bca1 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -329,6 +329,7 @@ void rockchip_clk_register_branches(struct
> rockchip_clk_branch *clk_list, unsigned int nr_clk);
>  void rockchip_clk_register_plls(struct rockchip_pll_clock *pll_list,
>  				unsigned int nr_pll, int grf_lock_offset);
> +void rockchip_clk_protect_critical(const char *clocks[], int nclocks);
> 
>  #define ROCKCHIP_SOFTRST_HIWORD_MASK	BIT(0)
