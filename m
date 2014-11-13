From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Thu, 13 Nov 2014 21:05:51 +0800
Subject: [Patch V1 0/6] Refine generic/PCI MSI irqodmian interfaces
In-Reply-To: <5464AA4A.6020508@huawei.com>
References: <1415879029-20098-1-git-send-email-jiang.liu@linux.intel.com>
 <5464A3F8.1000807@huawei.com> <5464A68E.4010004@linux.intel.com>
 <5464AA4A.6020508@huawei.com>
Message-ID: <5464ACAF.9060809@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/13 20:55, Yijing Wang wrote:
> On 2014/11/13 20:39, Jiang Liu wrote:
>>
>>
>> On 2014/11/13 20:28, Yijing Wang wrote:
>>> On 2014/11/13 19:43, Jiang Liu wrote:
>>>> This patch set is based on tip/irq/irqdomain and tries to refine
>>>> interfaces to support irqdomain for generic MSI and PCI MSI.
>>>>
>>>> Patch 1 is just minor fixes for tip/irq/irqdomain.
>>>>
>>>> Patch 2 introduces some helpers to hide struct msi_desc implementation
>>>> details, so later we could move msi_list from struct pci_dev into
>>>> struct device to enable generic MSI support.
>>>
>>> Hi Gerry,
>>>    I tried to move msi info(eg. msi_list) into struct device, but I found
>>> DMAR fault interrupt is initialized before the driver core init. And I don't
>>> know whether there are other devices like ARM consolidator(introduced in GIC v3)
>>> need to be initialized before driver core. What do you think about this ?
>> Hi Yijing,
>> 	DMAR interrupt doesn't make use of msi_desc, so has no
>> dependency on msi_list.
> 
> OK, I thought we could use msi_desc to describe DMAR/HPET irq, so they could
> share the mask/unmask, write_msg/read_etc.. But maybe it's not a right direction. :)
And DMAR/HPET interrupts are not associated with any struct device
object, no way to build msi_desc list at all:)
