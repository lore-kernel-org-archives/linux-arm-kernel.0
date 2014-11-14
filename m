From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 14 Nov 2014 15:16:08 +0000
Subject: [Patch V1 0/6] Refine generic/PCI MSI irqodmian interfaces
In-Reply-To: <54661103.8000707@linux.intel.com>
References: <1415879029-20098-1-git-send-email-jiang.liu@linux.intel.com>
 <54651BE2.9080008@arm.com> <54654C10.2040102@linux.intel.com>
 <54655632.2040209@huawei.com> <alpine.DEB.2.11.1411140211480.3935@nanos>
 <54655D44.1070703@linux.intel.com> <54660D7F.70702@gmail.com>
 <54661103.8000707@linux.intel.com>
Message-ID: <54661CB8.2070704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/14 14:26, Jiang Liu wrote:
> On 2014/11/14 22:11, Yijing Wang wrote:
>>
>> ? 2014/11/14 9:39, Jiang Liu ??:
>>> On 2014/11/14 9:31, Thomas Gleixner wrote:
>>>> On Fri, 14 Nov 2014, Yijing Wang wrote:
>>>>
>>> Hi Thomas,
>>>     So we need something like:
>>> struct msi_chip *pci_get_msi_chip(struct pci_dev *);
>>> or:
>>> struct irq_domain *pci_get_msi_domain(struct pci_dev *);
>>
>> Hi Gerry,
>> what about associate the platform specific  struct msi_chip
>> *pci_get_msi_chip(struct pci_dev *)
>> with struct pci_host_bridge. we could provide the private
>> "pci_get_msi_chip()" in the PCI
>> host drivers.
> Hi Yijing,
> 	Still need some time to dig into msi_chip related code.
> When refining the PCI MSI code, I feel the best way is:
> 1) Every PCI device is associated with an PCI MSI irqdomain.
> 2) PCI MSI core directly talks to irqdomain to allocate/free
>    interrupts.
> 3) Kill all weak functions in pci/drivers/msi.c.
> 4) Kill struct msi_chip.
> 
> We have achieved 1 and 2. And seems we could also achieve 3 by
> converting all arch specific PCI MSI code to use hierarchy
> irqdomain. But not sure whether we could achieve 4, not familiar
> with ARM world:)

Killing all the weak functions shouldn't be a problem for ARM, we're
trying very hard not to rely on them.

Killing msi_chip is a different story, as this is what we use to match a
PCI host controller with its MSI controller (that's what the of_node
field in msi_chip is for). See drivers/of/of_pci.c for details.

Also, we use msi_chip directly in the MSI drivers as a way to go from a
pci_dev to the MSI controller specific structure:

http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/tree/drivers/irqchip/irq-gic-v3-its.c?h=irq/stacked-its-v2#n1143

If we're going to kill msi_chip, we must make sure we have mechanisms
that allow the conversion of the existing code.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
