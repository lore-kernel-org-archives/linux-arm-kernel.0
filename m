From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 30 Jun 2014 14:37:48 -0700
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping,
 and synchronization
In-Reply-To: <1403493118-7597-9-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-9-git-send-email-nathan_lynch@mentor.com>
Message-ID: <53B1D8AC.7060104@mit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2014 08:11 PM, Nathan Lynch wrote:
> Initialize the vdso page list at boot, install the vdso mapping at
> exec time, and update the data page during timer ticks.  This code is
> not built if CONFIG_VDSO is not enabled.
> 
> Account for the vdso length when randomizing the offset from the
> stack.  The vdso is placed immediately following the sigpage with a
> separate install_special_mapping call in arm_install_vdso.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
>  arch/arm/kernel/process.c |  13 +++-
>  arch/arm/kernel/vdso.c    | 168 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/kernel/vdso.c
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 40445fb71ac9..39b0d68aa068 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -520,6 +520,7 @@ extern struct page *get_signal_page(void);
>  int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  {
>  	struct mm_struct *mm = current->mm;
> +	unsigned long npages;
>  	unsigned long addr;
>  	unsigned long hint;
>  	int ret;
> @@ -529,9 +530,11 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  	if (!signal_page)
>  		return -ENOMEM;
>  
> +	npages = (vdso_mapping_len >> PAGE_SHIFT) + 1;
> +
>  	down_write(&mm->mmap_sem);
> -	hint = vdso_addr(mm, 1);
> -	addr = get_unmapped_area(NULL, hint, PAGE_SIZE, 0, 0);
> +	hint = vdso_addr(mm, npages);
> +	addr = get_unmapped_area(NULL, hint, npages, 0, 0);
>  	if (IS_ERR_VALUE(addr)) {
>  		ret = addr;
>  		goto up_fail;
> @@ -544,6 +547,12 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  	if (ret == 0)
>  		mm->context.sigpage = addr;
>  
> +	/* Unlike the sigpage, failure to install the vdso is unlikely
> +	 * to be fatal to the process, so no error check needed
> +	 * here.
> +	 */
> +	arm_install_vdso(mm, addr + PAGE_SIZE);
> +
>   up_fail:
>  	up_write(&mm->mmap_sem);
>  	return ret;
> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
> new file mode 100644
> index 000000000000..0cfd25f09adf
> --- /dev/null
> +++ b/arch/arm/kernel/vdso.c
> @@ -0,0 +1,168 @@
> +/*
> + * Adapted from arm64 version.
> + *
> + * Copyright (C) 2012 ARM Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/timekeeper_internal.h>
> +#include <linux/vmalloc.h>
> +
> +#include <asm/barrier.h>
> +#include <asm/cacheflush.h>
> +#include <asm/page.h>
> +#include <asm/vdso.h>
> +#include <asm/vdso_datapage.h>
> +
> +static struct page **vdso_pagelist;
> +
> +unsigned long vdso_mapping_len __read_mostly;
> +
> +/*
> + * The vDSO data page.
> + */
> +static union vdso_data_store vdso_data_store __page_aligned_data;
> +static struct vdso_data *vdso_data = &vdso_data_store.data;
> +
> +static int __init vdso_init(void)
> +{
> +	unsigned long vdso_pages;
> +	int i;
> +
> +	if (memcmp(&vdso_start, "\177ELF", 4)) {
> +		pr_err("vDSO is not a valid ELF object!\n");
> +		return -ENOEXEC;
> +	}
> +
> +	vdso_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
> +	pr_debug("vdso: %ld code pages at base %p\n", vdso_pages, &vdso_start);
> +
> +	/* Allocate the vDSO pagelist, plus a page for the data. */
> +	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
> +				GFP_KERNEL);
> +	if (vdso_pagelist == NULL)
> +		return -ENOMEM;
> +
> +	/* Grab the vDSO data page. */
> +	vdso_pagelist[0] = virt_to_page(vdso_data);
> +
> +	/* Grab the vDSO code pages. */
> +	for (i = 0; i < vdso_pages; i++)
> +		vdso_pagelist[i + 1] = virt_to_page(&vdso_start + i * PAGE_SIZE);
> +
> +	/* Precompute the mapping size */
> +	vdso_mapping_len = (vdso_pages + 1) << PAGE_SHIFT;
> +
> +	return 0;
> +}
> +arch_initcall(vdso_init);
> +
> +/* assumes mmap_sem is write-locked */
> +void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
> +{
> +	int ret;
> +
> +	mm->context.vdso = ~0UL;
> +
> +	if (vdso_pagelist == NULL)
> +		return;
> +
> +	/*
> +	 * Put vDSO base into mm struct before calling
> +	 * install_special_mapping so the perf counter mmap tracking
> +	 * code will recognise it as a vDSO.
> +	 */
> +	mm->context.vdso = addr;
> +
> +	ret = install_special_mapping(mm, addr, vdso_mapping_len,
> +				      VM_READ|VM_EXEC|
> +				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +				      vdso_pagelist);

Eek.  You're mapping the shared data VM_MAYWRITE.  This will cause
bizarre and confusing failures if ptrace pokes at it.  You also seem to
be sticking it *before* the vdso in the same vma.  This will severely
piss off all the tools that assume that "[vdso]" points to an ELF object.

x86 calls this thing "[vvar]" and sticks it after the vdso.  You might
not want to have the complexity of sticking it after the vdso (it's
distinctly nontrivial), but I see nothing wrong with giving it its own
vma just before the vdso.  The new _install_special_mapping function
makes it considerably easier to do.

(Don't use any version of x86's code before 3.16-rc3 as a reference.)

--Andy
