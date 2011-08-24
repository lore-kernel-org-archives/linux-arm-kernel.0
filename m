From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 23 Aug 2011 21:07:29 -0400 (EDT)
Subject: [PATCH v4 3/8] ARM: lib: add switch_stack function for safely
	changing stack
In-Reply-To: <1314136012-20533-4-git-send-email-will.deacon@arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
	<1314136012-20533-4-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.00.1108232102430.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Aug 2011, Will Deacon wrote:

> When disabling the MMU, it is necessary to take out a 1:1 identity map
> of the reset code so that it can safely be executed with and without
> the MMU active. To avoid the situation where the physical address of the
> reset code aliases with the virtual address of the active stack (which
> cannot be included in the 1:1 mapping), it is desirable to change to a
> new stack at a location which is less likely to alias.
> 
> This code adds a new lib function, switch_stack:
> 
> void switch_stack(void (*fn)(void *), void *arg, void *sp);
> 
> which changes the stack to point at the sp parameter, before invoking
> fn(arg) with the new stack selected.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

For the implementation:

Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>

However I think switch_stack() is too vague a name for what this 
actually does.  Maybe something like call_with_stack(fn, arg, sp) is 
more precise.

> ---
>  arch/arm/lib/Makefile       |    3 +-
>  arch/arm/lib/switch_stack.S |   44 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/lib/switch_stack.S
> 
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index cf73a7f..cbb1bc1 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -13,7 +13,8 @@ lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
>  		   testchangebit.o testclearbit.o testsetbit.o        \
>  		   ashldi3.o ashrdi3.o lshrdi3.o muldi3.o             \
>  		   ucmpdi2.o lib1funcs.o div64.o                      \
> -		   io-readsb.o io-writesb.o io-readsl.o io-writesl.o
> +		   io-readsb.o io-writesb.o io-readsl.o io-writesl.o  \
> +		   switch_stack.o
>  
>  mmu-y	:= clear_user.o copy_page.o getuser.o putuser.o
>  
> diff --git a/arch/arm/lib/switch_stack.S b/arch/arm/lib/switch_stack.S
> new file mode 100644
> index 0000000..552090d
> --- /dev/null
> +++ b/arch/arm/lib/switch_stack.S
> @@ -0,0 +1,44 @@
> +/*
> + * arch/arm/lib/switch_stack.S
> + *
> + * Copyright (C) 2011 ARM Ltd.
> + * Written by Will Deacon <will.deacon@arm.com>
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
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +
> +/*
> + * void switch_stack(void (*fn)(void *), void *arg, void *sp)
> + *
> + * Change the stack to that pointed at by sp, then invoke fn(arg) with
> + * the new stack.
> + */
> +ENTRY(switch_stack)
> +	str	sp, [r2, #-4]!
> +	str	lr, [r2, #-4]!
> +
> +	mov	sp, r2
> +	mov	r2, r0
> +	mov	r0, r1
> +
> +	adr	lr, BSYM(1f)
> +	mov	pc, r2
> +
> +1:	ldr	lr, [sp]
> +	ldr	sp, [sp, #4]
> +	mov	pc, lr
> +ENDPROC(switch_stack)
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
