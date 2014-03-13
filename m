From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Mar 2014 15:54:15 +0000
Subject: [PATCH v6 6/7] arm64: ftrace: Add CALLER_ADDRx macros
In-Reply-To: <1394705630-12384-7-git-send-email-takahiro.akashi@linaro.org>
References: <1393564724-3966-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-7-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140313155415.GB25472@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:13:49AM +0000, AKASHI Takahiro wrote:
> CALLER_ADDRx returns caller's address at specified level in call stacks.
> They are used for several tracers like irqsoff and preemptoff.
> Strange to say, however, they are refered even without FTRACE.
> 
> Please note that this implementation assumes that we have frame pointers.
> (which means kernel should be compiled with -fno-omit-frame-pointer.)

How do you ensure that -fno-omit-frame-pointer is passed?

> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/include/asm/ftrace.h    |   13 ++++++++-
>  arch/arm64/kernel/Makefile         |    3 +-
>  arch/arm64/kernel/return_address.c |   55 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/kernel/return_address.c
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index ed5c448..c44c4b1 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -18,6 +18,7 @@
>  
>  #ifndef __ASSEMBLY__
>  extern void _mcount(unsigned long);
> +extern void *return_address(unsigned int);
>  
>  struct dyn_arch_ftrace {
>  	/* No extra data needed for arm64 */
> @@ -33,6 +34,16 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	 */
>  	return addr;
>  }
> -#endif /* __ASSEMBLY__ */
> +
> +#define HAVE_ARCH_CALLER_ADDR
> +
> +#define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
> +#define CALLER_ADDR1 ((unsigned long)return_address(1))
> +#define CALLER_ADDR2 ((unsigned long)return_address(2))
> +#define CALLER_ADDR3 ((unsigned long)return_address(3))
> +#define CALLER_ADDR4 ((unsigned long)return_address(4))
> +#define CALLER_ADDR5 ((unsigned long)return_address(5))
> +#define CALLER_ADDR6 ((unsigned long)return_address(6))

Could we change the core definitions of these macros (in linux/ftrace.h) to
use return_address, then provide an overridable version of return_address
that defaults to __builtin_return_address, instead of copy-pasting this
sequence?

> diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
> new file mode 100644
> index 0000000..89102a6
> --- /dev/null
> +++ b/arch/arm64/kernel/return_address.c
> @@ -0,0 +1,55 @@
> +/*
> + * arch/arm64/kernel/return_address.c
> + *
> + * Copyright (C) 2013 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/ftrace.h>
> +
> +#include <asm/stacktrace.h>
> +
> +struct return_address_data {
> +	unsigned int level;
> +	void *addr;
> +};
> +
> +static int save_return_addr(struct stackframe *frame, void *d)
> +{
> +	struct return_address_data *data = d;
> +
> +	if (!data->level) {
> +		data->addr = (void *)frame->pc;
> +		return 1;
> +	} else {
> +		--data->level;
> +		return 0;
> +	}
> +}
> +
> +void *return_address(unsigned int level)
> +{
> +	struct return_address_data data;
> +	struct stackframe frame;
> +	register unsigned long current_sp asm ("sp");
> +
> +	data.level = level + 2;
> +	data.addr = NULL;
> +
> +	frame.fp = (unsigned long)__builtin_frame_address(0);
> +	frame.sp = current_sp;
> +	frame.pc = (unsigned long)return_address; /* dummy */
> +
> +	walk_stackframe(&frame, save_return_addr, &data);
> +
> +	if (!data.level)
> +		return data.addr;
> +	else
> +		return NULL;
> +}
> +EXPORT_SYMBOL_GPL(return_address);

This whole file is basically copied from arch/arm/, but it's not too much
code. Ideally the toolchain would have made use of the frame pointer, but it
looks like it doesn't bother.

Will
