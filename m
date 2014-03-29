From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 28 Mar 2014 21:53:23 -0400 (EDT)
Subject: [PATCH RFC 1/3] arm64/crypto: add shared macro to test for
 NEED_RESCHED
In-Reply-To: <1396004735-15475-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1396004735-15475-1-git-send-email-ard.biesheuvel@linaro.org>
 <1396004735-15475-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.11.1403282141230.1571@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Mar 2014, Ard Biesheuvel wrote:

> This adds arch/arm64/crypto/preempt.h, currently containing just a single
> asm macro definition 'b_if_no_resched' that will be shared between multiple
> crypto algorithm implementations that need to test for preemption in the
> inner loop.

This file is a rather bad choice for this pretty generic macro.  There 
is nothing crypto specific about it, even if crypto might be the only 
user for now.  This should live in include/asm/assembler.h, or a 
separate file in that directory only if including <asm/asm-offsets.h> 
from assembler.h is considered a nuisance.


> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/crypto/preempt.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 arch/arm64/crypto/preempt.h
> 
> diff --git a/arch/arm64/crypto/preempt.h b/arch/arm64/crypto/preempt.h
> new file mode 100644
> index 000000000000..94302d5b5ae9
> --- /dev/null
> +++ b/arch/arm64/crypto/preempt.h
> @@ -0,0 +1,28 @@
> +/*
> + * preempt.h - shared macros to check preempt state
> + *
> + * Copyright (C) 2014 Linaro Ltd <ard.biesheuvel@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <asm/asm-offsets.h>
> +#include <asm/thread_info.h>
> +
> +	/*
> +	 * Branch to 'lb' but only if we have not been tagged for preemption.
> +	 *
> +	 * Expects current->thread_info in ti, or NULL if running in interrupt
> +	 * context. reg is a scratch x register.
> +	 */
> +	.macro		b_if_no_resched, ti, reg, lb
> +#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTARY)
> +	cbz		\ti, \lb			// have thread_info?
> +	ldr		\reg, [\ti, #TI_FLAGS]		// get flags
> +	tbz	 	\reg, #TIF_NEED_RESCHED, \lb	// needs rescheduling?
> +#else
> +	b		\lb
> +#endif
> +	.endm
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
