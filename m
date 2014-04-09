From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 9 Apr 2014 20:45:07 +0200
Subject: [PATCH v2] ARM: uprobes need icache flush after xol write
In-Reply-To: <1397023132-10313-2-git-send-email-victor.kamensky@linaro.org>
References: <1397023132-10313-1-git-send-email-victor.kamensky@linaro.org>
 <1397023132-10313-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140409184507.GA1058@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Victor, sorry, I can't even read this thread now, will try to reply
tomorrow... But at first glance,

On 04/08, Victor Kamensky wrote:
>
> Because on ARM cache flush function need kernel address

...

> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1287,6 +1287,7 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
>  {
>  	struct xol_area *area;
>  	unsigned long xol_vaddr;
> +	void *xol_page_kaddr;
>  
>  	area = get_xol_area();
>  	if (!area)
> @@ -1296,14 +1297,22 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
>  	if (unlikely(!xol_vaddr))
>  		return 0;
>  
> -	/* Initialize the slot */
> -	copy_to_page(area->page, xol_vaddr,
> -			&uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
>  	/*
> -	 * We probably need flush_icache_user_range() but it needs vma.
> -	 * This should work on supported architectures too.
> +	 * We don't use copy_to_page here because we need kernel page
> +	 * addr to invalidate caches correctly
>  	 */
> -	flush_dcache_page(area->page);
> +	xol_page_kaddr = kmap_atomic(area->page);
> +
> +	/* Initialize the slot */
> +	memcpy(xol_page_kaddr + (xol_vaddr & ~PAGE_MASK),
> +	       &uprobe->arch.ixol,
> +	       sizeof(uprobe->arch.ixol));
> +
> +	arch_uprobe_flush_xol_access(area->page, xol_vaddr,
> +				     xol_page_kaddr + (xol_vaddr & ~PAGE_MASK),
> +				     sizeof(uprobe->arch.ixol));
> +
> +	kunmap_atomic(xol_page_kaddr);
>  
>  	return xol_vaddr;
>  }
> @@ -1346,6 +1355,18 @@ static void xol_free_insn_slot(struct task_struct *tsk)
>  	}
>  }
>  
> +void __weak arch_uprobe_flush_xol_access(struct page *page, unsigned long vaddr,
> +					 void *kaddr, unsigned long len)
> +{
> +	/*
> +	 * We probably need flush_icache_user_range() but it needs vma.
> +	 * This should work on most of architectures by default. If
> +	 * architecture needs to do something different it can define
> +	 * its own version of the function.
> +	 */
> +	flush_dcache_page(page);
> +}

In this case I'd suggest to move this kmap/memcpy horror into arch_ helper.
IOW, something like below.

If arm needs the kernel address we are writing to, let it do kmap/etc in
its implementation.

Oleg.


--- x/kernel/events/uprobes.c
+++ x/kernel/events/uprobes.c
@@ -1291,18 +1291,16 @@ static unsigned long xol_get_insn_slot(s
 	if (unlikely(!xol_vaddr))
 		return 0;
 
-	/* Initialize the slot */
-	copy_to_page(area->page, xol_vaddr,
-			&uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
-	/*
-	 * We probably need flush_icache_user_range() but it needs vma.
-	 * This should work on supported architectures too.
-	 */
-	flush_dcache_page(area->page);
-
+	arch_uprobe_xxx(area->page, xol_vaddr, ...);
 	return xol_vaddr;
 }
 
+void __weak arch_uprobe_xxx(page, xol_vaddr, ...)
+{
+	copy_to_page(page, xol_vaddr, ...)
+	flush_dcache_page(page);
+}
+
 /*
  * xol_free_insn_slot - If slot was earlier allocated by
  * @xol_get_insn_slot(), make the slot available for
