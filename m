From: jays.lee@samsung.com (Jungseok Lee)
Date: Wed, 30 Apr 2014 11:29:35 +0900
Subject: [PATCH v4 6/7] arm64: mm: Implement 4 levels of translation tables
In-Reply-To: <20140429170404.GA32121@localhost>
References: <000601cf6367$cffab890$6ff029b0$@samsung.com>
 <20140429170404.GA32121@localhost>
Message-ID: <007b01cf641c$07357700$15a06500$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 30, 2014 2:04 AM, Catalin Marinas wrote:
> On Tue, Apr 29, 2014 at 05:59:33AM +0100, Jungseok Lee wrote:
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S index
> > 0fd5650..03ec424 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -37,8 +37,9 @@
> >
> >  /*
> >   * swapper_pg_dir is the virtual address of the initial page table.
> > We place
> > - * the page tables 3 * PAGE_SIZE below KERNEL_RAM_VADDR. The
> > idmap_pg_dir has
> > - * 2 pages and is placed below swapper_pg_dir.
> > + * the page tables 3 * PAGE_SIZE (2 or 3 levels) or 4 * PAGE_SIZE (4
> > + levels)
> > + * below KERNEL_RAM_VADDR. The idmap_pg_dir has 2 pages (2 or 3
> > + levels) or
> > + * 3 pages (4 levels) and is placed below swapper_pg_dir.
> >   */
> >  #define KERNEL_RAM_VADDR       (PAGE_OFFSET + TEXT_OFFSET)
> >
> > @@ -46,8 +47,13 @@
> >  #error KERNEL_RAM_VADDR must start at 0xXXX80000  #endif
> >
> > +#ifdef CONFIG_ARM64_4_LEVELS
> > +#define SWAPPER_DIR_SIZE       (4 * PAGE_SIZE)
> > +#define IDMAP_DIR_SIZE         (3 * PAGE_SIZE)
> > +#else
> >  #define SWAPPER_DIR_SIZE       (3 * PAGE_SIZE)
> >  #define IDMAP_DIR_SIZE         (2 * PAGE_SIZE)
> > +#endif
> 
> Mark Rutland was doing some clean-up of this code to no longer place swapper_pg_dir and idmap_pg_dir
> below the kernel image. I'm not sure whether the patches ended up on the list yet (not a problem for
> now, just a slight change for your patches).

I don't see those patches in the mailing list yet.
I will keep it in mind. Thanks.

Best Regards
Jungseok Lee
