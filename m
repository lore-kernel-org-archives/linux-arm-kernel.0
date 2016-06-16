From: geoff@infradead.org (Geoff Levand)
Date: Thu, 16 Jun 2016 15:41:06 -0700
Subject: [PATCH v18 03/13] arm64/kexec: Add core kexec support
In-Reply-To: <57618C1B.6000202@arm.com>
References: <cover.1465502767.git.geoff@infradead.org>
 <84e50e4043a2061e0f5d9273f55e158c59754af0.1465502767.git.geoff@infradead.org>
 <57618C1B.6000202@arm.com>
Message-ID: <1466116866.21058.48.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-06-15 at 18:10 +0100, James Morse wrote:
> On 09/06/16 21:08, Geoff Levand wrote:
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -0,0 +1,185 @@
> > +/*
> > + * kexec for arm64
> > + *
> > + * Copyright (C) Linaro.
> > + * Copyright (C) Huawei Futurewei Technologies.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include 
> 
> We don't have/need highmem on arm64. The kmap()/kunmap() calls just obscure what
> is going on.
> 
> 
> > +#include 
> > +#include 
> 
> What do you need of_fdt.h for? I guess this should be in patch 4.
> 
> 
> > +#include 
> 
> The control page was already allocated, I can't see anything else being
> allocated... What do you need slab.h for?
> 
> 
> > +#include 
> > +#include 
> 
> User space access? I guess this should be in patch 4.
> 
> 
> > +
> > +#include 
> > +#include 
> > +#include 
> > +#include 
> 
> I can't see anything in system_misc.h that you are using in here.

I cleaned up all these includes.

> > + * kexec_list_flush - Helper to flush the kimage list to PoC.
> > + */
> > +static void kexec_list_flush(struct kimage *kimage)
> > +{
> > +> > 	> > kimage_entry_t *entry;
> > +> > 	> > unsigned int flag;
> > +
> > +> > 	> > for (entry = &kimage->head, flag = 0; flag != IND_DONE; entry++) {
> > +> > 	> > 	> > void *addr = kmap(phys_to_page(*entry & PAGE_MASK));
> > +
> > +> > 	> > 	> > flag = *entry & IND_FLAGS;
> > +
> > +> > 	> > 	> > switch (flag) {
> > +> > 	> > 	> > case IND_INDIRECTION:
> > +> > 	> > 	> > 	> > entry = (kimage_entry_t *)addr - 1;
> 
> This '-1' is so that entry points before the first entry of the new table,
> and is un-done by entry++ next time round the loop...
> If I'm right, could you add a comment to that effect? It took me a little while
> to work out!

I added a comment.

> kexec_core.c has a snazzy macro: for_each_kimage_entry(), its a shame its not in
> a header file.
> This loop does the same but with two variables instead of three. These
> IN_INDIRECTION pages only appear at the end of a list, this list-walking looks
> correct.
> 
> 
> > +> > 	> > 	> > 	> > __flush_dcache_area(addr, PAGE_SIZE);
> 
> So if we find an indirection pointer, we switch entry to the new page, and clean
> it to the PoC, because later we walk this list with the MMU off.
> 
> But what cleans the very first page?

I don't think this routine was doing the quite the right thing.  The
arm64_relocate_new_kernel routine uses the list (the entry's), and
the second stage kernel buffers (the IND_SOURCE's). Those two things
are what should be flushed here.

> > +> > 	> > 	> > 	> > break;
> > +> > 	> > 	> > case IND_DESTINATION:
> > +> > 	> > 	> > 	> > break;
> > +> > 	> > 	> > case IND_SOURCE:
> > +> > 	> > 	> > 	> > __flush_dcache_area(addr, PAGE_SIZE);
> > +> > 	> > 	> > 	> > break;
> > +> > 	> > 	> > case IND_DONE:
> > +> > 	> > 	> > 	> > break;
> > +> > 	> > 	> > default:
> > +> > 	> > 	> > 	> > BUG();
> 
> Unless you think its less readable, you could group the clauses together:

Takahiro found a bug when CONFIG_SPARSEMEM_VMEMMAP=n, and this code
has now been reworked.

> > 	> > 	> > case IND_INDIRECTION:
> > 	> > 	> > 	> > entry = (kimage_entry_t *)addr - 1;
> > 	> > 	> > case IND_SOURCE:
> > 	> > 	> > 	> > __flush_dcache_area(addr, PAGE_SIZE);
> > 	> > 	> > case IND_DESTINATION:
> > 	> > 	> > case IND_DONE:
> > 	> > 	> > 	> > break;
> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> > new file mode 100644
> > index 0000000..e380db3
> > --- /dev/null
> > +++ b/arch/arm64/kernel/relocate_kernel.S
> > @@ -0,0 +1,131 @@
> > +.globl arm64_relocate_new_kernel
> > +arm64_relocate_new_kernel:
> 
> All the other asm functions use ENTRY(), which would do the .globl and alignment
> for you. (You would need a ENDPROC(arm64_relocate_new_kernel) too.)

Sure.

> > +
> > +> > 	> > /* Setup the list loop variables. */
> > +> > 	> > mov> > 	> > x18, x1> > 	> > 	> > 	> > 	> > /* x18 = kimage_start */
> > +> > 	> > mov> > 	> > x17, x0> > 	> > 	> > 	> > 	> > /* x17 = kimage_head */
> > +> > 	> > dcache_line_size x16, x0> > 	> > 	> > /* x16 = dcache line size */
> > +> > 	> > mov> > 	> > x15, xzr> > 	> > 	> > 	> > /* x15 = segment start */
> 
> What uses this 'segment start'?

That is left over from when we booted without purgatory (as
the arm arch does).

> > +> > 	> > mov> > 	> > x14, xzr> > 	> > 	> > 	> > /* x14 = entry ptr */
> > +> > 	> > mov> > 	> > x13, xzr> > 	> > 	> > 	> > /* x13 = copy dest */
> > +
> > +> > 	> > /* Clear the sctlr_el2 flags. */
> > +> > 	> > mrs> > 	> > x0, CurrentEL
> > +> > 	> > cmp> > 	> > x0, #CurrentEL_EL2
> > +> > 	> > b.ne> > 	> > 1f
> > +> > 	> > mrs> > 	> > x0, sctlr_el2
> > +> > 	> > ldr> > 	> > x1, =SCTLR_ELx_FLAGS
> > +> > 	> > bic> > 	> > x0, x0, x1
> > +> > 	> > msr> > 	> > sctlr_el2, x0
> > +> > 	> > isb
> > +1:
> > +
> > +> > 	> > /* Check if the new image needs relocation. */
> > +> > 	> > cbz> > 	> > x17, .Ldone
> 
> Does this happen? Do we ever come across an empty slot in the tables?
> 
> kimage_terminate() adds the IND_DONE entry, so we should never see an empty
> slot. kexec_list_flush() would BUG() on this too, and we call that
> unconditionally on the way in here.

I put that in just in case, but never checked if it would
ever actually happen.  I can take it out.

> > +> > 	> > tbnz> > 	> > x17, IND_DONE_BIT, .Ldone
> > +
> > +.Lloop:
> > +> > 	> > and> > 	> > x12, x17, PAGE_MASK> > 	> > 	> > /* x12 = addr */
> > +
> > +> > 	> > /* Test the entry flags. */
> > +.Ltest_source:
> > +> > 	> > tbz> > 	> > x17, IND_SOURCE_BIT, .Ltest_indirection
> > +
> > +> > 	> > /* Invalidate dest page to PoC. */
> > +> > 	> > mov     x0, x13
> > +> > 	> > add     x20, x0, #PAGE_SIZE
> > +> > 	> > sub     x1, x16, #1
> > +> > 	> > bic     x0, x0, x1
> > +2:> > 	> > dc      ivac, x0
> 
> This relies on an IND_DESTINATION being found first for x13 to be set to
> something other than 0. I guess if kexec-core hands us a broken list, all bets
> are off!

Yes, assumed to be IND_DESTINATION.

> > +
> > +.Ldone:
> 
>         /* wait for writes from copy_page to finish */

Added.

> > +	dsb	nsh
> > +> > 	> > ic> > 	> > iallu
> > +> > 	> > dsb> > 	> > nsh
> > +> > 	> > isb
> > +
> > +> > 	> > /* Start new image. */
> > +> > 	> > mov> > 	> > x0, xzr
> > +> > 	> > mov> > 	> > x1, xzr
> > +> > 	> > mov> > 	> > x2, xzr
> > +> > 	> > mov> > 	> > x3, xzr
> > +> > 	> > br> > 	> > x18
> > +
> > +.ltorg
> > +
> > +.align 3> > 	> > /* To keep the 64-bit values below naturally aligned. */
> > +
> > +.Lcopy_end:
> > +.org> > 	> > KEXEC_CONTROL_PAGE_SIZE
> 
> Why do we need to pad up to KEXEC_CONTROL_PAGE_SIZE?
> In machine_kexec() we only copy arm64_relocate_new_kernel_size bytes, so it
> shouldn't matter what is here. As far as I can see we don't even access it.

This is to check if arm64_relocate_new_kernel gets too
big.  The assembler should give an error if the location
counter is set backwards.

-Geoff
