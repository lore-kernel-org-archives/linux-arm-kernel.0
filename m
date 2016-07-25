From: eric.auger@redhat.com (Auger Eric)
Date: Mon, 25 Jul 2016 18:31:55 +0200
Subject: [PATCH v11 10/10] genirq/msi: use the MSI doorbell's IOVA when
 requested
In-Reply-To: <alpine.DEB.2.11.1607201105310.3564@nanos>
References: <1468933367-23159-1-git-send-email-eric.auger@redhat.com>
 <1468933367-23159-11-git-send-email-eric.auger@redhat.com>
 <alpine.DEB.2.11.1607201105310.3564@nanos>
Message-ID: <08a930f2-8cc9-7d99-78c0-77d08ee40db3@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 20/07/2016 11:09, Thomas Gleixner wrote:
> On Tue, 19 Jul 2016, Eric Auger wrote:
> 
> First of all - valid for all patches:
> 
> Subject: sys/subsys: Sentence starts with an uppercase letter
OK understood.
> 
> Now for this particular one:
> 
> genirq/msi: use the MSI doorbell's IOVA when requested
> 
>> On MSI message composition we now use the MSI doorbell's IOVA in
>> place of the doorbell's PA in case the device is upstream to an
>> IOMMU that requires MSI addresses to be mapped. The doorbell's
>> allocation and mapping happened on an early stage (pci_enable_msi).
> 
> This changelog is completely useless. At least I cannot figure out what that
> patch actually does. And the implementation is not self explaining either.

>  
>> @@ -63,10 +63,18 @@ static int msi_compose(struct irq_data *irq_data,
>>  {
>>  	int ret = 0;
>>  
>> -	if (erase)
>> +	if (erase) {
>>  		memset(msg, 0, sizeof(*msg));
>> -	else
>> +	} else {
>> +		struct device *dev;
>> +
>>  		ret = irq_chip_compose_msi_msg(irq_data, msg);
>> +		if (ret)
>> +			return ret;
>> +
>> +		dev = msi_desc_to_dev(irq_data_get_msi_desc(irq_data));
>> +		WARN_ON(iommu_msi_msg_pa_to_va(dev, msg));
> 
> What the heck is this call doing? And why is there only a WARN_ON and not a
> proper error return code handling?

iommu_msi_msg_pa_to_va is part of the new iommu-msi API introduced in PART I of
this series. This helper function detects the physical address found in the
MSI message has a corresponding allocated IOVA. This happens if the MSI doorbell
is accessed through an IOMMU and this IOMMU do not bypass the MSI addresses
(ARM case). Allocation of this IOVA was performed in the previous patch.

So, if this is the case, the physical address is swapped with the IOVA
address. That way the PCIe device will send the MSI with this IOVA and
the address will be translated by the IOMMU into the target MSI doorbell PA.

Hope this clarifies

Thanks

Eric 
> 
> Thanks,
> 
> 	tglx
> 
