From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 15 Dec 2014 01:46:30 +0200
Subject: [PATCH 1/4] iommu: introduce generic page table allocation
 framework
In-Reply-To: <1417089078-22900-2-git-send-email-will.deacon@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
 <1417089078-22900-2-git-send-email-will.deacon@arm.com>
Message-ID: <1610022.OYQk9afzNc@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Please see below for another small comment.

On Thursday 27 November 2014 11:51:15 Will Deacon wrote:
> This patch introduces a generic framework for allocating page tables for
> an IOMMU. There are a number of reasons we want to do this:
> 
>   - It avoids duplication of complex table management code in IOMMU
>     drivers that use the same page table format
> 
>   - It removes any coupling with the CPU table format (and even the
>     architecture!)
> 
>   - It defines an API for IOMMU TLB maintenance
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/iommu/Kconfig      |  8 ++++++
>  drivers/iommu/Makefile     |  1 +
>  drivers/iommu/io-pgtable.c | 71 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.h | 65 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 145 insertions(+)
>  create mode 100644 drivers/iommu/io-pgtable.c
>  create mode 100644 drivers/iommu/io-pgtable.h

[snip]

> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> new file mode 100644
> index 000000000000..5ae75d9cae50
> --- /dev/null
> +++ b/drivers/iommu/io-pgtable.h
> @@ -0,0 +1,65 @@
> +#ifndef __IO_PGTABLE_H
> +#define __IO_PGTABLE_H
> +
> +struct io_pgtable_ops {
> +	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
> +		   phys_addr_t paddr, size_t size, int prot);
> +	int (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
> +		     size_t size);
> +	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
> +				    unsigned long iova);
> +};
> +
> +struct iommu_gather_ops {
> +	/* Synchronously invalidate the entire TLB context */
> +	void (*tlb_flush_all)(void *cookie);
> +
> +	/* Queue up a TLB invalidation for a virtual address range */
> +	void (*tlb_add_flush)(unsigned long iova, size_t size, bool leaf,
> +			      void *cookie);
> +	/* Ensure any queued TLB invalidation has taken effect */
> +	void (*tlb_sync)(void *cookie);
> +
> +	/* Ensure page tables updates are visible to the IOMMU */
> +	void (*flush_pgtable)(void *ptr, size_t size, void *cookie);
> +};
> +
> +struct io_pgtable_cfg {
> +	int			quirks; /* IO_PGTABLE_QUIRK_* */
> +	unsigned long		pgsize_bitmap;
> +	unsigned int		ias;
> +	unsigned int		oas;
> +	struct iommu_gather_ops	*tlb;

Could you make this pointer const ?

> +	/* Low-level data specific to the table format */
> +	union {
> +	};
> +};
> +
> +enum io_pgtable_fmt {
> +	IO_PGTABLE_NUM_FMTS,
> +};
> +
> +struct io_pgtable {
> +	enum io_pgtable_fmt	fmt;
> +	void			*cookie;
> +	struct io_pgtable_cfg	cfg;
> +	struct io_pgtable_ops	ops;
> +};
> +
> +struct io_pgtable_init_fns {
> +	struct io_pgtable *(*alloc)(struct io_pgtable_cfg *cfg, void *cookie);
> +	void (*free)(struct io_pgtable *iop);
> +};
> +
> +struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
> +					    struct io_pgtable_cfg *cfg,
> +					    void *cookie);
> +
> +/*
> + * Free an io_pgtable_ops structure. The caller *must* ensure that the
> + * page table is no longer live, but the TLB can be dirty.
> + */
> +void free_io_pgtable_ops(struct io_pgtable_ops *ops);
> +
> +#endif /* __IO_PGTABLE_H */

-- 
Regards,

Laurent Pinchart
