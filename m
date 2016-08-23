From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 23 Aug 2016 09:38:16 +0900
Subject: [PATCH v24 5/9] arm64: kdump: add kdump support
In-Reply-To: <57BB0272.1000008@arm.com>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015615.28527-1-takahiro.akashi@linaro.org>
 <20160809015615.28527-3-takahiro.akashi@linaro.org>
 <57AB586D.3080900@arm.com> <20160818071547.GC20080@linaro.org>
 <20160819012651.GE20080@linaro.org>
 <20160819112217.GB22221@localhost.localdomain>
 <20160822012919.GI20080@linaro.org> <57BB0272.1000008@arm.com>
Message-ID: <20160823003815.GL20080@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 02:47:30PM +0100, James Morse wrote:
> On 22/08/16 02:29, AKASHI Takahiro wrote:
> > On Fri, Aug 19, 2016 at 04:52:17PM +0530, Pratyush Anand wrote:
> >> It will help kexec-tools to prevent copying  of any unnecessary data. I
> >> think, then you also need to change phys_offset calculation in kexec-tools. That
> >> should be start of either of first "reserved" or "System RAM" block.
> > 
> > Good point, but I'm not sure this is always true.
> 
> > Is there any system whose ACPI memory is *not* part of DRAM
> 
> From the spec, it looks like this is allowed.
> 
> What do you mean by 'DRAM'? Any ACPI region will be in the UEFI memory map, so
> the question is what is its type and memory attributes?

Yes.

> The UEFI spec[0] says ACPI regions can have a type of EfiACPIReclaimMemory or
> EfiACPIMemoryNVS, the memory attributes aren't specified, so are chosen by the
> firmware.
> 
> It is possible these regions have to be mapped non-cacheable, page 40 has a
> couple of:
> > If no information about the table location exists in the UEFI memory map or
> ACPI memory
> > descriptors, the table is assumed to be non-cached.
> 
> reserve_regions() in drivers/firmware/efi/arm-init.c will add any entry in the
> memory map that has a 'WB' attribute to the memblock.memory list (via
> early_init_dt_add_memory_arch()), it will also mark as no-map regions that have
> this attribute and aren't in the is_reserve_region() list.
> 
> If these ACPI regions have the 'WB' attribute, we add them as memory and mark
> them nomap. These show up as either a hole, or 'reserved' in /proc/iomem.
> If they don't have the 'WB' attribute, then then they are left out of memblock
> and aren't part of DRAM, I don't think these will show up in /proc/iomem at all.

Let's say,
0x1000-0x1fff: reserved (SRAM for UEFI, WB)
0x80000000-0xffffffff: System RAM (DRAM)

If, as Pratyush suggested, "reserved" resources are added to phys_offset
calculation, the kernel linear mapping area starts at PAGE_OFFSET, but
there is no actual mapping around PAGE_OFFSET.
It won't hurt anything, but looks funny.
So we'd better not include "reserved" in phys_offset calculation anyway.
        -> Pratyush

Thanks,
-Takahiro AKASHI

> 
> 
> Thanks,
> 
> James
> 
> [0] '2.3.6 AArch64 Platforms' of version 2.6 of the UEFI spec at
> http://uefi.org/specifications
