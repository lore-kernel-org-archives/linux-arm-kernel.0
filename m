From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Dec 2015 12:19:19 +0000
Subject: [PATCH] arm64: Support VDSO remapping
In-Reply-To: <1448455781-26660-1-git-send-email-cov@codeaurora.org>
References: <1448455781-26660-1-git-send-email-cov@codeaurora.org>
Message-ID: <20151202121918.GA4523@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On Wed, Nov 25, 2015 at 07:49:29AM -0500, Christopher Covington wrote:
> Some applications such as Checkpoint/Restore In Userspace (CRIU) remap and
> unmap the VDSO. Add support for this to the AArch64 kernel by copying in
> the PowerPC code with slight modifications.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/arm64/include/asm/Kbuild          |  1 -
>  arch/arm64/include/asm/mm-arch-hooks.h | 28 ++++++++++++++++++++++++++++
>  arch/arm64/include/asm/mmu_context.h   | 23 ++++++++++++++++++++++-
>  3 files changed, 50 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/mm-arch-hooks.h
> 
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index 70fd9ff..b112a39 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -25,7 +25,6 @@ generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
> -generic-y += mm-arch-hooks.h
>  generic-y += mman.h
>  generic-y += msgbuf.h
>  generic-y += msi.h
> diff --git a/arch/arm64/include/asm/mm-arch-hooks.h b/arch/arm64/include/asm/mm-arch-hooks.h
> new file mode 100644
> index 0000000..e6923fb
> --- /dev/null
> +++ b/arch/arm64/include/asm/mm-arch-hooks.h
> @@ -0,0 +1,28 @@
> +/*
> + * Architecture specific mm hooks
> + *
> + * Copyright (C) 2015, IBM Corporation
> + * Author: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_MM_ARCH_HOOKS_H
> +#define __ASM_MM_ARCH_HOOKS_H
> +
> +static inline void arch_remap(struct mm_struct *mm,
> +			      unsigned long old_start, unsigned long old_end,
> +			      unsigned long new_start, unsigned long new_end)
> +{
> +	/*
> +	 * mremap() doesn't allow moving multiple vmas so we can limit the
> +	 * check to old_start == vdso_base.
> +	 */
> +	if ((void *)old_start == mm->context.vdso)
> +		mm->context.vdso = (void *)new_start;
> +}
> +#define arch_remap arch_remap
> +
> +#endif /* __ASM_MM_ARCH_HOOKS_H */
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 2416578..9fe0773 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -24,7 +24,6 @@
>  
>  #include <asm/cacheflush.h>
>  #include <asm/proc-fns.h>
> -#include <asm-generic/mm_hooks.h>
>  #include <asm/cputype.h>
>  #include <asm/pgtable.h>
>  
> @@ -147,4 +146,26 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  #define deactivate_mm(tsk,mm)	do { } while (0)
>  #define activate_mm(prev,next)	switch_mm(prev, next, NULL)
>  
> +static inline void arch_dup_mmap(struct mm_struct *oldmm,
> +				      struct mm_struct *mm)
> +{
> +}
> +
> +static inline void arch_exit_mmap(struct mm_struct *mm)
> +{
> +}
> +
> +static inline void arch_unmap(struct mm_struct *mm,
> +			      struct vm_area_struct *vma,
> +			      unsigned long start, unsigned long end)
> +{
> +	if ((void *)start <= mm->context.vdso && mm->context.vdso < (void *)end)
> +		mm->context.vdso = NULL;
> +}
> +
> +static inline void arch_bprm_mm_init(struct mm_struct *mm,
> +				     struct vm_area_struct *vma)
> +{
> +}

This is virtually identical to the PowerPC implementation, afaict. Any
chance we could move this to core code and define some generic vdso
accessors for the mm?

Will
