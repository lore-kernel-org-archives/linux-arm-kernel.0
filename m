From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 31 Oct 2014 18:27:52 +0000
Subject: [RESEND][PATCH] arm64: add support to dump the kernel page tables
In-Reply-To: <1414441059-10781-1-git-send-email-lauraa@codeaurora.org>
References: <1414441059-10781-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141031182752.GB798@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Mon, Oct 27, 2014 at 08:17:39PM +0000, Laura Abbott wrote:
> In a similar manner to arm, it's useful to be able to dump the page
> tables to verify permissions and memory types. Add a debugfs file
> to check the page tables.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
> I sent this out a few months ago but never heard anything back. Would still
> be useful for debugging

I was hoping that I could hack this to figure out KVM issue a few days
ago, but found this blew up on Juno in walk_pte. I had a go at debugging
that, and found it was due to block mappings in level 1 tables that the
below code tried to handle as pmds.

More on that below, with a few other comments.

> ---
>  arch/arm64/Kconfig.debug |  12 ++
>  arch/arm64/mm/Makefile   |   1 +
>  arch/arm64/mm/dump.c     | 353 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 366 insertions(+)
>  create mode 100644 arch/arm64/mm/dump.c
>
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index 0a12933..5fdd6dc 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -6,6 +6,18 @@ config FRAME_POINTER
>         bool
>         default y
>
> +config ARM64_PTDUMP
> +       bool "Export kernel pagetable layout to userspace via debugfs"
> +       depends on DEBUG_KERNEL
> +       select DEBUG_FS
> +        help
> +         Say Y here if you want to show the kernel pagetable layout in a
> +         debugfs file. This information is only useful for kernel developers
> +         who are working in architecture specific areas of the kernel.
> +         It is probably not a good idea to enable this feature in a production
> +         kernel.
> +         If in doubt, say "N"
> +
>  config STRICT_DEVMEM
>         bool "Filter access to /dev/mem"
>         depends on MMU
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index c56179e..773d37a 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -3,3 +3,4 @@ obj-y                           := dma-mapping.o extable.o fault.o init.o \
>                                    ioremap.o mmap.o pgd.o mmu.o \
>                                    context.o proc.o pageattr.o
>  obj-$(CONFIG_HUGETLB_PAGE)     += hugetlbpage.o
> +obj-$(CONFIG_ARM64_PTDUMP)     += dump.o
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> new file mode 100644
> index 0000000..b3229e8
> --- /dev/null
> +++ b/arch/arm64/mm/dump.c
> @@ -0,0 +1,353 @@
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
> +#include <asm/pgtable.h>
> +
> +#define LOWEST_ADDR    (UL(0xffffffffffffffff) << VA_BITS)
> +
> +struct addr_marker {
> +       unsigned long start_address;
> +       const char *name;
> +};
> +
> +static struct addr_marker address_markers[] = {
> +       { 0,                    "vmalloc() Area" },
> +       { VMALLOC_END,          "vmalloc() End" },
> +       { MODULES_VADDR,        "Modules" },
> +       { PAGE_OFFSET,          "Kernel Mapping" },
> +       { -1,                   NULL },
> +};
> +
> +struct pg_state {
> +       struct seq_file *seq;
> +       const struct addr_marker *marker;
> +       unsigned long start_address;
> +       unsigned level;
> +       u64 current_prot;
> +};
> +
> +struct prot_bits {
> +       u64             mask;
> +       u64             val;
> +       const char      *set;
> +       const char      *clear;
> +};
> +
> +static const struct prot_bits pte_bits[] = {
> +       {
> +               .mask   = PTE_USER,
> +               .val    = PTE_USER,
> +               .set    = "USR",
> +               .clear  = "   ",
> +       }, {
> +               .mask   = PTE_RDONLY,
> +               .val    = PTE_RDONLY,
> +               .set    = "ro",
> +               .clear  = "RW",
> +       }, {
> +               .mask   = PTE_PXN,
> +               .val    = PTE_PXN,
> +               .set    = "NX",
> +               .clear  = "x ",
> +       }, {
> +               .mask   = PTE_SHARED,
> +               .val    = PTE_SHARED,
> +               .set    = "SHD",
> +               .clear  = "   ",
> +       }, {
> +               .mask   = PTE_AF,
> +               .val    = PTE_AF,
> +               .set    = "AF",
> +               .clear  = "  ",
> +       }, {
> +               .mask   = PTE_NG,
> +               .val    = PTE_NG,
> +               .set    = "NG",
> +               .clear  = "  ",
> +       }, {
> +               .mask   = PTE_UXN,
> +               .val    = PTE_UXN,
> +               .set    = "UXN",
> +       }, {
> +               .mask   = PTE_ATTRINDX_MASK,
> +               .val    = PTE_ATTRINDX(MT_DEVICE_nGnRnE),
> +               .set    = "DEVICE/nGnRnE",
> +       }, {
> +               .mask   = PTE_ATTRINDX_MASK,
> +               .val    = PTE_ATTRINDX(MT_DEVICE_nGnRE),
> +               .set    = "DEVICE/nGnRE",
> +       }, {
> +               .mask   = PTE_ATTRINDX_MASK,
> +               .val    = PTE_ATTRINDX(MT_DEVICE_GRE),
> +               .set    = "DEVICE/GRE",
> +       }, {
> +               .mask   = PTE_ATTRINDX_MASK,
> +               .val    = PTE_ATTRINDX(MT_NORMAL_NC),
> +               .set    = "MEM/BUFFERABLE",
> +       }, {
> +               .mask   = PTE_ATTRINDX_MASK,
> +               .val    = PTE_ATTRINDX(MT_NORMAL),
> +               .set    = "MEM/NORMAL",
> +       }
> +};
> +
> +static const struct prot_bits section_bits[] = {
> +       {
> +               .mask   = PMD_SECT_USER,
> +               .val    = PMD_SECT_USER,
> +               .set    = "USR",

We need a clear value here to keep pte and pmd output aligned similarly.

> +       }, {
> +               .mask   = PMD_SECT_RDONLY,
> +               .val    = PMD_SECT_RDONLY,
> +               .set    = "ro",
> +               .clear  = "RW",
> +       }, {
> +               .mask   = PMD_SECT_PXN,
> +               .val    = PMD_SECT_PXN,
> +               .set    = "NX",
> +               .clear  = "x ",
> +       }, {
> +               .mask   = PMD_SECT_S,
> +               .val    = PMD_SECT_S,
> +               .set    = "SHD",
> +               .clear  = "   ",
> +       }, {
> +               .mask   = PMD_SECT_AF,
> +               .val    = PMD_SECT_AF,
> +               .set    = "AF",
> +               .clear  = "  ",
> +       }, {
> +               .mask   = PMD_SECT_NG,
> +               .val    = PMD_SECT_NG,
> +               .set    = "NG",
> +               .clear  = "  ",
> +       }, {
> +               .mask   = PMD_SECT_UXN,
> +               .val    = PMD_SECT_UXN,
> +               .set    = "UXN",
> +       }, {
> +               .mask   = PTE_ATTRINDX_MASK,
> +               .val    = PTE_ATTRINDX(MT_DEVICE_nGnRnE),
> +               .set    = "DEVICE/nGnRnE",
> +       }, {
> +               .mask   = PTE_ATTRINDX_MASK,
> +               .val    = PTE_ATTRINDX(MT_DEVICE_nGnRE),
> +               .set    = "DEVICE/nGnRE",
> +       }, {
> +               .mask   = PTE_ATTRINDX_MASK,
> +               .val    = PTE_ATTRINDX(MT_DEVICE_GRE),
> +               .set    = "DEVICE/GRE",
> +       }, {
> +               .mask   = PTE_ATTRINDX_MASK,
> +               .val    = PTE_ATTRINDX(MT_NORMAL_NC),
> +               .set    = "MEM/BUFFERABLE",
> +       }, {
> +               .mask   = PTE_ATTRINDX_MASK,
> +               .val    = PTE_ATTRINDX(MT_NORMAL),
> +               .set    = "MEM/NORMAL",
> +       }
> +};
> +
> +struct pg_level {
> +       const struct prot_bits *bits;
> +       size_t num;
> +       u64 mask;
> +};
> +
> +static struct pg_level pg_level[] = {
> +       {
> +       }, { /* pgd */
> +       }, { /* pud */
> +       }, { /* pmd */
> +               .bits   = section_bits,
> +               .num    = ARRAY_SIZE(section_bits),
> +       }, { /* pte */
> +               .bits   = pte_bits,
> +               .num    = ARRAY_SIZE(pte_bits),
> +       },
> +};

