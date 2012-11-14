From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Nov 2012 14:14:09 +0900
Subject: [PATCH v2 2/5] clk: exynos4: register clocks using common clock
 framework
In-Reply-To: <1349629855-4962-3-git-send-email-thomas.abraham@linaro.org>
References: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
 <1349629855-4962-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <03a301cdc226$e0a41d50$a1ec57f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> For legacy Exynos4 platforms, the available clocks are statically
> listed and then registered using the common clock framework. On device
> tree enabled exynos platfotms, the device tree is searched and all
> clock nodes found are registered. Support for Exynos4210 and
> Exynos4x12 platforms is included.
> 
> Cc: Mike Turquette <mturquette@ti.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/clk/samsung/Makefile      |    1 +
>  drivers/clk/samsung/clk-exynos4.c |  647
> +++++++++++++++++++++++++++++++++++++
>  2 files changed, 648 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/clk/samsung/clk-exynos4.c

[...]

> +
> +/* base address of io remapped clock controller register space */
> +static	void __iomem *clk_base;
> +

I didn't look at the full details. BTW, you know, clock naming is very
important and there are some comments about that below...

> +static const char *pll_parent_names[] __initdata = { "fin_pll" };

Why is this only 'xxx_parent_names'? not just 'xxx_parents' like others?

> +static const char *fin_pll_parents[] __initdata = { "xxti", "xusbxti" };
> +static const char *mout_apll_parents[] __initdata = { "fin_pll",
> "fout_apll", };

According to original naming, how about clk_src_apll here?

+static const char *clk_src_apll[] __initdata = { "fin_pll", "fout_apll", };

> +static const char *mout_mpll_parents[] __initdata = { "fin_pll",

clk_src_mpll?

> "fout_mpll", };
> +static const char *mout_epll_parents[] __initdata = { "fin_pll",

clk_src_epll?

> "fout_epll", };
> +
> +static const char *sclk_ampll_parents[] __initdata = {

clk_src_aclk?

> +		"mout_mpll", "sclk_apll", };
> +
> +static const char *sclk_evpll_parents[] __initdata = {



> +		"mout_epll", "mout_vpll", };
> +
> +static const char *mout_core_parents[] __initdata = {

clk_src_core?

Hmm... most of the 'sources' is from out of MUX so mout is not required?...

> +		"mout_apll", "mout_mpll", };
> +
> +static const char *mout_mfc_parents[] __initdata = {
> +		"mout_mfc0", "mout_mfc1", };

Should be following?

+static const char *clk_src_mfc0[] __initdata = {"mout_mpll", "sclk_apll",
};
+static const char *clk_src_mfc1[] __initdata = {"mout_epll", "sclk_vpll",
};

> +
> +static const char *mout_dac_parents[] __initdata = {
> +		"mout_vpll", "sclk_hdmiphy", };

sclk_vpll?

+static const char *clk_src_sclk_dac[] __initdata = {"sclk_vpll",
"sclk_hdmiphy", };


> +
> +static const char *mout_hdmi_parents[] __initdata = {

clk_src_sclk_hdmi?

> +		"sclk_pixel", "sclk_hdmiphy", };
> +
> +static const char *mout_mixer_parents[] __initdata = {

clk_src_sclk_mixer?

> +		"sclk_dac", "sclk_hdmi", };
> +
> +static const char *group1_parents[] __initdata = {

According to original clock-exynos4.c, just 'group_parents' not
'group1_parents'?

> +		"xxti", "xusbxti", "sclk_hdmi24m", "sclk_usbphy0",

Should be 'sclk_hdmi27m' instead of 'sclk_hdmi24m'
+		"xxti", "xusbxti", "sclk_hdmi24m", "sclk_usbphy0",

> +		"none", "sclk_hdmiphy", "mout_mpll", "mout_epll",

Missed 'sclk_usbphy1'?
+		"sclk_usbphy1", "sclk_hdmiphy", "mout_mpll", "mout_epll",

> +		"mout_vpll" };
> +
> +static struct samsung_fixed_rate_clock exynos4_fixed_rate_clks[] = {
> +	FRATE_CLK(NULL, "xxti", NULL, CLK_IS_ROOT, 24000000),
> +	FRATE_CLK(NULL, "xusbxti", NULL, CLK_IS_ROOT, 24000000),

Well, above clock rate depends on board and it means it is not a fixed
value.

> +	FRATE_CLK(NULL, "sclk_hdmi24m", NULL, CLK_IS_ROOT, 24000000),
> +	FRATE_CLK(NULL, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 27000000),
> +	FRATE_CLK(NULL, "sclk_usbphy0", NULL, CLK_IS_ROOT, 48000000),

Missed sclk_hdmi27m?
+	FRATE_CLK(NULL, "sclk_hdmi27m", NULL, CLK_IS_ROOT, 27000000),

> +};
> +
> +static struct samsung_mux_clock exynos4_mux_clks[] = {

[...]

> +};
> +
> +static struct samsung_div_clock exynos4_div_clks[] = {

[...]

> +};
> +
> +struct samsung_gate_clock exynos4_gate_clks[] = {

[...]

> +	clk = clk_get(NULL, "fout_apll");
> +	samsung_pll_clk_set_cb(clk, NULL, exynos4210_get_rate_apll);

+	samsung_pll_clk_set_cb(clk, NULL, exynos4210_apll_get_rate);

> +	clk = clk_get(NULL, "fout_mpll");
+	samsung_pll_clk_set_cb(clk, NULL, exynos4210_mpll_get_rate);

> +	samsung_pll_clk_set_cb(clk, NULL, exynos4210_get_rate_mpll);


> +	clk = clk_get(NULL, "fout_epll");
> +	samsung_pll_clk_set_cb(clk, NULL, exynos4210_get_rate_epll);

+	samsung_pll_clk_set_cb(clk, NULL, exynos4210_epll_get_rate);

> +	clk = clk_get(NULL, "fout_vpll");
> +	samsung_pll_clk_set_cb(clk, exynos4210_vpll_set_rate,
> +				exynos4210_get_rate_mpll);

mpll? Should be vpll?

+				exynos4210_vpll_get_rate); ???

