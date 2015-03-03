From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 3 Mar 2015 16:35:15 +0800
Subject: [PATCH v4 16/30] PCI/IA64: Fix the build warning about
 pci_domain_nr()
In-Reply-To: <20150303025622.GH11978@google.com>
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
 <1424938344-4017-17-git-send-email-wangyijing@huawei.com>
 <20150303025622.GH11978@google.com>
Message-ID: <54F57243.8040905@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/3 10:56, Bjorn Helgaas wrote:
> On Thu, Feb 26, 2015 at 04:12:10PM +0800, Yijing Wang wrote:
>> Should pass pci_bus * instead of pci_dev * to pci_domain_nr().
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Tony Luck <tony.luck@intel.com>
>> CC: Fenghua Yu <fenghua.yu@intel.com>
>> CC: linux-ia64 at vger.kernel.org
>> ---
>>  arch/ia64/sn/kernel/io_acpi_init.c |    6 +++---
>>  arch/ia64/sn/kernel/io_init.c      |    2 +-
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/io_acpi_init.c
>> index 0640739..2fd7414 100644
>> --- a/arch/ia64/sn/kernel/io_acpi_init.c
>> +++ b/arch/ia64/sn/kernel/io_acpi_init.c
>> @@ -364,12 +364,12 @@ sn_acpi_get_pcidev_info(struct pci_dev *dev, struct pcidev_info **pcidev_info,
>>          status = acpi_evaluate_integer(rootbus_handle, METHOD_NAME__SEG, NULL,
>>                                         &segment);
>>          if (ACPI_SUCCESS(status)) {
>> -		if (segment != pci_domain_nr(dev)) {
>> +		if (segment != pci_domain_nr(dev->bus)) {
> 
> This is completely unrelated to the series, isn't it?  It looks like this
> is a bug fix that should be handled separately and marked for stable.

Yes, it's a separate patch, I would move it out of this series, and post it out separately.

Thanks!
Yijing.

> 
>>  			acpi_get_name(rootbus_handle, ACPI_FULL_PATHNAME,
>>  				&name_buffer);
>>  			printk(KERN_ERR
>>  			       "%s: Segment number mismatch, 0x%llx vs 0x%x for: %s\n",
>> -			       __func__, segment, pci_domain_nr(dev),
>> +			       __func__, segment, pci_domain_nr(dev->bus),
>>  			       (char *)name_buffer.pointer);
>>  			kfree(name_buffer.pointer);
>>  			return 1;
>> @@ -407,7 +407,7 @@ sn_acpi_get_pcidev_info(struct pci_dev *dev, struct pcidev_info **pcidev_info,
>>  	/* Build up the pcidev_info.pdi_slot_host_handle */
>>  	host_devfn = get_host_devfn(pcidev_match.handle, rootbus_handle);
>>  	(*pcidev_info)->pdi_slot_host_handle =
>> -			((unsigned long) pci_domain_nr(dev) << 40) |
>> +			((unsigned long) pci_domain_nr(dev->bus) << 40) |
>>  					/* bus == 0 */
>>  					host_devfn;
>>  	return 0;
>> diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
>> index bcdc5b8..a97fad4 100644
>> --- a/arch/ia64/sn/kernel/io_init.c
>> +++ b/arch/ia64/sn/kernel/io_init.c
>> @@ -164,7 +164,7 @@ sn_io_slot_fixup(struct pci_dev *dev)
>>  		panic("%s: Unable to alloc memory for sn_irq_info", __func__);
>>  
>>  	/* Call to retrieve pci device information needed by kernel. */
>> -	status = sal_get_pcidev_info((u64) pci_domain_nr(dev),
>> +	status = sal_get_pcidev_info((u64) pci_domain_nr(dev->bus),
>>  		(u64) dev->bus->number,
>>  		dev->devfn,
>>  		(u64) __pa(pcidev_info),
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing
