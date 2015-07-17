From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jul 2015 17:32:20 +0100
Subject: [PATCH 05/18] arm64: introduce CONFIG_ARM64_LSE_ATOMICS as
 fallback to ll/sc atomics
In-Reply-To: <1436779519-2232-6-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-6-git-send-email-will.deacon@arm.com>
Message-ID: <20150717163219.GA4208@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 10:25:06AM +0100, Will Deacon wrote:
> In order to patch in the new atomic instructions at runtime, we need to
> generate wrappers around the out-of-line exclusive load/store atomics.
> 
> This patch adds a new Kconfig option, CONFIG_ARM64_LSE_ATOMICS. which
> causes our atomic functions to branch to the out-of-line ll/sc
> implementations. To avoid the register spill overhead of the PCS, the
> out-of-line functions are compiled with specific compiler flags to
> force out-of-line save/restore of any registers that are usually
> caller-saved.

I'm still trying to get my head around those -ffixed -fcall-used
options.

> --- /dev/null
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -0,0 +1,181 @@
> +/*
> + * Based on arch/arm/include/asm/atomic.h
> + *
> + * Copyright (C) 1996 Russell King.
> + * Copyright (C) 2002 Deep Blue Solutions Ltd.
> + * Copyright (C) 2012 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __ASM_ATOMIC_LSE_H
> +#define __ASM_ATOMIC_LSE_H
> +
> +#ifndef __ARM64_IN_ATOMIC_IMPL
> +#error "please don't include this file directly"
> +#endif
> +
> +/* Move the ll/sc atomics out-of-line */
> +#define __LL_SC_INLINE
> +#define __LL_SC_PREFIX(x)	__ll_sc_##x
> +#define __LL_SC_EXPORT(x)	EXPORT_SYMBOL(__LL_SC_PREFIX(x))
> +
> +/* Macros for constructing calls to out-of-line ll/sc atomics */
> +#define __LL_SC_SAVE_LR(r)	"mov\t" #r ", x30\n"
> +#define __LL_SC_RESTORE_LR(r)	"mov\tx30, " #r "\n"
> +#define __LL_SC_CALL(op)						\
> +	"bl\t" __stringify(__LL_SC_PREFIX(atomic_##op)) "\n"
> +#define __LL_SC_CALL64(op)						\
> +	"bl\t" __stringify(__LL_SC_PREFIX(atomic64_##op)) "\n"
> +
> +#define ATOMIC_OP(op, asm_op)						\
> +static inline void atomic_##op(int i, atomic_t *v)			\
> +{									\
> +	unsigned long lr;						\
> +	register int w0 asm ("w0") = i;					\
> +	register atomic_t *x1 asm ("x1") = v;				\
> +									\
> +	asm volatile(							\
> +	__LL_SC_SAVE_LR(%0)						\
> +	__LL_SC_CALL(op)						\
> +	__LL_SC_RESTORE_LR(%0)						\
> +	: "=&r" (lr), "+r" (w0), "+Q" (v->counter)			\
> +	: "r" (x1));							\
> +}									\

Since that's an inline function, in most cases we wouldn't need to
save/restore LR for a BL call, it may already be on the stack of the
including functions. Can we just not tell gcc that LR is clobbered by
this asm and it makes its own decision about saving/restoring?

As for v->counter, could we allocate it in callee-saved registers
already and avoid the -ffixed etc. options.

But note that I'm still trying to understand all these tricks, so I may
be wrong.

-- 
Catalin
