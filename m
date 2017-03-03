From: kashyap.desai@broadcom.com (Kashyap Desai)
Date: Fri, 3 Mar 2017 14:29:28 +0530
Subject: ARM64 CONFIG_ZONE_DMA for 32-bit devices
In-Reply-To: 6eab56bb5a4ffd8812d8b59ffa8a7cce@mail.gmail.com
References: 6eab56bb5a4ffd8812d8b59ffa8a7cce@mail.gmail.com
Message-ID: <04e975a6fe5981d082639182a7be1653@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Robin and Catalin. Somehow I did not received email due to some
firewall or other technical issue, so copied your  discussion and replied
inline.


> > If you want to use a device which requires 32-bit-addressable DMA
> > resources with your crash kernel, and that device isn't behind an
> > IOMMU, then don't load your crash kernel above 4GB. It's as simple
> > as that, because in general there's no other way around the issue.
> > And if said device doesn't actually need 32-bit-addressable
> > resources, then yeah, fix the dma_set_mask() calls in the driver.
>
> I am working on driver level changes. So kdump and base kernel
> behavior is just setting and configuration problem.
> It is not the case we are seeing difference in DMA zone in kdump is
> different vs base kernel.
>
> >
> > That said, I think something is a bit wonky in max_zone_dma_phys()
> > with "It currently assumes that for memory starting above 4G, 32-bit
> > devices will use a DMA offset" - I think that assumption needs to be
> > revisited since,

 This is what exactly I could not understand as it is very specific to ARM
and not  many Arch follow this.

 Do you mean always reserve some memory for DMA zone in below 4GB as an
alternative solution?

 I am asking question with limited understanding of how ARM is working.
Need time to understand your reply completely.
 Solution I am looking for is driver asking 64 bit DMA mask for Streaming
IO and 32 bit consistent DMA can work in ARM64 platform ?

> >even disregarding cases like kdump, commonly available hardware now
> >exists for  which that is not true (e.g. AMD Seattle). Catalin?

 I recently receive another set of logs which has base kernel  causing
problem same as kdump kernel with crashkernel option in high mem.

 Here is /proc/iomem snippet in base kernel -

 7e930000-7e930fff : /soc/xxxxxxxx at 7e930000 4000200000-43ffffffff :
 System RAM
   4000280000-4000ed0fff : Kernel code
   4000fa1000-400116cfff : Kernel data
  e0d0000000-e0d003ffff : cfg

 DMA and Normal zone are configured as below -

 Feb 22 15:34:54 dhcp-135-24-241-244 kernel: [    0.000000] Zone ranges:
 Feb 22 15:34:54 dhcp-135-24-241-244 kernel: [    0.000000]   DMA
[mem
 0x0000004000200000-0x00000040ffffffff]
 Feb 22 15:34:54 dhcp-135-24-241-244 kernel: [    0.000000]   Normal
[mem
 0x0000004100000000-0x00000043ffffffff]

 This is first instance where I observed RAM was mapped above 4GB and
because of that driver asking for 32 bit DMA is failing.
Which parameter plays role  here for mapping system RAM above 4GB ? Is it
done in BIOS ?

>
> >
> > Robin.
