From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 04 Aug 2015 15:04:53 +0100
Subject: [PATCH v4 09/10] PCI: ACPI: Bind GIC MSI frame to PCI host bridge
In-Reply-To: <1438164539-29256-10-git-send-email-hanjun.guo@linaro.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
 <1438164539-29256-10-git-send-email-hanjun.guo@linaro.org>
Message-ID: <55C0C685.4000400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/15 11:08, Hanjun Guo wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> This patch introduces pci_host_bridge_acpi_msi_domain(), which queries
> a GIC MSI irq-domain token and use it to retrieve an irq_domain with
> DOMAIN_BUS_PCI_MSI bus type, and bind it to PCI host-bridge.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/pci/pci-acpi.c   | 18 ++++++++++++++++++
>  drivers/pci/probe.c      |  3 +++
>  include/linux/pci-acpi.h |  4 ++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 314a625..5f11653 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/init.h>
> +#include <linux/irqdomain.h>
>  #include <linux/pci.h>
>  #include <linux/pci_hotplug.h>
>  #include <linux/module.h>
> @@ -16,6 +17,7 @@
>  #include <linux/pci-acpi.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
> +#include <acpi/acpi_gic.h>
>  #include "pci.h"
>  
>  /*
> @@ -681,6 +683,22 @@ static bool pci_acpi_bus_match(struct device *dev)
>  	return dev_is_pci(dev);
>  }
>  
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus)
> +{
> +	struct irq_domain *d = NULL;
> +	void *token = acpi_gic_get_msi_token(&bus->dev);

Do you see why I positively *hate* having hardware details in generic
layers? They propagate everywhere...

> +
> +	if (token)
> +		d = irq_find_matching_host(token, DOMAIN_BUS_PCI_MSI);
> +
> +	if (!d)
> +		pr_debug("Fail to find domain for MSI\n");
> +
> +	return d;
> +}
> +#endif /*CONFIG_GENERIC_MSI_IRQ_DOMAIN*/
> +
>  static struct acpi_bus_type acpi_pci_bus = {
>  	.name = "PCI",
>  	.match = pci_acpi_bus_match,
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a7afeac..8c1204c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/cpumask.h>
>  #include <linux/pci-aspm.h>
> +#include <linux/pci-acpi.h>
>  #include <asm-generic/pci-bridge.h>
>  #include "pci.h"
>  
> @@ -670,6 +671,8 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
>  	 * should be called from here.
>  	 */
>  	d = pci_host_bridge_of_msi_domain(bus);
> +	if (!d)
> +		d = pci_host_bridge_acpi_msi_domain(bus);
>  
>  	return d;
>  }
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index a965efa..766d045 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -77,6 +77,8 @@ static inline void acpiphp_remove_slots(struct pci_bus *bus) { }
>  static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>  #endif
>  
> +struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
> +
>  extern const u8 pci_acpi_dsm_uuid[];
>  #define DEVICE_LABEL_DSM	0x07
>  #define RESET_DELAY_DSM		0x08
> @@ -85,6 +87,8 @@ extern const u8 pci_acpi_dsm_uuid[];
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> +static inline struct irq_domain *
> +pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
>  #endif	/* CONFIG_ACPI */
>  
>  #ifdef CONFIG_ACPI_APEI
> 

Once you solve the HW abstraction issue, this will be OK.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
