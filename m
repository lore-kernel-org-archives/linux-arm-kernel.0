From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Dec 2015 15:18:13 +0000
Subject: [RFC PATCH 1/2] arm64: Defer dcache flush in __cpu_copy_user_page
In-Reply-To: <1450099664-38554-2-git-send-email-ashoks@broadcom.com>
References: <1450099664-38554-1-git-send-email-ashoks@broadcom.com>
 <1450099664-38554-2-git-send-email-ashoks@broadcom.com>
Message-ID: <20151214151813.GE22038@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 05:27:43AM -0800, Ashok Kumar wrote:
> Defer dcache flushing to __sync_icache_dcache by calling
> flush_dcache_page which clears PG_dcache_clean flag.
> 
> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
> ---
>  arch/arm64/mm/copypage.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index 13bbc3be..22e4cb4 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -24,8 +24,9 @@
>  
>  void __cpu_copy_user_page(void *kto, const void *kfrom, unsigned long vaddr)
>  {
> +	struct page *page = virt_to_page(kto);
>  	copy_page(kto, kfrom);
> -	__flush_dcache_area(kto, PAGE_SIZE);
> +	flush_dcache_page(page);
>  }
>  EXPORT_SYMBOL_GPL(__cpu_copy_user_page);

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
