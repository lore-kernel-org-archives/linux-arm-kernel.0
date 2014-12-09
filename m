From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 09 Dec 2014 13:18:24 +0530
Subject: [PATCH 12/19] clk: samsung: exynos5433: Add clocks for CMU_GSCL
 domain
In-Reply-To: <1417510196-6714-13-git-send-email-cw00.choi@samsung.com>
References: <1417510196-6714-1-git-send-email-cw00.choi@samsung.com>
 <1417510196-6714-13-git-send-email-cw00.choi@samsung.com>
Message-ID: <5486A948.7010906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On Tuesday 02 December 2014 02:19 PM, Chanwoo Choi wrote:
> This patch adds the divider/gate of CMU_GSCL domain which contains gscaler
> clocks.
>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
> ---
>   .../devicetree/bindings/clock/exynos5433-clock.txt |   8 ++
>   drivers/clk/samsung/clk-exynos5433.c               | 144 +++++++++++++++++++++
>   include/dt-bindings/clock/exynos5433.h             |  37 +++++-
>   3 files changed, 188 insertions(+), 1 deletion(-)
>

[snip]

>   }
>   CLK_OF_DECLARE(exynos5433_cmu_g3d, "samsung,exynos5433-cmu-g3d",
>   		exynos5433_cmu_g3d_init);
> +
> +/*
> + * Register offset definitions for CMU_GSCL
> + */
> +#define MUX_SEL_GSCL				0x0200
> +#define MUX_ENABLE_GSCL				0x0300
> +#define	MUX_STAT_GSCL				0x0400
> +#define	ENABLE_ACLK_GSCL			0x0800
> +#define	ENABLE_ACLK_GSCL_SECURE_SMMU_GSCL0	0x0804
> +#define	ENABLE_ACLK_GSCL_SECURE_SMMU_GSCL1	0x0808
> +#define	ENABLE_ACLK_GSCL_SECURE_SMMU_GSCL2	0x080c
> +#define	ENABLE_PCLK_GSCL			0x0900
> +#define	ENABLE_PCLK_GSCL_SECURE_SMMU_GSCL0	0x0904
> +#define	ENABLE_PCLK_GSCL_SECURE_SMMU_GSCL1	0x0908
> +#define	ENABLE_PCLK_GSCL_SECURE_SMMU_GSCL2	0x090c
> +#define	ENABLE_IP_GSCL0				0x0b00
> +#define	ENABLE_IP_GSCL1				0x0b04
> +#define	ENABLE_IP_GSCL_SECURE_SMMU_GSCL0	0x0b08
> +#define	ENABLE_IP_GSCL_SECURE_SMMU_GSCL1	0x0b0c
> +#define	ENABLE_IP_GSCL_SECURE_SMMU_GSCL2	0x0b10
> +

nit: tabspace after #define should be changed to one whitespace.

> +static unsigned long gscl_clk_regs[] __initdata = {
> +	MUX_SEL_GSCL,
> +	MUX_ENABLE_GSCL,
> +	MUX_STAT_GSCL,
> +	ENABLE_ACLK_GSCL,
> +	ENABLE_ACLK_GSCL_SECURE_SMMU_GSCL0,
> +	ENABLE_ACLK_GSCL_SECURE_SMMU_GSCL1,
> +	ENABLE_ACLK_GSCL_SECURE_SMMU_GSCL2,
> +	ENABLE_PCLK_GSCL,
> +	ENABLE_PCLK_GSCL_SECURE_SMMU_GSCL0,
> +	ENABLE_PCLK_GSCL_SECURE_SMMU_GSCL1,
> +	ENABLE_PCLK_GSCL_SECURE_SMMU_GSCL2,
> +	ENABLE_IP_GSCL0,
> +	ENABLE_IP_GSCL1,
> +	ENABLE_IP_GSCL_SECURE_SMMU_GSCL0,
> +	ENABLE_IP_GSCL_SECURE_SMMU_GSCL1,
> +	ENABLE_IP_GSCL_SECURE_SMMU_GSCL2,
> +};
> +
> +/* list of all parent clock list */
> +PNAME(aclk_gscl_111_user_p)	= { "fin_pll", "aclk_gscl_111", };
> +PNAME(aclk_gscl_333_user_p)	= { "fin_pll", "aclk_gscl_333", };
> +
> +static struct samsung_mux_clock gscl_mux_clks[] __initdata = {
> +	/* MUX_SEL_GSCL */
> +	MUX(CLK_MOUT_ACLK_GSCL_111_USER, "mout_aclk_gscl_111_user",
> +			aclk_gscl_111_user_p, MUX_SEL_GSCL, 4, 1),
> +	MUX(CLK_MOUT_ACLK_GSCL_333_USER, "mout_aclk_gscl_333_user",
> +			aclk_gscl_333_user_p, MUX_SEL_GSCL, 4, 1),

aclk_gscl_333_user mux clock has a shift of '0'.

> +};
> +

Thanks,
Pankaj Dubey
