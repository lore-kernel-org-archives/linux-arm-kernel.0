From: domenico.andreoli@linux.com (Domenico Andreoli)
Date: Wed, 12 Apr 2017 14:44:19 +0200
Subject: [PATCH] arm64: kernel: restrict /dev/mem read() calls to linear
 region
In-Reply-To: <CAKv+Gu8zJqGE7bGF0DkDon2Ojhfoo76bm2ebfkqf3Cj05S5sDQ@mail.gmail.com>
References: <20170412082606.17151-1-ard.biesheuvel@linaro.org>
 <20170412083342.GA6957@localhost>
 <20170412092918.GX17774@n2100.armlinux.org.uk>
 <CAKv+Gu8zJqGE7bGF0DkDon2Ojhfoo76bm2ebfkqf3Cj05S5sDQ@mail.gmail.com>
Message-ID: <20170412124418.GA8911@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 10:37:46AM +0100, Ard Biesheuvel wrote:
> On 12 April 2017 at 10:29, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Wed, Apr 12, 2017 at 10:33:43AM +0200, Domenico Andreoli wrote:
> >> On Wed, Apr 12, 2017 at 09:26:06AM +0100, Ard Biesheuvel wrote:
> >> > When running lscpu on an AArch64 system that has SMBIOS version 2.0
> >> > tables, it will segfault in the following way:
> >> >
> >> >   Unable to handle kernel paging request at virtual address ffff8000bfff0000
> >> >   pgd = ffff8000f9615000
> >> >   [ffff8000bfff0000] *pgd=0000000000000000
> >> >   Internal error: Oops: 96000007 [#1] PREEMPT SMP
> >> >   Modules linked in:
> >> >   CPU: 0 PID: 1284 Comm: lscpu Not tainted 4.11.0-rc3+ #103
> >> >   Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> >> >   task: ffff8000fa78e800 task.stack: ffff8000f9780000
> >> >   PC is at __arch_copy_to_user+0x90/0x220
> >> >   LR is at read_mem+0xcc/0x140
> >> >
> >> > This is caused by the fact that lspci issues a read() on /dev/mem at the
> >> > offset where it expects to find the SMBIOS structure array. However, this
> >> > region is classified as EFI_RUNTIME_SERVICE_DATA (as per the UEFI spec),
> >> > and so it is omitted from the linear mapping.
> >> >
> >> > So let's restrict /dev/mem read/write access to those areas that are
> >> > covered by the linear region.
> >> >
> >> > Reported-by: Alexander Graf <agraf@suse.de>
> >> > Fixes: 4dffbfc48d65 ("arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP")
> >> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> > ---
> >> >  arch/arm64/mm/mmap.c | 9 +++------
> >> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> >> > index 7b0d55756eb1..2956240d17d7 100644
> >> > --- a/arch/arm64/mm/mmap.c
> >> > +++ b/arch/arm64/mm/mmap.c
> >> > @@ -18,6 +18,7 @@
> >> >
> >> >  #include <linux/elf.h>
> >> >  #include <linux/fs.h>
> >> > +#include <linux/memblock.h>
> >> >  #include <linux/mm.h>
> >> >  #include <linux/mman.h>
> >> >  #include <linux/export.h>
> >> > @@ -103,12 +104,8 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
> >> >   */
> >> >  int valid_phys_addr_range(phys_addr_t addr, size_t size)
> >> >  {
> >> > -   if (addr < PHYS_OFFSET)
> >> > -           return 0;
> >> > -   if (addr + size > __pa(high_memory - 1) + 1)
> >> > -           return 0;
> >> > -
> >> > -   return 1;
> >> > +   return memblock_is_map_memory(addr) &&
> >> > +          memblock_is_map_memory(addr + size - 1);
> >> >  }
> >> >
> >> >  /*
> >>
> >> Does arch/arm/mm/mmap.c need the same treatment?
> >
> > high_memory is supposed to be the virtual address of the end of the
> > linearly mapped region.  ARM conforms to that.
> >
> 
> Yes, but with UEFI boot, there will be holes in the linear region.
> This is due to the fact that those regions may have special
> significance to the firmware, and may be mapped with mismatched
> attributes.
> 
> As it happens, the UEFI spec recommends that SMBIOS tables (which only
> have significance to the OS) are covered by a EFI_RUNTIME_SERVICE_DATA
> region, which is one of the types we mark MEMBLOCK_NOMAP, and omit
> from the linear region.
> 
> So when lspcu goes looking for the SMBIOS tables, using the read()
> interface to /dev/mem, it will dereference a physical pointer into an
> unmapped region. This will undoubtedly produce a similar result to the
> above if we don't account for NOMAP regions.
> 
> However, we have no DMI/SMBIOS support yet for ARM (nor ACPI support),
> so this particular issue does not exist on ARM atm. But read() calls
> to /dev/mem may indeed provoke a similar splat when (ab)used in a
> similar manner.

I was exactly thinking at this last abuse indeed. Maybe other archs
are affected.

thanks,
Domenico

-- 
3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
