From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 15 Sep 2015 10:49:24 -0700
Subject: [PATCH 2/6] PCI: generic: Only fixup irqs for bus we are creating.
In-Reply-To: <20150915173654.GJ31157@arm.com>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
 <1442013719-5001-3-git-send-email-ddaney.cavm@gmail.com>
 <20150915173654.GJ31157@arm.com>
Message-ID: <55F85A24.2010600@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2015 10:36 AM, Will Deacon wrote:
> Hi David,
>
> On Sat, Sep 12, 2015 at 12:21:55AM +0100, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Use pci_walk_bus() to restrict the fixup irq actions to only the bus
>> being created.
>>
>> If we create multiple buses with pci-host-generic, or there are buses
>> created by other drivers, we don't want to call pci_fixup_irqs() which
>> operates on all devices, not just the devices on the bus being added.
>> The consequence is that either the fixups are done more than once, or
>> in some cases incorrect fixups could be applied.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   drivers/pci/host/pci-host-generic.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
>> index 265dd25..a0fb241 100644
>> --- a/drivers/pci/host/pci-host-generic.c
>> +++ b/drivers/pci/host/pci-host-generic.c
>> @@ -205,6 +205,12 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>>   	return 0;
>>   }
>>
>> +static int gen_pci_fixup_irq_cb(struct pci_dev *dev, void *arg)
>> +{
>> +	pdev_fixup_irq(dev, pci_common_swizzle, of_irq_parse_and_map_pci);
>> +	return 0;
>> +}
>> +
>>   static int gen_pci_probe(struct platform_device *pdev)
>>   {
>>   	int err;
>> @@ -262,7 +268,7 @@ static int gen_pci_probe(struct platform_device *pdev)
>>   		return -ENODEV;
>>   	}
>>
>> -	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>> +	pci_walk_bus(bus, gen_pci_fixup_irq_cb, NULL);
>
> Any chance we could put something in the core PCI code for this? I think
> any host controller wanting to work with arm64 is potentially going to
> run into the same problem.

Good idea.

I will move the walking code into setup-irq.c (the current home of 
pci_fixup_irqs()), and make it part of patch 1/6.

Thanks,
David Daney


>
> Will
>
