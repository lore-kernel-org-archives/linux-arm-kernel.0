From: ccross@google.com (Colin Cross)
Date: Thu, 16 Sep 2010 14:27:47 -0700
Subject: [PATCH 1/3] [ARM] tegra: add PCI Express clocks
In-Reply-To: <79b943ad0c9d4b99a6207e1a7e3ae09bbbe4fae5.1284655723.git.mike@compulab.co.il>
References: <cover.1284655723.git.mike@compulab.co.il>
	<79b943ad0c9d4b99a6207e1a7e3ae09bbbe4fae5.1284655723.git.mike@compulab.co.il>
Message-ID: <AANLkTinN0rYG7rp5Gs3TyGOAQu5qJ18V_-yEuManuX33@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 9:53 AM, Mike Rapoport <mike@compulab.co.il> wrote:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
> ?arch/arm/mach-tegra/tegra2_clocks.c | ? 76 +++++++++++++++++++++++++++++++++-
> ?1 files changed, 73 insertions(+), 3 deletions(-)

<snip>

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

I've been told by Nvidia that the pll lock bits are not reliable, and
will be removing uses of tegra2_pll_clk_wait_for_lock and replacing
them with delays selected by each pll.  Can you confirm with Nvidia
that PLLE_MISC_READY works?

<snip>

> +static struct clk_ops tegra_pcie_clk_ops = {
> + ? ? ? .enable ? ? = tegra2_periph_clk_enable,
> + ? ? ? .disable ? ?= tegra2_periph_clk_disable,
> +};
Why is this needed?  Won't the regular periph ops work?

<snip>

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
These should probably all be defined in the CLK_PERIPH table.
