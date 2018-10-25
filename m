From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Oct 2018 17:09:47 +0200
Subject: [PATCH 3/3] iommu/tegra194_smmu: Add Tegra194 SMMU driver
In-Reply-To: <1540334347-7178-4-git-send-email-vdumpa@nvidia.com>
References: <1540334347-7178-1-git-send-email-vdumpa@nvidia.com>
 <1540334347-7178-4-git-send-email-vdumpa@nvidia.com>
Message-ID: <20181025150947.GN21521@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 03:39:07PM -0700, Krishna Reddy wrote:
> Tegra194 SMMU driver supports Dual ARM SMMU configuration
> supported in Tegra194 SOC.
> The IOVA accesses from HW devices are interleaved across two
> ARM SMMU devices.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  drivers/iommu/Makefile        |   1 +
>  drivers/iommu/tegra194-smmu.c | 201 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 202 insertions(+)
>  create mode 100644 drivers/iommu/tegra194-smmu.c
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index a158a68..84da9f9 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_OMAP_IOMMU_DEBUG) += omap-iommu-debug.o
>  obj-$(CONFIG_ROCKCHIP_IOMMU) += rockchip-iommu.o
>  obj-$(CONFIG_TEGRA_IOMMU_GART) += tegra-gart.o
>  obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
> +obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra194-smmu.o
>  obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o

I think we'll need a new Kconfig option for this. This is completely
different from the old Tegra SMMU, and as it is, it will build the
Tegra194 SMMU driver all the way back to Tegra30 where no such thing
exists.

Also, as the 0-day builder already reported there are dependencies that
aren't properly modelled and make the build fail under some
configurations. I think we'll want something like this:

	config ARM_SMMU_TEGRA
		depends on ARM64 && MMU && ARCH_TEGRA
		select IOMMU_API
		select IOMMU_IO_PGTABLE_LPAE
		help
			...

That should pull in the dependency as necessary.

It might also be worth considering to move the Kconfig and Makefile
entries closer to the ARM SMMU entries to clarify that they're related.

> diff --git a/drivers/iommu/tegra194-smmu.c b/drivers/iommu/tegra194-smmu.c
> new file mode 100644
> index 0000000..02109c8
> --- /dev/null
> +++ b/drivers/iommu/tegra194-smmu.c
> @@ -0,0 +1,201 @@
> +/*
> + * IOMMU API for Tegra194 Dual ARM SMMU implementation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Copyright (C) 2018 Nvidia Corporation
> + *
> + * Author: Krishna Reddy <vdumpa@nvidia.com>
> + */
> +
> +#define pr_fmt(fmt) "tegra194-smmu: " fmt
> +
> +#include "arm-smmu-common.h"
> +
> +/* Tegra194 has three SMMU instances.
> + * Two of the SMMU instances are used by specific set of devices to
> + * access IOVA addresses in interleaved fashion.
> + * The 3rd SMMU instance is used alone by specific set of devices.
> + * This driver only support Dual SMMU configuration which interleaves
> + * IOVA accesses across two SMMU's.
> + * For the 3rd SMMU instance, Default ARM SMMU driver is used.
> + */
> +#define NUM_SMMU_INSTANCES 2

Can we parameterize this at runtime? I suspect that this is something
that could show up in a future chip as well but with a different number
of instances. If we parameterize that, supporting the next generation
may be almost automatic.

That said, it's probably fine to do that in a follow-up if indeed some
future chip requires it.

> +
> +struct tegra194_smmu {
> +	void __iomem			*bases[NUM_SMMU_INSTANCES];
> +	struct arm_smmu_device		*smmu;
> +};
> +
> +static struct tegra194_smmu t194_smmu;

Why the global variable here? It seems to me like the only reason for
its existence is to prevent multiple instances of the dual SMMU. I don't
think that's something we need to worry about. We should expect the DT
to contain the correct number of SMMU instances.

> +
> +static inline void writel_one(u32 val, volatile void __iomem *virt_addr)
> +{
> +	writel(val, virt_addr);
> +}
> +
> +static inline void writel_relaxed_one(u32 val,
> +			volatile void __iomem *virt_addr)
> +{
> +	writel_relaxed(val, virt_addr);
> +}
> +
> +#define WRITEL_FN(fn, call, type) \
> +static inline void fn(type val, volatile void __iomem *virt_addr) \
> +{ \
> +	int i; \
> +	u32 offset = abs(virt_addr - t194_smmu.bases[0]); \
> +	for (i = 0; i < NUM_SMMU_INSTANCES; i++) \
> +		call(val, t194_smmu.bases[i] + offset); \
> +}

Ah... the global variable is also used here. The fact that we need this
strange construct here indicates to me that this isn't properly factored
out into library code yet.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181025/f0a20c0f/attachment-0001.sig>
