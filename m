From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Jul 2013 14:40:55 -0600
Subject: [PATCH v2 20/22] iommu/tegra: smmu: Get "nvidia,memory-client"
 from DT
In-Reply-To: <1373021097-32420-21-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-21-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E852D7.4070302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> This provides the info about which swgroups a device belongs to. This
> info is passed from DT. This is necessary for the unified SMMU driver
> among Tegra SoCs since each has different H/W accelerators.

> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt

> @@ -11,6 +11,7 @@ Required properties:
>  - nvidia,swgroups: A bitmap of supported HardWare Accelerators(HWA).
>    Each bit represents one swgroup. The assignments may be found in header
>    file <dt-bindings/memory/tegra-swgroup.h>.
> +- nvidia,memory-client: Indicates which swgroups a device belongs to.

The list of properties you're adding to is for the SMMU node itself. If
specific properties need to exist in SMMU client nodes, you need to
create a separate section/list in the document for that. For example,
see the clear distinction between sections (1) and (2) in
Documentation/devicetree/bindings/gpio/gpio.txt.

What is the format/size of data in this property?

>From the example below:

> +			nvidia,memory-client = <TEGRA_SWGROUP_NV
> +						TEGRA_SWGROUP_NV2>;

... it seems like multiple entries are allowed. Should the property be
named "nvidia,memory-clients" instead (a plural)? "memory-clients" seems
like new terminology that exists just for this property. Is "swgroups"
the correct term here?

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> +static u64 smmu_of_get_memory_client(struct device *dev)

> +	for (i = 0; i < bytes / sizeof(u32); i++, prop++)
> +		swgroup |= 1ULL << be32_to_cpup(prop);

Oh, so it's a list of bit numbers instead of a list of masks. Definitely
good to specify in the binding doc!
