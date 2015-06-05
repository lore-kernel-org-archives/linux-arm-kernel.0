From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Fri, 5 Jun 2015 11:53:38 +0800
Subject: [PATCH v2 1/4] ARM/PCI: remove align_resource callback in
 pcibios_align_resource
In-Reply-To: <55705036.7030004@arm.com>
References: <1433320542-49576-1-git-send-email-wangzhou1@hisilicon.com>
 <1433320542-49576-2-git-send-email-wangzhou1@hisilicon.com>
 <55705036.7030004@arm.com>
Message-ID: <55711D42.1040507@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/6/4 21:18, James Morse wrote:
> On 03/06/15 09:35, Zhou Wang wrote:
>> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
>> index fcbbbb1..47588dc 100644
>> --- a/arch/arm/kernel/bios32.c
>> +++ b/arch/arm/kernel/bios32.c
>> @@ -468,7 +468,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>>  		sys->busnr   = busnr;
>>  		sys->swizzle = hw->swizzle;
>>  		sys->map_irq = hw->map_irq;
>> -		sys->align_resource = hw->align_resource;
>>  		INIT_LIST_HEAD(&sys->resources);
>>  
>>  		if (hw->private_data)
>> @@ -597,9 +596,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>>  
>>  	start = (start + align - 1) & ~(align - 1);
>>  
>> -	if (sys->align_resource)
>> -		return sys->align_resource(dev, res, start, size, align);
>> -
>>  	return start;
>>  }
> 
> This leaves both 'sys' and 'dev' in this function as unused variables.
> Please remove them too.
> 

Right, will do in next version.

>> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
>> index 1ab8635..155d05f 100644
>> --- a/drivers/pci/host/pci-mvebu.c
>> +++ b/drivers/pci/host/pci-mvebu.c
>> @@ -22,6 +22,8 @@
>>  #include <linux/of_pci.h>
>>  #include <linux/of_platform.h>
>>  
>> +#include "../pci.h" /* HACK to see pci_find_host_bridge */
>> +
> 
> Wouldn't it be better to promote pci_find_host_bridge to be declared in
> include/linux/pci.h instead?
> 
> 
> Thanks,
> 
> James
>

The files which use pci_find_host_bridge are all under drivers/pci, so maybe putting
in drivers/pci/pci.h is better ?

Many thanks for reviewing?
Zhou

>>  /*
>>   * PCIe unit register offsets.
>>   */
>> @@ -751,27 +753,20 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
>>  	return 1;
>>  }
>>  
>> -static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>> +static resource_size_t mvebu_pcie_align_resource(void *data,
>> +						 const struct resource *res,
>> +						 resource_size_t size,
>> +						 resource_size_t align)
>>  {
>> -	struct mvebu_pcie *pcie = sys_to_pcie(sys);
>> -	struct pci_bus *bus;
>> +	struct pci_dev *dev = data;
>>  
>> -	bus = pci_create_root_bus(&pcie->pdev->dev, sys->busnr,
>> -				  &mvebu_pcie_ops, sys, &sys->resources);
>> -	if (!bus)
>> -		return NULL;
>> +	resource_size_t start = res->start;
>>  
>> -	pci_scan_child_bus(bus);
>> +	if (res->flags & IORESOURCE_IO && start & 0x300)
>> +		start = (start + 0x3ff) & ~0x3ff;
>>  
>> -	return bus;
>> -}
>> +	start = (start + align - 1) & ~(align - 1);
>>  
>> -static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
>> -						 const struct resource *res,
>> -						 resource_size_t start,
>> -						 resource_size_t size,
>> -						 resource_size_t align)
>> -{
>>  	if (dev->bus->number != 0)
>>  		return start;
>>  
>> @@ -796,6 +791,25 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
>>  		return start;
>>  }
>>  
>> +static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>> +{
>> +	struct mvebu_pcie *pcie = sys_to_pcie(sys);
>> +	struct pci_host_bridge *phb;
>> +	struct pci_bus *bus;
>> +
>> +	bus = pci_create_root_bus(&pcie->pdev->dev, sys->busnr,
>> +				  &mvebu_pcie_ops, sys, &sys->resources);
>> +	if (!bus)
>> +		return NULL;
>> +
>> +	phb = pci_find_host_bridge(bus);
>> +	phb->align_resource = mvebu_pcie_align_resource;
>> +
>> +	pci_scan_child_bus(bus);
>> +
>> +	return bus;
>> +}
>> +
>>  static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
>>  {
>>  	struct hw_pci hw;
>> @@ -812,7 +826,6 @@ static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
>>  	hw.scan           = mvebu_pcie_scan_bus;
>>  	hw.map_irq        = of_irq_parse_and_map_pci;
>>  	hw.ops            = &mvebu_pcie_ops;
>> -	hw.align_resource = mvebu_pcie_align_resource;
>>  
>>  	pci_common_init(&hw);
>>  }
> 
> 
> .
> 
