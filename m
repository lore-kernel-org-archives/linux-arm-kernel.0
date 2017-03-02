From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Mar 2017 18:35:09 +0000
Subject: ARM64 CONFIG_ZONE_DMA for 32-bit devices
In-Reply-To: <66ba5ad3-456e-f205-b142-b3f938d7c42b@arm.com>
References: <6eab56bb5a4ffd8812d8b59ffa8a7cce@mail.gmail.com>
 <66ba5ad3-456e-f205-b142-b3f938d7c42b@arm.com>
Message-ID: <20170302183509.GH12157@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 12:42:51PM +0000, Robin Murphy wrote:
> On 28/02/17 10:34, Kashyap Desai wrote:
> > I was reading below articles. Mine is not similar issue, but  I understand
> > few things about ARM64 SWIOTLB interface from below discussion.
> > Any input will be a great help to resolve/understand the issue.
> > 
> > https://patchwork.codeaurora.org/patch/143833/
> > https://patchwork.kernel.org/patch/9495893/
> > 
> > Current problem statement is -
> > "Trying to load kdump kernel from above 4GB memory does not work on ARM64
> > platform as <megaraid_sas> driver require certain DMA buffer from below
> > 4GB memory range."
> > 
> > Looking for alternative/workaround for time being. Long term plan is to
> > remove limitation of <megaraid_sas> driver to remove 32 bit DMA mask for
> > SAS3.0 onwards controller.
> > 
> > 1) I found below code @arch/arm64/mm/init.c . ARM64 kernel has provision
> > to support 32-bit DMA as well.  I am not sure about why CONFIG_ZONE_DMA
> > option is an configurable option for ARM64 ?
> > 
> >         /* 4GB maximum for 32-bit only capable devices */
> >         if (IS_ENABLED(CONFIG_ZONE_DMA))
> >                 arm64_dma_phys_limit = max_zone_dma_phys();
> >         else
> >                 arm64_dma_phys_limit = PHYS_MASK + 1;
> >         dma_contiguous_reserve(arm64_dma_phys_limit);
> > 
> > One of the reason I think "kdump" kernel can load from above 4GB memory
> > range provided crashkernel=<>, high and crashkernel=0, low option. So I
> > guess ARM64 kdump kernel may have disabled CONFIG_ZONE_DMA option, but
> > base kernel must have enabled CONFIG_ZONE_DMA option to support 32-bit
> > only capable devices.
> 
> I believe it's more that ZONE_DMA goes a bit crazy when the available
> RAM starts above 4GB. It's not technically possible to turn it off
> without hacking Kconfig.

I think even if you hack Kconfig, the kernel may not build. We keep the
Kconfig option so that enum zone_type has ZONE_DMA defined.

Regarding the DMA zone selection, max_zone_dma_phys() is more of a hack
(needed on Seattle where all RAM is above 4GB). Basically the first
32-bit at the start of RAM are considered for ZONE_DMA, even though the
actual physical address of the start of RAM would be well beyond 4GB.
This assumes that 32-bit only devices have the relevant dma_pfn_offset
passed via DT (not sure what we do on ACPI).

> > 2.)
> > 
> > Typically - SWIOTLB uses DMA buffer from below 4GB range only. ARM64 is
> > the only architecture which support Low memory definition as per ARCH
> > specified. See below
> > 
> > [root@ linux]# grep -R ARCH_LOW_ADDRESS_LIMIT arch/
> > arch/s390/include/asm/processor.h:#define ARCH_LOW_ADDRESS_LIMIT
> > 0x7fffffffUL
> > arch/arm64/include/asm/processor.h:#define ARCH_LOW_ADDRESS_LIMIT
> > (arm64_dma_phys_limit - 1)
> > 
> > For only ARM64, it is possible to get SWTBL DMA buffer above 4GB. See
> > below snippet from crashed kernel on ARM64.
> > 
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000005fc0000000-0x0000005fffffffff]
> > [    0.000000]   Normal   empty

I guess that's because the kernel thinks 0x5fc00000 is the start of all
RAM that is available and just assumes that ZONE_DMA would be covered by
the lower 32-bit of this (high) range.

The physical address in the 32-bit DMA context is rather irrelevant.
What you need is the actual DMA address that the device is seeing and
this is calculated by phys_to_dma (taking dma_pfn_offset into account).

> > SWIOTLB can map 64MB buffer from above 4GB only on ARM64 machine and that
> > is causing problem for <megaraid_sas> driver.
> > Current megaraid_sas driver wants certain resources from below 4GB memory
> > and that is why it request consistent dma mask as below -
> > pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32)).
> > 
> > If I do the same on x86_64, SWTBL INIT will fail because there is no Low
> > memory below 4GB. See below prints from x86_64 machine.
> > 
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> > [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> > [    0.000000]   Normal   [mem 0x0000000100000000-0x000000407effffff]
> >   [    0.000000] Movable zone start for each node
> >    ..
> >    [    0.000000] Cannot allocate SWIOTLB buffer
> > 
> > Question is - "ARM64 platform can't allocate memory for crash kernel in
> > below 4GB range ?"
> 
> If you want to use a device which requires 32-bit-addressable DMA
> resources with your crash kernel, and that device isn't behind an IOMMU,
> then don't load your crash kernel above 4GB. It's as simple as that,
> because in general there's no other way around the issue. And if said
> device doesn't actually need 32-bit-addressable resources, then yeah,
> fix the dma_set_mask() calls in the driver.

I agree. I don't think there is much we can do, other than parsing all
dma_pfn_offsets early on in DT and deciding whether the ZONE_DMA
heuristics actually helps (and, if not, print some warning).

> That said, I think something is a bit wonky in max_zone_dma_phys() with
> "It currently assumes that for memory starting above 4G, 32-bit devices
> will use a DMA offset" - I think that assumption needs to be revisited
> since, even disregarding cases like kdump, commonly available hardware
> now exists for which that is not true (e.g. AMD Seattle). Catalin?

IIRC, I did this specifically for Seattle, though not sure whether it
was just a matter of failing memory allocations when ZONE_DMA was empty
rather than a device actually using it. That's the best we could do if
there actually is a device with the relevant dma_pfn_offset.

The alternative would be to put everything in ZONE_DMA if the RAM is
beyond 4GB but it doesn't help if we do have devices with a proper
dma_pfn_offset. Leaving ZONE_DMA empty probably has other implications
with failing allocations (you can fall back from ZONE_NORMAL to ZONE_DMA
but not the other way around).

-- 
Catalin
