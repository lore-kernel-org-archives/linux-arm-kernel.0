From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 13 Sep 2014 13:17:06 +0200
Subject: [PATCH v4 4/8] clk: samsung: add initial clock support for Exynos7
 SoC
In-Reply-To: <1410535592-5782-6-git-send-email-ch.naveen@samsung.com>
References: <1410535592-5782-1-git-send-email-ch.naveen@samsung.com>
 <1410535592-5782-6-git-send-email-ch.naveen@samsung.com>
Message-ID: <541427B2.4030108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

Please see my comments inline.

On 12.09.2014 17:26, Naveen Krishna Chatradhi wrote:
> Add initial clock support for Exynos7 SoC which is required
> to bring up platforms based on Exynos7.

[snip]

> +External clocks:
> +
> +There are several clocks that are generated outside the SoC. It
> +is expected that they are defined using standard clock bindings
> +with following clock-output-names:
> +
> + - "fin_pll" - PLL input clock from XXTI

In addition to just relying on clock names (which I hope to finally go
away from common clock framework some day) the binding should be defined
to take all input clocks using generic clock bindings (i.e. clocks and
clock-names). Even if the driver wouldn't use that yet, this would help
with determining initialization order of clock providers.

> +
> +Required Properties for Clock Controller:
> +
> + - compatible: clock controllers will use one of the following
> +	compatible strings to indicate the clock controller
> +	functionality.
> +
> +	- "samsung,exynos7-clock-topc"
> +	- "samsung,exynos7-clock-top0"
> +	- "samsung,exynos7-clock-peric0"
> +	- "samsung,exynos7-clock-peric1"
> +	- "samsung,exynos7-clock-peris"
> +
> + - reg: physical base address of the controller and the length of
> +	memory mapped region.
> +
> + - #clock-cells: should be 1.
> diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
> index 6fb4bc6..5da0ba9 100644
> --- a/drivers/clk/samsung/Makefile
> +++ b/drivers/clk/samsung/Makefile
> @@ -18,3 +18,4 @@ obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
>  obj-$(CONFIG_S3C2443_COMMON_CLK)+= clk-s3c2443.o
>  obj-$(CONFIG_ARCH_S3C64XX)	+= clk-s3c64xx.o
>  obj-$(CONFIG_ARCH_S5PV210)	+= clk-s5pv210.o clk-s5pv210-audss.o
> +obj-$(CONFIG_ARCH_EXYNOS7)	+= clk-exynos7.o

Please keep the entries sorted alphabetically.

> diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
> new file mode 100644
> index 0000000..3ea8d0e
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-exynos7.c

[snip]

> +static struct samsung_fixed_factor_clock topc_fixed_factor_clks[] __initdata = {
> +	FFACTOR(0, "ffac_topc_bus0_pll_div2", "mout_bus0_pll_ctrl", 1, 2, 0),
> +	FFACTOR(0, "ffac_topc_bus0_pll_div4",
> +				"ffac_topc_bus0_pll_div2", 1, 2, 0),

Please use a consistent way of breaking long lines. Here you have 3
tabs, but further in the driver I can see 1 tab or 2 tabs. I'd recommend
making them all 1 tab.

> +	FFACTOR(0, "ffac_topc_bus1_pll_div2", "mout_bus1_pll_ctrl", 1, 2, 0),
> +	FFACTOR(0, "ffac_topc_cc_pll_div2", "mout_cc_pll_ctrl", 1, 2, 0),
> +	FFACTOR(0, "ffac_topc_mfc_pll_div2", "mout_mfc_pll_ctrl", 1, 2, 0),
> +};

[snip]

> +static void __init exynos7_clk_topc_init(struct device_node *np)
> +{
> +	struct exynos_cmu_info cmu = {0};
> +
> +	cmu.pll_clks = topc_pll_clks;
> +	cmu.nr_pll_clks = ARRAY_SIZE(topc_pll_clks);
> +	cmu.mux_clks = topc_mux_clks;
> +	cmu.nr_mux_clks = ARRAY_SIZE(topc_mux_clks);
> +	cmu.div_clks = topc_div_clks;
> +	cmu.nr_div_clks = ARRAY_SIZE(topc_div_clks);
> +	cmu.fixed_factor_clks = topc_fixed_factor_clks;
> +	cmu.nr_fixed_factor_clks = ARRAY_SIZE(topc_fixed_factor_clks);
> +	cmu.clk_regs = topc_clk_regs;
> +	cmu.nr_clk_regs = ARRAY_SIZE(topc_clk_regs);

I wonder if you couldn't simply make this struct statically initialized
and marked as __initdata.

Otherwise looks good.

Best regards,
Tomasz