[...]

> +	samsung_clk_register_pll("fout_apll", pll_parent_names, NULL,
> +		NULL, exynos4210_get_rate_apll);

+		NULL, exynos4210_apll_get_rate);

> +	samsung_clk_register_pll("fout_mpll", pll_parent_names, NULL,
> +		NULL, exynos4210_get_rate_mpll);

+		NULL, exynos4210_mpll_get_rate);

> +	samsung_clk_register_pll("fout_epll", pll_parent_names, NULL,
> +		NULL, exynos4210_get_rate_epll);

+		NULL, exynos4210_epll_get_rate);

> +	samsung_clk_register_pll("fout_vpll", exynos4210_vpll_parent_names,
> +		NULL, exynos4210_vpll_set_rate, exynos4210_get_rate_vpll);


+		NULL, exynos4210_vpll_set_rate, exynos4210_vpll_get_rate);

[...]

> +static unsigned long exynos4x12_get_rate_apll(unsigned long xtal_rate)

exynos4x12_apll_get_rate()

> +{
> +	return s5p_get_pll35xx(xtal_rate, __raw_readl(EXYNOS4_APLL_CON0));
> +}
> +
> +static unsigned long exynos4x12_get_rate_mpll(unsigned long xtal_rate)

exynos4x12_mpll_get_rate()

> +{
> +	return s5p_get_pll35xx(xtal_rate, __raw_readl(EXYNOS4_MPLL_CON0));
> +}
> +
> +static unsigned long exynos4x12_get_rate_epll(unsigned long xtal_rate)

exynos4x12_epll_get_rate()

> +{
> +	return s5p_get_pll36xx(xtal_rate, __raw_readl(EXYNOS4_EPLL_CON0),
> +		__raw_readl(EXYNOS4_EPLL_CON1));
> +}
> +
> +static unsigned long exynos4x12_get_rate_vpll(unsigned long vpllsrc_rate)

exynos4x12_vpll_get_rate()

> +{
> +	return s5p_get_pll36xx(vpllsrc_rate, __raw_readl(EXYNOS4_VPLL_CON0),
> +		__raw_readl(EXYNOS4_VPLL_CON1));
> +}
> +
> +/* Exynos4x12 specific clock registeration */
> +void __init exynos4x12_clk_init(void)
> +{
> +	exynos4_clk_init();
> +
> +	samsung_clk_register_pll("fout_apll", pll_parent_names, NULL,
> +		NULL, exynos4x12_get_rate_apll);

+		NULL, exynos4x12_apll_get_rate);

> +	samsung_clk_register_pll("fout_mpll", pll_parent_names, NULL,
> +		NULL, exynos4x12_get_rate_mpll);

+		NULL, exynos4x12_mpll_get_rate);

> +	samsung_clk_register_pll("fout_epll", pll_parent_names, NULL,
> +		NULL, exynos4x12_get_rate_epll);

+		NULL, exynos4x12_epll_get_rate);

> +	samsung_clk_register_pll("fout_vpll", pll_parent_names, NULL,
> +		NULL, exynos4x12_get_rate_vpll);

+		NULL, exynos4x12_vpll_get_rate);

> +
> +	samsung_clk_register_mux(exynos4x12_mux_clks,
> +			ARRAY_SIZE(exynos4x12_mux_clks));
> +
> +	pr_info("EXYNOS4210: PLL settings: A=%ld, M=%ld, E=%ld, V=%ld\n",

pr_info("EXYNOS4X12:...

> +		_get_rate("fout_apll"), _get_rate("fout_mpll"),
> +		_get_rate("fout_epll"), _get_rate("fout_vpll"));
> +
> +	pr_info("EXYNOS4210: ARMCLK=%ld, ACLK200=%ld, ACLK100=%ld\n"

pr_info("EXYNOS4X12:...

> +		"         ACLK160=%ld, ACLK133=%ld\n", _get_rate("armclk"),
> +		_get_rate("aclk_200"), _get_rate("aclk_100"),
> +		_get_rate("aclk_160"), _get_rate("aclk_133"));
> +}
> --
> 1.7.5.4


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
