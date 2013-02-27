From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Feb 2013 11:53:40 -0700
Subject: [PATCH V2 1/4] ARM: tegra: pmc: convert PMC driver to support
 DT only
In-Reply-To: <1361932087-13372-2-git-send-email-josephl@nvidia.com>
References: <1361932087-13372-1-git-send-email-josephl@nvidia.com>
 <1361932087-13372-2-git-send-email-josephl@nvidia.com>
Message-ID: <512E5634.4060106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 07:28 PM, Joseph Lo wrote:
> The Tegra kernel only support boot from DT now. Clean up the PMC driver
> to support DT only, that includes:
> 
> * remove the ifdef of CONFIG_OF
> * replace the static mapping of PMC addr to map from DT

> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c

>  static inline void tegra_pmc_writel(u32 val, u32 reg)
>  {
> -	writel(val, IO_ADDRESS(TEGRA_PMC_BASE + reg));
> +	writel(val, (tegra_pmc_base + reg));

There are redundant () there.

> +static void tegra_pmc_parse_dt(void)
>  {
> +	struct device_node *np;
>  
> +	np = of_find_matching_node(NULL, matches);
> +	if (np) {

Why not:

BUG_ON(!np);

That way, you can get rid of if if/else blocks, and remove one level of
indentation throughout this function. I already mentioned this internally...
