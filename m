From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Aug 2016 13:47:13 -0600
Subject: [PATCH v3 11/12] clk: tegra: Add BPMP clock driver
In-Reply-To: <20160819173233.13260-12-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-12-thierry.reding@gmail.com>
Message-ID: <30386cdd-ea1d-25bc-cbe2-831c94209a99@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 11:32 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> This driver uses the services provided by the BPMP firmware driver to
> implement a clock driver based on the MRQ_CLK request. This part of the
> BPMP ABI provides a means to enumerate and control clocks and should
> allow the driver to work on any chip that supports this ABI.

> diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c

> +#define TEGRA_BPMP_CLK_HAS_MUX		BIT(0)
> +#define TEGRA_BPMP_CLK_HAS_SET_RATE	BIT(1)
> +#define TEGRA_BPMP_CLK_IS_ROOT		BIT(2)

Shouldn't those be defined in the BPMP ABI header?

> +static int
> +tegra_bpmp_clk_transfer_atomic(struct tegra_bpmp *bpmp,
> +			       const struct tegra_bpmp_clk_message *clk)
> +{
> +	struct mrq_clk_request request;
> +	struct tegra_bpmp_message msg;
> +	void *req = (void *)&request;
> +
> +	memset(&request, 0, sizeof(request));
> +	request.cmd_and_id = (clk->cmd << 24) | clk->clk;
> +	memcpy(req + 4, clk->tx.data, clk->tx.size);

So the TX payload gets memcpy()d once here to combine it with the 
request header, and again inside the BPMP driver to copy it to the IVC 
shared memory. Does it make sense to eliminate the copy here, and 
require callers to allocate and fill in the entire TX structure? The 
"(clk->cmd << 24) | clk->clk" could be wrapped in a static inline 
function to avoid any duplication of logic.

> +static int tegra_bpmp_clk_transfer(struct tegra_bpmp *bpmp,
> +				   const struct tegra_bpmp_clk_message *clk)
...
> +	err = tegra_bpmp_transfer(bpmp, &msg);
> +	if (err != -EAGAIN)
> +		return err;
> +
> +	return __tegra_bpmp_clk_transfer_atomic(bpmp, &msg);
> +}

This seems odd; can you add some comments indicating why there's a need 
for a retry, and why it falls back to the _atomic() function rather than 
just retrying?

Nit: Perhaps s/tegra_bpmp_clk/tegra_clk_bpmp/ for all symbols 
implemented in this driver; it can be a little hard to tell which 
function calls are to the Tegra BPMP driver (tegra_bpmp_*), and which 
are to the Tegra clock driver that's implemented using BPMP 
(tegra_bpmp_clk_*).

> +static int tegra_bpmp_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +				   unsigned long parent_rate)
> +{
> +	return 0;
> +}
> +
> +static long tegra_bpmp_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +				      unsigned long *parent_rate)
> +{
> +	return 0;
> +}
> +
> +static unsigned long tegra_bpmp_clk_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	return 0;
> +}

Aren't those all missing an implementation?

> +static int tegra_bpmp_probe_clocks(struct tegra_bpmp *bpmp,
> +				   struct tegra_bpmp_clk_info **clocksp)

> +	for (id = 0; id <= max_id; id++) {
> +		struct tegra_bpmp_clk_info *info = &clocks[count];
> +#if 0
> +		const char *prefix = "";
> +		struct seq_buf buf;
> +		unsigned int i;
> +		char flags[64];
> +#endif

Should the #if 0 be removed? checkpatch would warn about this; was it 
run and if not would it find other things to complain about?

> +static struct clk_hw *
> +tegra_bpmp_clk_register(struct tegra_bpmp *bpmp,
> +			const struct tegra_bpmp_clk_info *info,
> +			const struct tegra_bpmp_clk_info *clocks,
> +			unsigned int num_clocks)
> +{
> +	struct tegra_bpmp_clk *priv;
> +	struct clk_init_data init;
...
> +	/* hardware clock initialization */
> +	priv->hw.init = &init;
> +	init.name = info->name;
...
> +	clk = clk_register(bpmp->dev, &priv->hw);

Is priv->hw.init guaranteed to only be used inside the call to 
clk_register()? If not, it's storing a pointer to the stack for longer 
than it's valid.

> +	parents = kcalloc(info->num_parents, sizeof(*parents), GFP_KERNEL);
> +	if (!parents)
> +		return ERR_PTR(-ENOMEM);

That needs to free priv->parents which was allocated earlier this function.

> +static struct clk_hw *tegra_bpmp_clk_of_xlate(struct of_phandle_args *clkspec,
> +					      void *data)
> +{
> +	unsigned int id = clkspec->args[0], i;

Should this function validate the cell count first? Too small means 
args[0] doesn't contain valid data, and too large means the DT is bogus, 
and we should at least warn the user they've included extra cruft, since 
it could in theory gain additional meaning later on if the binding gets 
extended.
