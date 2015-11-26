From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Nov 2015 12:10:08 +0000
Subject: [PATCH v7 0/4] KASAN for arm64
In-Reply-To: <564B4BFC.1020905@virtuozzo.com>
References: <1444665180-301-1-git-send-email-ryabinin.a.a@gmail.com>
 <20151013083432.GG6320@e104818-lin.cambridge.arm.com>
 <5649BAFD.6030005@arm.com> <5649F783.40109@gmail.com>
 <564B40A7.1000206@arm.com> <564B4BFC.1020905@virtuozzo.com>
Message-ID: <20151126121007.GC32343@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Can you pick up Andrey's patch below for v4.4, until we have a better
solution?

I stumbled across this myself and was about to post a similar patch.

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

On Tue, Nov 17, 2015 at 06:47:08PM +0300, Andrey Ryabinin wrote:
> We should either add proper Kconfig dependency for now, or just make it work.
> 
> 
> From: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Subject: [PATCH] arm64: KASAN depends on !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> 
> On KASAN + 16K_PAGES + 48BIT_VA
>  arch/arm64/mm/kasan_init.c: In function ?kasan_early_init?:
>  include/linux/compiler.h:484:38: error: call to ?__compiletime_assert_95? declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE)
>     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> 
> Currently KASAN will not work on 16K_PAGES and 48BIT_VA, so
> forbid such configuration to avoid above build failure.
> 
> Reported-by: Suzuki K. Poulose <Suzuki.Poulose@arm.com>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 9ac16a4..bf7de69 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -49,7 +49,7 @@ config ARM64
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_BITREVERSE
>  	select HAVE_ARCH_JUMP_LABEL
> -	select HAVE_ARCH_KASAN if SPARSEMEM_VMEMMAP
> +	select HAVE_ARCH_KASAN if SPARSEMEM_VMEMMAP && !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_TRACEHOOK
> -- 
> 2.4.10
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
