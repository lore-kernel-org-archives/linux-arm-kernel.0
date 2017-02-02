From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 2 Feb 2017 13:21:36 +0900
Subject: [PATCH v31 02/12] arm64: limit memory regions based on DT
 property, usable-memory-range
In-Reply-To: <20170201150700.GD4756@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-1-takahiro.akashi@linaro.org>
 <20170201150700.GD4756@leverpostej>
Message-ID: <20170202042135.GA13549@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 03:07:00PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Feb 01, 2017 at 09:46:21PM +0900, AKASHI Takahiro wrote:
> > +static int __init early_init_dt_scan_usablemem(unsigned long node,
> > +		const char *uname, int depth, void *data)
> > +{
> > +	struct memblock_region *usablemem = (struct memblock_region *)data;
> 
> Nit: unnecessary cast.

OK

> > +	const __be32 *reg;
> > +	int len;
> > +
> > +	usablemem->size = 0;
> 
> Could we please lift this assignment/initialisation into the caller...
> 
> > +
> > +	if (depth != 1 || strcmp(uname, "chosen") != 0)
> > +		return 0;
> > +
> > +	reg = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
> > +	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
> > +		return 1;
> > +
> > +	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> > +	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
> > +
> > +	return 1;
> > +}
> > +
> > +static void __init fdt_enforce_memory_region(void)
> > +{
> > +	struct memblock_region reg;
> 
> ... e.g. have:
> 
> 	struct memblock_region reg = {
> 		.size = 0,
> 	};

Sure

> That saves us from making unnecessary assignments to the size field, and
> makes it clear that reg.size has definitely been initialised, regardless
> of what of_scan_flat_dt() happens to do.
>
> With that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
-Takahiro AKASHI

> Thanks,
> Mark.
> 
> > +
> > +	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
> > +
> > +	if (reg.size)
> > +		memblock_cap_memory_range(reg.base, reg.size);
> > +}
> > +
> >  void __init arm64_memblock_init(void)
> >  {
> >  	const s64 linear_region_size = -(s64)PAGE_OFFSET;
> >  
> > +	/* Handle linux,usable-memory-range property */
> > +	fdt_enforce_memory_region();
> > +
> >  	/*
> >  	 * Ensure that the linear region takes up exactly half of the kernel
> >  	 * virtual address space. This way, we can distinguish a linear address
> > -- 
> > 2.11.0
> > 
