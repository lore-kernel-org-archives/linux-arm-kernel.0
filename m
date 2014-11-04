From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 4 Nov 2014 15:47:30 +0100
Subject: [Patch Part2 v4 00/31] Enable hierarchy irqdomian on x86 platforms
In-Reply-To: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <20141104144730.GE14512@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiang,

On Tue, Nov 04, 2014 at 08:01:34PM +0800, Jiang Liu wrote:
> This is the second patch set to enable support of hierarchy irqdomain
> on x86 platforms. It depends on the first part at:
> https://lkml.org/lkml/2014/10/27/122
> And you may access it at:
> https://github.com/jiangliu/linux.git irqdomain/p2v4

I gave this some testing on a couple of machines. Unfortunatly it panics
on my AMD Kaveri system with IOMMU enabled in drivers/pci/msi.c:

static void msi_set_mask_bit(struct irq_data *data, u32 flag)
{
        struct msi_desc *desc = irq_data_get_msi(data);

        if (desc->msi_attrib.is_msix) {		<--@this line something goes wrong
                msix_mask_irq(desc, flag);
                readl(desc->mask_base);         /* Flush write to device */
        } else {
                unsigned offset = data->irq - desc->irq;
                msi_mask_irq(desc, 1 << offset, flag << offset);
        }
}

I am further investigating to find out what went wrong, but maybe you
also have an idea?


	Joerg
