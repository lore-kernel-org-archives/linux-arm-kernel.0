From: james.morse@arm.com (James Morse)
Date: Tue, 17 Jan 2017 17:25:58 +0000
Subject: [PATCH V2 1/2] kexec: arm64: create identity page table to be
 used in purgatory
In-Reply-To: <ea98a0045c8d466456f53150f341546810dd47e1.1482129830.git.panand@redhat.com>
References: <cover.1482129830.git.panand@redhat.com>
 <ea98a0045c8d466456f53150f341546810dd47e1.1482129830.git.panand@redhat.com>
Message-ID: <587E53A6.6020709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 19/12/16 07:13, Pratyush Anand wrote:
> Purgatory sha verification is very slow when D-cache is not enabled there.
> We need to enable MMU as well to enable D-Cache.Therefore,we need to an
> identity mapped page table in purgatory.
> 
> Since debugging is very difficult in purgatory therefore we prefer to do as
> much work as possible in kexec.
> 
> This patch prepares page table for purgatory in advance. We support only 4K
> page table,because it will be available on most of the platform. This page
> table is passed to the purgatory as a new segment.
> 
> VA bit is fixed as 48, page table level is 3 where 3rd level page table
> contains 2M block entries.

> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index 04fd3968bb52..c2c8ff1b6940 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -24,6 +24,45 @@
>  #include "kexec-syscall.h"
>  #include "arch/options.h"
>  
> +/*
> + * kexec creates identity page table to be used in purgatory so that
> + * dcache verification becomes faster.
> + *
> + * These are the definitions to be used by page table creation routine.
> + *
> + * Only 4K page table, 3 level, 2M block mapping, 48bit VA is supported
> + */
> +#define PGDIR_SHIFT		39
> +#define PUD_SHIFT		30
> +#define PMD_SHIFT		21
> +#define PTRS_PER_PGD		0x1FF
> +#define PTRS_PER_PUD		0x1FF
> +#define PTRS_PER_PMD		0x1FF

Aren't these 0x200 for 4K pages in the kernel? It looks like you use them as a
mask instead.


> +#define PMD_TYPE_TABLE		(3UL << 0)
> +#define PMD_TYPE_SECT		(1UL << 0)
> +#define PMD_SECT_AF		(1UL << 10)
> +#define PMD_ATTRINDX(t)		((unsigned long)(t) << 2)

> +#define MT_NORMAL		4

This needs to correspond to the part of MAIR that describes the memory type for
'normal'. You define MT_NORMAL again in the next patch, it would be better to
share the definition so they can't be different. (I don't see why you can't use 0!)


> +#define PMD_FLAGS_NORMAL	(PMD_TYPE_SECT | PMD_SECT_AF)
> +#define MMU_FLAGS_NORMAL	(PMD_ATTRINDX(MT_NORMAL) | PMD_FLAGS_NORMAL)

The SH and AP bits are left as zero, which means non-shareable, read/writeable,
(which I think is fine).


