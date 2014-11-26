From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 26 Nov 2014 11:29:42 +0000
Subject: [PATCHv3] arm64: add support to dump the kernel page tables
In-Reply-To: <1416961719-6644-1-git-send-email-lauraa@codeaurora.org>
References: <1416961719-6644-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141126112941.GA11184@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 04:28:39PM -0800, Laura Abbott wrote:
> In a similar manner to arm, it's useful to be able to dump the page
> tables to verify permissions and memory types. Add a debugfs file
> to check the page tables.
> 

Hi Laura,
Just one comment below to address, then:
Acked-by: Steve Capper <steve.capper@linaro.org>
Tested-by: Steve Capper <steve.capper@linaro.org>

Cheers,
-- 
Steve

> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
> v3: Addresses some style comments. Dropped the section bits since the
> arrays are the same right now. More headers are printed for more
> address ranges.
> ---
>  arch/arm64/Kconfig.debug |  12 ++
>  arch/arm64/mm/Makefile   |   1 +
>  arch/arm64/mm/dump.c     | 331 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 344 insertions(+)
>  create mode 100644 arch/arm64/mm/dump.c
> 
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index 0a12933..5fdd6dc 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -6,6 +6,18 @@ config FRAME_POINTER
>  	bool
>  	default y
>  
> +config ARM64_PTDUMP
> +	bool "Export kernel pagetable layout to userspace via debugfs"
> +	depends on DEBUG_KERNEL
> +	select DEBUG_FS
> +        help
> +	  Say Y here if you want to show the kernel pagetable layout in a
> +	  debugfs file. This information is only useful for kernel developers
> +	  who are working in architecture specific areas of the kernel.
> +	  It is probably not a good idea to enable this feature in a production
> +	  kernel.
> +	  If in doubt, say "N"
> +
>  config STRICT_DEVMEM
>  	bool "Filter access to /dev/mem"
>  	depends on MMU
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index c56179e..773d37a 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -3,3 +3,4 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
>  				   ioremap.o mmap.o pgd.o mmu.o \
>  				   context.o proc.o pageattr.o
>  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
> +obj-$(CONFIG_ARM64_PTDUMP)	+= dump.o
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> new file mode 100644
> index 0000000..961051e
> --- /dev/null
> +++ b/arch/arm64/mm/dump.c
> @@ -0,0 +1,331 @@
> +/*
> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + * Debug helper to dump the current kernel pagetables of the system
> + * so that we can see what the various memory ranges are set to.
> + *
> + * Derived from x86 and arm implementation:
> + * (C) Copyright 2008 Intel Corporation
> + *
> + * Author: Arjan van de Ven <arjan@linux.intel.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2
> + * of the License.
> + */
> +#include <linux/debugfs.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/seq_file.h>
> +
> +#include <asm/fixmap.h>
> +#include <asm/pgtable.h>
> +
> +#define LOWEST_ADDR	(UL(0xffffffffffffffff) << VA_BITS)
> +
> +struct addr_marker {
> +	unsigned long start_address;
> +	const char *name;
> +};
> +
> +enum address_markers_idx {
> +	VMALLOC_START_NR = 0,
> +	VMALLOC_END_NR,
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +	VMEMMAP_START_NR,
> +	VMEMMAP_END_NR,
> +#endif
> +	PCI_START_NR,
> +	PCI_END_NR,
> +	FIXADDR_START_NR,
> +	FIXADDR_END_NR,
> +	MODULES_START_NR,
> +	MODUELS_END_NR,
> +	KERNEL_SPACE_NR,
> +};
> +
> +static struct addr_marker address_markers[] = {
> +	{ VMALLOC_START,	"vmalloc() Area" },
> +	{ VMALLOC_END,		"vmalloc() End" },
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +	{ 0,			"vmemmap start" },
> +	{ 0,			"vmemmap end" },
> +#endif
> +	{ (unsigned long) PCI_IOBASE,		"PCI I/O start" },
> +	{ (unsigned long) PCI_IOBASE + SZ_16M,	"PCI I/O end" },
> +	{ FIXADDR_START,	"Fixmap start" },
> +	{ FIXADDR_TOP,		"Fixmap end" },
> +	{ MODULES_VADDR,	"Modules start" },
> +	{ MODULES_END,		"Modules end" },
> +	{ PAGE_OFFSET,		"Kernel Mapping" },
> +	{ -1,			NULL },
> +};
> +
> +struct pg_state {
> +	struct seq_file *seq;
> +	const struct addr_marker *marker;
> +	unsigned long start_address;
> +	unsigned level;
> +	u64 current_prot;
> +};
> +
> +struct prot_bits {
> +	u64		mask;
> +	u64		val;
> +	const char	*set;
> +	const char	*clear;
> +};
> +
> +static const struct prot_bits pte_bits[] = {
> +	{
> +		.mask	= PTE_USER,
> +		.val	= PTE_USER,
> +		.set	= "USR",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= PTE_RDONLY,
> +		.val	= PTE_RDONLY,
> +		.set	= "ro",
> +		.clear	= "RW",
> +	}, {
> +		.mask	= PTE_PXN,
> +		.val	= PTE_PXN,
> +		.set	= "NX",
> +		.clear	= "x ",
> +	}, {
> +		.mask	= PTE_SHARED,
> +		.val	= PTE_SHARED,
> +		.set	= "SHD",
> +		.clear	= "   ",
> +	}, {
> +		.mask	= PTE_AF,
> +		.val	= PTE_AF,
> +		.set	= "AF",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= PTE_NG,
> +		.val	= PTE_NG,
> +		.set	= "NG",
> +		.clear	= "  ",
> +	}, {
> +		.mask	= PTE_UXN,
> +		.val	= PTE_UXN,
> +		.set	= "UXN",
> +	}, {
> +		.mask	= PTE_ATTRINDX_MASK,
> +		.val	= PTE_ATTRINDX(MT_DEVICE_nGnRnE),
> +		.set	= "DEVICE/nGnRnE",
> +	}, {
> +		.mask	= PTE_ATTRINDX_MASK,
> +		.val	= PTE_ATTRINDX(MT_DEVICE_nGnRE),
> +		.set	= "DEVICE/nGnRE",
> +	}, {
> +		.mask	= PTE_ATTRINDX_MASK,
> +		.val	= PTE_ATTRINDX(MT_DEVICE_GRE),
> +		.set	= "DEVICE/GRE",
> +	}, {
> +		.mask	= PTE_ATTRINDX_MASK,
> +		.val	= PTE_ATTRINDX(MT_NORMAL_NC),
> +		.set	= "MEM/BUFFERABLE",
> +	}, {
> +		.mask	= PTE_ATTRINDX_MASK,
> +		.val	= PTE_ATTRINDX(MT_NORMAL),
> +		.set	= "MEM/NORMAL",
> +	}
> +};
> +
> +struct pg_level {
> +	const struct prot_bits *bits;
> +	size_t num;
> +	u64 mask;
> +};
> +
> +static struct pg_level pg_level[] = {
> +	{
> +	}, { /* pgd */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	}, { /* pud */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	}, { /* pmd */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	}, { /* pte */
> +		.bits	= pte_bits,
> +		.num	= ARRAY_SIZE(pte_bits),
> +	},
> +};
> +
> +static void dump_prot(struct pg_state *st, const struct prot_bits *bits,
> +			size_t num)
> +{
> +	unsigned i;
> +
> +	for (i = 0; i < num; i++, bits++) {
> +		const char *s;
> +
> +		if ((st->current_prot & bits->mask) == bits->val)
> +			s = bits->set;
> +		else
> +			s = bits->clear;
> +
> +		if (s)
> +			seq_printf(st->seq, " %s", s);
> +	}
> +}
> +
> +static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
> +				u64 val)
> +{
> +	static const char units[] = "KMGTPE";
> +	u64 prot = val & pg_level[level].mask;
> +
> +	if (addr < LOWEST_ADDR)
> +		return;
> +
> +	if (!st->level) {
> +		st->level = level;
> +		st->current_prot = prot;
> +		st->start_address = addr;
> +		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +	} else if (prot != st->current_prot || level != st->level ||
> +		   addr >= st->marker[1].start_address) {
> +		const char *unit = units;
> +		unsigned long delta;
> +
> +		if (st->current_prot) {
> +			seq_printf(st->seq, "0x%16lx-0x%16lx   ",
> +				   st->start_address, addr);
> +
> +			delta = (addr - st->start_address) >> 10;
> +			while (!(delta & 1023) && unit[1]) {
> +				delta >>= 10;
> +				unit++;
> +			}
> +			seq_printf(st->seq, "%9lu%c", delta, *unit);
> +			if (pg_level[st->level].bits)
> +				dump_prot(st, pg_level[st->level].bits,
> +					  pg_level[st->level].num);
> +			seq_puts(st->seq, "\n");
> +		}
> +
> +		if (addr >= st->marker[1].start_address) {
> +			st->marker++;
> +			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +		}
> +
> +		st->start_address = addr;
> +		st->current_prot = prot;
> +		st->level = level;
> +	}
> +
> +	if (addr >= st->marker[1].start_address) {
> +		st->marker++;
> +		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +	}
> +
> +}
> +
> +static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
> +{
> +	pte_t *pte = pte_offset_kernel(pmd, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
> +		addr = start + i * PAGE_SIZE;
> +		note_page(st, addr, 4, pte_val(*pte));
> +	}
> +}
> +
> +static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
> +{
> +	pmd_t *pmd = pmd_offset(pud, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
> +		addr = start + i * PMD_SIZE;
> +		if (pmd_none(*pmd) || pmd_sect(*pmd) || pmd_bad(*pmd))
> +			note_page(st, addr, 3, pmd_val(*pmd));
> +		else
> +			walk_pte(st, pmd, addr);
> +	}
> +}
> +
> +static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
> +{
> +	pud_t *pud = pud_offset(pgd, 0);
> +	unsigned long addr;
> +	unsigned i;
> +
> +	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
> +		addr = start + i * PUD_SIZE;
> +		if (pud_none(*pud) || pud_sect(*pud) || pud_bad(*pud))
> +			note_page(st, addr, 2, pud_val(*pud));
> +		else
> +			walk_pmd(st, pud, addr);
> +	}
> +}
> +
> +static void walk_pgd(struct pg_state *st, struct mm_struct *mm, unsigned long start)
> +{
> +	pgd_t *pgd = pgd_offset(mm, 0);
> +	unsigned i;
> +	unsigned long addr;
> +
> +	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
> +		addr = start + i * PGDIR_SIZE;
> +		if (pgd_none(*pgd) || pgd_bad(*pgd))
> +			note_page(st, addr, 1, pgd_val(*pgd));
> +		else
> +			walk_pud(st, pgd, addr);
> +	}
> +}
> +
> +static int ptdump_show(struct seq_file *m, void *v)
> +{
> +	struct pg_state st = {
> +		.seq = m,
> +		.marker = address_markers,
> +	};
> +
> +	walk_pgd(&st, &init_mm, LOWEST_ADDR);

I get the following compile error:
arch/arm64/mm/dump.c: In function ?ptdump_show?:
arch/arm64/mm/dump.c:294:17: error: ?init_mm? undeclared (first use in this function)
  walk_pgd(&st, &init_mm, LOWEST_ADDR);

This cropped up with 3.18-rc5, running 64KB pages with 2 levels.
(can send a full .config if that's helpful). My gcc was:
gcc version 4.9.1 20140505 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05) 

>From what I can see, other parts of the kernel that use init_mm pull
it in from <linux/sched.h>, as there's an extern there.

> +
> +	note_page(&st, 0, 0, 0);
> +	return 0;
> +}
> +
> +static int ptdump_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, ptdump_show, NULL);
> +}
> +
> +static const struct file_operations ptdump_fops = {
> +	.open		= ptdump_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int ptdump_init(void)
> +{
> +	struct dentry *pe;
> +	unsigned i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
> +		if (pg_level[i].bits)
> +			for (j = 0; j < pg_level[i].num; j++)
> +				pg_level[i].mask |= pg_level[i].bits[j].mask;
> +
> +	address_markers[VMEMMAP_START_NR].start_address =
> +				(unsigned long)virt_to_page(PAGE_OFFSET);
> +	address_markers[VMEMMAP_END_NR].start_address =
> +				(unsigned long)virt_to_page(high_memory);
> +
> +	pe = debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
> +				 &ptdump_fops);
> +	return pe ? 0 : -ENOMEM;
> +}
> +device_initcall(ptdump_init);

Cheers,
-- 
Steve
