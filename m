From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 19 Aug 2013 19:16:45 -0400 (EDT)
Subject: [PATCH resend] ARM: add workaround for ambiguous C99 stdint.h
 types
In-Reply-To: <1376896358-21076-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1376896358-21076-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.03.1308191915190.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Aug 2013, Ard Biesheuvel wrote:

> The C99 types uintXX_t that are usually defined in 'stdint.h' are not as
> unambiguous on ARM as you would expect. For the types below, there is a
> difference on ARM between GCC built for bare metal ARM, GCC built for glibc
> and the kernel itself, which results in build errors if you try to build with
> -ffreestanding and include 'stdint.h' (such as when you include 'arm_neon.h'
> in order to use NEON intrinsics)
> 
> As the typedefs for these types in 'stdint.h' are based on builtin defines
> supplied by GCC, we can tweak these to align with the kernel's idea of those
> types, so 'linux/types.h' and 'stdint.h' can be safely included from the same
> source file (provided that -ffreestanding is used).
> 
>                    int32_t         uint32_t               uintptr_t
> bare metal GCC     long            unsigned long          unsigned int
> glibc GCC          int             unsigned int           unsigned int
> kernel             int             unsigned int           unsigned long
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Acked by: Dave Martin <dave.martin@arm.com>
> Acked-by: Mikael Pettersson <mikpe@it.uu.se>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I think you may put this patch into Russell's patch system now:

http://www.arm.linux.org.uk/developer/patches/



> ---
>  arch/arm/include/asm/types.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 arch/arm/include/asm/types.h
> 
> diff --git a/arch/arm/include/asm/types.h b/arch/arm/include/asm/types.h
> new file mode 100644
> index 0000000..c4f0bca
> --- /dev/null
> +++ b/arch/arm/include/asm/types.h
> @@ -0,0 +1,40 @@
> +#ifndef _ASM_TYPES_H
> +#define _ASM_TYPES_H
> +
> +#include <asm-generic/int-ll64.h>
> +
> +/*
> + * The C99 types uintXX_t that are usually defined in 'stdint.h' are not as
> + * unambiguous on ARM as you would expect. For the types below, there is a
> + * difference on ARM between GCC built for bare metal ARM, GCC built for glibc
> + * and the kernel itself, which results in build errors if you try to build with
> + * -ffreestanding and include 'stdint.h' (such as when you include 'arm_neon.h'
> + * in order to use NEON intrinsics)
> + *
> + * As the typedefs for these types in 'stdint.h' are based on builtin defines
> + * supplied by GCC, we can tweak these to align with the kernel's idea of those
> + * types, so 'linux/types.h' and 'stdint.h' can be safely included from the same
> + * source file (provided that -ffreestanding is used).
> + * 
> + *                    int32_t         uint32_t               uintptr_t
> + * bare metal GCC     long            unsigned long          unsigned int
> + * glibc GCC          int             unsigned int           unsigned int
> + * kernel             int             unsigned int           unsigned long
> + */
> +
> +#ifdef __INT32_TYPE__
> +#undef __INT32_TYPE__
> +#define __INT32_TYPE__		int
> +#endif
> +
> +#ifdef __UINT32_TYPE__
> +#undef __UINT32_TYPE__
> +#define __UINT32_TYPE__	unsigned int
> +#endif
> +
> +#ifdef __UINTPTR_TYPE__
> +#undef __UINTPTR_TYPE__
> +#define __UINTPTR_TYPE__	unsigned long
> +#endif
> +
> +#endif /* _ASM_TYPES_H */
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
