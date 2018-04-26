From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Apr 2018 18:47:14 +0100
Subject: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
In-Reply-To: <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
References: <cover.1524077494.git.andreyknvl@google.com>
 <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
Message-ID: <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 08:53:13PM +0200, Andrey Konovalov wrote:
> diff --git a/mm/gup.c b/mm/gup.c
> index 76af4cfeaf68..fb375de7d40d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -386,6 +386,8 @@ struct page *follow_page_mask(struct vm_area_struct *vma,
>  	struct page *page;
>  	struct mm_struct *mm = vma->vm_mm;
>  
> +	address = untagged_addr(address);
> +
>  	*page_mask = 0;
>  
>  	/* make this handle hugepd */

Does having a tagged address here makes any difference? I couldn't hit a
failure with my simple tests (LD_PRELOAD a library that randomly adds
tags to pointers returned by malloc).

> @@ -647,6 +649,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  	if (!nr_pages)
>  		return 0;
>  
> +	start = untagged_addr(start);
> +
>  	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
>  
>  	/*
> @@ -801,6 +805,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>  	struct vm_area_struct *vma;
>  	int ret, major = 0;
>  
> +	address = untagged_addr(address);
> +
>  	if (unlocked)
>  		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
>  
> @@ -854,6 +860,8 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>  	long ret, pages_done;
>  	bool lock_dropped;
>  
> +	start = untagged_addr(start);
> +
>  	if (locked) {
>  		/* if VM_FAULT_RETRY can be returned, vmas become invalid */
>  		BUG_ON(vmas);

Isn't __get_user_pages() untagging enough to cover this case as well?
Can this function not cope with tagged pointers?

> @@ -1751,6 +1759,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	unsigned long flags;
>  	int nr = 0;
>  
> +	start = untagged_addr(start);
> +
>  	start &= PAGE_MASK;
>  	addr = start;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
> @@ -1803,6 +1813,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	unsigned long addr, len, end;
>  	int nr = 0, ret = 0;
>  
> +	start = untagged_addr(start);
> +
>  	start &= PAGE_MASK;
>  	addr = start;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;

Have you hit a problem with the fast gup functions and tagged pointers?
The page table walking macros (e.g. p*d_index()) should mask the tag out
already.

-- 
Catalin
