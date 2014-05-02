From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 2 May 2014 10:59:37 +0100
Subject: [PATCH] arm64: mm: Optimise tlb flush logic where we have >4K
 granule
In-Reply-To: <20140502092905.GA17370@arm.com>
References: <1399021303-30911-1-git-send-email-steve.capper@linaro.org>
 <20140502092905.GA17370@arm.com>
Message-ID: <20140502095936.GA32228@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 10:29:05AM +0100, Will Deacon wrote:
> Hi Steve,

Hey Will,

> 
> On Fri, May 02, 2014 at 10:01:43AM +0100, Steve Capper wrote:
> > The tlb maintainence functions: __cpu_flush_user_tlb_range and
> > __cpu_flush_kern_tlb_range do not take into consideration the page
> > granule when looping through the address range, and repeatedly flush
> > tlb entries for the same page when operating with 64K pages.
> > 
> > This patch re-works the logic s.t. we instead advance the loop by
> >  1 << (PAGE_SHIFT - 12), so avoid repeating ourselves.
> > 
> > Also the routines have been converted from assembler to static inline
> > functions to aid with legibility and potential compiler optimisations.
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > ---
> > Hello,
> > Options have been added to the dsbs in this patch. At the moment the
> > dsb macro ignores the option, but this is set to change in future.
> > 
> > As always comments/critique/testers welcome!
> 
> This is likely to conflict with some barrier re-work I'm doing, but the
> conflict will be trivial (and I'll probably be the guy fixing it up anyway
> :).
> 
> One other comment below...
> 
> > diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> > index 8b48203..7881d7d 100644
> > --- a/arch/arm64/include/asm/tlbflush.h
> > +++ b/arch/arm64/include/asm/tlbflush.h
> > @@ -98,11 +98,31 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
> >  	dsb();
> >  }
> >  
> > -/*
> > - * Convert calls to our calling convention.
> > - */
> > -#define flush_tlb_range(vma,start,end)	__cpu_flush_user_tlb_range(start,end,vma)
> > -#define flush_tlb_kernel_range(s,e)	__cpu_flush_kern_tlb_range(s,e)
> > +static inline void flush_tlb_range(struct vm_area_struct *vma,
> > +					unsigned long start, unsigned long end)
> > +{
> > +	unsigned long asid = (unsigned long)ASID(vma->vm_mm) << 48;
> > +	unsigned long addr;
> > +	start = asid | (start >> 12);
> > +	end = asid | (end >> 12);
> > +
> > +	dsb(ishst);
> > +	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
> > +		asm("tlbi vae1is, %0" : : "r"(addr));
> > +	dsb(ish);
> > +}
> > +
> > +static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> > +{
> > +	unsigned long addr;
> > +	start >>= 12;
> > +	end >>= 12;
> > +
> > +	dsb(ishst);
> > +	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
> > +		asm("tlbi vaae1is, %0" : : "r"(addr));
> > +	dsb(ish);
> 
> Why have you removed the isb() here? There's not a guaranteed exception
> return back to kernel text, so you could argue that it's needed. That
> said, when do we actually remap kernel text? Modules are one place, but
> then there's already I-side flushing (with an isb) associated with that.

Thanks, that's a slip on my part. I will add the isb(.).

I can see the .text being re-mapped rw/ro by future patches.

Cheers,
-- 
Steve

> 
> Assuming that logic works out:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Will
> 
> > diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> > index b51d364..3ecb56c 100644
> > --- a/arch/arm64/mm/Makefile
> > +++ b/arch/arm64/mm/Makefile
> > @@ -1,5 +1,5 @@
> >  obj-y				:= dma-mapping.o extable.o fault.o init.o \
> >  				   cache.o copypage.o flush.o \
> >  				   ioremap.o mmap.o pgd.o mmu.o \
> > -				   context.o tlb.o proc.o
> > +				   context.o proc.o
> >  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
> > diff --git a/arch/arm64/mm/tlb.S b/arch/arm64/mm/tlb.S
> > deleted file mode 100644
> > index 19da91e..0000000
> > --- a/arch/arm64/mm/tlb.S
> > +++ /dev/null
> > @@ -1,71 +0,0 @@
> > -/*
> > - * Based on arch/arm/mm/tlb.S
> > - *
> > - * Copyright (C) 1997-2002 Russell King
> > - * Copyright (C) 2012 ARM Ltd.
> > - * Written by Catalin Marinas <catalin.marinas@arm.com>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - * GNU General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU General Public License
> > - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > - */
> > -#include <linux/linkage.h>
> > -#include <asm/assembler.h>
> > -#include <asm/asm-offsets.h>
> > -#include <asm/page.h>
> > -#include <asm/tlbflush.h>
> > -#include "proc-macros.S"
> > -
> > -/*
> > - *	__cpu_flush_user_tlb_range(start, end, vma)
> > - *
> > - *	Invalidate a range of TLB entries in the specified address space.
> > - *
> > - *	- start - start address (may not be aligned)
> > - *	- end   - end address (exclusive, may not be aligned)
> > - *	- vma   - vma_struct describing address range
> > - */
> > -ENTRY(__cpu_flush_user_tlb_range)
> > -	vma_vm_mm x3, x2			// get vma->vm_mm
> > -	mmid	w3, x3				// get vm_mm->context.id
> > -	dsb	sy
> > -	lsr	x0, x0, #12			// align address
> > -	lsr	x1, x1, #12
> > -	bfi	x0, x3, #48, #16		// start VA and ASID
> > -	bfi	x1, x3, #48, #16		// end VA and ASID
> > -1:	tlbi	vae1is, x0			// TLB invalidate by address and ASID
> > -	add	x0, x0, #1
> > -	cmp	x0, x1
> > -	b.lo	1b
> > -	dsb	sy
> > -	ret
> > -ENDPROC(__cpu_flush_user_tlb_range)
> > -
> > -/*
> > - *	__cpu_flush_kern_tlb_range(start,end)
> > - *
> > - *	Invalidate a range of kernel TLB entries.
> > - *
> > - *	- start - start address (may not be aligned)
> > - *	- end   - end address (exclusive, may not be aligned)
> > - */
> > -ENTRY(__cpu_flush_kern_tlb_range)
> > -	dsb	sy
> > -	lsr	x0, x0, #12			// align address
> > -	lsr	x1, x1, #12
> > -1:	tlbi	vaae1is, x0			// TLB invalidate by address
> > -	add	x0, x0, #1
> > -	cmp	x0, x1
> > -	b.lo	1b
> > -	dsb	sy
> > -	isb
> > -	ret
> > -ENDPROC(__cpu_flush_kern_tlb_range)
> > -- 
> > 1.8.1.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
