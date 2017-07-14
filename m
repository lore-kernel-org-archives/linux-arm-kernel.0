From: dingtianhong@huawei.com (Ding Tianhong)
Date: Fri, 14 Jul 2017 09:26:15 +0800
Subject: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
In-Reply-To: <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-3-git-send-email-dingtianhong@huawei.com>
 <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
Message-ID: <0260e398-bd8e-6615-6d5c-1f7c07b6fc09@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/7/14 5:09, Sinan Kaya wrote:
> On 7/13/2017 10:21 AM, Ding Tianhong wrote:
>> static void pci_configure_relaxed_ordering(struct pci_dev *dev)
>> +{
>> +	/* We should not alter the relaxed ordering bit for the VF */
>> +	if (dev->is_virtfn)
>> +		return;
>> +
>> +	/* If the releaxed ordering enable bit is not set, do nothing. */
>> +	if (!pcie_relaxed_ordering_supported(dev))
>> +		return;
>> +
>> +	if (pci_dev_should_disable_relaxed_ordering(dev)) {
>> +		pcie_clear_relaxed_ordering(dev);
>> +		dev_info(&dev->dev, "Disable Relaxed Ordering\n");
>> +	}
>> +}
> 
> I couldn't find anywhere where you actually enable the relaxed ordering
> like the subject suggests.
> 
There is no code to enable the PCIe Relaxed Ordering bit in the configuration space,
it is only be enable by default according to the PCIe Standard Specification, what we
do is to distinguish the RC problematic platform and clear the Relaxed Ordering bit
to tell the PCIe EP don't send any TLPs with Relaxed Ordering Attributes to the Root
Complex.

Thanks
Ding
