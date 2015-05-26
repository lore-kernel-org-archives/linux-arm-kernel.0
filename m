From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 27 May 2015 01:24:54 +0800
Subject: [PATCH 11/11] ARM64 / PCI / ACPI: support for ACPI based PCI
 hostbridge init
In-Reply-To: <20150526171350.GV1565@arm.com>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <1432644564-24746-12-git-send-email-hanjun.guo@linaro.org>
 <20150526171350.GV1565@arm.com>
Message-ID: <5564AC66.1030608@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/27 1:13, Will Deacon wrote:
> On Tue, May 26, 2015 at 01:49:24PM +0100, Hanjun Guo wrote:
>> Based on Jiang Liu's common interface to support PCI host bridge
>> init and refactoring of MMCONFIG, this patch using information
>> from ACPI MCFG table and IO/irq resources from _CRS to init
>> ARM64 PCI hostbridge, then PCI will work on ARM64.
>>
>> This patch is based on Mark Salter and Tomasz Nowicki's work.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
>> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> ---
>>  arch/arm64/Kconfig      |   7 ++
>>  arch/arm64/kernel/pci.c | 245 +++++++++++++++++++++++++++++++++++++++++++++---
>>  drivers/pci/pci.c       |  26 +++--
>>  3 files changed, 257 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 9b80428..8e4b789 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -276,6 +276,13 @@ config PCI_DOMAINS_GENERIC
>>  config PCI_SYSCALL
>>         def_bool PCI
>>
>> +config PCI_MMCONFIG
>> +       def_bool y
>> +       select PCI_ECAM
>> +       select HAVE_PCI_ECAM
>> +       select GENERIC_PCI_ECAM
>> +       depends on ACPI
>> +
>>  source "drivers/pci/Kconfig"
>>  source "drivers/pci/pcie/Kconfig"
>>  source "drivers/pci/hotplug/Kconfig"
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index 4095379..d1629dc 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -11,12 +11,15 @@
>>   */
>>
>>  #include <linux/acpi.h>
>> +#include <linux/ecam.h>
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>>  #include <linux/kernel.h>
>>  #include <linux/mm.h>
>> +#include <linux/of_address.h>
>>  #include <linux/of_pci.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/pci-acpi.h>
>>  #include <linux/slab.h>
>>
>>  #include <asm/pci-bridge.h>
>> @@ -43,31 +46,251 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>>   */
>>  int pcibios_add_device(struct pci_dev *dev)
>>  {
>> -       dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>> +       if (acpi_disabled)
>> +               dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>>
>>         return 0;
>>  }
>>
>> +#ifdef CONFIG_ACPI
>> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>> +{
>> +       struct pci_controller *sd = bridge->bus->sysdata;
>> +
>> +       ACPI_COMPANION_SET(&bridge->dev, sd->companion);
>> +       return 0;
>> +}
>> +
>> +void pcibios_add_bus(struct pci_bus *bus)
>> +{
>> +       acpi_pci_add_bus(bus);
>> +}
>> +
>> +void pcibios_remove_bus(struct pci_bus *bus)
>> +{
>> +       acpi_pci_remove_bus(bus);
>> +}
>> +
>> +int pcibios_enable_irq(struct pci_dev *dev)
>> +{
>> +       if (!pci_dev_msi_enabled(dev))
>> +               acpi_pci_irq_enable(dev);
>> +       return 0;
>> +}
>> +
>> +int pcibios_disable_irq(struct pci_dev *dev)
>> +{
>> +       if (!pci_dev_msi_enabled(dev))
>> +               acpi_pci_irq_disable(dev);
>> +       return 0;
>> +}
>> +
>> +int pcibios_enable_device(struct pci_dev *dev, int bars)
>> +{
>> +       int err;
>> +
>> +       err = pci_enable_resources(dev, bars);
>> +       if (err < 0)
>> +               return err;
>> +
>> +       return pcibios_enable_irq(dev);
>> +}
>> +
>> +static int __init pcibios_assign_resources(void)
>> +{
>> +       struct pci_bus *root_bus;
>> +
>> +       if (acpi_disabled)
>> +               return 0;
>> +
>> +       list_for_each_entry(root_bus, &pci_root_buses, node) {
>> +               pcibios_resource_survey_bus(root_bus);
>> +               pci_assign_unassigned_root_bus_resources(root_bus);
>> +       }
>> +       return 0;
>> +}
> 
> I'm starting to sound like a stuck record (and getting bored of it
> myself!), but none of this looks arch-specific. Can it be moved into the
> core?
Hi Will,
	Kindly reminder, there's a pending patch set to change the way
to manage IRQ for pci devices, which affects
pcibios_enable_irq()/pcibios_enable_device() and friends.
Please refer to https://lkml.org/lkml/2015/5/6/989
Thanks!
Gerry

> 
> Will
> 
