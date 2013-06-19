From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 19 Jun 2013 18:54:33 +0200
Subject: [PATCH v6 2/7] clk: samsung: Define a common
 samsung_clk_register_pll()
In-Reply-To: <1370870659-10929-3-git-send-email-yadi.brar@samsung.com>
References: <1370870659-10929-1-git-send-email-yadi.brar@samsung.com>
 <1370870659-10929-3-git-send-email-yadi.brar@samsung.com>
Message-ID: <2209237.a9mepGgblz@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yadwinder,

Generally looks really good, but some comments inline.

On Monday 10 of June 2013 18:54:14 Yadwinder Singh Brar wrote:
> This patch defines a common samsung_clk_register_pll() and its migrating
> the PLL35xx & PLL36xx to use it. Other samsung PLL can also be migrated
> to it. It also adds exynos5250 & exynos5420 PLLs to unique id list of
> clocks. Since pll2550 & pll35xx and pll2650 & pll36xx have exactly same
> clk ops implementation, added pll2550 and pll2650 also.
> 
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c    |   40 +++++++----
>  drivers/clk/samsung/clk-exynos5250.c |   60 +++++++++++-----
>  drivers/clk/samsung/clk-exynos5420.c |   86 +++++++++++++++-------
>  drivers/clk/samsung/clk-pll.c        |  132
> ++++++++++++++++------------------ drivers/clk/samsung/clk-pll.h       
> |   11 ++-
>  drivers/clk/samsung/clk.h            |   48 ++++++++++++
>  6 files changed, 242 insertions(+), 135 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c
> b/drivers/clk/samsung/clk-exynos4.c index addc738..ba25a1b 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -17,7 +17,6 @@
>  #include <linux/of_address.h>
> 
>  #include "clk.h"
> -#include "clk-pll.h"
> 
>  /* Exynos4 clock controller register offsets */
>  #define SRC_LEFTBUS		0x4200
> @@ -97,12 +96,14 @@
>  #define GATE_IP_PERIL		0xc950
>  #define E4210_GATE_IP_PERIR	0xc960
>  #define GATE_BLOCK		0xc970
> +#define E4X12_MPLL_LOCK		0x10008
>  #define E4X12_MPLL_CON0		0x10108
>  #define SRC_DMC			0x10200
>  #define SRC_MASK_DMC		0x10300
>  #define DIV_DMC0		0x10500
>  #define DIV_DMC1		0x10504
>  #define GATE_IP_DMC		0x10900
> +#define APLL_LOCK		0x14000
>  #define APLL_CON0		0x14100
>  #define E4210_MPLL_CON0		0x14108
>  #define SRC_CPU			0x14200
> @@ -121,6 +122,12 @@ enum exynos4_soc {
>  	EXYNOS4X12,
>  };
> 
> +/* list of PLLs to be registered */
> +enum exynos4_plls {
> +	apll, mpll, epll, vpll,
> +	nr_plls			/* number of PLLs */
> +};
> +
>  /*
>   * Let each supported clock get a unique id. This id is used to lookup
> the clock * for device tree based platforms. The clocks are categorized
> into three @@ -988,6 +995,17 @@ static __initdata struct of_device_id
> ext_clk_match[] = { {},
>  };
> 
> +struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {
> +	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", 
APLL_LOCK,
> +		APLL_CON0, "fout_apll"),
> +	[mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll",
> +		E4X12_MPLL_LOCK, E4X12_MPLL_CON0, "fout_mpll"),
> +	[epll] = PLL_A(pll_36xx, fout_epll, "fout_epll", "fin_pll", 
EPLL_LOCK,
> +		EPLL_CON0, "fout_epll"),
> +	[vpll] = PLL_A(pll_36xx, fout_vpll, "fout_vpll", "fin_pll", 
VPLL_LOCK,
> +		VPLL_CON0, "fout_vpll"),
> +};
> +
>  /* register exynos4 clocks */
>  void __init exynos4_clk_init(struct device_node *np, enum exynos4_soc
> exynos4_soc, void __iomem *reg_base, unsigned long xom) {
> @@ -1024,22 +1042,16 @@ void __init exynos4_clk_init(struct device_node
> *np, enum exynos4_soc exynos4_so reg_base + EPLL_CON0, pll_4600);
>  		vpll = samsung_clk_register_pll46xx("fout_vpll", 
"mout_vpllsrc",
>  					reg_base + VPLL_CON0, pll_4650c);
> +
> +		samsung_clk_add_lookup(apll, fout_apll);
> +		samsung_clk_add_lookup(mpll, fout_mpll);
> +		samsung_clk_add_lookup(epll, fout_epll);
> +		samsung_clk_add_lookup(vpll, fout_vpll);
>  	} else {
> -		apll = samsung_clk_register_pll35xx("fout_apll", 
"fin_pll",
> -					reg_base + APLL_CON0);
> -		mpll = samsung_clk_register_pll35xx("fout_mpll", 
"fin_pll",
> -					reg_base + E4X12_MPLL_CON0);
> -		epll = samsung_clk_register_pll36xx("fout_epll", 
"fin_pll",
> -					reg_base + EPLL_CON0);
> -		vpll = samsung_clk_register_pll36xx("fout_vpll", 
"fin_pll",
> -					reg_base + VPLL_CON0);
> +		samsung_clk_register_pll(exynos4_plls,
> +					ARRAY_SIZE(exynos4_plls), 
reg_base);
>  	}
> 
> -	samsung_clk_add_lookup(apll, fout_apll);
> -	samsung_clk_add_lookup(mpll, fout_mpll);
> -	samsung_clk_add_lookup(epll, fout_epll);
> -	samsung_clk_add_lookup(vpll, fout_vpll);
> -
>  	samsung_clk_register_fixed_rate(exynos4_fixed_rate_clks,
>  			ARRAY_SIZE(exynos4_fixed_rate_clks));
>  	samsung_clk_register_mux(exynos4_mux_clks,
> diff --git a/drivers/clk/samsung/clk-exynos5250.c
> b/drivers/clk/samsung/clk-exynos5250.c index 7c68850..dc6a700 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -17,11 +17,22 @@
>  #include <linux/of_address.h>
> 
>  #include "clk.h"
> -#include "clk-pll.h"
> 
> +#define APLL_LOCK		0x0
> +#define APLL_CON0		0x100
>  #define SRC_CPU			0x200
>  #define DIV_CPU0		0x500
> +#define MPLL_LOCK		0x4000
> +#define MPLL_CON0		0x4100
>  #define SRC_CORE1		0x4204
> +#define CPLL_LOCK		0x10020
> +#define EPLL_LOCK		0x10030
> +#define VPLL_LOCK		0x10040
> +#define GPLL_LOCK		0x10050
> +#define CPLL_CON0		0x10120
> +#define EPLL_CON0		0x10130
> +#define VPLL_CON0		0x10140
> +#define GPLL_CON0		0x10150
>  #define SRC_TOP0		0x10210
>  #define SRC_TOP2		0x10218
>  #define SRC_GSCL		0x10220
> @@ -59,10 +70,18 @@
>  #define GATE_IP_FSYS		0x10944
>  #define GATE_IP_PERIC		0x10950
>  #define GATE_IP_PERIS		0x10960
> +#define BPLL_LOCK		0x20010
> +#define BPLL_CON0		0x20110
>  #define SRC_CDREX		0x20200
>  #define PLL_DIV2_SEL		0x20a24
>  #define GATE_IP_DISP1		0x10928
> 
> +/* list of PLLs to be registered */
> +enum exynos5250_plls {
> +	apll, mpll, bpll, gpll, cpll, epll, vpll,
> +	nr_plls			/* number of PLLs */
> +};
> +
>  /*
>   * Let each supported clock get a unique id. This id is used to lookup
> the clock * for device tree based platforms. The clocks are categorized
> into three @@ -79,7 +98,8 @@ enum exynos5250_clks {
>  	none,
> 
>  	/* core clocks */
> -	fin_pll,
> +	fin_pll, fout_apll, fout_mpll, fout_bpll, fout_gpll, fout_cpll,
> +	fout_epll, fout_vpll,
> 
>  	/* gate for special clocks (sclk) */
>  	sclk_cam_bayer = 128, sclk_cam0, sclk_cam1, sclk_gscl_wa,
> sclk_gscl_wb, @@ -470,11 +490,27 @@ static __initdata struct
> of_device_id ext_clk_match[] = { { },
>  };
> 
> +struct __initdata samsung_pll_clock exynos5250_plls[nr_plls] = {
> +	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", 
APLL_LOCK,
> +		APLL_CON0, "fout_apll"),
> +	[mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll", 
MPLL_LOCK,
> +		MPLL_CON0, "fout_mpll"),
> +	[bpll] = PLL(pll_35xx, fout_bpll, "fout_bpll", "fin_pll", 
BPLL_LOCK,
> +		BPLL_CON0),
> +	[gpll] = PLL(pll_35xx, fout_gpll, "fout_gpll", "fin_pll", 
GPLL_LOCK,
> +		GPLL_CON0),
> +	[cpll] = PLL(pll_35xx, fout_cpll, "fout_cpll", "fin_pll", 
CPLL_LOCK,
> +		CPLL_CON0),
> +	[epll] = PLL(pll_36xx, fout_epll, "fout_epll", "fin_pll", 
EPLL_LOCK,
> +		EPLL_CON0),
> +	[vpll] = PLL(pll_36xx, fout_vpll, "fout_vpll", "fin_pll", 
VPLL_LOCK,
> +		VPLL_CON0),
> +};
> +
>  /* register exynox5250 clocks */
>  void __init exynos5250_clk_init(struct device_node *np)
>  {
>  	void __iomem *reg_base;
> -	struct clk *apll, *mpll, *epll, *vpll, *bpll, *gpll, *cpll;
> 
>  	if (np) {
>  		reg_base = of_iomap(np, 0);
> @@ -490,22 +526,8 @@ void __init exynos5250_clk_init(struct device_node
> *np) samsung_clk_of_register_fixed_ext(exynos5250_fixed_rate_ext_clks,
> ARRAY_SIZE(exynos5250_fixed_rate_ext_clks),
>  			ext_clk_match);
> -
> -	apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
> -			reg_base + 0x100);
> -	mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
> -			reg_base + 0x4100);
> -	bpll = samsung_clk_register_pll35xx("fout_bpll", "fin_pll",
> -			reg_base + 0x20110);
> -	gpll = samsung_clk_register_pll35xx("fout_gpll", "fin_pll",
> -			reg_base + 0x10150);
> -	cpll = samsung_clk_register_pll35xx("fout_cpll", "fin_pll",
> -			reg_base + 0x10120);
> -	epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
> -			reg_base + 0x10130);
> -	vpll = samsung_clk_register_pll36xx("fout_vpll", "mout_vpllsrc",
> -			reg_base + 0x10140);
> -
> +	samsung_clk_register_pll(exynos5250_plls, 
ARRAY_SIZE(exynos5250_plls),
> +					reg_base);
>  	samsung_clk_register_fixed_rate(exynos5250_fixed_rate_clks,
>  			ARRAY_SIZE(exynos5250_fixed_rate_clks));
>  	samsung_clk_register_fixed_factor(exynos5250_fixed_factor_clks,
> diff --git a/drivers/clk/samsung/clk-exynos5420.c
> b/drivers/clk/samsung/clk-exynos5420.c index 68a96cb..3ea6b4f 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -17,13 +17,30 @@
>  #include <linux/of_address.h>
> 
>  #include "clk.h"
> -#include "clk-pll.h"
> 
> +#define APLL_LOCK		0x0
> +#define APLL_CON0		0x100
>  #define SRC_CPU			0x200
>  #define DIV_CPU0		0x500
>  #define DIV_CPU1		0x504
>  #define GATE_BUS_CPU		0x700
>  #define GATE_SCLK_CPU		0x800
> +#define CPLL_LOCK		0x10020
> +#define DPLL_LOCK		0x10030
> +#define EPLL_LOCK		0x10040
> +#define RPLL_LOCK		0x10050
> +#define IPLL_LOCK		0x10060
> +#define SPLL_LOCK		0x10070
> +#define VPLL_LOCK		0x10070
> +#define MPLL_LOCK		0x10090
> +#define CPLL_CON0		0x10120
> +#define DPLL_CON0		0x10128
> +#define EPLL_CON0		0x10130
> +#define RPLL_CON0		0x10140
> +#define IPLL_CON0		0x10150
> +#define SPLL_CON0		0x10160
> +#define VPLL_CON0		0x10170
> +#define MPLL_CON0		0x10180
>  #define SRC_TOP0		0x10200
>  #define SRC_TOP1		0x10204
>  #define SRC_TOP2		0x10208
> @@ -75,15 +92,27 @@
>  #define GATE_TOP_SCLK_MAU	0x1083c
>  #define GATE_TOP_SCLK_FSYS	0x10840
>  #define GATE_TOP_SCLK_PERIC	0x10850
> +#define BPLL_LOCK		0x20010
> +#define BPLL_CON0		0x20110
>  #define SRC_CDREX		0x20200
> +#define KPLL_LOCK		0x28000
> +#define KPLL_CON0		0x28100
>  #define SRC_KFC			0x28200
>  #define DIV_KFC0		0x28500
> 
> +/* list of PLLs */
> +enum exynos5420_plls {
> +	apll, cpll, dpll, epll, rpll, ipll, spll, vpll, mpll,
> +	bpll, kpll,
> +	nr_plls			/* number of PLLs */
> +};
> +
>  enum exynos5420_clks {
>  	none,
> 
>  	/* core clocks */
> -	fin_pll,
> +	fin_pll,  fout_apll, fout_cpll, fout_dpll, fout_epll, fout_rpll,
> +	fout_ipll, fout_spll, fout_vpll, fout_mpll, fout_bpll, fout_kpll,
> 
>  	/* gate for special clocks (sclk) */
>  	sclk_uart0 = 128, sclk_uart1, sclk_uart2, sclk_uart3, sclk_mmc0,
> @@ -698,6 +727,31 @@ struct samsung_gate_clock exynos5420_gate_clks[]
> __initdata = { GATE(smmu_mscl2, "smmu_mscl2", "aclk400_mscl",
> GATE_IP_MSCL, 10, 0, 0), };
> 
> +struct __initdata samsung_pll_clock exynos5420_plls[nr_plls] = {
> +	[apll] = PLL(pll_2550, fout_apll, "fout_apll", "fin_pll", 
APLL_LOCK,
> +		APLL_CON0),
> +	[cpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", 
MPLL_LOCK,
> +		MPLL_CON0),
> +	[dpll] = PLL(pll_2550, fout_dpll, "fout_dpll", "fin_pll", 
DPLL_LOCK,
> +		DPLL_CON0),
> +	[epll] = PLL(pll_2650, fout_epll, "fout_epll", "fin_pll", 
EPLL_LOCK,
> +		EPLL_CON0),
> +	[rpll] = PLL(pll_2650, fout_rpll, "fout_rpll", "fin_pll", 
RPLL_LOCK,
> +		RPLL_CON0),
> +	[ipll] = PLL(pll_2550, fout_ipll, "fout_ipll", "fin_pll", 
IPLL_LOCK,
> +		IPLL_CON0),
> +	[spll] = PLL(pll_2550, fout_spll, "fout_spll", "fin_pll", 
SPLL_LOCK,
> +		SPLL_CON0),
> +	[vpll] = PLL(pll_2550, fout_vpll, "fout_vpll", "fin_pll", 
VPLL_LOCK,
> +		VPLL_CON0),
> +	[mpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", 
MPLL_LOCK,
> +		MPLL_CON0),
> +	[bpll] = PLL(pll_2550, fout_bpll, "fout_bpll", "fin_pll", 
BPLL_LOCK,
> +		BPLL_CON0),
> +	[kpll] = PLL(pll_2550, fout_kpll, "fout_kpll", "fin_pll", 
KPLL_LOCK,
> +		KPLL_CON0),
> +};
> +
>  static __initdata struct of_device_id ext_clk_match[] = {
>  	{ .compatible = "samsung,exynos5420-oscclk", .data = (void *)0, },
>  	{ },
> @@ -707,8 +761,6 @@ static __initdata struct of_device_id
> ext_clk_match[] = { void __init exynos5420_clk_init(struct device_node
> *np)
>  {
>  	void __iomem *reg_base;
> -	struct clk *apll, *bpll, *cpll, *dpll, *epll, *ipll, *kpll, *mpll;
> -	struct clk *rpll, *spll, *vpll;
> 
>  	if (np) {
>  		reg_base = of_iomap(np, 0);
> @@ -724,30 +776,8 @@ void __init exynos5420_clk_init(struct device_node
> *np) samsung_clk_of_register_fixed_ext(exynos5420_fixed_rate_ext_clks,
> ARRAY_SIZE(exynos5420_fixed_rate_ext_clks),
>  			ext_clk_match);
> -
> -	apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
> -			reg_base + 0x100);
> -	bpll = samsung_clk_register_pll35xx("fout_bpll", "fin_pll",
> -			reg_base + 0x20110);
> -	cpll = samsung_clk_register_pll35xx("fout_cpll", "fin_pll",
> -			reg_base + 0x10120);
> -	dpll = samsung_clk_register_pll35xx("fout_dpll", "fin_pll",
> -			reg_base + 0x10128);
> -	epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
> -			reg_base + 0x10130);
> -	ipll = samsung_clk_register_pll35xx("fout_ipll", "fin_pll",
> -			reg_base + 0x10150);
> -	kpll = samsung_clk_register_pll35xx("fout_kpll", "fin_pll",
> -			reg_base + 0x28100);
> -	mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
> -			reg_base + 0x10180);
> -	rpll = samsung_clk_register_pll36xx("fout_rpll", "fin_pll",
> -			reg_base + 0x10140);
> -	spll = samsung_clk_register_pll35xx("fout_spll", "fin_pll",
> -			reg_base + 0x10160);
> -	vpll = samsung_clk_register_pll35xx("fout_vpll", "fin_pll",
> -			reg_base + 0x10170);
> -
> +	samsung_clk_register_pll(exynos5420_plls, 
ARRAY_SIZE(exynos5420_plls),
> +					reg_base);
>  	samsung_clk_register_fixed_rate(exynos5420_fixed_rate_clks,
>  			ARRAY_SIZE(exynos5420_fixed_rate_clks));
>  	samsung_clk_register_fixed_factor(exynos5420_fixed_factor_clks,
> diff --git a/drivers/clk/samsung/clk-pll.c
> b/drivers/clk/samsung/clk-pll.c index 8224bde..f132353 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -17,6 +17,7 @@ struct samsung_clk_pll {
>  	struct clk_hw		hw;
>  	void __iomem		*lock_reg;
>  	void __iomem		*con_reg;
> +	enum samsung_pll_type	type;
>  };
> 
>  #define to_clk_pll(_hw) container_of(_hw, struct samsung_clk_pll, hw)
> @@ -54,41 +55,6 @@ static const struct clk_ops samsung_pll35xx_clk_ops =
> { .recalc_rate = samsung_pll35xx_recalc_rate,
>  };
> 
> -struct clk * __init samsung_clk_register_pll35xx(const char *name,
> -			const char *pname, const void __iomem *con_reg)
> -{
> -	struct samsung_clk_pll *pll;
> -	struct clk *clk;
> -	struct clk_init_data init;
> -
> -	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> -	if (!pll) {
> -		pr_err("%s: could not allocate pll clk %s\n", __func__, 
name);
> -		return NULL;
> -	}
> -
> -	init.name = name;
> -	init.ops = &samsung_pll35xx_clk_ops;
> -	init.flags = CLK_GET_RATE_NOCACHE;
> -	init.parent_names = &pname;
> -	init.num_parents = 1;
> -
> -	pll->hw.init = &init;
> -	pll->con_reg = con_reg;
> -
> -	clk = clk_register(NULL, &pll->hw);
> -	if (IS_ERR(clk)) {
> -		pr_err("%s: failed to register pll clock %s\n", __func__,
> -				name);
> -		kfree(pll);
> -	}
> -
> -	if (clk_register_clkdev(clk, name, NULL))
> -		pr_err("%s: failed to register lookup for %s", __func__, 
name);
> -
> -	return clk;
> -}
> -
>  /*
>   * PLL36xx Clock Type
>   */
> @@ -126,41 +92,6 @@ static const struct clk_ops samsung_pll36xx_clk_ops
> = { .recalc_rate = samsung_pll36xx_recalc_rate,
>  };
> 
> -struct clk * __init samsung_clk_register_pll36xx(const char *name,
> -			const char *pname, const void __iomem *con_reg)
> -{
> -	struct samsung_clk_pll *pll;
> -	struct clk *clk;
> -	struct clk_init_data init;
> -
> -	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> -	if (!pll) {
> -		pr_err("%s: could not allocate pll clk %s\n", __func__, 
name);
> -		return NULL;
> -	}
> -
> -	init.name = name;
> -	init.ops = &samsung_pll36xx_clk_ops;
> -	init.flags = CLK_GET_RATE_NOCACHE;
> -	init.parent_names = &pname;
> -	init.num_parents = 1;
> -
> -	pll->hw.init = &init;
> -	pll->con_reg = con_reg;
> -
> -	clk = clk_register(NULL, &pll->hw);
> -	if (IS_ERR(clk)) {
> -		pr_err("%s: failed to register pll clock %s\n", __func__,
> -				name);
> -		kfree(pll);
> -	}
> -
> -	if (clk_register_clkdev(clk, name, NULL))
> -		pr_err("%s: failed to register lookup for %s", __func__, 
name);
> -
> -	return clk;
> -}
> -
>  /*
>   * PLL45xx Clock Type
>   */
> @@ -411,3 +342,64 @@ struct clk * __init
> samsung_clk_register_pll2550x(const char *name,
> 
>  	return clk;
>  }
> +
> +void __init samsung_clk_register_pll(struct samsung_pll_clock
> *clk_list, +				unsigned int nr_pll, void __iomem 
*base)
> +{
> +	struct samsung_clk_pll *pll;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +	struct samsung_pll_clock *list = clk_list;
> +	int cnt;
> +
> +	for (cnt = 0; cnt < nr_pll; cnt++, list++) {

I'd suggest moving contents of this loop to a function like following?

static int __init _samsung_clk_register_pll(struct samsung_pll_clock *pll,
					    void __iomem *base)

This will make the code less indented and so more readable.

> +		pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +		if (!pll) {
> +			pr_err("%s: could not allocate pll clk %s\n",
> +				__func__, list->name);
> +			continue;
> +		}
> +
> +		init.name = list->name;
> +		init.flags = list->flags;
> +		init.parent_names = &list->parent_name;
> +		init.num_parents = 1;
> +
> +		switch (list->type) {
> +		/* clk_ops for 35xx and 2550 are similar */
> +		case pll_35xx:
> +		case pll_2550:
> +			init.ops = &samsung_pll35xx_clk_ops;
> +			break;
> +		/* clk_ops for 36xx and 2650 are similar */
> +		case pll_36xx:
> +		case pll_2650:
> +			init.ops = &samsung_pll36xx_clk_ops;
> +			break;
> +		default:
> +			pr_warn("%s: Unknown pll type for pll clk %s\n",
> +				__func__, list->name);
> +		}
> +
> +		pll->hw.init = &init;
> +		pll->type = list->type;
> +		pll->lock_reg = base + list->lock_offset;
> +		pll->con_reg = base + list->con_offset;
> +
> +		clk = clk_register(NULL, &pll->hw);
> +		if (IS_ERR(clk)) {
> +			pr_err("%s: failed to register pll clock %s\n",
> +				__func__, list->name);
> +			kfree(pll);
> +			continue;
> +		}
> +
> +		samsung_clk_add_lookup(clk, list->id);
> +
> +		if (list->alias)
> +			if (clk_register_clkdev(clk, list->alias,
> +				list->dev_name))

What about

		if (!list->alias)
			return;

		ret = clk_register_clkdev(clk, list->alias, list-
>dev_name);
		if (ret)
			pr_err("%s: failed to register lookup for %s",
						__func__, list->name);

> +				pr_err("%s: failed to register lookup for 
%s",
> +					__func__, list->name);
> +	}
> +}
> diff --git a/drivers/clk/samsung/clk-pll.h
> b/drivers/clk/samsung/clk-pll.h index f33786e..1536f27 100644
> --- a/drivers/clk/samsung/clk-pll.h
> +++ b/drivers/clk/samsung/clk-pll.h
> @@ -12,6 +12,13 @@
>  #ifndef __SAMSUNG_CLK_PLL_H
>  #define __SAMSUNG_CLK_PLL_H
> 
> +enum samsung_pll_type {
> +	pll_35xx,
> +	pll_36xx,
> +	pll_2550,
> +	pll_2650,
> +};
> +
>  enum pll45xx_type {
>  	pll_4500,
>  	pll_4502,
> @@ -24,10 +31,6 @@ enum pll46xx_type {
>  	pll_4650c,
>  };
> 
> -extern struct clk * __init samsung_clk_register_pll35xx(const char
> *name, -			const char *pname, const void __iomem 
*con_reg);
> -extern struct clk * __init samsung_clk_register_pll36xx(const char
> *name, -			const char *pname, const void __iomem 
*con_reg);
>  extern struct clk * __init samsung_clk_register_pll45xx(const char
> *name, const char *pname, const void __iomem *con_reg,
>  			enum pll45xx_type type);
> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
> index e4ad6ea..51f60ca 100644
> --- a/drivers/clk/samsung/clk.h
> +++ b/drivers/clk/samsung/clk.h
> @@ -19,6 +19,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include "clk-pll.h"
> 
>  /**
>   * struct samsung_clock_alias: information about mux clock
> @@ -258,6 +259,51 @@ struct samsung_clk_reg_dump {
>  	u32	value;
>  };
> 
> +/**
> + * struct samsung_pll_clock: information about pll clock
> + * @id: platform specific id of the clock.
> + * @dev_name: name of the device to which this clock belongs.
> + * @name: name of this pll clock.
> + * @parent_name: name of the parent clock.
> + * @flags: optional flags for basic clock.
> + * @con_offset: offset of the register for configuring the PLL.
> + * @lock_offset: offset of the register for locking the PLL.
> + * @type: Type of PLL to be registered.
> + * @alias: optional clock alias name to be assigned to this clock.
> + */
> +struct samsung_pll_clock {
> +	unsigned int		id;
> +	const char		*dev_name;
> +	const char		*name;
> +	const char		*parent_name;
> +	unsigned long		flags;
> +	const int		con_offset;
> +	const int		lock_offset;

I don't see any point of having all those const qualifiers of non-
pointers. This makes the struct useless for creating and initializing at 
runtime.

> +	enum			samsung_pll_type type;

IMHO the enum keyword shouldn't be separated from enum name like this.

Otherwise the patch looks fine. Maybe it's a bit too big - things could be 
done a bit more gradually, like:
1) first add required structs and functions,
2) then move existing clock drivers to use the new API, possibly one patch 
per driver,
3) remove the old API.

This would make the whole change easier to review and, in case of any 
regressions, easier to track down the problem.

Best regards,
Tomasz

> +	const char              *alias;
> +};
> +
> +#define __PLL(_typ, _id, _dname, _name, _pname, _flags, _lock, _con,
> _alias) \ +	{								
\
> +		.id		= _id,					\
> +		.type		= _typ,					\
> +		.dev_name	= _dname,				\
> +		.name		= _name,				\
> +		.parent_name	= _pname,				\
> +		.flags		= CLK_GET_RATE_NOCACHE,			\
> +		.con_offset	= _con,					\
> +		.lock_offset	= _lock,				\
> +		.alias		= _alias,				\
> +	}
> +
> +#define PLL(_typ, _id, _name, _pname, _lock, _con)			\
> +	__PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE,	\
> +		_lock, _con, NULL)
> +
> +#define PLL_A(_typ, _id, _name, _pname, _lock, _con, _alias)		\
> +	__PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE,	\
> +		_lock, _con, _alias)
> +
>  extern void __init samsung_clk_init(struct device_node *np, void
> __iomem *base, unsigned long nr_clks, unsigned long *rdump,
>  		unsigned long nr_rdump, unsigned long *soc_rdump,
> @@ -281,6 +327,8 @@ extern void __init samsung_clk_register_div(struct
> samsung_div_clock *clk_list, unsigned int nr_clk);
>  extern void __init samsung_clk_register_gate(
>  		struct samsung_gate_clock *clk_list, unsigned int nr_clk);
> +extern void __init samsung_clk_register_pll(struct samsung_pll_clock
> *list, +		unsigned int nr_clk, void __iomem *base);
> 
>  extern unsigned long _get_rate(const char *clk_name);
