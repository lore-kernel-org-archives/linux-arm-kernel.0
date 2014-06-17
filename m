From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jun 2014 10:51:56 +0100
Subject: [PATCH] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <1402957778-13830-1-git-send-email-abhimany@codeaurora.org>
References: <1402957778-13830-1-git-send-email-abhimany@codeaurora.org>
Message-ID: <20140617095155.GD13020@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 11:29:38PM +0100, Abhimanyu Kapur wrote:
> Add support for debug communications channel based
> hvc console for arm64 cpus.

Should we be setting MDSCR_EL1.TDCC to prevent userspace access to the DCC?

> Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
> ---
>  arch/arm64/include/asm/dcc.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/tty/hvc/Kconfig      |  2 +-
>  2 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/dcc.h
> 
> diff --git a/arch/arm64/include/asm/dcc.h b/arch/arm64/include/asm/dcc.h
> new file mode 100644
> index 0000000..ef74324
> --- /dev/null
> +++ b/arch/arm64/include/asm/dcc.h
> @@ -0,0 +1,41 @@
> +/* Copyright (c) 2014 The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <asm/barrier.h>
> +
> +static inline u32 __dcc_getstatus(void)
> +{
> +	u32 __ret;

Can this result in the mrs receiving a W register?

> +	asm volatile("mrs %0, mdccsr_el0" : "=r" (__ret)
> +			: : "cc");

Why the CC clobber? Why volatile?

> +
> +	return __ret;
> +}
> +
> +static inline char __dcc_getchar(void)
> +{
> +	char __c;
> +
> +	asm volatile("mrs %0, dbgdtrrx_el0" : "=r" (__c));
> +	isb();

Why the isb and why volatile??

> +
> +	return __c;
> +}
> +
> +static inline void __dcc_putchar(char c)
> +{
> +	asm volatile("msr dbgdtrtx_el0, %0"
> +			: /* No output register */
> +			: "r" (c));

Can you guarantee that GCC hasn't put junk in the upper bits of c?

> +	isb();

Why the isb?

Will
