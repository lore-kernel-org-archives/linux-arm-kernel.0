From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Jul 2013 14:33:02 -0600
Subject: [PATCH v2 19/22] iommu/tegra: smmu: Workaround PCIe IOMMU'able
In-Reply-To: <1373021097-32420-20-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-20-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E850FE.4000506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Make PCIe work as it is. IOMMU support can be implemented later. We
> need the same kind of registration framework for PCIe as platform_bus
> does currently.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>  	for_each_set_bit(i, (unsigned long *)&map,
>  			 sizeof(map) * BITS_PER_BYTE) {
> +		if (i == TEGRA_SWGROUP_AFI) /* FIXME: IOMMU'able PCIe */
> +			continue;

Isn't it just a fluke that TEGRA_SWGROUP_AFI is defined identically for
the SoCs that we support upstream?

If this change is required, don't we need it before the SMMU starts
enabling itself for clients, so that git bisect is maintained?

By deferring the question of registering the IOMMU for PCIe, ar we going
to require non-backwards-compatible changes to DT for the PCIe
controller at some later point in time?
