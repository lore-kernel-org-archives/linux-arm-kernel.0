From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 21 Feb 2014 12:00:44 +0100
Subject: [PATCH v4 1/7] drivers: of: add initialization code for reserved
 memory
In-Reply-To: <20140220140100.5BD65C4050F@trevor.secretlab.ca>
References: <1392893567-31623-1-git-send-email-m.szyprowski@samsung.com>
 <1392893567-31623-2-git-send-email-m.szyprowski@samsung.com>
 <20140220140100.5BD65C4050F@trevor.secretlab.ca>
Message-ID: <530731DC.2000400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-02-20 15:01, Grant Likely wrote:
> On Thu, 20 Feb 2014 11:52:41 +0100, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > This patch adds device tree support for contiguous and reserved memory
> > regions defined in device tree.
> >
> > Large memory blocks can be reliably reserved only during early boot.
> > This must happen before the whole memory management subsystem is
> > initialized, because we need to ensure that the given contiguous blocks
> > are not yet allocated by kernel. Also it must happen before kernel
> > mappings for the whole low memory are created, to ensure that there will
> > be no mappings (for reserved blocks) or mapping with special properties
> > can be created (for CMA blocks). This all happens before device tree
> > structures are unflattened, so we need to get reserved memory layout
> > directly from fdt.
> >
> > Later, those reserved memory regions are assigned to devices on each
> > device structure initialization.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > [joshc: rework to implement new DT binding, provide mechanism for
> >  plugging in new reserved-memory node handlers via
> >  RESERVEDMEM_OF_DECLARE]
> > Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> > [mszyprow: added generic memory reservation code, refactored code to
> >  put it directly into fdt.c]
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/of/Kconfig                |    6 +
> >  drivers/of/Makefile               |    1 +
> >  drivers/of/fdt.c                  |  145 ++++++++++++++++++
> >  drivers/of/of_reserved_mem.c      |  296 +++++++++++++++++++++++++++++++++++++
> >  drivers/of/platform.c             |    7 +
> >  include/asm-generic/vmlinux.lds.h |   11 ++
> >  include/linux/of_reserved_mem.h   |   65 ++++++++
> >  7 files changed, 531 insertions(+)
> >  create mode 100644 drivers/of/of_reserved_mem.c
> >  create mode 100644 include/linux/of_reserved_mem.h
>
> Hi Marek,
>
> There's a lot of moving parts in this patch. Can you split the patch up a bit please. There are parts that I'm not entierly comfortable with yet and it will help reviewing them if they are added separately. For instance, the attaching regions to devices is something that I want to have some discussion about, but the core reserving static ranges I think is pretty much ready to be merged. I can merge the later while still debating the former if they are split.
>
> I would recommend splitting into four:
> 1) reservation of static regions without the support code for referencing them later
> 2) code to also do dynamic allocations of reserved regions - again without any driver references
> 3) add hooks to reference specific regions.
> 4) hooks into drivers/of/platform.c for wiring into the driver model.
>
> Can you also make the binding doc the first patch?

Ok, I will slice the patch into 4 pieces.

(snipped)

