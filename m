From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 3 Oct 2016 15:32:51 +0100
Subject: [PATCH] coresight: tmc: implementing TMC-ETR AUX space API
In-Reply-To: <1474319674-18172-1-git-send-email-mathieu.poirier@linaro.org>
References: <1474319674-18172-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <3aba2b4f-72b1-297b-bc0a-2a08aa8845e8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/16 22:14, Mathieu Poirier wrote:
> This patch implements the AUX area interfaces required to
> use the TMC-ETR (configured to work in scatter-gather mode)
> from the Perf sub-system.
>
> Some of this work was inspired from the original implementation
> done by Pratik Patel at CodeAurora.
>

Hi Mathieu,

Thanks for nailing the monster. I have a few comments below on the implementation.

> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 629 +++++++++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.h     |   1 +
>  2 files changed, 621 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 6d7de0309e94..581d6393bb5d 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -17,10 +17,60 @@
>
>  #include <linux/coresight.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
>
> -void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
> +/**
> + * struct etr_page - DMA'able and virtual address representation for a page
> + * @daddr:		DMA'able page address returned by dma_map_page()
> + * @vaddr:		Virtual address returned by page_address()
> + */
> +struct etr_page {
> +	dma_addr_t	daddr;
> +	u64		vaddr;
> +};
> +
> +/**
> + * struct cs_etr_buffer - keep track of a recording session' specifics
> + * @dev:		device reference to be used with the DMA API
> + * @tmc:		generic portion of the TMC buffers
> + * @etr_nr_pages:	number of memory pages for the ETR-SG trace storage
> + * @pt_vaddr:		the virtual address of the first page table entry
> + * @page_addr:		quick access to all the pages held in the page table
> + */
> +struct cs_etr_buffers {
> +	struct device		*dev;
> +	struct cs_buffers	tmc;
> +	unsigned int		etr_nr_pages;
> +	void __iomem		*pt_vaddr;
> +	struct etr_page		page_addr[0];
> +};
> +
> +#define TMC_ETR_ENTRIES_PER_PT (PAGE_SIZE / sizeof(u32))
> +
> +/*
> + * Helpers for scatter-gather descriptors.  Descriptors are defined as follow:
> + *
> + * ---Bit31------------Bit4-------Bit1-----Bit0--
> + * |     Address[39:12]    | SBZ |  Entry Type  |
> + * ----------------------------------------------
> + *
> + * Address: Bits [39:12] of a physical page address. Bits [11:0] are
> + *	    always zero.
> + *
> + * Entry type:	b10 - Normal entry
> + *		b11 - Last entry in a page table
> + *		b01 - Last entry
> + */
> +#define TMC_ETR_SG_LST_ENT(phys_pte)	(((phys_pte >> PAGE_SHIFT) << 4) | 0x1)
> +#define TMC_ETR_SG_ENT(phys_pte)	(((phys_pte >> PAGE_SHIFT) << 4) | 0x2)
> +#define TMC_ETR_SG_NXT_TBL(phys_pte)	(((phys_pte >> PAGE_SHIFT) << 4) | 0x3)
> +

Please be aware that on arm64, the PAGE_SIZE can be 16K or 64K. So hard coding
PAGE_SHIFT here might be problematic on those configurations as the ETR page size
is always 4K.

> +#define TMC_ETR_SG_ENT_TO_PG(entry)	((entry >> 4) << PAGE_SHIFT)
> +
> +void tmc_etr_enable_hw_cnt_mem(struct tmc_drvdata *drvdata)
>  {
>  	u32 axictl;
>
> @@ -57,7 +107,47 @@ void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  	CS_LOCK(drvdata->base);
>  }
>
> -static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
> +void tmc_etr_enable_hw_sg_mem(struct tmc_drvdata *drvdata)


> +	 * DBAHI Holds the upper eight bits of the 40-bit address used to
> +	 * locate the trace buffer in system memory.
> +	 */
> +	writel_relaxed((drvdata->paddr >> 32) & 0xFF,
> +			drvdata->base + TMC_DBAHI);

I think we should do the same for tmc_etr_enable_hw_cnt_mem().

