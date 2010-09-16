From: mogambo.kztrj@gmail.com (Mogambo Park)
Date: Fri, 17 Sep 2010 08:53:41 +0900
Subject: [PATCH 1/3] [ARM] tegra: add PCI Express clocks
In-Reply-To: <79b943ad0c9d4b99a6207e1a7e3ae09bbbe4fae5.1284655723.git.mike@compulab.co.il>
References: <cover.1284655723.git.mike@compulab.co.il>
	<79b943ad0c9d4b99a6207e1a7e3ae09bbbe4fae5.1284655723.git.mike@compulab.co.il>
Message-ID: <AANLkTi=ioZa3JpsSci5Yavaij9dT=R+Nf4VRiUAH4ZN7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good evening Mike Rapport,

 Are there is some datasheet/TRM availability for Nvidia Tegra chip ?
Please say me if yes and where.

thanks

On Fri, Sep 17, 2010 at 1:53 AM, Mike Rapoport <mike@compulab.co.il> wrote:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
> ?arch/arm/mach-tegra/tegra2_clocks.c | ? 76 +++++++++++++++++++++++++++++++++-
> ?1 files changed, 73 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
> index 4261632..44f1b81 100644
> --- a/arch/arm/mach-tegra/tegra2_clocks.c
> +++ b/arch/arm/mach-tegra/tegra2_clocks.c
> @@ -92,6 +92,8 @@
> ?#define PLLD_MISC_DIV_RST ? ? ? ? ? ? ?(1<<23)
> ?#define PLLD_MISC_DCCON_SHIFT ? ? ? ? ?12
>
> +#define PLLE_MISC_READY ? ? ? ? ? ? ? ? ? ? ? ?(1 << 15)
> +
> ?#define PERIPH_CLK_TO_ENB_REG(c) ? ? ? ((c->clk_num / 32) * 4)
> ?#define PERIPH_CLK_TO_ENB_SET_REG(c) ? ((c->clk_num / 32) * 8)
> ?#define PERIPH_CLK_TO_ENB_BIT(c) ? ? ? (1 << (c->clk_num % 32))
> @@ -356,12 +358,12 @@ static unsigned long tegra2_pll_clk_recalculate_rate(struct clk *c)
> ? ? ? ?return c->rate;
> ?}
>
> -static int tegra2_pll_clk_wait_for_lock(struct clk *c)
> +static int tegra2_pll_clk_wait_for_bit_set(struct clk *c, int bit)
> ?{
> ? ? ? ?ktime_t before;
>
> ? ? ? ?before = ktime_get();
> - ? ? ? while (!(clk_readl(c->reg + PLL_BASE) & PLL_BASE_LOCK)) {
> + ? ? ? while (!(clk_readl(c->reg + PLL_BASE) & bit)) {
> ? ? ? ? ? ? ? ?if (ktime_us_delta(ktime_get(), before) > 5000) {
> ? ? ? ? ? ? ? ? ? ? ? ?pr_err("Timed out waiting for lock bit on pll %s",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?c->name);
> @@ -414,7 +416,7 @@ static int tegra2_pll_clk_enable(struct clk *c)
> ? ? ? ?val |= PLL_MISC_LOCK_ENABLE;
> ? ? ? ?clk_writel(val, c->reg + PLL_MISC(c));
>
> - ? ? ? tegra2_pll_clk_wait_for_lock(c);
> + ? ? ? tegra2_pll_clk_wait_for_bit_set(c, PLL_BASE_LOCK);
>
> ? ? ? ?return 0;
> ?}
> @@ -754,6 +756,34 @@ static struct clk_ops tegra_clk_double_ops = {
> ? ? ? ?.recalculate_rate ? ? ? = &tegra2_clk_recalculate_rate,
> ?};
>
> +/* PCI Express clock ops */
> +static int tegra2_plle_clk_enable(struct clk *c)
> +{
> + ? ? ? u32 val;
> +
> + ? ? ? pr_debug("%s on clock %s\n", __func__, c->name);
> +
> + ? ? ? if (tegra2_pll_clk_wait_for_bit_set(c, PLLE_MISC_READY))
> + ? ? ? ? ? ? ? return -EBUSY;
> +
> + ? ? ? val = clk_readl(c->reg + PLL_BASE);
> + ? ? ? val |= PLL_BASE_ENABLE | PLL_BASE_BYPASS;
> + ? ? ? clk_writel(val, c->reg + PLL_BASE);
> +
> + ? ? ? return 0;
> +}
> +
> +static struct clk_ops tegra_plle_ops = {
> + ? ? ? .init ? ? ? = tegra2_pll_clk_init,
> + ? ? ? .enable ? ? = tegra2_plle_clk_enable,
> + ? ? ? .set_rate ? = tegra2_pll_clk_set_rate,
> +};
> +
> +static struct clk_ops tegra_pcie_clk_ops = {
> + ? ? ? .enable ? ? = tegra2_periph_clk_enable,
> + ? ? ? .disable ? ?= tegra2_periph_clk_disable,
> +};
> +
> ?/* Clock definitions */
> ?static struct clk tegra_clk_32k = {
> ? ? ? ?.name = "clk_32k",
> @@ -1109,6 +1139,42 @@ static struct clk tegra_clk_pclk = {
> ? ? ? ?.ops ? ? ? ? ? ?= &tegra_bus_ops,
> ?};
>
> +/* PCI Express clocks */
> +static struct clk_pll_table tegra_pll_e_table[] = {
> + ? ? ? { 12000000, 100000000, ?200, ?24, 1, 0 },
> +};
> +
> +static struct clk tegra_pll_e = {
> + ? ? ? .name ? ? ?= "pll_e",
> + ? ? ? .flags ? ? = PLL_ALT_MISC_REG,
> + ? ? ? .ops ? ? ? = &tegra_plle_ops,
> + ? ? ? .input_min = 12000000,
> + ? ? ? .input_max = 12000000,
> + ? ? ? .parent ? ?= &tegra_clk_m,
> + ? ? ? .reg ? ? ? = 0xe8,
> + ? ? ? .pll_table = tegra_pll_e_table,
> +};
> +
> +static struct clk tegra_clk_pex = {
> + ? ? ? .name ? ? ?= "pex",
> + ? ? ? .flags ? ? = PERIPH_MANUAL_RESET,
> + ? ? ? .ops ? ? ? = &tegra_pcie_clk_ops,
> + ? ? ? .clk_num ? = 70,
> +};
> +
> +static struct clk tegra_clk_afi = {
> + ? ? ? .name ? ? ?= "afi",
> + ? ? ? .flags ? ? = PERIPH_MANUAL_RESET,
> + ? ? ? .ops ? ? ? = &tegra_pcie_clk_ops,
> + ? ? ? .clk_num ? = 72,
> +};
> +
> +/* the pcie_xclk is required for reset of PCIE subsystem */
> +static struct clk tegra_clk_pcie_xclk = {
> + ? ? ? .name ? ? ?= "pcie_xclk",
> + ? ? ? .clk_num ? = 74,
> +};
> +
> ?static struct clk_mux_sel mux_pllm_pllc_pllp_plla[] = {
> ? ? ? ?{ .input = &tegra_pll_m, .value = 0},
> ? ? ? ?{ .input = &tegra_pll_c, .value = 1},
> @@ -1315,11 +1381,15 @@ struct clk_lookup tegra_clk_lookups[] = {
> ? ? ? ?CLK(NULL, ? ? ? "pll_d_out0", ? &tegra_pll_d_out0),
> ? ? ? ?CLK(NULL, ? ? ? "pll_u", ? ? ? ?&tegra_pll_u),
> ? ? ? ?CLK(NULL, ? ? ? "pll_x", ? ? ? ?&tegra_pll_x),
> + ? ? ? CLK(NULL, ? ? ? "pll_e", ? ? ? ?&tegra_pll_e),
> ? ? ? ?CLK(NULL, ? ? ? "cpu", ? ? ? ? ?&tegra_clk_cpu),
> ? ? ? ?CLK(NULL, ? ? ? "sys", ? ? ? ? ?&tegra_clk_sys),
> ? ? ? ?CLK(NULL, ? ? ? "hclk", ? ? ? ? &tegra_clk_hclk),
> ? ? ? ?CLK(NULL, ? ? ? "pclk", ? ? ? ? &tegra_clk_pclk),
> ? ? ? ?CLK(NULL, ? ? ? "clk_d", ? ? ? ?&tegra_clk_d),
> + ? ? ? CLK(NULL, ? ? ? "pcie_xclk", ? ?&tegra_clk_pcie_xclk),
> + ? ? ? CLK(NULL, ? ? ? "pex", ? ? ? ? ?&tegra_clk_pex),
> + ? ? ? CLK(NULL, ? ? ? "afi", ? ? ? ? ?&tegra_clk_afi),
> ?};
>
> ?void __init tegra2_init_clocks(void)
> --
> 1.6.6.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
