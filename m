From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Dec 2015 16:27:45 +0000
Subject: [PATCH v3 6/7] arm64: map linear region as non-executable
In-Reply-To: <CAKv+Gu-e+FpXQGFWebBKieSJk7MT_SGEW8OLQFC5QopEPgPq-Q@mail.gmail.com>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447672998-20981-7-git-send-email-ard.biesheuvel@linaro.org>
 <20151207161953.GE7083@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-e+FpXQGFWebBKieSJk7MT_SGEW8OLQFC5QopEPgPq-Q@mail.gmail.com>
Message-ID: <20151207162744.GF7083@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 05:22:32PM +0100, Ard Biesheuvel wrote:
> On 7 December 2015 at 17:19, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Nov 16, 2015 at 12:23:17PM +0100, Ard Biesheuvel wrote:
> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >> index c7ba171951c8..526eeb7e1e97 100644
> >> --- a/arch/arm64/mm/mmu.c
> >> +++ b/arch/arm64/mm/mmu.c
> >> @@ -357,47 +357,10 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
> >>                               phys, virt, size, prot, late_alloc);
> >>  }
> >>
> >> -#ifdef CONFIG_DEBUG_RODATA
> >>  static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
> >>  {
> >> -     /*
> >> -      * Set up the executable regions using the existing section mappings
> >> -      * for now. This will get more fine grained later once all memory
> >> -      * is mapped
> >> -      */
> >> -     unsigned long kernel_x_start = round_down(__pa(_stext), SWAPPER_BLOCK_SIZE);
> >> -     unsigned long kernel_x_end = round_up(__pa(__init_end), SWAPPER_BLOCK_SIZE);
> >> -
> >> -     if (end < kernel_x_start) {
> >> -             create_mapping(start, __phys_to_virt(start),
> >> -                     end - start, PAGE_KERNEL);
> >> -     } else if (start >= kernel_x_end) {
> >> -             create_mapping(start, __phys_to_virt(start),
> >> -                     end - start, PAGE_KERNEL);
> >> -     } else {
> >> -             if (start < kernel_x_start)
> >> -                     create_mapping(start, __phys_to_virt(start),
> >> -                             kernel_x_start - start,
> >> -                             PAGE_KERNEL);
> >> -             create_mapping(kernel_x_start,
> >> -                             __phys_to_virt(kernel_x_start),
> >> -                             kernel_x_end - kernel_x_start,
> >> -                             PAGE_KERNEL_EXEC);
> >> -             if (kernel_x_end < end)
> >> -                     create_mapping(kernel_x_end,
> >> -                             __phys_to_virt(kernel_x_end),
> >> -                             end - kernel_x_end,
> >> -                             PAGE_KERNEL);
> >> -     }
> >> -
> >> -}
> >> -#else
> >> -static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
> >> -{
> >> -     create_mapping(start, __phys_to_virt(start), end - start,
> >> -                     PAGE_KERNEL_EXEC);
> >> +     create_mapping(start, __phys_to_virt(start), end - start, PAGE_KERNEL);
> >>  }
> >> -#endif
> >>
> >>  struct bootstrap_pgtables {
> >>       pte_t   pte[PTRS_PER_PTE];
> >> @@ -471,7 +434,7 @@ static unsigned long __init bootstrap_region(struct bootstrap_pgtables *reg,
> >>                                     SWAPPER_BLOCK_SIZE));
> >>
> >>               create_mapping(__pa(vstart - va_offset), vstart, vend - vstart,
> >> -                            PAGE_KERNEL_EXEC);
> >> +                            PAGE_KERNEL);
> >>
> >>               return vend;
> >>       }
> >
> > These make sense. However, shall we go a step further and unmap the
> > kernel image completely from the linear mapping, maybe based on
> > CONFIG_DEBUG_RODATA? The mark_rodata_ro() function changes the text to
> > read-only but you can still get writable access to it via
> > __va(__pa(_stext)).
> 
> If we can tolerate the fragmentation, then yes, let's unmap it
> completely. As long as we don't unmap the.pgdir section, since that
> will be referenced via the linear mapping

I think we should do this in mark_rodata_ro() function *if*
CONFIG_DEBUG_RODATA is enabled, otherwise we leave them as they are
(non-exec linear mapping).

The problem, as before is potential TLB conflicts that Mark is going to
solve ;).

-- 
Catalin
