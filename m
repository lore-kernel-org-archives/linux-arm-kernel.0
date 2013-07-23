From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 23 Jul 2013 16:05:58 -0400 (EDT)
Subject: [PATCH 3/6] ARM: prefetch: add support for prefetchw using pldw on
 SMP ARMv7+ CPUs
In-Reply-To: <1374579389-32704-4-git-send-email-will.deacon@arm.com>
References: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
 <1374579389-32704-4-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.03.1307231559120.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jul 2013, Will Deacon wrote:

> SMP ARMv7 CPUs implement the pldw instruction, which allows them to
> prefetch data cachelines in an exclusive state.
> 
> This patch defines the prefetchw macro using pldw for CPUs that support
> it.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Minor nit below.  Otherwise:

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/processor.h | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index cbdb130..d571697 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -116,12 +116,19 @@ static inline void prefetch(const void *ptr)
>  		:: "p" (ptr));
>  }
>  
> +#if __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
>  #define ARCH_HAS_PREFETCHW
> -#define prefetchw(ptr)	prefetch(ptr)
> -
> -#define ARCH_HAS_SPINLOCK_PREFETCH
> -#define spin_lock_prefetch(x) do { } while (0)
> -

What about keeping the above definitions when __LINUX_ARM_ARCH__ >= 7
&& defined(CONFIG_SMP) is not true?

> +static inline void prefetchw(const void *ptr)
> +{
> +	__asm__ __volatile__(
> +		".arch_extension	mp\n"
> +	__ALT_SMP_ASM(
> +		WASM(pldw)		"\t%a0",
> +		WASM(pld)		"\t%a0"
> +	)

The paren indentation looks odd.  If you shift the whole __ALT_SMP_ASM 
block right then it is also less likely to look like a sequential 
execution of pldw followed by pld to the casual reader.

> +		:: "p" (ptr));
> +}
> +#endif
>  #endif
>  
>  #define HAVE_ARCH_PICK_MMAP_LAYOUT
> -- 
> 1.8.2.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
