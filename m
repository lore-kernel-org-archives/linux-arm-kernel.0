From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 17 Jan 2011 15:02:20 +0100
Subject: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for function
	body copying
In-Reply-To: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
References: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
Message-ID: <AANLkTintFe4V6BxrUxh-gwvhoa=RcH0tkHjYbfyGHKD=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 10:17 PM, Dave Martin <dave.martin@linaro.org> wrote:
> In low-level board support code, there is sometimes a need to
> copy a function body to another location at run-time.
>
> A straightforward call to memcpy doesn't work in Thumb-2,
> because bit 0 of external Thumb function symbols is set to 1,
> indicating that the function is Thumb. ?Without corrective
> measures, this will cause an off-by-one copy, and the copy
> may be called using the wrong instruction set.
>
> This patch adds an fncpy() macro to help with such copies.
>
> Particular care is needed, because C doesn't guarantee any
> defined behaviour when casting a function pointer to any other
> type. ?This has been observed to lead to strange optimisation
> side-effects when doing the arithmetic which is required in
> order to copy/move function bodies correctly in Thumb-2.
>
> Thanks to Russell King and Nicolas Pitre for their input
> on this patch.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Tested-by: Jean Pihet <j-pihet@ti.com>
> ---
> ?arch/arm/include/asm/fncpy.h | ? 96 ++++++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 96 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/include/asm/fncpy.h
>
> diff --git a/arch/arm/include/asm/fncpy.h b/arch/arm/include/asm/fncpy.h
> new file mode 100644
> index 0000000..8b94b5f
> --- /dev/null
> +++ b/arch/arm/include/asm/fncpy.h
> @@ -0,0 +1,96 @@
> +/*
> + * arch/arm/include/asm/fncpy.h - helper macros for function body copying
> + *
> + * Copyright (C) 2011 Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +/*
> + * These macros are intended for use when there is a need to copy a low-level
> + * function body into special memory.
> + *
> + * For example, when reconfiguring the SDRAM controller, the code doing the
> + * reconfiguration may need to run from SRAM.
> + *
> + * NOTE: that the copied function body must be entirely self-contained and
> + * position-independent in order for this to work properly.
> + *
> + * NOTE: in order for embedded literals and data to get referenced correctly,
> + * the alignment of functions must be preserved when copying. ?To ensure this,
> + * the source and destination addresses for fncpy() must be aligned to a
> + * multiple of 8 bytes: you will be get a BUG() if this condition is not met.
> + * You will typically need a ".align 3" directive in the assembler where the
> + * function to be copied is defined, and ensure that your allocator for the
> + * destination buffer returns 8-byte-aligned pointers.

Note that aligning the source and destination pointers to a multiple
of 8 bytes has an impact on the behavio(u)r and so must be carefully
thought and tested on OMAP1/2/3 platforms.

Regards,
Jean

> + *
> + * Typical usage example:
> + *
> + * extern int f(args);
> + * extern uint32_t size_of_f;
> + * int (*copied_f)(args);
> + * void *sram_buffer;
> + *
> + * copied_f = fncpy(sram_buffer, &f, size_of_f);
> + *
> + * ... do any required D-side/I-side synchronisation ...
> + *
> + * ... later, call the function: ...
> + *
> + * copied_f(args);
> + *
> + * The size of the function to be copied can't be determined from C:
> + * this must be determined by other means, such as adding assmbler directives
> + * in the file where f is defined.
> + */
> +
> +#ifndef __ASM_FNCPY_H
> +#define __ASM_FNCPY_H
> +
> +#include <linux/types.h>
> +#include <linux/string.h>
> +
> +#include <asm/bug.h>
> +#include <asm/cacheflush.h>
> +
> +/*
> + * Minimum alignment requirement for the source and destination addresses
> + * for function copying.
> + */
> +#define FNCPY_ALIGN 8
> +
> +#define fncpy(dest_buf, funcp, size) ({ ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? uintptr_t __funcp_address; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? typeof(funcp) __result; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? asm("" : "=r" (__funcp_address) : "0" (funcp)); ? ? ? ? ? ? ? ? \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? /* ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? ?* Ensure alignment of source and destination addresses, ? ? ? ?\
> + ? ? ? ?* disregarding the function's Thumb bit: ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? ?*/ ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? BUG_ON((uintptr_t)(dest_buf) & (FNCPY_ALIGN - 1) || ? ? ? ? ? ? \
> + ? ? ? ? ? ? ? (__funcp_address & ~(uintptr_t)1 & (FNCPY_ALIGN - 1))); \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? memcpy(dest_buf, (void const *)(__funcp_address & ~1), size); ? \
> + ? ? ? flush_icache_range((unsigned long)(dest_buf), ? ? ? ? ? ? ? ? ? \
> + ? ? ? ? ? ? ? (unsigned long)(dest_buf) + (size)); ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? asm("" : "=r" (__result) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? ? ? ? ? : "0" ((uintptr_t)(dest_buf) | (__funcp_address & 1))); \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? __result; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> +})
> +
> +#endif /* !__ASM_FNCPY_H */
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
