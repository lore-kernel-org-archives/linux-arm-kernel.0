From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 5 May 2014 16:28:02 -0600
Subject: [PATCH v3 4/7] of: configure the platform device dma parameters
In-Reply-To: <5575019.Hr92MUuDnc@wuerfel>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <20923376.buVzFR52Qe@wuerfel>
 <CAErSpo5-FXmVs8BWRYKz9Ln1g1Ls7_uo3oiPd32fUegf3d8hXQ@mail.gmail.com>
 <5575019.Hr92MUuDnc@wuerfel>
Message-ID: <CAErSpo6gYT34-sOvNgEdV+3wxv=Fdqtx7c1d-4577mFydLtZMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 5, 2014 at 2:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 05 May 2014 14:45:21 Bjorn Helgaas wrote:
>> [+cc Ben, Chris]
>>
>> On Fri, May 2, 2014 at 12:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 02 May 2014 10:54:59 Bjorn Helgaas wrote:
>> >> > +static void of_dma_configure(struct device *dev)
>> >> > +{
>> >> > +     u64 dma_addr, paddr, size;
>> >> > +     int ret;
>> >> > +
>> >> > +     dev->coherent_dma_mask = DMA_BIT_MASK(32);
>> >> > +     if (!dev->dma_mask)
>> >> > +             dev->dma_mask = &dev->coherent_dma_mask;
>> >> > +
>> >> > +     /*
>> >> > +      * if dma-coherent property exist, call arch hook to setup
>> >> > +      * dma coherent operations.
>> >> > +      */
>> >> > +     if (of_dma_is_coherent(dev->of_node)) {
>> >> > +             set_arch_dma_coherent_ops(dev);
>> >> > +             dev_dbg(dev, "device is dma coherent\n");
>> >> > +     }
>> >> > +
>> >> > +     /*
>> >> > +      * if dma-ranges property doesn't exist - just return else
>> >> > +      * setup the dma offset
>> >> > +      */
>> >> > +     ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
>> >> > +     if ((ret == -ENODEV) || (ret < 0)) {
>> >> > +             dev_dbg(dev, "no dma range information to setup\n");
>> >> > +             return;
>> >> > +     }
>> >> > +
>> >> > +     /* DMA ranges found. Calculate and set dma_pfn_offset */
>> >> > +     dev->dma_pfn_offset = PFN_DOWN(paddr - dma_addr);
>> >> > +     dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
>> >>
>> >> Is this effectively the same as an IOMMU that applies a constant offset
>> >> to the bus address?  Could or should this be done by adding a simple IOMMU
>> >> driver instead of adding dma_pfn_offset to struct device?
>> >
>> > We currently have two dma_map_ops variants on ARM (plus another set for
>> > coherent/noncoherent differences, but we can ignore that for the sake
>> > of this discussion): one that handles linear mappings and one that
>> > handles IOMMUs by calling into the linux/iommu.h APIs.
>> >
>> > I guess what you mean by 'a simple IOMMU driver' would be another
>> > dma_map_ops implementation that is separate from real IOMMUs, right?
>>
>> I suppose so; it seems like the offset could be managed inside
>> arm_dma_ops.  My idea of an IOMMU is something that maps bus addresses
>> to physical memory addresses.  That's what we're doing here; it's just
>> that the mapping function is very simple.  So why add something new in
>> struct device for it?
>>
>> I think powerpc and tile do something similar in dma_direct_map_page()
>> and tile_pci_dma_map_page() (they store the offset in struct
>> dev_archdata).
>
> Ah, so the only question is whether to store it in dev_archdata or
> in device. I think the argument for using struct device directly
> was that it lets us access this field from architecture independent
> code. It's not important to the overall design though: we could easily
> put it in dev_archdata and call an architecture specific function to
> set it, if there are good reasons for keeping it out of the generic
> device structure.

Well, it wasn't my *only* question, since I didn't know about the
powerpc and tile usage originally :).  Putting it in dev_archdata does
seem better because it's a similar solution to a similar problem, and
it's less public.

I still wonder whether arm, powerpc, and tile (and I just noticed
microblaze also has a similar dma_direct_map_page()) could all be
handled by attaching devices to a generic trivial IOMMU driver
parameterized with the appropriate constant offset.

What arch-independent code would access this data?  I expect that
drivers will use dma_map_page(), etc., so they should already have
both the bus and the physical address and wouldn't need it.  Shouldn't
generic code just rely on the DMA API, which might use an IOMMU or
this dma_pfn_offset internally?

Bjorn
