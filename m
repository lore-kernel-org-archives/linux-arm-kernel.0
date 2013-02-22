From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Feb 2013 11:32:40 -0700
Subject: [PATCH 1/4] ARM: tegra: pmc: convert PMC driver to support DT only
In-Reply-To: <1361515491-16199-2-git-send-email-josephl@nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <1361515491-16199-2-git-send-email-josephl@nvidia.com>
Message-ID: <5127B9C8.3050600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2013 11:44 PM, Joseph Lo wrote:
> The Tegra kernel only support boot from DT now. Clean up the PMC driver
> to support DT only, that includes:
> 
> * remove the ifdef of CONFIG_OF
> * replace the static mapping of PMC addr to map from DT

> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c

>  static inline u32 tegra_pmc_readl(u32 reg)
>  {
> -	return readl(IO_ADDRESS(TEGRA_PMC_BASE + reg));
> +	return readl_relaxed(tegra_pmc_base + reg);

The change from readl to readl_relaxed is definitely unrelated to
cleaning up DT support. It needs to be a separate patch, and needs to be
mentioned in the commit description.

> +static void tegra_pmc_parse_dt(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, matches);
> +	if (np) {

Here, if (!np) BUG(); would be simpler, and allow the rest of the
function not to be indented.

>  void __init tegra_pmc_init(void)
>  {
...
> +	if (!of_have_populated_dt())
> +		return;

That won't ever be true.
