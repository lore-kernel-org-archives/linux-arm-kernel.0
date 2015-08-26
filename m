From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 26 Aug 2015 09:01:58 +0700
Subject: [PATCH V2 4/4] PCI: ACPI: Add support for PCI device DMA coherency
In-Reply-To: <5541922.5doADRYBJG@vostro.rjw.lan>
References: <1440524009-5359-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1440524009-5359-5-git-send-email-Suravee.Suthikulpanit@amd.com>
 <5541922.5doADRYBJG@vostro.rjw.lan>
Message-ID: <55DD1E16.40607@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 8/26/15 06:48, Rafael J. Wysocki wrote:
> On Wednesday, August 26, 2015 12:33:29 AM Suravee Suthikulpanit wrote:
>> This patch adds support for setting up PCI device DMA coherency from
>> ACPI _CCA object that should normally be specified in the DSDT node
>> of its PCI host bridge.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
>> CC: Murali Karicheri <m-karicheri2@ti.com>
>> ---
>>   drivers/pci/probe.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 4de6594..2fd2a60 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1551,17 +1551,22 @@ static void pci_init_capabilities(struct pci_dev *dev)
>>    * @dev: ptr to pci_dev struct of the PCI device
>>    *
>>    * Function to update PCI devices's DMA configuration using the same
>> - * info from the OF node of host bridge's parent (if any).
>> + * info from the OF node or ACPI node of host bridge's parent (if any).
>>    */
>>   static void pci_dma_configure(struct pci_dev *dev)
>>   {
>>   	struct device *bridge = pci_get_host_bridge_device(dev);
>>
>>   	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
>> -		if (!bridge->parent)
>> -			return;
>> -
>> -		of_dma_configure(&dev->dev, bridge->parent->of_node);
>> +		if (bridge->parent)
>> +			of_dma_configure(&dev->dev,
>> +					 bridge->parent->of_node);
>> +	} else if (has_acpi_companion(bridge)) {
>> +		struct acpi_device *adev = to_acpi_node(bridge->fwnode);
>> +		int coherent = acpi_check_dma_coherency(adev);
>> +
>> +		if (-1 != coherent)
>
> The ordering of this check is somewhat unusual.

I'll fix this.

Thanks,
Suravee
