From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 19 Dec 2011 07:27:28 +0100
Subject: [PATCH v2 1/2] [RFC] ARM: IOMMU: Tegra20: iommu_ops for GART
 driver
In-Reply-To: <1323954690-7000-2-git-send-email-hdoyu@nvidia.com>
References: <1323954690-7000-1-git-send-email-hdoyu@nvidia.com><1323954690-7000-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <20111219.082728.2074123164274991497.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

One question is inlined below:

From: Hiroshi Doyu <hdoyu@nvidia.com>
Subject: [PATCH v2 1/2] [RFC] ARM: IOMMU: Tegra20: iommu_ops for GART driver
Date: Thu, 15 Dec 2011 14:11:29 +0100
Message-ID: <1323954690-7000-2-git-send-email-hdoyu@nvidia.com>

> Tegra 20 IOMMU H/W, GART (Graphics Address Relocation Table). This
> patch implements struct iommu_ops for GART for the upper IOMMU API.
>
> This H/W module supports only single virtual address space(domain),
> and manages a single level 1-to-1 mapping H/W translation page table.
>
> Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> ---
>  drivers/iommu/Kconfig      |   11 +
>  drivers/iommu/Makefile     |    1 +
>  drivers/iommu/tegra-gart.c |  451 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 463 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/iommu/tegra-gart.c
>
....
> +
> +struct gart_device {
> +       void __iomem            *regs;
> +       u32                     *savedata;
> +       u32                     page_count; /* total remappable size */
> +       dma_addr_t              iovmm_base; /* offset to apply to vmm_area */
> +       spinlock_t              pte_lock; /* for pagetable */
> +       struct list_head        client;
> +       spinlock_t              client_lock; /* for client list */
> +       struct device           *dev;
> +};
> +
> +static struct gart_device *gart_handle; /* unique for a system */
			      ^^^^^^^^^^^
.....
> +
> +static int gart_iommu_domain_init(struct iommu_domain *domain)
> +{
> +       domain->priv = gart_handle;
	  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +       pr_debug("gart@%p\n", gart_handle);
> +       return 0;
> +}

In the above, the global pointer is used to pass gart_device to set it
in dmain->priv. It works with a single gart_device, but not with
multiple gart_devices. This is too bad, I know;). I guess that this
can be solved with device tree info where a client device is set as a
child of gart_device at device registration. Is this the right way
from IOMMU API POV?

 for (i = 0; i < ARRAY_SIZE(dmaapi_dummy_device); i++) {
	 int err;
	 struct platform_device *pdev = &dmaapi_dummy_device[i];

	 pdev->dev.platform_data = (void *)dummy_hwgrp_map[i];
	 pdev->dev.parent = &tegra_gart_device;
			    ^^^^^^^^^^^^^^^^^^^
	 err = platform_device_register(pdev);
