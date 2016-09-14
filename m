From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Sep 2016 16:45:11 +0100
Subject: [RFC PATCH v2 05/11] ACPI: platform: setup MSI domain for ACPI
 based platform device
In-Reply-To: <1473862879-7769-6-git-send-email-guohanjun@huawei.com>
References: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
 <1473862879-7769-6-git-send-email-guohanjun@huawei.com>
Message-ID: <57D97087.5040703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/16 15:21, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> With the platform msi domain created, we can set up the msi domain
> for a platform device when it's probed.
> 
> This patch introduces acpi_configure_msi_domain(), which retrieves
> the domain from iort and set it to platform device.
> 
> As some platform devices such as an irqchip needs the msi irqdomain
> to be the interrupt parent domain, we need to get irqdomain before
> platform device is probed.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/arm64/iort.c   |  5 ++++-
>  drivers/base/platform-msi.c | 15 ++++++++++++++-
>  drivers/base/platform.c     |  2 ++
>  include/linux/msi.h         |  1 +
>  4 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 13a1905..bccd3cc 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -478,6 +478,7 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
>  {
>  	struct fwnode_handle *handle;
>  	int its_id;
> +	enum irq_domain_bus_token bus_token;
>  
>  	if (iort_dev_find_its_id(dev, req_id, 0, &its_id))
>  		return NULL;
> @@ -486,7 +487,9 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
>  	if (!handle)
>  		return NULL;
>  
> -	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
> +	bus_token = dev_is_pci(dev) ?
> +			DOMAIN_BUS_PCI_MSI : DOMAIN_BUS_PLATFORM_MSI;
> +	return irq_find_matching_fwnode(handle, bus_token);
>  }
>  
>  static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 279e539..f6eae18 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -17,8 +17,8 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/acpi_iort.h>
>  #include <linux/device.h>
> -#include <linux/idr.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/msi.h>
> @@ -416,3 +416,16 @@ int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  
>  	return err;
>  }
> +
> +int acpi_configure_msi_domain(struct device *dev)
> +{
> +	struct irq_domain *d = NULL;
> +
> +	d = iort_get_device_domain(dev, 0);

This looks completely wrong. Why RID 0? As far as I can see, 0 is not a
special value, and could be something else.

> +	if (d) {
> +		dev_set_msi_domain(dev, d);
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}

I really hate this, as the platform MSI code is intentionally free of
any firmware reference. This should live in the ACPI code.

> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 6482d47..ea01a37 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -24,6 +24,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/idr.h>
>  #include <linux/acpi.h>
> +#include <linux/msi.h>
>  #include <linux/clk/clk-conf.h>
>  #include <linux/limits.h>
>  #include <linux/property.h>
> @@ -500,6 +501,7 @@ struct platform_device *platform_device_register_full(
>  	pdev->dev.parent = pdevinfo->parent;
>  	pdev->dev.fwnode = pdevinfo->fwnode;
>  
> +	acpi_configure_msi_domain(&pdev->dev);

It feels odd to put this in the generic code, while you could perfectly
put the call into acpi_platform.c and keep the firmware stuff away from
the generic code.

>  	if (pdevinfo->dma_mask) {
>  		/*
>  		 * This memory isn't freed when the device is put,
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index e8c81fb..1e93a78 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -308,6 +308,7 @@ int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
>  			      unsigned int nvec);
>  void *platform_msi_get_host_data(struct irq_domain *domain);
> +int acpi_configure_msi_domain(struct device *dev);
>  #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
>  
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