It's possible to have block mappings in level 1 tables, which can be
pgds or puds. Because there are no bits, the masks will be empty and
note_page will skip printing them.

On my Juno that means 7GB of memory is missing from the ptdump output
because it got mapped with 1GB blocks.

So all of the pg_level entries will need bits set in some cases
(depending on the number of tables and page size). I think we can get
away with always setting .bits for all of them, as luckily all the prot
bits in pte_bits are the same for block and table entries at any level
anyway. We can just point all pg_level[*].bits entries at pte_bits for
now.

> +static void note_page(struct pg_state *st, unsigned long addr,
> unsigned level,
> +                               u64 val)
> +{
> +       static const char units[] = "KMGTPE";
> +       u64 prot = val & pg_level[level].mask;
> +
> +       if (addr < LOWEST_ADDR)
> +               return;
> +
> +       if (!st->level) {
> +               st->level = level;
> +               st->current_prot = prot;
> +               st->start_address = addr;
> +               seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +       } else if (prot != st->current_prot || level != st->level ||
> +                  addr >= st->marker[1].start_address) {
> +               const char *unit = units;
> +               unsigned long delta;
> +
> +               if (st->current_prot) {
> +                       seq_printf(st->seq, "0x%16lx-0x%16lx   ",
> +                                  st->start_address, addr);
> +
> +                       delta = (addr - st->start_address) >> 10;
> +                       while (!(delta & 1023) && unit[1]) {
> +                               delta >>= 10;
> +                               unit++;
> +                       }
> +                       seq_printf(st->seq, "%9lu%c", delta, *unit);
> +                       if (pg_level[st->level].bits)
> +                               dump_prot(st, pg_level[st->level].bits,
> +                                         pg_level[st->level].num);
> +                       seq_puts(st->seq, "\n");
> +               }
> +
> +               if (addr >= st->marker[1].start_address) {
> +                       st->marker++;
> +                       seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +               }
> +               st->start_address = addr;
> +               st->current_prot = prot;
> +               st->level = level;
> +       }
> +}
> +
> +static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
> +{
> +       pte_t *pte = pte_offset_kernel(pmd, 0);
> +       unsigned long addr;
> +       unsigned i;
> +
> +       for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
> +               addr = start + i * PAGE_SIZE;
> +               note_page(st, addr, 4, pte_val(*pte));
> +       }
> +}
> +
> +static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
> +{
> +       pmd_t *pmd = pmd_offset(pud, 0);
> +       unsigned long addr;
> +       unsigned i;
> +
> +       for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
> +               addr = start + i * PMD_SIZE;
> +               if (pmd_none(*pmd) || !pmd_present(*pmd) || pmd_bad(*pmd))

As far as I can tell p*d_present(x) == !p*d_none(x) in all cases, so we
should only need to check pmd_none and not !pmd_present.

> +                       note_page(st, addr, 3, pmd_val(*pmd));
> +               else
> +                       walk_pte(st, pmd, addr);
> +       }
> +}
> +
> +static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
> +{
> +       pud_t *pud = pud_offset(pgd, 0);
> +       unsigned long addr;
> +       unsigned i;
> +
> +       for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
> +               addr = start + i * PUD_SIZE;
> +               if (!pud_none(*pud))

In case of block mappings we need to check pud_none here too or we'll
end up dereferencing garbage. It would also be nice to match the pattern
of walk_pmd.

> +                       walk_pmd(st, pud, addr);
> +               else
> +                       note_page(st, addr, 2, pud_val(*pud));
> +       }
> +}
> +
> +static unsigned long normalize_addr(unsigned long u)
> +{
> +       return u | LOWEST_ADDR;
> +}
> +
> +static void walk_pgd(struct seq_file *m)
> +{
> +       pgd_t *pgd = swapper_pg_dir;
> +       struct pg_state st;
> +       unsigned long addr;
> +       unsigned i, pgdoff = 0;
> +
> +       memset(&st, 0, sizeof(st));
> +       st.seq = m;
> +       st.marker = address_markers;
> +
> +       for (i = pgdoff; i < PTRS_PER_PGD; i++, pgd++) {

This is the only use of pgdoff, so it can go.

> +               addr = normalize_addr(i * PGDIR_SIZE);
> +               if (!pgd_none(*pgd))
> +                       walk_pud(&st, pgd, addr);

Similarly to walk_pud, we need to check pgd_bad here.

We might need this on ARM too for LPAE. I don't know if we currently do
block mappings in pgds there.

> +               else
> +                       note_page(&st, addr, 1, pgd_val(*pgd));
> +       }
> +
> +       note_page(&st, 0, 0, 0);
> +}

It's a little annoying that walk_pgd also owns the setup and teardown,
as it makes it look different to walk_{pud,pmd}. It would be nicer if
that lived in ptdump_show.

Thanks,
Mark.

> +static int ptdump_show(struct seq_file *m, void *v)
> +{
> +       walk_pgd(m);
> +       return 0;
> +}
> +
> +static int ptdump_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, ptdump_show, NULL);
> +}
> +
> +static const struct file_operations ptdump_fops = {
> +       .open           = ptdump_open,
> +       .read           = seq_read,
> +       .llseek         = seq_lseek,
> +       .release        = single_release,
> +};
> +
> +static int ptdump_init(void)
> +{
> +       struct dentry *pe;
> +       unsigned i, j;
> +
> +       for (i = 0; i < ARRAY_SIZE(pg_level); i++)
> +               if (pg_level[i].bits)
> +                       for (j = 0; j < pg_level[i].num; j++)
> +                               pg_level[i].mask |= pg_level[i].bits[j].mask;
> +
> +       address_markers[0].start_address = VMALLOC_START;
> +
> +       pe = debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
> +                                &ptdump_fops);
> +       return pe ? 0 : -ENOMEM;
> +}
> +device_initcall(ptdump_init);
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
