From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Tue, 04 Nov 2014 23:12:51 +0800
Subject: [Patch Part2 v4 00/31] Enable hierarchy irqdomian on x86 platforms
In-Reply-To: <20141104144730.GE14512@8bytes.org>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
 <20141104144730.GE14512@8bytes.org>
Message-ID: <5458ECF3.4040308@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/4 22:47, Joerg Roedel wrote:
> Hi Jiang,
> 
> On Tue, Nov 04, 2014 at 08:01:34PM +0800, Jiang Liu wrote:
>> This is the second patch set to enable support of hierarchy irqdomain
>> on x86 platforms. It depends on the first part at:
>> https://lkml.org/lkml/2014/10/27/122
>> And you may access it at:
>> https://github.com/jiangliu/linux.git irqdomain/p2v4
> 
> I gave this some testing on a couple of machines. Unfortunatly it panics
> on my AMD Kaveri system with IOMMU enabled in drivers/pci/msi.c:
> 
> static void msi_set_mask_bit(struct irq_data *data, u32 flag)
> {
>         struct msi_desc *desc = irq_data_get_msi(data);
> 
>         if (desc->msi_attrib.is_msix) {		<--@this line something goes wrong
>                 msix_mask_irq(desc, flag);
>                 readl(desc->mask_base);         /* Flush write to device */
>         } else {
>                 unsigned offset = data->irq - desc->irq;
>                 msi_mask_irq(desc, 1 << offset, flag << offset);
>         }
> }
> 
> I am further investigating to find out what went wrong, but maybe you
> also have an idea?
Hi Joerg,
	Thanks for testing:)
	Do you have the call stack? I have changed the way to call
irq_set_msi_desc_off() for MSI/MSIx interrupts, which may cause the
panic. Patch 19-21 changes the PCI MSI code.
Regards!
Gerry

> 
> 
> 	Joerg
> 
