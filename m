From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 17:03:31 -0600
Subject: [PATCH v2 02/22] ARM: tegra: Populate AHB/IOMMU earlier than
 others
In-Reply-To: <1373021097-32420-3-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E5D143.3000602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Populate AHB/IOMMU earlier than others. IOMMU depends on AHB. IOMMU
> needs to be instanciated earlier than others so that IOMMU can
> register other platform devices as IOMMU'able. Once IOMMU is
> populated, IOMMU/AHB nodes are detached to prevent another
> registeration.

Hmmm. I'm still in two minds about this. If just the IOMMU was needed,
then this wouldn't be too bad. But then there's the dependency on the
AHB device too. And in general, there could be, say, a dependency on a
SoC power-controller, clock controller, reset module, etc. This could
become a huge slippery slope.

Modelling the IOMMU as an explicit bus with the bus-master-capable
devices underneath it would make everything work automatically...

> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c

> +static void tegra_of_platform_populate_iommu(void)
> +{
> +	int i;
> +	struct platform_device *pdev;
> +	const char * const path[] = {"/ahb", "/iommu", };
> +
> +	for (i = 0; i < ARRAY_SIZE(path); i++) {
> +		struct device_node *np;
> +
> +		np  = of_find_node_by_path(path[i]);

I think this should at least look up the nodes by compatible value. See
how e.g. mach-tegra/pmc.c finds the right DT node.
