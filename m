From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 9 Aug 2013 15:14:24 +0100
Subject: [RFC PATCH] ARM: add workaround for ambiguous C99 stdint.h types
In-Reply-To: <1376033802-12826-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1376033802-12826-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20130809141424.GC3977@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 09:36:42AM +0200, Ard Biesheuvel wrote:
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
> bare metal GCC     long            unsigned long          unsigned long
> glibc GCC          int             unsigned int           unsigned int
> kernel             int             unsigned int           unsigned long
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> Hi all,
> 
> This is another, less obtrusive way of handling the problem for which I
> previously sent an RFC patch 'types.h: use GCC supplied typedefs if appropriate'
> In this case, only source files that in fact include stdint.h and are being
> built for ARM should be affected.
> 
> Regards,
> -- 
> Ard.
> 
> 
>  arch/arm/include/asm/types.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 arch/arm/include/asm/types.h
> 
> diff --git a/arch/arm/include/asm/types.h b/arch/arm/include/asm/types.h
> new file mode 100644
> index 0000000..976ac31
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
> + * bare metal GCC     long            unsigned long          unsigned long
> + * glibc GCC          int             unsigned int           unsigned int
> + * kernel             int             unsigned int           unsigned long
> + */
> +
> +#ifdef __INT32__TYPE__
> +#undef __INT32__TYPE__
> +#define __INT32__TYPE__		int
> +#endif
> +
> +#ifdef __UINT32__TYPE__
> +#undef __UINT32__TYPE__
> +#define __UINT32__TYPE__	unsigned int
> +#endif
> +
> +#ifdef __UINTPTR_TYPE__
> +#undef __UINTPTR_TYPE__
> +#define __UINTPTR_TYPE__	unsigned long
> +#endif

Somebody else might have the opposite problem to ARM, so I'm doubtful
about whether it's safe to do this for all arches.  The arch maintainers
would have to comment on that.  This looks ugly in an otherwise generic
header.

(As a cosmetic thing, you can lose the #ifdefs.  #undef doesn't trigger
an error of the specified macro doesn't already exist.)

Cheers
---Dave
