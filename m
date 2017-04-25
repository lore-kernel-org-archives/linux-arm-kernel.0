From: dsafonov@virtuozzo.com (Dmitry Safonov)
Date: Tue, 25 Apr 2017 20:19:21 +0300
Subject: [PATCH] ARM/shmem: Drop page coloring align for non-VIPT CPUs
In-Reply-To: <20170414100953.4703-1-dsafonov@virtuozzo.com>
References: <20170414100953.4703-1-dsafonov@virtuozzo.com>
Message-ID: <571024bf-892d-4d08-dd9e-654b1e28c23e@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2017 01:09 PM, Dmitry Safonov wrote:
> On ARMv6 CPUs with VIPT caches there are aliasing issues: if two
> different cache line indexes correspond to the same physical
> address, then changes made to one of the alias might be lost
> or they can overwrite each other. To overcome aliasing issues,
> the align for shared mappings was introduced with:
> 
> commit 4197692eef113eeb8e3e413cc70993a5e667e5b8
> Author: Russell King <rmk@flint.arm.linux.org.uk>
> Date:   Wed Apr 28 22:22:33 2004 +0100
> 
>      [ARM] Fix shared mmap()ings for ARM VIPT caches.
> 
>      This allows us to appropriately align shared mappings on VIPT caches
>      with aliasing issues.
> 
> Which introduced 4 pages align with SHMLBA, which resulted in
> unique physical address after any tag in cache (because two upper bits
> corresponding to page address get unused in tags).
> 
> As this workaround is not needed by non-VIPT caches (like most armv7
> CPUs which have PIPT caches), ARM mmap() code checks if cache is VIPT
> aliasing for MAP_SHARED.
> 
> The problem here is in shmat() syscall:
> 1. if shmaddr is NULL then do_shmat() uses arch_get_unmapped_area()
>     to allocate shared mapping.
> 2. if shmaddr is specified then do_shmat() checks that address has
>     SHMLBA alignment regardless to CPU cache aliasing.
> 
> Which results on ARMv7 CPUs that shmat() with NULL shmaddr may return
> non-SHMLBA aligned address (page-aligned), but shmat() with the same
> address will fail.
> 
> That is not critical issue for CRIU as after shmat() with NULL address,
> we can mremap() resulted shmem to restore shared memory mappings on the
> same address where they were on checkpointing.
> But it's still worth fixing because we can't reliably tell from
> userspace if the platform has VIPT cache, and so this mremap()
> workaround is done with HUGE warning that restoring application, that
> uses SHMBLA-unaligned shmem on ARMv6 CPU with VIPT cache may result
> in data corruptions.
> 
> I also changed SHMLBA build-time check to init-time WARN_ON(), as
> it's not constant afterward.
> 
> This is resend of the patch from discussion:
> http://www.spinics.net/lists/arm-kernel/msg258870.html
> 
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Christopher Covington <cov@codeaurora.org>
> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
> Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
> ---
>   arch/arm/include/asm/shmparam.h | 8 ++++----
>   arch/arm/mm/copypage-v6.c       | 5 +----
>   2 files changed, 5 insertions(+), 8 deletions(-)

Ping?

> 
> diff --git a/arch/arm/include/asm/shmparam.h b/arch/arm/include/asm/shmparam.h
> index a5223b3a9bf9..6e1a72cbdf78 100644
> --- a/arch/arm/include/asm/shmparam.h
> +++ b/arch/arm/include/asm/shmparam.h
> @@ -1,16 +1,16 @@
>   #ifndef _ASMARM_SHMPARAM_H
>   #define _ASMARM_SHMPARAM_H
>   
> +#include <asm/cachetype.h>
> +
>   /*
>    * This should be the size of the virtually indexed cache/ways,
>    * or page size, whichever is greater since the cache aliases
>    * every size/ways bytes.
>    */
> -#define	SHMLBA	(4 * PAGE_SIZE)		 /* attach addr a multiple of this */
> +#define	SHMLBA (cache_is_vipt_aliasing() ? 4 * PAGE_SIZE : PAGE_SIZE)
>   
> -/*
> - * Enforce SHMLBA in shmat
> - */
> +/* Enforce SHMLBA in shmat */
>   #define __ARCH_FORCE_SHMLBA
>   
>   #endif /* _ASMARM_SHMPARAM_H */
> diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
> index 70423345da26..9b22c530e8b6 100644
> --- a/arch/arm/mm/copypage-v6.c
> +++ b/arch/arm/mm/copypage-v6.c
> @@ -20,10 +20,6 @@
>   
>   #include "mm.h"
>   
> -#if SHMLBA > 16384
> -#error FIX ME
> -#endif
> -
>   static DEFINE_RAW_SPINLOCK(v6_lock);
>   
>   /*
> @@ -129,6 +125,7 @@ struct cpu_user_fns v6_user_fns __initdata = {
>   
>   static int __init v6_userpage_init(void)
>   {
> +	WARN_ON(SHMLBA > 16384);
>   	if (cache_is_vipt_aliasing()) {
>   		cpu_user.cpu_clear_user_highpage = v6_clear_user_highpage_aliasing;
>   		cpu_user.cpu_copy_user_highpage = v6_copy_user_highpage_aliasing;
> 


-- 
              Dmitry
