From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 16:53:17 -0700
Subject: [PATCHv4 3/7] iommu/tegra: smmu: Register IOMMU'able devices
 dynamically
In-Reply-To: <1384158718-4756-4-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
 <1384158718-4756-4-git-send-email-hdoyu@nvidia.com>
Message-ID: <5282BF6D.8070801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> platform_devices are registered as IOMMU'able dynamically via
> add_device() and remove_device().
> 
> Tegra SMMU can have multiple address spaces(AS). IOMMU'able devices
> can belong to one of them. Multiple IOVA maps are created at boot-up,
> which can be attached to devices later. We reserve 2 of them for
> static assignment, AS[0] for system default, AS[1] for AHB clusters as
> protected domain from others, where there are many traditional
> pheripheral devices like USB, SD/MMC. They should be isolated from
> some smart devices like host1x for system robustness. Even if smart
> devices behaves wrongly, the traditional devices(SD/MMC, USB) wouldn't
> be affected, and the system could continue most likely. DMA API(ARM)
> needs ARM_DMA_USE_IOMMU to be enabled.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> +enum {
> +	SYSTEM_DEFAULT,
> +	SYSTEM_PROTECTED,
> +};
> +
...
> +static int smmu_iommu_add_device(struct device *dev)
...
> +	switch (swgroups) {
> +	case TEGRA_SWGROUP_BIT(PPCS):
> +		map = smmu_handle->map[SYSTEM_PROTECTED];
> +		break;
> +	default:
> +		map = smmu_handle->map[SYSTEM_DEFAULT];
> +		break;
> +	}

As I think I mentioned before, this hard-codes some valid ASIDs.
However, the number of valid ASIDs is configured dynamically from DT, in
tegra_smmu_probe(), via:

static int tegra_smmu_probe(struct platform_device *pdev)
...
        int i, asids, err = 0;
...
        if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
                return -ENODEV;
...
        smmu->num_as = asids;

Shouldn't tegra_smmu_probe() validate that asids >= SYSTEM_PROTECTED, or
similar?
