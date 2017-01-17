From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jan 2017 17:19:30 +0000
Subject: [PATCH] arm64: mm: fix __page_to_voff definition
In-Reply-To: <e57db47e-3c3a-1344-9492-442b37c6897c@gmail.com>
References: <1484666633-1753-1-git-send-email-andr2000@gmail.com>
 <20170117161546.GF11939@leverpostej>
 <e57db47e-3c3a-1344-9492-442b37c6897c@gmail.com>
Message-ID: <20170117171929.GA367@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 07:13:45PM +0200, Oleksandr Andrushchenko wrote:
> On 01/17/2017 06:15 PM, Mark Rutland wrote:
> >On Tue, Jan 17, 2017 at 05:23:53PM +0200, Oleksandr Andrushchenko wrote:
> >>From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
> >>
> >>Fix parameter name for __page_to_voff, to match its definition.
> >>There are other callers of page_to_virt which do not
> >>declare 'page'.
> >>
> >>Fixes: 3fa72fe9c614 ("arm64: mm: fix __page_to_voff definition")
> >>Signed-off-by: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
> >I take it this is because it messes up the 'struct page' at the end of
> >the macro expansion?
> yes, you got it right
> >It would be good to explicitly state that, since that's not immediately
> >obvious.
> Will do that in patch v1
> >
> >With that:
> >
> >Acked-by: Mark Rutland <mark.rutland@arm.com>
> Can I put your ack into the v1?

Yes, with the updated commit message and title, you can add my ack.

W.r.t. wording, I'd recommend:

  arm64: mm: avoid name clash in __page_to_voff()

  The arm64 __page_to_voff() macro taks a parameter called 'page', and
  also refers to 'struct page'. Thus, if the value passed in is not
  called 'page', we'll refer to the wrong struct name (which might not
  exist).

  Rename the parameter so that it doesn't clash.

Thanks,
Mark.

> >
> >Thanks,
> >Mark.
> Thanks,
> Oleksandr
> >>---
> >>  arch/arm64/include/asm/memory.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> >>index bfe632808d77..90c39a662379 100644
> >>--- a/arch/arm64/include/asm/memory.h
> >>+++ b/arch/arm64/include/asm/memory.h
> >>@@ -222,7 +222,7 @@ static inline void *phys_to_virt(phys_addr_t x)
> >>  #define _virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
> >>  #else
> >>  #define __virt_to_pgoff(kaddr)	(((u64)(kaddr) & ~PAGE_OFFSET) / PAGE_SIZE * sizeof(struct page))
> >>-#define __page_to_voff(page)	(((u64)(page) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
> >>+#define __page_to_voff(kaddr)	(((u64)(kaddr) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
> >>  #define page_to_virt(page)	((void *)((__page_to_voff(page)) | PAGE_OFFSET))
> >>  #define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
> >>-- 
> >>2.7.4
> >>
> >>
> >>_______________________________________________
> >>linux-arm-kernel mailing list
> >>linux-arm-kernel at lists.infradead.org
> >>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
