From: rabin@rab.in (Rabin Vincent)
Date: Thu, 27 Aug 2015 19:26:48 +0200
Subject: [PATCH] arm: insn: use set_fixmap_offset to make it more clear
In-Reply-To: <1440552266-19940-1-git-send-email-yalin.wang2010@gmail.com>
References: <1440552266-19940-1-git-send-email-yalin.wang2010@gmail.com>
Message-ID: <20150827172605.GA5251@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 09:24:26AM +0800, yalin wang wrote:
> A little change to patch_map() function,
> use set_fixmap_offset() to make code more clear.
> 
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> ---
>  arch/arm/kernel/patch.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
> index 69bda1a..5779105 100644
> --- a/arch/arm/kernel/patch.c
> +++ b/arch/arm/kernel/patch.c
> @@ -36,9 +36,8 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
>  	else
>  		__acquire(&patch_lock);
>  
> -	set_fixmap(fixmap, page_to_phys(page));
> -
> -	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
> +	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
> +			(uintaddr & ~PAGE_MASK));
>  }

Perhaps a temporary variable to make it clearerer?  Something like this:

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index 69bda1a..0b8e594 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -23,6 +23,7 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 	unsigned int uintaddr = (uintptr_t) addr;
 	bool module = !core_kernel_text(uintaddr);
 	struct page *page;
+	phys_addr_t phys;
 
 	if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
 		page = vmalloc_to_page(addr);
@@ -36,9 +37,8 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 	else
 		__acquire(&patch_lock);
 
-	set_fixmap(fixmap, page_to_phys(page));
-
-	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
+	phys = page_to_phys(page) + (uintaddr & ~PAGE_MASK);
+	return (void *) set_fixmap_offset(fixmap, phys);
 }
 
 static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
