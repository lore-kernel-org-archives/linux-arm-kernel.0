From: Suravee.Suthikulpanit@amd.com (Suthikulpanit, Suravee)
Date: Sat, 16 May 2015 15:12:05 +0000
Subject: [V4 PATCH 3/6] pci: Generic function for setting up PCI device
 DMA coherency
In-Reply-To: <3954735.qeaTp8qOcM@vostro.rjw.lan>
Message-ID: <D17CC7D6.1AFD3%suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 5/15/15, 18:59, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

>On Friday, May 15, 2015 04:23:11 PM Suravee Suthikulpanit wrote:
>> This patch refactors of_pci_dma_configure() into a more generic
>> pci_dma_configure(), which can be reused by non-OF code.
>> Then, it adds support for setting up PCI device DMA coherency from
>> ACPI _CCA object that should normally be specified in the DSDT node
>> of its PCI host bridge..
>> 
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
>> CC: Murali Karicheri <m-karicheri2@ti.com>
>> ---
>>  drivers/of/of_pci.c    | 20 --------------------
>>  drivers/pci/probe.c    | 35 +++++++++++++++++++++++++++++++++--
>>  include/linux/of_pci.h |  3 ---
>>  3 files changed, 33 insertions(+), 25 deletions(-)
>> 
>> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
>> index 5751dc5..b66ee4e 100644
>> --- a/drivers/of/of_pci.c
>> +++ b/drivers/of/of_pci.c
>> @@ -117,26 +117,6 @@ int of_get_pci_domain_nr(struct device_node *node)
>>  }
>>  EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>>  
>> -/**
>> - * of_pci_dma_configure - Setup DMA configuration
>> - * @dev: ptr to pci_dev struct of the PCI device
>> - *
>> - * Function to update PCI devices's DMA configuration using the same
>> - * info from the OF node of host bridge's parent (if any).
>> - */
>> -void of_pci_dma_configure(struct pci_dev *pci_dev)
>> -{
>> -	struct device *dev = &pci_dev->dev;
>> -	struct device *bridge = pci_get_host_bridge_device(pci_dev);
>> -
>> -	if (!bridge->parent)
>> -		return;
>> -
>> -	of_dma_configure(dev, bridge->parent->of_node);
>> -	pci_put_host_bridge_device(bridge);
>> -}
>> -EXPORT_SYMBOL_GPL(of_pci_dma_configure);
>> -
>>  #if defined(CONFIG_OF_ADDRESS)
>>  /**
>>   * of_pci_get_host_bridge_resources - Parse PCI host bridge resources
>>from DT
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 6675a7a..3c6f2e5 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -6,12 +6,14 @@
>>  #include <linux/delay.h>
>>  #include <linux/init.h>
>>  #include <linux/pci.h>
>> -#include <linux/of_pci.h>
>> +#include <linux/of_device.h>
>>  #include <linux/pci_hotplug.h>
>>  #include <linux/slab.h>
>>  #include <linux/module.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/pci-aspm.h>
>> +#include <linux/acpi.h>
>> +#include <linux/property.h>
>>  #include <asm-generic/pci-bridge.h>
>>  #include "pci.h"
>>  
>> @@ -1508,6 +1510,35 @@ static void pci_init_capabilities(struct pci_dev
>>*dev)
>>  	pci_enable_acs(dev);
>>  }
>>  
>> +/**
>> + * pci_dma_configure - Setup DMA configuration
>> + * @pci_dev: ptr to pci_dev struct of the PCI device
>> + *
>> + * Function to update PCI devices's DMA configuration using the same
>> + * info from the OF node or ACPI node of host bridge's parent (if any).
>> + */
>> +static void pci_dma_configure(struct pci_dev *pci_dev)
>> +{
>> +	struct device *dev = &pci_dev->dev;
>> +	struct device *bridge = pci_get_host_bridge_device(pci_dev);
>> +	struct device *host = bridge->parent;
>> +	struct acpi_device *adev;
>> +
>> +	if (!host)
>> +		return;
>> +
>> +	if (acpi_disabled) {
>> +		of_dma_configure(dev, host->of_node);
>
>I'd rather do
>
>	if (IS_ENABLED(CONFIG_OF) && host->of_node) {
>		of_dma_configure(dev, host->of_node);
>	} else {
>		struct acpi_device *adev = ACPI_COMPANION(host);
>
>		if (adev && acpi_dma_is_supported(adev)) {

Ok, I?ll update this.

>
>> +	} else if (has_acpi_companion(host)) {
>> +		adev = acpi_node(host->fwnode);
>> +		if (acpi_dma_is_supported(adev))
>> +			arch_setup_dma_ops(dev, 0, 0, NULL,
>> +					   acpi_dma_is_coherent(adev));
>> +	}
>> +
>> +	pci_put_host_bridge_device(bridge);
>> +}
>> +
>>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>>  {
>>  	int ret;
>> @@ -1521,7 +1552,7 @@ void pci_device_add(struct pci_dev *dev, struct
>>pci_bus *bus)
>>  	dev->dev.dma_mask = &dev->dma_mask;
>>  	dev->dev.dma_parms = &dev->dma_parms;
>>  	dev->dev.coherent_dma_mask = 0xffffffffull;
>> -	of_pci_dma_configure(dev);
>> +	pci_dma_configure(dev);
>
>Also I'm not quite sure if that's actually OK.
>
>We should be handling the DMA setup on x86 in the ACPI case already
>without it.
>Or is this a NOP on x86?

You are correct. x86 doesn?t implement the arch_setup_dma_ops().
Therefore, this is a NOP on x86.

Thanks,

Suravee