> +#define SECTION_SIZE		(2 * 1024 * 1024)
> +#define PAGE_SIZE		(4 * 1024)
> +/* Since we are using 3 level of page tables, therefore minimum number of
> + * table will be 3. Most likely we will never need more than 3. Each entry
> + * in level 3 page table can map 2MB memory area. Thus a level 3 page table
> + * indexed by bit 29:21 can map a total of 1G memory area. Therefore, if
> + * any segment crosses 1G boundary, then we will need one more level 3
> + * table. Similarly, level 2 page table indexed by bit 38:30 can map a
> + * total of 512G memory area. If segment addresses are more than 512G apart
> + * then we will need two more table for each such block. We do not expect
> + * any memory segment to cross 512G boundary, however if we will ever wish
> + * to support uart debugging in purgatory then that might cross the
> + * boundary and therefore additional 2 more table space. Thus we will need
> + * maximum of 6 table space.

Surely we only need 6 page_size table entries if we support uart debugging,
which your 'if we ever' suggests we don't. So surely we only need 3, and a
comment that this needs expanding to 6 if we need to map two distinct areas.


> + */
> +#define MAX_PGTBLE_SZ	(6 * 4096)
> +static int next_tbl_cnt = 1;
> +
>  /* Global varables the core kexec routines expect. */
>  
>  unsigned char reuse_initrd;
> @@ -316,6 +355,117 @@ unsigned long arm64_locate_kernel_segment(struct kexec_info *info)
>  	return hole;
>  }
>  
> +static unsigned long *create_table_entry(unsigned long *pgtbl_buf,
> +		unsigned long pgtbl_mem, unsigned long *tbl,
> +		unsigned long virt, int shift,
> +		unsigned long ptrs)
> +{
> +	unsigned long index, desc, offset;
> +
> +	index = (virt >> shift) & ptrs;
> +	/* check if we have allocated a table already for this index */
> +	if (tbl[index]) {
> +		/*
> +		 * table index will have entry as per purgatory page table
> +		 * memory. Find out corresponding buffer address of table.
> +		 */
> +		desc = tbl[index] & ~3UL;
> +		offset = desc - pgtbl_mem;

wait .. no .. pgtbl_mem is also a guest physical address, so this is fine... its
not obvious at first glance!  You could do with a typedef to make it clear which
addresses are the guests (pgtable_mem) and which are the hosts (pgtable_buf).
Something like phys_addr_t?


> +		return &pgtbl_buf[offset >> 3];
> +	}
> +
> +	/*
> +	 * Always write page table content as per page table memory allocated
> +	 * for purgaory area, but return corresponding buffer area alloced

Nit: purgatory, allocated,

> +	 * in kexec
> +	 */
> +	if (next_tbl_cnt > 5)
> +		die("%s: No more memory for page table\n", __func__);

die()? With a bit of juggling can't we return an error so we never try to enable
the MMU+dcache instead?


> +
> +	tbl[index] = (pgtbl_mem + PAGE_SIZE * next_tbl_cnt) | PMD_TYPE_TABLE;
> +
> +	return &pgtbl_buf[(next_tbl_cnt++ * PAGE_SIZE) >> 3];
> +}
> +
> +static void craete_block_entry(unsigned long *tbl, unsigned long flags,
> +		unsigned long phys, unsigned long virt)

Why have separate phys and virt parameters if all this ever does is idmap?


> +{
> +	unsigned long index;
> +	unsigned long desc;
> +
> +	index = (virt >> PMD_SHIFT) & PTRS_PER_PMD;

Copying the pmd_index() macro would make this clearer.


> +	desc = (phys >> PMD_SHIFT) << PMD_SHIFT;

Looks like you wanted a PMD_MASK.


> +	desc |= flags;
> +	tbl[index] = desc;
> +}
> +
> +static void create_identity_entry(unsigned long *pgtbl_buf,
> +		unsigned long pgtbl_mem, unsigned long virt,
> +		unsigned long flags)
> +{
> +	unsigned long *tbl = pgtbl_buf;
> +
> +	tbl = create_table_entry(pgtbl_buf, pgtbl_mem, tbl, virt,
> +			PGDIR_SHIFT, PTRS_PER_PGD);
> +	tbl = create_table_entry(pgtbl_buf, pgtbl_mem, tbl, virt,
> +			PUD_SHIFT, PTRS_PER_PUD);
> +	craete_block_entry(tbl, flags, virt, virt);

Nit: create

> +}
> +
> +/**
> + * arm64_create_pgtbl_segment - Create page table segments to be used by
> + * purgatory. Page table will have entries to access memory area of all
> + * those segments which becomes part of sha verification in purgatory.
> + * Additionaly, we also create page table for purgatory segment as well.

Nit: additionally,

> + */
> +
> +static int arm64_create_pgtbl_segment(struct kexec_info *info,
> +		unsigned long hole_min, unsigned long hole_max)
> +{
> +	unsigned long *pgtbl_buf;
> +	int i;
> +	unsigned long mstart, mend, pgtbl_mem;
> +	unsigned long purgatory_base, purgatory_len;
> +
> +	pgtbl_buf = xmalloc(MAX_PGTBLE_SZ);
> +	memset(pgtbl_buf, 0, MAX_PGTBLE_SZ);

> +	pgtbl_mem = add_buffer_phys_virt(info, pgtbl_buf, MAX_PGTBLE_SZ,
> +			MAX_PGTBLE_SZ, PAGE_SIZE, hole_min, hole_max, 1, 0);

I want to check what this does, but this all looks like it is doing the right thing.


> +	for (i = 0; i < info->nr_segments; i++) {
> +		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
> +			purgatory_base = (unsigned long)info->segment[i].mem;
> +			purgatory_len = info->segment[i].memsz;
> +		}
> +		mstart = (unsigned long)info->segment[i].mem;
> +		mend = mstart + info->segment[i].memsz;
> +		mstart &= ~(SECTION_SIZE - 1);
> +		while (mstart < mend) {
> +			create_identity_entry(pgtbl_buf, pgtbl_mem,
> +					mstart, MMU_FLAGS_NORMAL);
> +			mstart += SECTION_SIZE;
> +		}
> +	}


Thanks,

James
