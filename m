From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 3 Apr 2017 11:28:44 +0900
Subject: [PATCH v34 06/14] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <CAKv+Gu-7eQaceTK7q35FkTnmT2r+mLys9bWoK-aQxh_0enwLqQ@mail.gmail.com>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-4-takahiro.akashi@linaro.org>
 <CAKv+Gu8MFxQ8Lk2io7ywfe=em0qTm8MgCAfrFkQFtAoOaiNqkw@mail.gmail.com>
 <20170328110733.GB16309@linaro.org>
 <CAKv+Gu8_+WR3qrbxX4ZNZwnWDa=rpMgR=hsqzhtyC=n5+0zJUQ@mail.gmail.com>
 <20170330095625.GC16309@linaro.org>
 <CAKv+Gu-7eQaceTK7q35FkTnmT2r+mLys9bWoK-aQxh_0enwLqQ@mail.gmail.com>
Message-ID: <20170403022843.GD16309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 02:58:14PM +0100, Ard Biesheuvel wrote:
> On 30 March 2017 at 10:56, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > Date: Tue, 28 Mar 2017 15:51:24 +0900
> > Subject: [PATCH] arm64: kdump: protect crash dump kernel memory
> >
> > arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
> > are meant to be called by kexec_load() in order to protect the memory
> > allocated for crash dump kernel once the image is loaded.
> >
> > The protection is implemented by unmapping the relevant segments in crash
> > dump kernel memory, rather than making it read-only as other archs do,
> > to prevent coherency issues due to potential cache aliasing (with
> > mismatched attributes).
> >
> > Page-level mappings are consistently used here so that we can change
> > the attributes of segments in page granularity as well as shrink the region
> > also in page granularity through /sys/kernel/kexec_crash_size, putting
> > the freed memory back to buddy system.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> This looks mostly correct. One comment below.
> 
> > ---
> >  arch/arm64/kernel/machine_kexec.c |  32 +++++++++---
> >  arch/arm64/mm/mmu.c               | 103 ++++++++++++++++++++------------------
> >  2 files changed, 80 insertions(+), 55 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index bc96c8a7fc79..b63baa749609 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -14,7 +14,9 @@
> >
> >  #include <asm/cacheflush.h>
> >  #include <asm/cpu_ops.h>
> > +#include <asm/mmu.h>
> >  #include <asm/mmu_context.h>
> > +#include <asm/page.h>
> >
> >  #include "cpu-reset.h"
> >
> > @@ -22,8 +24,6 @@
> >  extern const unsigned char arm64_relocate_new_kernel[];
> >  extern const unsigned long arm64_relocate_new_kernel_size;
> >
> > -static unsigned long kimage_start;
> > -
> >  /**
> >   * kexec_image_info - For debugging output.
> >   */
> > @@ -64,8 +64,6 @@ void machine_kexec_cleanup(struct kimage *kimage)
> >   */
> >  int machine_kexec_prepare(struct kimage *kimage)
> >  {
> > -       kimage_start = kimage->start;
> > -
> >         kexec_image_info(kimage);
> >
> >         if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
> > @@ -183,7 +181,7 @@ void machine_kexec(struct kimage *kimage)
> >         kexec_list_flush(kimage);
> >
> >         /* Flush the new image if already in place. */
> > -       if (kimage->head & IND_DONE)
> > +       if ((kimage != kexec_crash_image) && (kimage->head & IND_DONE))
> >                 kexec_segment_flush(kimage);
> >
> >         pr_info("Bye!\n");
> > @@ -201,7 +199,7 @@ void machine_kexec(struct kimage *kimage)
> >          */
> >
> >         cpu_soft_restart(1, reboot_code_buffer_phys, kimage->head,
> > -               kimage_start, 0);
> > +               kimage->start, 0);
> >
> >         BUG(); /* Should never get here. */
> >  }
> > @@ -210,3 +208,25 @@ void machine_crash_shutdown(struct pt_regs *regs)
> >  {
> >         /* Empty routine needed to avoid build errors. */
> >  }
> > +
> > +void arch_kexec_protect_crashkres(void)
> > +{
> > +       int i;
> > +
> > +       kexec_segment_flush(kexec_crash_image);
> > +
> > +       for (i = 0; i < kexec_crash_image->nr_segments; i++)
> > +               set_memory_valid(
> > +                       __phys_to_virt(kexec_crash_image->segment[i].mem),
> > +                       kexec_crash_image->segment[i].memsz >> PAGE_SHIFT, 0);
> > +}
> > +
> > +void arch_kexec_unprotect_crashkres(void)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < kexec_crash_image->nr_segments; i++)
> > +               set_memory_valid(
> > +                       __phys_to_virt(kexec_crash_image->segment[i].mem),
> > +                       kexec_crash_image->segment[i].memsz >> PAGE_SHIFT, 1);
> > +}
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 91502e36e6d9..3cde5f2d30ec 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -22,6 +22,8 @@
> >  #include <linux/kernel.h>
> >  #include <linux/errno.h>
> >  #include <linux/init.h>
> > +#include <linux/ioport.h>
> > +#include <linux/kexec.h>
> >  #include <linux/libfdt.h>
> >  #include <linux/mman.h>
> >  #include <linux/nodemask.h>
> > @@ -393,10 +395,28 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
> >         flush_tlb_kernel_range(virt, virt + size);
> >  }
> >
> > -static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
> > +static void __init __map_memblock(pgd_t *pgd, phys_addr_t start,
> > +                                 phys_addr_t end, pgprot_t prot, int flags)
> > +{
> > +       __create_pgd_mapping(pgd, start, __phys_to_virt(start), end - start,
> > +                            prot, early_pgtable_alloc, flags);
> > +}
> > +
> > +void __init mark_linear_text_alias_ro(void)
> > +{
> > +       /*
> > +        * Remove the write permissions from the linear alias of .text/.rodata
> > +        */
> > +       update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
> > +                           (unsigned long)__init_begin - (unsigned long)_text,
> > +                           PAGE_KERNEL_RO);
> > +}
> > +
> > +static void __init map_mem(pgd_t *pgd)
> >  {
> >         phys_addr_t kernel_start = __pa_symbol(_text);
> >         phys_addr_t kernel_end = __pa_symbol(__init_begin);
> > +       struct memblock_region *reg;
> >         int flags = 0;
> >
> >         if (debug_pagealloc_enabled())
> > @@ -405,30 +425,28 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
> >         /*
> >          * Take care not to create a writable alias for the
> >          * read-only text and rodata sections of the kernel image.
> > +        * So temporarily mark them as NOMAP to skip mappings in
> > +        * the following for-loop
> >          */
> > +       memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> > +#ifdef CONFIG_KEXEC_CORE
> > +       if (crashk_res.end)
> > +               memblock_mark_nomap(crashk_res.start,
> > +                                   resource_size(&crashk_res));
> > +#endif
> >
> > -       /* No overlap with the kernel text/rodata */
> > -       if (end < kernel_start || start >= kernel_end) {
> > -               __create_pgd_mapping(pgd, start, __phys_to_virt(start),
> > -                                    end - start, PAGE_KERNEL,
> > -                                    early_pgtable_alloc, flags);
> > -               return;
> > -       }
> > +       /* map all the memory banks */
> > +       for_each_memblock(memory, reg) {
> > +               phys_addr_t start = reg->base;
> > +               phys_addr_t end = start + reg->size;
> >
> > -       /*
> > -        * This block overlaps the kernel text/rodata mappings.
> > -        * Map the portion(s) which don't overlap.
> > -        */
> > -       if (start < kernel_start)
> > -               __create_pgd_mapping(pgd, start,
> > -                                    __phys_to_virt(start),
> > -                                    kernel_start - start, PAGE_KERNEL,
> > -                                    early_pgtable_alloc, flags);
> > -       if (kernel_end < end)
> > -               __create_pgd_mapping(pgd, kernel_end,
> > -                                    __phys_to_virt(kernel_end),
> > -                                    end - kernel_end, PAGE_KERNEL,
> > -                                    early_pgtable_alloc, flags);
> > +               if (start >= end)
> > +                       break;
> > +               if (memblock_is_nomap(reg))
> > +                       continue;
> > +
> > +               __map_memblock(pgd, start, end, PAGE_KERNEL, flags);
> > +       }
> >
> >         /*
> >          * Map the linear alias of the [_text, __init_begin) interval
> > @@ -440,37 +458,24 @@ static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end
> >          * Note that contiguous mappings cannot be remapped in this way,
> >          * so we should avoid them here.
> >          */
> > -       __create_pgd_mapping(pgd, kernel_start, __phys_to_virt(kernel_start),
> > -                            kernel_end - kernel_start, PAGE_KERNEL,
> > -                            early_pgtable_alloc, NO_CONT_MAPPINGS);
> > -}
> > +       __map_memblock(pgd, kernel_start, kernel_end,
> > +                      PAGE_KERNEL_RO, NO_CONT_MAPPINGS);
> 
> This should be PAGE_KERNEL not PAGE_KERNEL_RO.

