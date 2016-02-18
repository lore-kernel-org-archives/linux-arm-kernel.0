From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 18 Feb 2016 12:20:51 -0500 (EST)
Subject: [PATCH 8/9] ARM: do not use optimized do_div for ARMv3
In-Reply-To: <1455804123-2526139-9-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-9-git-send-email-arnd@arndb.de>
Message-ID: <alpine.LFD.2.20.1602181215310.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Feb 2016, Arnd Bergmann wrote:

> The gcc-4.9 optimization goes wrong while building target_core_iblock.c
> for ARMv3 and leaves a bogus reference to __aeabi_uldivmod in the
> output:
> 
> ERROR: "__aeabi_uldivmod" [drivers/target/target_core_iblock.ko] undefined!
> 
> I could not find anyone who is interested in fixing it in gcc,
> so as a workaround this disables the do_div magic, just like
> we do for old compilers and for OABI.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I suppose this is good enough for the purpose of keeping RiscPC 
buildable. Whether or not it is still used is another question.  If it 
is then its user probably expects it to be slow already.

Acked-by: Nicolas Pitre <nico@linaro.org>

Still unfortunate having to use a big hammer such as -march=armv3 just 
to avoid halfword memory accesses.


> ---
>  arch/arm/include/asm/div64.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index 7d919a9b32e5..958fdc2363f5 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -58,6 +58,14 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>   */
>  #define do_div(n, base) __div64_32(&(n), base)
>  
> +#elif defined(CONFIG_CPU_32v3)
> +
> +/*
> + * modern compiler versions (>= gcc-4.9) tend to misoptimize
> + * the code for ARMv3, and this is not getting fixed any more.
> + */
> +#define do_div(n, base) __div64_32(&(n), base)
> +
>  #else
>  
>  /*
> -- 
> 2.7.0
> 
> 