> @@ -199,7 +290,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, u32 mode)
>  		goto out;
>  	}
>
> -	tmc_etr_enable_hw(drvdata);
> +	tmc_etr_enable_hw_sg_mem(drvdata);
>  out:
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
> @@ -241,9 +332,528 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
>  	dev_info(drvdata->dev, "TMC-ETR disabled\n");
>  }
>
> +/*
> + * The default perf ring buffer size is 32 and 1024 pages for user and kernel
> + * space respectively.  The size of the intermediate SG list is allowed
> + * to match the size of the perf ring buffer but cap it to the default
> + * kernel size.
> + */
> +#define DEFAULT_NR_KERNEL_PAGES	1024
> +static int tmc_get_etr_pages(int nr_pages)

The name could be confusing, as it kind of implies it allocates nr_pages.
It might be worth renaming it to tmc_get_etr_pages_nr ?

> +{
> +	if (nr_pages <= DEFAULT_NR_KERNEL_PAGES)
> +		return nr_pages;
> +
> +	return DEFAULT_NR_KERNEL_PAGES;
> +}
> +
> +/*
> + * Go through all the pages in the SG list and check if @phys_addr
> + * falls within one of those.  If so record the information in
> + * @page and @offset.
> + */
> +static int
> +tmc_get_sg_page_index(struct cs_etr_buffers *etr_buffer,
> +		      u64 phys_addr, u32 *page, u32 *offset)
> +{
> +	int i = 0, pte = 0, nr_pages = etr_buffer->etr_nr_pages;
> +	u32 *page_table_itr = etr_buffer->pt_vaddr;
> +	phys_addr_t phys_page_addr;
> +
> +	/* Circle through all the pages in the SG list */
> +	while (pte < nr_pages) {
> +		phys_page_addr = TMC_ETR_SG_ENT_TO_PG((u64)*page_table_itr);

Could we not find the phys_addr by scanning the etr_pages[].daddr and use the
index to hope through the PageTable links to reach the entry which could have it
and return the offset within that page ?

> +
> +		/* Does @phys_addr falls within this page? */
> +		if (phys_addr >= phys_page_addr &&
> +		    phys_addr < (phys_page_addr + PAGE_SIZE)) {
> +			*page = pte;
> +			*offset = phys_addr - phys_page_addr;
> +			return 0;
> +		}
> +
> +		if (pte == nr_pages - 1) {
> +			/* The last page in the SG list */
> +			pte++;
> +		} else if (i == TMC_ETR_ENTRIES_PER_PT - 1) {
> +			/*
> +			 * The last entry in this page table - get a reference
> +			 * on the next page table and do _not_ increment @pte
> +			 */
> +			page_table_itr = phys_to_virt(phys_page_addr);
> +			i = 0;
> +		} else {
> +			/* A normal page in the SG list */
> +			page_table_itr++;
> +			pte++;
> +			i++;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void tmc_sg_page_sync(struct cs_etr_buffers *etr_buffer,
> +			     int start_page, u64 to_sync)

nit: to_sync doesn't give a clue on what the unit is ? pages ? bytes ?
could it be u64 size ?

> +{
> +	int i, index;
> +	int pages_to_sync = DIV_ROUND_UP_ULL(to_sync, PAGE_SIZE);
> +	dma_addr_t daddr;
> +	struct device *dev = etr_buffer->dev;
> +
> +	for (i = start_page; i < (start_page + pages_to_sync); i++) {
> +		/* Wrap around the etr page list if need be */
> +		index = i % etr_buffer->etr_nr_pages;
> +		daddr = etr_buffer->page_addr[index].daddr;
> +		dma_sync_single_for_cpu(dev, daddr, PAGE_SIZE, DMA_FROM_DEVICE);
> +	}
> +}
> +

> +static void tmc_free_sg_buffer(struct cs_etr_buffers *etr_buffer, int nr_pages)
> +{
> +	int i = 0, pte = 0;
> +	u32 *page_addr, *page_table_itr;
> +	u32 *page_table_addr = etr_buffer->pt_vaddr;
> +	phys_addr_t phys_page_addr;
> +	dma_addr_t daddr;
> +	struct device *dev = etr_buffer->dev;
> +
> +	if (!page_table_addr)
> +		return;
> +

Please check comments on tmc_alloc_sg_buffer().

> +
> +static int
> +tmc_alloc_sg_buffer(struct cs_etr_buffers *etr_buffer, int cpu, int nr_pages)
> +{
> +	int i = 0, node, pte = 0, ret = 0;
> +	dma_addr_t dma_page_addr;
> +	u32 *page_table_addr, *page_addr;
> +	struct page *page;
> +	struct device *dev = etr_buffer->dev;
> +
> +	if (cpu == -1)
> +		cpu = smp_processor_id();
> +	node = cpu_to_node(cpu);
> +
> +	/* Allocate the first page table */
> +	page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	page_table_addr = page_address(page);

Would it be simpler to allocate the pages required for the PageTables and track them
separately ? i.e for a given nr_pages, we could easily calculate the number of Table
entries required.

nr_table_pages = (nr_pages << (PAGE_SHIFT - 12)) / (TMC_ETR_ENTRIES_PER_PT - 1);
table_pages = alloc_pages_exact_nid(node, GFP_KERNEL|__GFP_ZERO, nr_table_pages * PAGE_SIZE);

where, PAGE_SHIFT - 12 ( = PAGE_SHIFT_4K) gives the log2 number 4K pages in a system
page.

That way, we can link the pages easily and also free them easily in tmc_free_sg_buffer() without
traversing the page table once again, since we track the ETR pages and the pages for the tables now.
Also the page table initialisation below could be much simpler as we could link the table entries
at one shot.
	
> +	/*
> +	 * Keep track of the first page table, the rest will be chained
> +	 * in the last page table entry.
> +	 */
> +	etr_buffer->pt_vaddr = page_table_addr;
> +
> +	while (pte < nr_pages) {
> +		page = alloc_pages_node(node,
> +					GFP_KERNEL | __GFP_ZERO, 0);
> +		if (!page) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		page_addr = page_address(page);
> +
> +		if (pte == nr_pages - 1) {
> +			/* The last page in the list */
> +			dma_page_addr = tmc_setup_dma_page(dev, page);
> +			if (dma_page_addr == -EINVAL) {
> +				ret = -EINVAL;
> +				goto err;
> +			}
> +
> +			*page_table_addr = TMC_ETR_SG_LST_ENT(dma_page_addr);
> +
> +			etr_buffer->page_addr[pte].vaddr = (u64)page_addr;
> +			etr_buffer->page_addr[pte].daddr = dma_page_addr;
> +
> +			pte++;
> +		} else if (i == TMC_ETR_ENTRIES_PER_PT - 1) {
> +			/* The last entry in this page table */
> +			*page_table_addr =
> +				TMC_ETR_SG_NXT_TBL(virt_to_phys(page_addr));

Shouldn't this also be a dma_addr_t of the page ? The TMC ETR would use the
address in the table to "read" the page table in this case, while the other
pte entries are used to "write" data to the addresses (for which you correctly
set up the dma address). I don't see why the "read" address should be any different.
The TMC TRM uses PTn_BaseAddr for the page table base, which can be confusing.
But if you see the DBALO which points to the PT0_BaseAddr, it should be clear.

> +			/* Move on to the next page table */
> +			page_table_addr = page_addr;
> +
> +			i = 0;
> +		} else {
> +			/* A normal page in the SG list */
> +			dma_page_addr = tmc_setup_dma_page(dev, page);
> +			if (dma_page_addr == -EINVAL) {
> +				ret = -EINVAL;
> +				goto err;
> +			}
> +
> +			*page_table_addr = TMC_ETR_SG_ENT(dma_page_addr);
> +
> +			etr_buffer->page_addr[pte].vaddr = (u64)page_addr;
> +			etr_buffer->page_addr[pte].daddr = dma_page_addr;
> +
> +			page_table_addr++;

As mentioned above, with a page size other than 4K, we are wasting space here.

> +			pte++;
> +			i++;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	tmc_free_sg_buffer(etr_buffer, pte);
> +	etr_buffer->pt_vaddr = NULL;
> +	return ret;
> +}
> +
> +static void *tmc_alloc_etr_buffer(struct coresight_device *csdev, int cpu,
> +				  void **pages, int nr_pages, bool overwrite)
> +{
> +	int etr_pages, node;
> +	struct device *dev = csdev->dev.parent;
> +	struct cs_etr_buffers *buf;
> +
> +	if (cpu == -1)
> +		cpu = smp_processor_id();
> +	node = cpu_to_node(cpu);
> +
> +	/* Register DBALO and DBAHI form a 40-bit address range */
> +	if (dma_set_mask(dev, DMA_BIT_MASK(40)))
> +		return NULL;
> +
> +	/*
> +	 * The HW can't start collecting data in the middle of the SG list,
> +	 * it must start at the beginning.  As such we can't use the ring
> +	 * buffer provided by perf as entries into the page tables since
> +	 * it is not guaranteed that user space will have the chance to
> +	 * consume the data before the next trace run begins.
> +	 *
> +	 * To work around this reserve a set of pages that will be used as
> +	 * and intermediate (SG) buffer.  This isn't optimal but the best we
> +	 * can do with the current HW revision.

Just for my understanding, is this because we don't get a notification from
the hardware when the buffers are (getting) full ?

> +	 */
> +	etr_pages = tmc_get_etr_pages(nr_pages);

nit: As mentioned above the function name and the variable name etr_pages could be
confusing. How about renaming the variable to nr_etr_pages ?

> +static int tmc_set_etr_buffer(struct coresight_device *csdev,
> +			      struct perf_output_handle *handle,
> +			      void *sink_config)
> +{
> +	unsigned long head;
> +	struct cs_etr_buffers *buf = sink_config;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	/* wrap head around to the amount of space we have */
> +	head = handle->head & ((buf->tmc.nr_pages << PAGE_SHIFT) - 1);
> +
> +	/* find the page to write to */
> +	buf->tmc.cur = head / PAGE_SIZE;
> +
> +	/* and offset within that page */
> +	buf->tmc.offset = head % PAGE_SIZE;
> +
> +	local_set(&buf->tmc.data_size, 0);
> +
> +	/* Keep track of how big the internal SG list is */
> +	drvdata->size = buf->etr_nr_pages << PAGE_SHIFT;
> +
> +	/* Tell the HW where to put the trace data */
> +	drvdata->paddr = virt_to_phys(buf->pt_vaddr);

Shouldn't this be a dma_addr as we used to program in the normal mode ?

> +
> +	return 0;
> +}
> +
> +static unsigned long tmc_reset_etr_buffer(struct coresight_device *csdev,
> +					  struct perf_output_handle *handle,
> +					  void *sink_config, bool *lost)
> +{
> +	long size = 0;
> +	struct cs_etr_buffers *buf = sink_config;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	if (buf) {
> +		/*
> +		 * In snapshot mode ->data_size holds the new address of the
> +		 * ring buffer's head.  The size itself is the whole address
> +		 * range since we want the latest information.
> +		 */
> +		if (buf->tmc.snapshot) {
> +			size = buf->tmc.nr_pages << PAGE_SHIFT;
> +			handle->head = local_xchg(&buf->tmc.data_size, size);
> +		}
> +
> +		/*
> +		 * Tell the tracer PMU how much we got in this run and if
> +		 * something went wrong along the way.  Nobody else can use
> +		 * this cs_etr_buffers instance until we are done.  As such
> +		 * resetting parameters here and squaring off with the ring
> +		 * buffer API in the tracer PMU is fine.
> +		 */
> +		*lost = !!local_xchg(&buf->tmc.lost, 0);
> +		size = local_xchg(&buf->tmc.data_size, 0);

I don't fully understand the cs_buffer API, but we set the data_size to 0, unconditionally here.
Whats the point of setting the data_size above for snapshot mode ?

> +	}
> +
> +	/* Get ready for another run */
> +	drvdata->vaddr = NULL;
> +	drvdata->paddr = 0;
> +
> +	return size;
> +}
> +
> +static void tmc_update_etr_buffer(struct coresight_device *csdev,
> +				  struct perf_output_handle *handle,
> +				  void *sink_config)
> +{
> +	bool full;
> +	int i, rb_index, sg_index = 0;
> +	u32 rwplo, rwphi, rb_offset, sg_offset = 0;
> +	u32 stop_index, stop_offset, to_copy, sg_size;
> +	u32 *rb_ptr, *sg_ptr;
> +	u64 rwp, to_read;
> +	struct cs_etr_buffers *etr_buf = sink_config;
> +	struct cs_buffers *cs_buf = &etr_buf->tmc;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	if (!etr_buf)
> +		return;
> +
> +	/* This shouldn't happen */
> +	if (WARN_ON_ONCE(local_read(&drvdata->mode) != CS_MODE_PERF))
> +		return;
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	tmc_flush_and_stop(drvdata);
> +
> +	rwplo = readl_relaxed(drvdata->base + TMC_RWP);
> +	rwphi = readl_relaxed(drvdata->base + TMC_RWPHI);
> +	full = (readl_relaxed(drvdata->base + TMC_STS) & TMC_STS_FULL);

nitpick: you don't need the brackets above.

> +
> +	/* Combine the high and low part of the rwp to make a full address */
> +	rwp = (u64)rwphi << 32;
> +	rwp |= rwplo;
> +
> +	/* Convert the stop address in RAM to a page and an offset */
> +	if (tmc_get_sg_page_index(etr_buf, rwp, &stop_index, &stop_offset))
> +		goto out;
> +
> +	if (full) {
> +		/*
> +		 * The buffer head has wrapped around.  As such the size
> +		 * is the entire buffer length and the index and offset in
> +		 * the scatter-gather list are moved forward.
> +		 */
> +		local_inc(&cs_buf->lost);
> +		to_read = drvdata->size;
> +		sg_index = stop_index;
> +		sg_offset = stop_offset;
> +	} else {
> +		to_read = (stop_index * PAGE_SIZE) + stop_offset;
> +	}
> +
> +	/*
> +	 * The TMC RAM buffer may be bigger than the space available in the
> +	 * perf ring buffer (handle->size).  If so advance the RRP so that we
> +	 * get the latest trace data.
> +	 */

A stupid question: Is this something we can tune in the tmc to match the handle->size so that we
don't have to worry about it ?

> +	if (to_read > handle->size) {
> +		u64 rrp;
> +
> +		/*
> +		 * Compute where we should start reading from
> +		 * relative to rwp.
> +		 */
> +		rrp = rwp + drvdata->size;
> +		/* Go back just enough */
> +		rrp -= handle->size;


This looks wrong to me. We cannot simply move the rrp pointer back and forth, as the buffer
is not guaranteed to be contiguous.

> +		/* Make sure we are still within our limits */
> +		rrp %= drvdata->size;

And the above step definitely makes it not an address. We may have to find the address by looking
at the page table.

> +
> +		/* Get a new index and offset based on rrp */
> +		if (tmc_get_sg_page_index(etr_buf, rrp,
> +					  &stop_index, &stop_offset))
> +			goto out;
> +
> +		/* Tell user space we lost data */
> +		local_inc(&cs_buf->lost);
> +		to_read = handle->size;
> +		/* Adjust start index and offset */
> +		sg_index = stop_index;
> +		sg_offset = stop_offset;
> +	}
> +
> +	/* Get a handle on where the Perf ring buffer is */
> +	rb_index = cs_buf->cur;
> +	rb_offset = cs_buf->offset;
> +
> +	/* Refresh the SG list */
> +	tmc_sg_page_sync(etr_buf, sg_index, to_read);
> +
> +	for (i = to_read; i > 0; ) {
> +		/* Get current location of the perf ring buffer */
> +		rb_ptr = cs_buf->data_pages[rb_index] + rb_offset;
> +		/* Get current location in the ETR SG list */
> +		sg_ptr = (u32 *)(etr_buf->page_addr[sg_index].vaddr +
> +				 sg_offset);
> +
> +		/*
> +		 * First figure out the maximum amount of data we can get out
> +		 * of the ETR SG list.
> +		 */
> +		if (i < PAGE_SIZE)
> +			sg_size = i;
> +		else
> +			sg_size = PAGE_SIZE - sg_offset;

If i < PAGE_SIZE and (PAGE_SIZE - sg_offset) < i, we could crash below trying to
copy from beyond the page.
I think it should be :

		sg_size = min(PAGE_SIZE - sg_offset, i);


Thanks
Suzuki
