From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 08 Dec 2014 17:00:05 +0530
Subject: [PATCH 01/19] clk: samsung: exynos5433: Add clocks using common
 clock framework
In-Reply-To: <1417510196-6714-2-git-send-email-cw00.choi@samsung.com>
References: <1417510196-6714-1-git-send-email-cw00.choi@samsung.com>
 <1417510196-6714-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <54858BBD.5060002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On Tuesday 02 December 2014 02:19 PM, Chanwoo Choi wrote:
> This patch adds the support for CMU (Clock Management Units) of Exynos5433
> which is 64bit SoC and has Octa-cores. This patch supports necessary clocks
> (PLL/MMC/UART/MCT/I2C/SPI) for kernel boot and includes binding documentation
> for Exynos5433 clock controller.
>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
> ---
>   .../devicetree/bindings/clock/exynos5433-clock.txt | 106 +++
>   drivers/clk/samsung/Makefile                       |   1 +
>   drivers/clk/samsung/clk-exynos5433.c               | 967 +++++++++++++++++++++
>   include/dt-bindings/clock/exynos5433.h             | 199 +++++
>   4 files changed, 1273 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/exynos5433-clock.txt
>   create mode 100644 drivers/clk/samsung/clk-exynos5433.c
>   create mode 100644 include/dt-bindings/clock/exynos5433.h
>

[snip]

> +
> +static struct samsung_div_clock top_div_clks[] __initdata = {
> +	/* DIV_TOP2 */
> +	DIV(CLK_DIV_ACLK_FSYS_200, "div_aclk_fsys_200", "mout_bus_pll_user",
> +			DIV_TOP2, 0, 3),
> +
> +	/* DIV_TOP3 */
> +	DIV(CLK_DIV_ACLK_IMEM_SSSX, "div_aclk_imem_sssx",

As per UM, this clock name should be imem_sssx_266

> +			"mout_bus_pll_user", DIV_TOP3, 24, 3),
> +	DIV(CLK_DIV_ACLK_IMEM_200, "div_aclk_imem_200",
> +			"mout_bus_pll_user", DIV_TOP3, 20, 3),
> +	DIV(CLK_DIV_ACLK_IMEM_266, "div_aclk_imem_266",
> +			"mout_bus_pll_user", DIV_TOP3, 16, 3),
> +	DIV(CLK_DIV_ACLK_PERIC_66_B, "div_aclk_peric_66_b",
> +			"div_aclk_peric_66_a", DIV_TOP3, 12, 3),
> +	DIV(CLK_DIV_ACLK_PERIC_66_A, "div_aclk_peric_66_a",
> +			"mout_bus_pll_user", DIV_TOP3, 8, 3),
> +	DIV(CLK_DIV_ACLK_PERIS_66_B, "div_aclk_peris_66_b",
> +			"div_aclk_peris_66_a", DIV_TOP3, 4, 3),
> +	DIV(CLK_DIV_ACLK_PERIS_66_A, "div_aclk_peris_66_a",

[snip]

> +
> +static void __init exynos5433_cmu_mif_init(struct device_node *np)
> +{
> +	samsung_cmu_register_one(np, &mif_cmu_info);
> +}
> +CLK_OF_DECLARE(exynos5433_cmu_mif, "samsung,exynos5433-cmu-mif",
> +		exynos5433_cmu_mif_init);
> +
> +/*
> + * Register offset definitions for CMU_PERIC
> + */
> +#define DIV_PERIC			0x0600
> +#define ENABLE_ACLK_PERIC		0x0800
> +#define ENABLE_PCLK_PERIC0		0x0900
> +#define ENABLE_PCLK_PERIC1		0x0904
> +#define ENABLE_SCLK_PERIC		0x0A00
> +#define ENABLE_IP_PERIC0		0x0B00
> +#define ENABLE_IP_PERIC1		0x0B04
> +#define ENABLE_IP_PERIC2		0x0B08
> +

nit: Just for consistency, all these offset should be in small case.

> +static unsigned long peric_clk_regs[] __initdata = {
> +	DIV_PERIC,
> +	ENABLE_ACLK_PERIC,
> +	ENABLE_PCLK_PERIC0,
> +	ENABLE_PCLK_PERIC1,
> +	ENABLE_SCLK_PERIC,
> +	ENABLE_IP_PERIC0,
> +	ENABLE_IP_PERIC1,
> +	ENABLE_IP_PERIC2,
> +};
> +

[snip]

Thanks,
Pankaj Dubey
