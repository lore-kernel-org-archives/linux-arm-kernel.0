From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 29 Mar 2017 11:14:00 +0100
Subject: [PATCH v9 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <1488890410-15503-11-git-send-email-guohanjun@huawei.com>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
 <1488890410-15503-11-git-send-email-guohanjun@huawei.com>
Message-ID: <20170329101400.GA10807@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun, Marc,

On Tue, Mar 07, 2017 at 08:40:05PM +0800, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> For devices connecting to ITS, the devices need to identify themself
> through a dev id; this dev id is represented in the IORT table in named
> component node [1] for platform devices, so this patch adds code that
> scans the IORT table to retrieve the devices' dev id.
> 
> Leveraging the iort_node_map_platform_id() IORT API, add a new function
> call, iort_pmsi_get_dev_id() and use it in its_pmsi_prepare() to allow
> retrieving dev id in ACPI platforms.
> 
> [1]: https://static.docs.arm.com/den0049/b/DEN0049B_IO_Remapping_Table.pdf
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> [lorenzo.pieralisi at arm.com: rewrote commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Ming Lei <ming.lei@canonical.com>
> Tested-by: Wei Xu <xuwei5@hisilicon.com>
> Tested-by: Sinan Kaya <okaya@codeaurora.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/acpi/arm64/iort.c                     | 24 ++++++++++++++++++++++++
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |  3 ++-
>  include/linux/acpi_iort.h                     |  5 +++++
>  3 files changed, 31 insertions(+), 1 deletion(-)

To simplify merging ACPI/IRQCHIP changes via different trees it
would be good to split this patch; I am not sure what's the best
way of handling it though given that we would end up in a merge
ordering dependency anyway (ie we can create an empty stub
for iort_pmsi_get_dev_id() but that would create a dependency
between ARM64 and irqchip trees anyway).

Please let me know what's your preferred way of handling this.

Thanks,
Lorenzo

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 83cd59d..fb95ceb 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -468,6 +468,30 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>  }
>  
>  /**
> + * iort_pmsi_get_dev_id() - Get the device id for a device
> + * @dev: The device for which the mapping is to be done.
> + * @dev_id: The device ID found.
> + *
> + * Returns: 0 for successful find a dev id, -ENODEV on error
> + */
> +int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
> +{
> +	int i;
> +	struct acpi_iort_node *node;
> +
> +	node = iort_find_dev_node(dev);
> +	if (!node)
> +		return -ENODEV;
> +
> +	for (i = 0; i < node->mapping_count; i++) {
> +		if (iort_node_map_platform_id(node, dev_id, IORT_MSI_TYPE, i))
> +			return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +/**
>   * iort_dev_find_its_id() - Find the ITS identifier for a device
>   * @dev: The device.
>   * @req_id: Device's requester ID
> diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> index e4ba9f4..e801fc0 100644
> --- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> @@ -57,7 +57,8 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
>  
>  	msi_info = msi_get_domain_info(domain->parent);
>  
> -	ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
> +	ret = dev->of_node ? of_pmsi_get_dev_id(domain, dev, &dev_id) :
> +		iort_pmsi_get_dev_id(dev, &dev_id);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 77e0809..d074c77 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -34,6 +34,7 @@
>  bool iort_node_match(u8 type);
>  u32 iort_msi_map_rid(struct device *dev, u32 req_id);
>  struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
> +int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>  /* IOMMU interface */
>  void iort_set_dma_mask(struct device *dev);
>  const struct iommu_ops *iort_iommu_configure(struct device *dev);
> @@ -45,6 +46,10 @@ static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>  static inline struct irq_domain *iort_get_device_domain(struct device *dev,
>  							u32 req_id)
>  { return NULL; }
> +
> +static inline int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
> +{ return -ENODEV; }
> +
>  /* IOMMU interface */
>  static inline void iort_set_dma_mask(struct device *dev) { }
>  static inline
> -- 
> 1.7.12.4
> 
