From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Jun 2015 14:12:28 +0100
Subject: [PATCH] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
In-Reply-To: <1434751734-2178-1-git-send-email-timur@codeaurora.org>
References: <1434751734-2178-1-git-send-email-timur@codeaurora.org>
Message-ID: <20150622131228.GE1583@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 11:08:54PM +0100, Timur Tabi wrote:
> From: Abhimanyu Kapur <abhimany@codeaurora.org>
> 
> Add support for debug communications channel based
> hvc console for arm64 cpus.

I still think we should be disabling userspace access to the DCC if the
kernel is using it as its console.

> Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  arch/arm64/include/asm/dcc.h | 49 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/tty/hvc/Kconfig      |  2 +-
>  2 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/dcc.h
> 
> diff --git a/arch/arm64/include/asm/dcc.h b/arch/arm64/include/asm/dcc.h
> new file mode 100644
> index 0000000..f038d61
> --- /dev/null
> +++ b/arch/arm64/include/asm/dcc.h
> @@ -0,0 +1,49 @@
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
> + *
> + * A call to __dcc_getchar() or __dcc_putchar() is typically followed by
> + * a call to __dcc_getstatus().  We want to make sure that the CPU does
> + * not speculative read the DCC status before executing the read or write
> + * instruction.  That's what the ISBs are for.
> + *
> + * The 'volatile' ensures that the compiler does not cache the status bits,
> + * and instead reads the DCC register every time.
> + */

Missing header guards.

> +#include <asm/barrier.h>
> +
> +static inline u32 __dcc_getstatus(void)
> +{
> +	u32 __ret;
> +
> +	asm volatile("mrs %0, mdccsr_el0" : "=r" (__ret)
> +			: : "cc");

You don't need the "cc" clobber.

Will
