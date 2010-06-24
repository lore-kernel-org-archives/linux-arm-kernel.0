From: igawa@mxs.nes.nec.co.jp (Masayuki Igawa)
Date: Thu, 24 Jun 2010 16:33:56 +0900
Subject: [PATCH 3/3] add ARM crashdump support
In-Reply-To: <b567a76e7f4502ccd56f818ebd3d6509ebd4a96d.1277188128.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
	<b567a76e7f4502ccd56f818ebd3d6509ebd4a96d.1277188128.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <20100624163356.dbb849bc.igawa@mxs.nes.nec.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mika.

On Tue, 22 Jun 2010 09:59:12 +0300, Mika Westerberg wrote:
> This patch adds support for processing ARM kernel crashdumps as well.
> 
> Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> ---
>  Makefile       |    4 +-
>  arm.c          |  200 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  makedumpfile.h |   33 +++++++++
>  3 files changed, 235 insertions(+), 2 deletions(-)
>  create mode 100644 arm.c
> 
> diff --git a/Makefile b/Makefile
> index 4a8a060..3d2ee34 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -23,8 +23,8 @@ CFLAGS_ARCH += -m64
>  endif
>  
>  SRC	= makedumpfile.c makedumpfile.h diskdump_mod.h
> -SRC_ARCH = x86.c x86_64.c ia64.c ppc64.c
> -OBJ_ARCH = x86.o x86_64.o ia64.o ppc64.o
> +SRC_ARCH = arm.c x86.c x86_64.c ia64.c ppc64.c
> +OBJ_ARCH = arm.o x86.o x86_64.o ia64.o ppc64.o
>  
>  all: makedumpfile
>  
> diff --git a/arm.c b/arm.c
> new file mode 100644
> index 0000000..5acad78
> --- /dev/null
> +++ b/arm.c
> @@ -0,0 +1,200 @@
> +/*
> + * arm.c
> + *
> + * Created by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> + * Copyright (C) 2010 Nokia Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#ifdef __arm__
> +
> +#include "makedumpfile.h"
> +
> +#define PMD_TYPE_MASK	3
> +#define PMD_TYPE_SECT	2
> +#define PMD_TYPE_TABLE	1
> +
> +#define pgd_index(vaddr) ((vaddr) >> PGDIR_SHIFT)
> +#define pte_index(vaddr) ((vaddr >> PAGESHIFT()) & (PTRS_PER_PTE - 1))
> +
> +#define pgd_offset(pgdir, vaddr) \
> +	((pgdir) + pgd_index(vaddr) * 2 * sizeof(unsigned long))
> +#define pmd_offset(dir, vaddr) (dir)
> +#define pte_offset(pmd, vaddr) \
> +	(pmd_page_vaddr(pmd) + pte_index(vaddr) * sizeof(unsigned long))
> +
> +/*
> + * These only work for kernel directly mapped addresses.
> + */
> +#define __va(paddr) ((paddr) - info->phys_base + info->page_offset)
> +#define __pa(vaddr) ((vaddr) - info->page_offset + info->phys_base)
> +
> +static inline unsigned long
> +pmd_page_vaddr(unsigned long pmd)
> +{
> +	unsigned long ptr;
> +
> +	ptr = pmd & ~(PTRS_PER_PTE * sizeof(void *) - 1);
> +	ptr += PTRS_PER_PTE * sizeof(void *);
> +
> +	return __va(ptr);
> +}
> +
> +int
> +get_phys_base_arm(void)
> +{
> +	unsigned long phys_base = ULONG_MAX;
> +	int i;
> +
> +	/*
> +	 * We resolve phys_base from PT_LOAD segments. LMA contains physical
> +	 * address of the segment, and we use the first one.
> +	 */
> +	for (i = 0; i < info->num_load_memory; i++) {
> +		const struct pt_load_segment *pls = &info->pt_load_segments[i];
> +
> +		if (pls->phys_start < phys_base)
> +			phys_base = pls->phys_start;
> +	}
> +
> +	if (phys_base == ULONG_MAX) {
> +		ERRMSG("Can't determine phys_base.\n");
> +		return FALSE;
> +	}
> +
> +	info->phys_base = phys_base;
> +	DEBUG_MSG("phys_base    : %lx\n", phys_base);
> +
> +	return TRUE;
> +}
> +
> +int
> +get_machdep_info_arm(void)
> +{
> +	unsigned long vmlist, vmalloc_start;
> +
> +	info->page_offset = __PAGE_OFFSET;
> +	info->max_physmem_bits = _MAX_PHYSMEM_BITS;
> +	info->kernel_start = SYMBOL(_stext);
> +	info->section_size_bits = _SECTION_SIZE_BITS;
> +
> +	/*
> +	 * For the compatibility, makedumpfile should run without the symbol
> +	 * vmlist and the offset of vm_struct.addr if they are not necessary.
> +	 */
> +	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL) ||
> +		OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE) {
> +		return TRUE;
> +	}
> +
> +	if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
> +		ERRMSG("Can't get vmlist.\n");
> +		return FALSE;
> +	}
> +	if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
> +		     sizeof(vmalloc_start))) {
> +		ERRMSG("Can't get vmalloc_start.\n");
> +		return FALSE;
> +	}
> +
> +	info->vmalloc_start = vmalloc_start;
> +
> +	DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
> +	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
> +	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
> +
> +	return TRUE;
> +}
> +
> +static int
> +is_vmalloc_addr_arm(unsigned long vaddr)
> +{
> +	return (info->vmalloc_start && vaddr >= info->vmalloc_start);
> +}
> +
> +/*
> + * vtop_arm() - translate arbitrary virtual address to physical
> + * @vaddr: virtual address to translate
> + *
> + * Function translates @vaddr into physical address using page tables. This
> + * address can be any virtual address. Returns physical address of the
> + * corresponding virtual address or %NOT_PADDR when there is no translation.
> + */
> +static unsigned long long
> +vtop_arm(unsigned long vaddr)
> +{
> +	unsigned long long paddr = NOT_PADDR;
> +	unsigned long ptr, pgd, pte, pmd;
> +
> +	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
> +		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
> +		return NOT_PADDR;
> +	}
> +
> +	ptr = pgd_offset(SYMBOL(swapper_pg_dir), vaddr);
> +	if (!readmem(VADDR, ptr, &pgd, sizeof(pmd))) {
> +		ERRMSG("Can't read pgd\n");
> +		return NOT_PADDR;
> +	}
> +
> +	if (info->vaddr_for_vtop == vaddr)
> +		MSG("  PGD : %08lx => %08lx\n", ptr, pgd);
> +
> +	pmd = pmd_offset(pgd, vaddr);
> +
> +	switch (pmd & PMD_TYPE_MASK) {
> +	case PMD_TYPE_TABLE: {
> +		/* 4k small page */
> +		ptr = pte_offset(pmd, vaddr);
> +		if (!readmem(VADDR, ptr, &pte, sizeof(pte))) {
> +			ERRMSG("Can't read pte\n");
> +			return NOT_PADDR;
> +		}
> +
> +		if (info->vaddr_for_vtop == vaddr)
> +			MSG("  PTE : %08lx => %08lx\n", ptr, pte);
> +
> +		if (!(pte & _PAGE_PRESENT)) {
> +			ERRMSG("Can't get a valid pte.\n");
> +			return NOT_PADDR;
> +		}
> +
> +		paddr = PAGEBASE(pte) + (vaddr & (PAGESIZE() - 1));
> +		break;
> +	}
> +
> +	case PMD_TYPE_SECT:
> +		/* 1MB section */
> +		pte = pmd & PMD_MASK;
> +		paddr = pte + (vaddr & (PMD_SIZE - 1));
> +		break;
> +	}
> +
> +	return paddr;
> +}
> +
> +unsigned long long
> +vaddr_to_paddr_arm(unsigned long vaddr)
> +{
> +	unsigned long long paddr;
> +
> +	if ((paddr = vaddr_to_paddr_general(vaddr)) != NOT_PADDR)
> +		return paddr;

Here is a checkpatche.pl's error.
====
ERROR: do not use assignment in if condition
#303: FILE: arm.c:189:
+       if ((paddr = vaddr_to_paddr_general(vaddr)) != NOT_PADDR)

total: 1 errors, 0 warnings, 261 lines checked
====

How about is this?
====
+unsigned long long
+vaddr_to_paddr_arm(unsigned long vaddr)
+{
+	unsigned long long paddr = vaddr_to_paddr_general(vaddr);
+
+	if (paddr != NOT_PADDR)
+		return paddr;
====

BTW, I'm testing these patches for x86/x86_64 arch now.
I'll merge these patches after my testing.

But I cannot test for ARM because have no test machines of ARM.

Thanks.
-- Masayuki Igawa


> +
> +	if (is_vmalloc_addr_arm(vaddr))
> +		paddr = vtop_arm(vaddr);
> +	else
> +		paddr = __pa(vaddr);
> +
> +	return paddr;
> +}
> +
> +#endif /* __arm__ */
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 2717d81..8a74b34 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -506,6 +506,24 @@ do { \
>  #define VMEMMAP_START		(info->vmemmap_start)
>  #define VMEMMAP_END		(info->vmemmap_end)
>  
> +#ifdef __arm__
> +#define __PAGE_OFFSET		(0xc0000000)
> +#define KVBASE_MASK		(0xffff)
> +#define KVBASE			(SYMBOL(_stext) & ~KVBASE_MASK)
> +#define _SECTION_SIZE_BITS	(28)
> +#define _MAX_PHYSMEM_BITS	(32)
> +#define ARCH_PFN_OFFSET		(info->phys_base >> PAGESHIFT())
> +
> +#define PTRS_PER_PTE		(512)
> +#define PGDIR_SHIFT		(21)
> +#define PMD_SHIFT		(21)
> +#define PMD_SIZE		(1UL << PMD_SHIFT)
> +#define PMD_MASK		(~(PMD_SIZE - 1))
> +
> +#define _PAGE_PRESENT		(1 << 0)
> +
> +#endif /* arm */
> +
>  #ifdef __x86__
>  #define __PAGE_OFFSET		(0xc0000000)
>  #define __VMALLOC_RESERVE       (128 << 20)
> @@ -653,6 +671,16 @@ do { \
>  /*
>   * The function of dependence on machine
>   */
> +#ifdef __arm__
> +int get_phys_base_arm(void);
> +int get_machdep_info_arm(void);
> +unsigned long long vaddr_to_paddr_arm(unsigned long vaddr);
> +#define get_phys_base()		get_phys_base_arm()
> +#define get_machdep_info()	get_machdep_info_arm()
> +#define get_versiondep_info()	TRUE
> +#define vaddr_to_paddr(X)	vaddr_to_paddr_arm(X)
> +#endif /* arm */
> +
>  #ifdef __x86__
>  int get_machdep_info_x86(void);
>  int get_versiondep_info_x86(void);
> @@ -1148,6 +1176,11 @@ struct domain_list {
>  #define PAGES_PER_MAPWORD 	(sizeof(unsigned long) * 8)
>  #define MFNS_PER_FRAME		(info->page_size / sizeof(unsigned long))
>  
> +#ifdef __arm__
> +#define kvtop_xen(X)	FALSE
> +#define get_xen_info_arch(X) FALSE
> +#endif	/* arm */
> +
>  #ifdef __x86__
>  #define HYPERVISOR_VIRT_START_PAE	(0xF5800000UL)
>  #define HYPERVISOR_VIRT_START		(0xFC000000UL)
> -- 
> 1.5.6.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
