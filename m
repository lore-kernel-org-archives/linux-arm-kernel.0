From: minchan@kernel.org (Minchan Kim)
Date: Fri, 14 Sep 2018 15:26:55 +0900
Subject: [RFC 1/3] arm: mm: reordering memory type table
In-Reply-To: <20180910165011.zcighyuabshsmxjb@armageddon.cambridge.arm.com>
References: <20180906102212.218294-1-minchan@kernel.org>
 <20180906102212.218294-2-minchan@kernel.org>
 <20180910165011.zcighyuabshsmxjb@armageddon.cambridge.arm.com>
Message-ID: <20180914062655.GA102810@rodete-desktop-imager.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 05:50:11PM +0100, Catalin Marinas wrote:
> On Thu, Sep 06, 2018 at 07:22:10PM +0900, Minchan Kim wrote:
> > diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> > index 92fd2c8a9af0..91b99fadcba1 100644
> > --- a/arch/arm/include/asm/pgtable-2level.h
> > +++ b/arch/arm/include/asm/pgtable-2level.h
> > @@ -164,14 +164,23 @@
> >  #define L_PTE_MT_BUFFERABLE	(_AT(pteval_t, 0x01) << 2)	/* 0001 */
> >  #define L_PTE_MT_WRITETHROUGH	(_AT(pteval_t, 0x02) << 2)	/* 0010 */
> >  #define L_PTE_MT_WRITEBACK	(_AT(pteval_t, 0x03) << 2)	/* 0011 */
> > +#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
> >  #define L_PTE_MT_MINICACHE	(_AT(pteval_t, 0x06) << 2)	/* 0110 (sa1100, xscale) */
> >  #define L_PTE_MT_WRITEALLOC	(_AT(pteval_t, 0x07) << 2)	/* 0111 */
> > -#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
> > -#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
> > +#if defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7M) || \
> > +	defined (CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
> > +#define L_PTE_MT_DEV_WC		L_PTE_MT_BUFFERABLE
> > +#define L_PTE_MT_DEV_CACHED	L_PTE_MT_WRITEBACK
> > +#define L_PTE_MT_DEV_NONSHARED	L_PTE_MT_MINICACHE
> 
> I think you can just ignore v7M here, it doesn't have an MMU.

I didn't know that. Will fix.

> 
> You are defining L_PTE_MT_DEV_NONSHARED to L_PTE_MT_MINICACHE but what I
> think you just meant is index 6 in the cpu_v6_mt_table which I would use
> explicitly to avoid confusion.
> 
> Anyway, on ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to
> shared device in hardware. Looking through the arm32 code, it seems that

Thanks for the information. I didn't know that.

> MT_DEVICE_NONSHARED is used by arch/arm/mach-shmobile/setup-r8a7779.c
> and IIUC that's a v7 platform (R-Car H1, Cortex-A9). I think the above
> should be defined to L_PTE_MT_DEV_SHARED, unless I miss any place where
> DEV_NONSHARED is relevant on ARMv6 (adding Simon to confirm on
> shmobile).

Simon, could you confirm this?

> 
> > diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> > index 81d0efb055c6..f896a30653fa 100644
> > --- a/arch/arm/mm/proc-macros.S
> > +++ b/arch/arm/mm/proc-macros.S
> > @@ -134,21 +134,21 @@
> >  	.macro	armv6_mt_table pfx
> >  \pfx\()_mt_table:
> 
> Since you changed the MT index, you'd have to fix proc-v7-*levels.S  as
> well. If you define DEV_NONSHARED to SHARED, I think you only need to
> update the index for L_PTE_MT_VECTORS.

Good idea. I will try it on.

Thanks for the review, Catalin.
