From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 16:58:56 -0700
Subject: [PATCHv4 3/7] iommu/tegra: smmu: Register IOMMU'able devices
 dynamically
In-Reply-To: <1384158718-4756-4-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
 <1384158718-4756-4-git-send-email-hdoyu@nvidia.com>
Message-ID: <5282C0C0.6010708@wwwdotorg.org>
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

> +static int smmu_iommu_add_device(struct device *dev)
> +{
> +	int err = -EPROBE_DEFER;
> +	u64 swgroups;
> +	struct dma_iommu_mapping *map = NULL;
> +
> +	swgroups = smmu_of_get_memory_client(dev);

BTW, that function doesn't seem to exist in this patch series nor
next-20131107. This call is removed in patch 5/7, but this does make the
series non-bisectable.
