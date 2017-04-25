From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Apr 2017 17:46:46 +0100
Subject: [PATCH] arm64: kernel: restrict /dev/mem read() calls to linear
 region
In-Reply-To: <CAKv+Gu_j9GzO2_35Xutg4CbhdK7CekhYcOx0r+OCw_N5uGBWdA@mail.gmail.com>
References: <20170412082606.17151-1-ard.biesheuvel@linaro.org>
 <a65b0a0b-aeb8-0dcd-2d80-e77962206d7c@suse.de>
 <CAKv+Gu_j9GzO2_35Xutg4CbhdK7CekhYcOx0r+OCw_N5uGBWdA@mail.gmail.com>
Message-ID: <20170425164644.GQ24484@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 09:31:38AM +0100, Ard Biesheuvel wrote:
> On 12 April 2017 at 09:29, Alexander Graf <agraf@suse.de> wrote:
> >
> >
> > On 12.04.17 10:26, Ard Biesheuvel wrote:
> >>
> >> When running lscpu on an AArch64 system that has SMBIOS version 2.0
> >> tables, it will segfault in the following way:
> >>
> >>   Unable to handle kernel paging request at virtual address
> >> ffff8000bfff0000
> >>   pgd = ffff8000f9615000
> >>   [ffff8000bfff0000] *pgd=0000000000000000
> >>   Internal error: Oops: 96000007 [#1] PREEMPT SMP
> >>   Modules linked in:
> >>   CPU: 0 PID: 1284 Comm: lscpu Not tainted 4.11.0-rc3+ #103
> >>   Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> >>   task: ffff8000fa78e800 task.stack: ffff8000f9780000
> >>   PC is at __arch_copy_to_user+0x90/0x220
> >>   LR is at read_mem+0xcc/0x140
> >>
> >> This is caused by the fact that lspci issues a read() on /dev/mem at the
> >> offset where it expects to find the SMBIOS structure array. However, this
> >> region is classified as EFI_RUNTIME_SERVICE_DATA (as per the UEFI spec),
> >> and so it is omitted from the linear mapping.
> >>
> >> So let's restrict /dev/mem read/write access to those areas that are
> >> covered by the linear region.
> >>
> >> Reported-by: Alexander Graf <agraf@suse.de>
> >> Fixes: 4dffbfc48d65 ("arm64/efi: mark UEFI reserved regions as
> >> MEMBLOCK_NOMAP")
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/mm/mmap.c | 9 +++------
> >>  1 file changed, 3 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> >> index 7b0d55756eb1..2956240d17d7 100644
> >> --- a/arch/arm64/mm/mmap.c
> >> +++ b/arch/arm64/mm/mmap.c
> >> @@ -18,6 +18,7 @@
> >>
> >>  #include <linux/elf.h>
> >>  #include <linux/fs.h>
> >> +#include <linux/memblock.h>
> >>  #include <linux/mm.h>
> >>  #include <linux/mman.h>
> >>  #include <linux/export.h>
> >> @@ -103,12 +104,8 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
> >>   */
> >>  int valid_phys_addr_range(phys_addr_t addr, size_t size)
> >>  {
> >> -       if (addr < PHYS_OFFSET)
> >> -               return 0;
> >> -       if (addr + size > __pa(high_memory - 1) + 1)
> >> -               return 0;
> >> -
> >> -       return 1;
> >> +       return memblock_is_map_memory(addr) &&
> >> +              memblock_is_map_memory(addr + size - 1);
> >
> >
> > Is that safe? Are we guaranteed that size is less than one page? Otherwise,
> > someone could map a region that spans over a reserved one:
> >
> >   [conv mem]
> >   [reserved]
> >   [conv mem]
> >
> 
> Well, I will leave it to the maintainers to decide how elaborate they
> want this logic to become, given that read()ing from /dev/mem is
> something we are not eager to support in the first place.
> 
> But indeed, if the start and end of the region are covered by the
> linear region, there could potentially be an uncovered hole in the
> middle.

I think it would be worth handling that case, even if it means we have to
walk over the memblocks which the region overlaps.

Will