> > +/**
> > + * res_mem_alloc_size() - allocate reserved memory described by 'size', 'align'
> > + *			  and 'alloc-ranges' properties
> > + */
> > +static int __init
> > +__reserved_mem_alloc_size(unsigned long node, const char *uname,
> > +			  phys_addr_t *res_base, phys_addr_t *res_size)
> > +{
> > +	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
> > +	phys_addr_t start = 0, end = 0;
> > +	phys_addr_t base = 0, align = 0, size;
> > +	unsigned long len;
> > +	__be32 *prop;
> > +	int nomap;
> > +	int ret;
> > +
> > +	prop = of_get_flat_dt_prop(node, "size", &len);
> > +	if (!prop)
> > +		return -EINVAL;
> > +
> > +	if (len != dt_root_size_cells * sizeof(__be32)) {
> > +		pr_err("Reserved memory: invalid size property in '%s' node.\n",
> > +				uname);
> > +		return -EINVAL;
> > +	}
> > +	size = dt_mem_next_cell(dt_root_size_cells, &prop);
> > +
> > +	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
> > +
> > +	prop = of_get_flat_dt_prop(node, "align", &len);
> > +	if (prop) {
> > +		if (len != dt_root_addr_cells * sizeof(__be32)) {
> > +			pr_err("Reserved memory: invalid align property in '%s' node.\n",
> > +				uname);
> > +			return -EINVAL;
> > +		}
> > +		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
> > +	}
> > +
> > +	prop = of_get_flat_dt_prop(node, "alloc-ranges", &len);
> > +	if (prop) {
> > +
> > +		if (len % t_len != 0) {
> > +			pr_err("Reserved memory: invalid alloc-ranges property in '%s', skipping node.\n",
> > +			       uname);
> > +			return -EINVAL;
> > +		}
> > +
> > +		base = 0;
> > +
> > +		while (len > 0) {
> > +			start = dt_mem_next_cell(dt_root_addr_cells, &prop);
> > +			end = start + dt_mem_next_cell(dt_root_size_cells,
> > +						       &prop);
> > +
> > +			ret = early_init_dt_alloc_reserved_memory_arch(size,
> > +					align, start, end, nomap, &base);
> > +			if (ret == 0) {
> > +				pr_debug("Reserved memory: allocated memory for '%s' node: base %pa, size %ld MiB\n",
> > +					uname, &base,
> > +					(unsigned long)size / SZ_1M);
> > +				break;
> > +			}
> > +			len -= t_len;
> > +		}
> > +
> > +	} else {
> > +		ret = early_init_dt_alloc_reserved_memory_arch(size, align,
> > +							0, 0, nomap, &base);
> > +		if (ret == 0)
> > +			pr_debug("Reserved memory: allocated memory for '%s' node: base %pa, size %ld MiB\n",
> > +				uname, &base, (unsigned long)size / SZ_1M);
> > +	}
> > +
> > +	if (base == 0) {
> > +		pr_info("Reserved memory: failed to allocate memory for node '%s'\n",
> > +			uname);
> > +		return -ENOMEM;
> > +	}
>
> <off topic> Wow, the flattree parsing code has to be really verbose. We really need better
> flat tree parsing functions and helpers.

Yes, parsing fdt is a real pain, but please don't ask me to implement 
all the
helpers to make it easier together with this patch. I (and probably other
developers) would really like to get this piece merged asap.

> > +
> > +	*res_base = base;
> > +	*res_size = size;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id __rmem_of_table_sentinel
> > +	__used __section(__reservedmem_of_table_end);
> > +
> > +/**
> > + * res_mem_init_node() - call region specific reserved memory init code
> > + */
> > +static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
> > +{
> > +	extern const struct of_device_id __reservedmem_of_table[];
> > +	const struct of_device_id *i;
> > +
> > +	for (i = __reservedmem_of_table; i < &__rmem_of_table_sentinel; i++) {
> > +		reservedmem_of_init_fn initfn = i->data;
> > +		const char *compat = i->compatible;
> > +
> > +		if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
> > +			continue;
>
> What if two entries both match the compatible list? Ideally score would
> be taken into account. (I won't block on this issue, it can be a future
> enhancement)

If two entries have same compatible value they will be probed in the order
of presence in the kernel binary. The return value is checked and the next
one is being tried if init fails for the given function. The provided code
already makes use of this feature. Both DMA coherent and CMA use
"shared-dma-pool" compatible. DMA coherent init fails if 'reusable'
property has been found. On the other hand, CMA fails initialization if
'reusable' property is missing. Frankly I would like to change standard
DMA coherent compatible value to 'dma-pool' and keep 'shared-dma-pool'
only for CMA, but I've implemented it the way it has been described in
your binding documentation.

(snipped)

Thanks for your comments, I will send updated patches asap.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
