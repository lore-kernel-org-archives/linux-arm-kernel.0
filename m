From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 13 Jan 2017 12:11:44 +0000
Subject: [PATCH v7 09/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <1484147199-4267-10-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-10-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20170113121144.GE20837@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 11:06:33PM +0800, Hanjun Guo wrote:
> For devices connecting to ITS, it needs dev id to identify itself, and
> this dev id is represented in the IORT table in named component node
> [1] for platform devices, so in this patch we will scan the IORT to
> retrieve device's dev id.
> 
> For named components we know that there are always two steps
> involved (second optional):
> 
> (1) Retrieve the initial id (this may well provide the final mapping)
> (2) Map the id (optional if (1) represents the map type we need), this
>     is needed for use cases such as NC (named component) -> SMMU -> ITS
>     mappings.
> 
> we have API iort_node_get_id() for step (1) above and
> iort_node_map_rid() for step (2), so create a wrapper
> iort_node_map_platform_id() to retrieve the dev id.
> 
> [1]: https://static.docs.arm.com/den0049/b/DEN0049B_IO_Remapping_Table.pdf

This patch should be split and IORT changes should be squashed with
patch 10.

> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Suggested-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/acpi/arm64/iort.c                     | 56 +++++++++++++++++++++++++++
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |  4 +-
>  include/linux/acpi_iort.h                     |  8 ++++
>  3 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 069a690..95fd20b 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -30,6 +30,7 @@
>  #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
>  #define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
>  				(1 << ACPI_IORT_NODE_SMMU_V3))
> +#define IORT_TYPE_ANY		(IORT_MSI_TYPE | IORT_IOMMU_TYPE)
>  
>  struct iort_its_msi_chip {
>  	struct list_head	list;
> @@ -406,6 +407,34 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
>  	return NULL;
>  }
>  
> +static
> +struct acpi_iort_node *iort_node_map_platform_id(struct acpi_iort_node *node,
> +						 u32 *id_out, u8 type_mask,
> +						 int index)
> +{
> +	struct acpi_iort_node *parent;
> +	u32 id;
> +
> +	/* step 1: retrieve the initial dev id */
> +	parent = iort_node_get_id(node, &id, IORT_TYPE_ANY, index);
> +	if (!parent)
> +		return NULL;
> +
> +	/*
> +	 * optional step 2: map the initial dev id if its parent is not
> +	 * the target type we wanted, map it again for the use cases such
> +	 * as NC (named component) -> SMMU -> ITS. If the type is matched,
> +	 * return the parent pointer directly.
> +	 */
> +	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
> +		parent = iort_node_map_id(parent, id, id_out, type_mask);
> +	else
> +		if (id_out)

Remove this pointer check.

> +			*id_out = id;
> +
> +	return parent;
> +}
> +
>  static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
>  {
>  	struct pci_bus *pbus;
> @@ -444,6 +473,33 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>  }
>  
>  /**
> + * iort_pmsi_get_dev_id() - Get the device id for a device
> + * @dev: The device for which the mapping is to be done.
> + * @dev_id: The device ID found.
> + *
> + * Returns: 0 for successful find a dev id, errors otherwise

Nit: -ENODEV on error

> + */
> +int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
> +{
> +	int i;
> +	struct acpi_iort_node *node;
> +
> +	if (!iort_table)
> +		return -ENODEV;

I do not think this iort_table check is needed.

> +	node = iort_find_dev_node(dev);
> +	if (!node)
> +		return -ENODEV;
> +
> +	for (i = 0; i < node->mapping_count; i++) {
> +		if(iort_node_map_platform_id(node, dev_id, IORT_MSI_TYPE, i))
                  ^

Nit: Missing a space.

Lorenzo

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
> index ebe933e..e801fc0 100644
> --- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> @@ -15,6 +15,7 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/acpi_iort.h>
>  #include <linux/device.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
> @@ -56,7 +57,8 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
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
> index 77e0809..ef99fd52 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -33,6 +33,7 @@
>  void acpi_iort_init(void);
>  bool iort_node_match(u8 type);
>  u32 iort_msi_map_rid(struct device *dev, u32 req_id);
> +int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>  struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
>  /* IOMMU interface */
>  void iort_set_dma_mask(struct device *dev);
> @@ -42,9 +43,16 @@ static inline void acpi_iort_init(void) { }
>  static inline bool iort_node_match(u8 type) { return false; }
>  static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>  { return req_id; }
> +
>  static inline struct irq_domain *iort_get_device_domain(struct device *dev,
>  							u32 req_id)
>  { return NULL; }
> +
> +static inline int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
> +{
> +	return -ENODEV;
> +}
> +
>  /* IOMMU interface */
>  static inline void iort_set_dma_mask(struct device *dev) { }
>  static inline
> -- 
> 1.9.1
> 
