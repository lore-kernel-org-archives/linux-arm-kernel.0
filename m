From: wangyijing0307@gmail.com (Yijing Wang)
Date: Fri, 14 Nov 2014 22:11:11 +0800
Subject: [Patch V1 0/6] Refine generic/PCI MSI irqodmian interfaces
In-Reply-To: <54655D44.1070703@linux.intel.com>
References: <1415879029-20098-1-git-send-email-jiang.liu@linux.intel.com>
 <54651BE2.9080008@arm.com> <54654C10.2040102@linux.intel.com>
 <54655632.2040209@huawei.com> <alpine.DEB.2.11.1411140211480.3935@nanos>
 <54655D44.1070703@linux.intel.com>
Message-ID: <54660D7F.70702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


? 2014/11/14 9:39, Jiang Liu ??:
> On 2014/11/14 9:31, Thomas Gleixner wrote:
>> On Fri, 14 Nov 2014, Yijing Wang wrote:
>>
>> Could you please use a mail client which does proper line wraps or
>> configure yours to do so?
>>
>>> Associate the irq domain and PCI bus is not necessary, because all
>>> PCI buses under same host bridge always share same MSI chip/irq
>>> domain, we only need associate them and pci host bridge.
>>>
>>> I'm refactoring the pci_host_bridge, make it be a generic one, rip
>>> out of the pci root bus creation, so we could put the irq domain and
>>> pci domain etc.. in it. Finally, we could eliminate lots platform
>>> arch functions. I will post it out within one week.
>> That's a completely orthogonal problem. From the MSI/interrupt
>> handling POV it does not matter at all where that information is
>> stored. All we care about is that it is retrievable via the (pci)
>> device which tries to setup MSI[X].
>>
>> So we can store/retrieve it via generic functions into/from whatever
>> is available right now. If the irq side has generic interfaces to do
>> so then this wont conflict with your decisions to change the final
>> storage point because all it takes is to tweak the storage/retrieve
>> functions.
>>
>> So all we need at the moment is an agreed on way to store/retrieve
>> that information which is based on the current shared infrastructure,
>> aka. Linus tree. If we can utilize that you are completely free to
>> change the association mechanism underneath.
> Hi Thomas,
> 	So we need something like:
> struct msi_chip *pci_get_msi_chip(struct pci_dev *);
> or:
> struct irq_domain *pci_get_msi_domain(struct pci_dev *);

Hi Gerry,
what about associate the platform specific  struct msi_chip 
*pci_get_msi_chip(struct pci_dev *)
with struct pci_host_bridge. we could provide the private 
"pci_get_msi_chip()" in the PCI
host drivers.

Thanks!
Yijing.

>
> BTW, there's a conflict when merging tip/irq/irqdomain into
> tip/x86/apic. It's my first time to deal with merging conflicts,
> what's the preferred way? Is it working like this?
> 1) I merge the two branch
> 2) I rebase my x86 irqdomain patch sets and send them to you
> 3) You merge the two branch and apply my patch set.
> Regards!
> Gerry
>> Thanks,
>>
>> 	tglx
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
