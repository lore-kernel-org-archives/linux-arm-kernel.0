From: bp@alien8.de (Borislav Petkov)
Date: Tue, 29 Jan 2013 09:35:22 +0100
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
Message-ID: <20130129083522.GA14302@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 07:30:33PM -0600, Kim Phillips wrote:
> Enable the compiler intrinsic for byte swapping on arch ARM.  This
> allows the compiler to detect and be able to optimize out byte
> swappings, e.g. in big endian to big endian moves.
> 
> AFAICT, arm gcc got __builtin_bswap{32,64} support in 4.6,
> and for the 16-bit version in 4.8.
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> akin to: http://comments.gmane.org/gmane.linux.kernel.cross-arch/16016
> 
> based on linux-next.  Depends on commit "compiler-gcc{3,4}.h: Use
> GCC_VERSION macro" by Daniel Santos <daniel.santos@pobox.com>,
> currently in the akpm branch.
> 
> RFC because of unfamiliarity with arch ARM, and that at91sam9rl,
> at91rm9200, and lpd270 (so far, at least) builds fail with:
> 
> include/uapi/linux/swab.h:60: undefined reference to `__bswapsi2'
> 
> I'm using eldk-5.2.1/armv7a's arm-linux-gnueabi-gcc (GCC) 4.6.4
> 20120303 (prerelease)
> 
>  arch/arm/Kconfig              |    1 +
>  include/linux/compiler-gcc4.h |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index eda8711..437d11a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -3,6 +3,7 @@ config ARM
>  	default y
>  	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> +	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_HAVE_CUSTOM_GPIO_H
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select BUILDTIME_EXTABLE_SORT if MMU
> diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
> index 68b162d..da5f728 100644
> --- a/include/linux/compiler-gcc4.h
> +++ b/include/linux/compiler-gcc4.h
> @@ -67,7 +67,8 @@
>  
>  
>  #ifdef CONFIG_ARCH_USE_BUILTIN_BSWAP
> -#if GCC_VERSION >= 40400
> +#if (!defined(__arm__) && GCC_VERSION >= 40400) || \
> +    (defined(__arm__) && GCC_VERSION >= 40600)

There should be no arch-specific stuff in a generic header. I guess
you probably need to select ARCH_USE_BUILTIN_BSWAP in an arm-specific
compiler.h header after checking compiler version...

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
