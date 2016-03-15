From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Mar 2016 11:32:21 +0000
Subject: [PATCH] arm64: drop unused __local_flush_icache_all()
In-Reply-To: <1458035230-1038-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458035230-1038-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160315113220.GB19263@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 05:47:10PM +0800, Kefeng Wang wrote:
> After commit 65da0a8e34a8 ("arm64: use non-global mappings for UEFI
> runtime regions"), nobody use __local_flush_icache_all() anymore,
> so drop it.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

The only other user was the old ASID allocator. For the boot and idle
paths we do the local maintenance in asm. I don't imagine we're likely
to need this again soon.

So FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/cacheflush.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 22dda61..c64268d 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -116,13 +116,6 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>  extern void flush_dcache_page(struct page *);
>  
> -static inline void __local_flush_icache_all(void)
> -{
> -	asm("ic iallu");
> -	dsb(nsh);
> -	isb();
> -}
> -
>  static inline void __flush_icache_all(void)
>  {
>  	asm("ic	ialluis");
> -- 
> 2.6.0.GIT
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