Ah, yes. Fixed it.

Thanks,
-Takahiro AKASHI


> > +       memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> >
> > -void __init mark_linear_text_alias_ro(void)
> > -{
> > +#ifdef CONFIG_KEXEC_CORE
> >         /*
> > -        * Remove the write permissions from the linear alias of .text/.rodata
> > +        * Use page-level mappings here so that we can shrink the region
> > +        * in page granularity and put back unused memory to buddy system
> > +        * through /sys/kernel/kexec_crash_size interface.
> >          */
> > -       update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
> > -                           (unsigned long)__init_begin - (unsigned long)_text,
> > -                           PAGE_KERNEL_RO);
> > -}
> > -
> > -static void __init map_mem(pgd_t *pgd)
> > -{
> > -       struct memblock_region *reg;
> > -
> > -       /* map all the memory banks */
> > -       for_each_memblock(memory, reg) {
> > -               phys_addr_t start = reg->base;
> > -               phys_addr_t end = start + reg->size;
> > -
> > -               if (start >= end)
> > -                       break;
> > -               if (memblock_is_nomap(reg))
> > -                       continue;
> > -
> > -               __map_memblock(pgd, start, end);
> > +       if (crashk_res.end) {
> > +               __map_memblock(pgd, crashk_res.start, crashk_res.end + 1,
> > +                              PAGE_KERNEL,
> > +                              NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> > +               memblock_clear_nomap(crashk_res.start,
> > +                                    resource_size(&crashk_res));
> >         }
> > +#endif
> >  }
> >
> >  void mark_rodata_ro(void)
> > --
> > 2.11.1
> >
