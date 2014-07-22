From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jul 2014 10:57:22 -0600
Subject: [PATCH 8/8] clk: tegra: Add EMC clock driver
In-Reply-To: <1405088313-20048-9-git-send-email-mperttunen@nvidia.com>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
 <1405088313-20048-9-git-send-email-mperttunen@nvidia.com>
Message-ID: <53CE97F2.80300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2014 08:18 AM, Mikko Perttunen wrote:
> The driver is currently only tested on Tegra124 Jetson TK1, but should
> work with other Tegra124 boards, provided that correct EMC tables are
> provided through the device tree. Older chip models have differing
> timing change sequences, so they are not currently supported.

> diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c

> +struct emc_timing {
> +	unsigned long rate, parent_rate;
> +	u8 parent_index;
> +	struct clk *parent;
> +
> +	/* Store EMC burst data in a union to minimize mistakes. This allows
> +	 * us to use the same burst data lists as used by the downstream and
> +	 * ChromeOS kernels. */

Nit: */ should be on its own line. This applies to many comments in the
file.

> +/* * * * * * * * * * * * * * * * * * * * * * * * * *
> + * Timing change sequence functions                *
> + * * * * * * * * * * * * * * * * * * * * * * * * * */

Nit: This kind of banner comment is unusual, but I guess it's fine.

> +static void emc_seq_update_timing(struct tegra_emc *tegra)
...
> +	dev_err(&tegra->pdev->dev, "timing update failed\n");
> +	BUG();
> +}

Is there any way to avoid all these BUGs? Can we just continue on and
retry the next time, or disallow any further clock rate changes or
something?

> +/* * * * * * * * * * * * * * * * * * * * * * * * * *
> + * Debugfs entry                                   *
> + * * * * * * * * * * * * * * * * * * * * * * * * * */
> +
> +static int emc_debug_rate_get(void *data, u64 *rate)
> +{
> +	struct tegra_emc *tegra = data;
> +
> +	*rate = clk_get_rate(tegra->hw.clk);
> +
> +	return 0;
> +}
> +
> +static int emc_debug_rate_set(void *data, u64 rate)
> +{
> +	struct tegra_emc *tegra = data;
> +
> +	return clk_set_rate(tegra->hw.clk, rate);
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(emc_debug_rate_fops, emc_debug_rate_get,
> +			emc_debug_rate_set, "%lld\n");

I think the rate can already be obtained through
...debug/clock/clock_summary. I'm not sure about changing the rate, but
shouldn't that be a feature of the common clock core, not individual
drivers?

> +static int load_timings_from_dt(struct tegra_emc *tegra,
> +				struct device_node *node)
> +{
...
> +	for_each_child_of_node(node, child) {
...
> +		if (timing->rate <= prev_rate) {
> +			dev_err(&tegra->pdev->dev,
> +				"timing %s: rate not increasing\n",
> +				child->name);

I don't believe there's any guaranteed node enumeration order. If the
driver needs the child nodes sorted, it should sort them itself.

> +static const struct of_device_id tegra_car_of_match[] = {
> +	{ .compatible = "nvidia,tegra124-car" },
> +	{}
> +};
> +
> +static const struct of_device_id tegra_mc_of_match[] = {
> +	{ .compatible = "nvidia,tegra124-mc" },
> +	{}
> +};

It would be better if this driver explicitly called into the driver for
other modules, rather than directly touching their registers.
