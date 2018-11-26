From: Steve.Capper@arm.com (Steve Capper)
Date: Mon, 26 Nov 2018 12:13:36 +0000
Subject: [PATCH V3 4/5] arm64: mm: introduce 52-bit userspace support
In-Reply-To: <20181123183516.GM3360@arrakis.emea.arm.com>
References: <20181114133920.7134-1-steve.capper@arm.com>
 <20181114133920.7134-5-steve.capper@arm.com>
 <20181123183516.GM3360@arrakis.emea.arm.com>
Message-ID: <20181126121322.GC2012@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 06:35:16PM +0000, Catalin Marinas wrote:
> On Wed, Nov 14, 2018 at 01:39:19PM +0000, Steve Capper wrote:
> > diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> > index 2e05bcd944c8..56c3ccabeffe 100644
> > --- a/arch/arm64/include/asm/pgalloc.h
> > +++ b/arch/arm64/include/asm/pgalloc.h
> > @@ -27,7 +27,11 @@
> >  #define check_pgt_cache()		do { } while (0)
> >  
> >  #define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
> > +#ifdef CONFIG_ARM64_52BIT_VA
> > +#define PGD_SIZE	((1 << (52 - PGDIR_SHIFT)) * sizeof(pgd_t))
> > +#else
> >  #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
> > +#endif
> 
> This introduces a mismatch between PTRS_PER_PGD and PGD_SIZE. While it
> happens not to corrupt any memory (we allocate a full page for pgdirs),
> the compiler complains about the memset() in map_entry_trampoline()
> since tramp_pg_dir[] is smaller.

Thanks Catalin,
I think the way forward may be to remove the sizes from the
declarations for tramp_pg_dir and friends as they are specified to be
PAGE_SIZE by the linker script anyway.

I think this should be in a separate patch preceeding this one, will get
something ready.

(I'll also upgrade my build system :-) )

Cheers,
-- 
Steve
