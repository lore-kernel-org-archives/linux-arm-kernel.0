From: jays.lee@samsung.com (Jungseok Lee)
Date: Fri, 02 May 2014 11:13:03 +0900
Subject: [PATCH v5 3/6] arm64: Add a description on 48-bit address space
 with 4KB pages
In-Reply-To: <20140501100612.GA2848@lvm>
References: <000301cf64e5$d27f9a20$777ece60$@samsung.com>
 <20140501100612.GA2848@lvm>
Message-ID: <000101cf65ac$0ce4b850$26ae28f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 01, 2014 7:06 PM, Christoffer Dall wrote:
> On Thu, May 01, 2014 at 11:34:05AM +0900, Jungseok Lee wrote:
> > This patch adds memory layout and translation lookup information about
> > 48-bit address space with 4K pages. The description is based on 4
> > levels of translation tables.
> >
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Steve Capper <steve.capper@linaro.org>
> > Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
> > Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
> > ---
> >  Documentation/arm64/memory.txt |   59 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 51 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/arm64/memory.txt
> > b/Documentation/arm64/memory.txt index d50fa61..8142709 100644
> > --- a/Documentation/arm64/memory.txt
> > +++ b/Documentation/arm64/memory.txt
> > @@ -8,10 +8,11 @@ This document describes the virtual memory layout
> > used by the AArch64  Linux kernel. The architecture allows up to 4
> > levels of translation  tables with a 4KB page size and up to 3 levels with a 64KB page size.
> >
> > -AArch64 Linux uses 3 levels of translation tables with the 4KB page
> > -configuration, allowing 39-bit (512GB) virtual addresses for both
> > user -and kernel. With 64KB pages, only 2 levels of translation tables
> > are -used but the memory layout is the same.
> > +AArch64 Linux uses 3 levels and 4 levels of translation tables with
> 
> uses either 3 or 4 levels of translation?

Yes, you are right. I will fix it.

> > +the 4KB page configuration, allowing 39-bit (512GB) and 48-bit
> > +(256TB) virtual addresses, respectively, for both user and kernel.
> > +With 64KB pages, only 2 levels of translation tables are used but the
> > +memory layout is the same.
> 
> Perhaps it's worth clarifying that with 64KB and 2 levels of translation tables we are limited to a
> 42-bit address space here.

Okay, I will add it.

> >
> >  User addresses have bits 63:39 set to 0 while the kernel addresses
> > have  the same bits set to 1. TTBRx selection is given by bit 63 of
> > the @@ -21,7 +22,7 @@ The swapper_pgd_dir address is written to TTBR1
> > and never written to  TTBR0.
> >
> >
> > -AArch64 Linux memory layout with 4KB pages:
> > +AArch64 Linux memory layout with 4KB pages + 3 levels:
> >
> >  Start			End			Size		Use
> >  -----------------------------------------------------------------------
> > @@ -48,7 +49,34 @@ ffffffbffc000000	ffffffbfffffffff	  64MB		modules
> >  ffffffc000000000	ffffffffffffffff	 256GB		kernel logical memory map
> >
> >
> > -AArch64 Linux memory layout with 64KB pages:
> > +AArch64 Linux memory layout with 4KB pages + 4 levels:
> > +
> > +Start			End			Size		Use
> > +-----------------------------------------------------------------------
> > +0000000000000000	0000ffffffffffff	 256TB		user
> > +
> > +ffff000000000000	ffff7bfffffeffff	~124TB		vmalloc
> > +
> > +ffff7bffffff0000	ffff7bffffffffff	  64KB		[guard page]
> > +
> > +ffff7c0000000000	ffff7dffffffffff	   2TB		vmemmap
> > +
> > +ffff7e0000000000	ffff7ffffbbfffff	  ~2TB		[guard, future vmmemap]
> 
> hmm, I may be completely confused, but if VMALLOC_END is defined to be (PAGE_OFFSET - UL(0x400000000)
> - SZ_64K), how can we squeeze ~4TB into a 16 GB hole?

In the 5th patch, VMALLOC_END is changed to (PAGE_OFFSET - UL(0x40000000000)
- SZ_64K) when 4 level is set.

> > +
> > +ffff7ffffa000000	ffff7ffffaffffff	  16MB		PCI I/O space
> > +
> > +ffff7ffffb000000	ffff7ffffbbfffff	  12MB		[guard]
> > +
> > +ffff7ffffbc00000	ffff7ffffbdfffff	   2MB		earlyprintk device
> 
> shouldn't this be "fixed mappings" now?

Thanks!! I will fix it.

Best Regards
Jungseok Lee
