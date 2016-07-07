From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 7 Jul 2016 09:49:43 +0900
Subject: [PATCH v21 4/8] arm64: kdump: add kdump support
In-Reply-To: <1467826689.8880.39.camel@infradead.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-5-takahiro.akashi@linaro.org>
 <1467826689.8880.39.camel@infradead.org>
Message-ID: <20160707004942.GV20774@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 10:38:09AM -0700, Geoff Levand wrote:
> On Wed, 2016-07-06 at 16:52 +0900, AKASHI Takahiro wrote:
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -136,6 +137,57 @@ static void __init reserve_crashkernel(void)
> >  }
> >  #endif /* CONFIG_KEXEC_CORE */
> >  
> > +#ifdef CONFIG_CRASH_DUMP
> > +static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
> > +> 	> 	> const char *uname, int depth, void *data)
> > +{
> > +> 	> const __be32 *reg;
> > +> 	> int len;
> > +
> > +> 	> if (depth != 1 || strcmp(uname, "chosen") != 0)
> > +> 	> 	> return 0;
> > +
> > +> 	> reg = of_get_flat_dt_prop(node, "linux,elfcorehdr", &len);
> > +> 	> if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
> > +> 	> 	> return 1;
> > +
> > +> 	> elfcorehdr_addr = dt_mem_next_cell(dt_root_addr_cells, ??);
> > +> 	> elfcorehdr_size = dt_mem_next_cell(dt_root_size_cells, ??);
> > +
> > +> 	> return 1;
> > +}
> > +
> > +/*
> > + * reserve_elfcorehdr() - reserves memory for elf core header
> > + *
> > + * This function reserves elf core header given in "elfcorehdr=" kernel
> > + * command line parameter. This region contains all the information about
> > + * primary kernel's core image and is used by a dump capture kernel to
> > + * access the system memory on primary kernel.
> > + */
> > +static void __init reserve_elfcorehdr(void)
> > +{
> 
> It seems like you could get rid of all these conditionals by
> just putting this here:
> 
> 	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
> 		return;

Add this to reserve_elfcorehdr()?
Unfortunately, it won't work because this function accesses
elfcorehdr_addr & elfcorehdr_size which are defined only
if CONFIG_CRASH_DUMP.

Thanks,
-Takahiro AKASHI

> 
> > +> 	> of_scan_flat_dt(early_init_dt_scan_elfcorehdr, NULL);
> > +
> > +> 	> if (!elfcorehdr_size)
> > +> 	> 	> return;
> > +
> > +> 	> if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
> > +> 	> 	> pr_warn("elfcorehdr is overlapped\n");
> > +> 	> 	> return;
> > +> 	> }
> > +
> > +> 	> memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
> > +
> > +> 	> pr_info("Reserving %lldKB of memory at 0x%llx for elfcorehdr\n",
> > +> 	> 	> elfcorehdr_size >> 10, elfcorehdr_addr);
> > +}
> > +#else
> > +static void __init reserve_elfcorehdr(void)
> > +{
> > +> 	> ;
> > +}
> > +#endif /* CONFIG_CRASH_DUMP */
> >  /*
> >   * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
> >   * currently assumes that for memory starting above 4G, 32-bit devices will
> > @@ -389,6 +441,8 @@ void __init arm64_memblock_init(void)
> >  
> >  > 	> reserve_crashkernel();
> >  
> > +> 	> reserve_elfcorehdr();
> > +
> >  > 	> early_init_fdt_scan_reserved_mem();
> >  
> >  > 	> /* 4GB maximum for 32-bit only capable devices */
> 
