From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Fri, 14 Nov 2014 22:26:11 +0800
Subject: [Patch V1 0/6] Refine generic/PCI MSI irqodmian interfaces
In-Reply-To: <54660D7F.70702@gmail.com>
References: <1415879029-20098-1-git-send-email-jiang.liu@linux.intel.com>
 <54651BE2.9080008@arm.com> <54654C10.2040102@linux.intel.com>
 <54655632.2040209@huawei.com> <alpine.DEB.2.11.1411140211480.3935@nanos>
 <54655D44.1070703@linux.intel.com> <54660D7F.70702@gmail.com>
Message-ID: <54661103.8000707@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/14 22:11, Yijing Wang wrote:
> 
> ? 2014/11/14 9:39, Jiang Liu ??:
>> On 2014/11/14 9:31, Thomas Gleixner wrote:
>>> On Fri, 14 Nov 2014, Yijing Wang wrote:
>>>
>> Hi Thomas,
>>     So we need something like:
>> struct msi_chip *pci_get_msi_chip(struct pci_dev *);
>> or:
>> struct irq_domain *pci_get_msi_domain(struct pci_dev *);
> 
> Hi Gerry,
> what about associate the platform specific  struct msi_chip
> *pci_get_msi_chip(struct pci_dev *)
> with struct pci_host_bridge. we could provide the private
> "pci_get_msi_chip()" in the PCI
> host drivers.
Hi Yijing,
	Still need some time to dig into msi_chip related code.
When refining the PCI MSI code, I feel the best way is:
1) Every PCI device is associated with an PCI MSI irqdomain.
2) PCI MSI core directly talks to irqdomain to allocate/free
   interrupts.
3) Kill all weak functions in pci/drivers/msi.c.
4) Kill struct msi_chip.

We have achieved 1 and 2. And seems we could also achieve 3 by
converting all arch specific PCI MSI code to use hierarchy
irqdomain. But not sure whether we could achieve 4, not familiar
with ARM world:)

On x86, we could kill all PCI MSI weak function after converting
Xen to irqdomain. I think we may have a prototype for x86 in next
week.
Thanks!
Gerry
