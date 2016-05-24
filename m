From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 May 2016 12:37:27 +0100
Subject: [PATCH 1/1] arm64: fix flush_cache_range
In-Reply-To: <1464088597-8820-1-git-send-email-thunder.leizhen@huawei.com>
References: <1464088597-8820-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20160524113727.GD25374@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 07:16:37PM +0800, Zhen Lei wrote:
> When we ran mprotect04(a test case in LTP) infinitely, it would always
> failed after a few seconds. The case can be described briefly that: copy
> a empty function from code area into a new memory area(created by mmap),
> then call mprotect to change the protection to PROT_EXEC. The syscall
> sys_mprotect will finally invoke flush_cache_range, but this function
> currently only invalid icache, the operation of flush dcache is missed.

In the LTP code I see powerpc-specific D-cache / I-cache synchronisation
(i.e. d-cache cleaning followed by I-cache invalidation), so there
appears to be some expectation of userspace maintenance. Hoever, there
is no such ARM-specific I-cache maintenance.

It looks like the test may be missing I-cache maintenance regardless of
the semantics of mprotect in this case.

I have not yet devled into flush_cache_range and how it is called.

Thanks,
Mark.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/mm/flush.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index dbd12ea..eda4124 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -31,7 +31,7 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
>  		       unsigned long end)
>  {
>  	if (vma->vm_flags & VM_EXEC)
> -		__flush_icache_all();
> +		flush_icache_range(start, end);
>  }
> 
>  static void sync_icache_aliases(void *kaddr, unsigned long len)
> --
> 2.5.0
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
