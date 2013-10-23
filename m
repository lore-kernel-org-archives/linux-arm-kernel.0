From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 23 Oct 2013 00:59:05 -0500
Subject: [RFC] ARM: tty: Move HVC DCC assembly to arch/arm
In-Reply-To: <1382120064-2459-1-git-send-email-cov@codeaurora.org>
References: <1382120064-2459-1-git-send-email-cov@codeaurora.org>
Message-ID: <B273A106-344F-4D36-998B-E44F889AD93F@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 18, 2013, at 1:14 PM, Christopher Covington wrote:

> Put architecture-specific assembly code where it belongs,
> allowing for support of additional architectures such as arm64 in
> the future.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
> arch/arm/include/asm/dcc.h | 45 +++++++++++++++++++++++++++++++++++++++++++
> drivers/tty/hvc/hvc_dcc.c  | 48 ++--------------------------------------------
> 2 files changed, 47 insertions(+), 46 deletions(-)
> create mode 100644 arch/arm/include/asm/dcc.h
> 
> diff --git a/arch/arm/include/asm/dcc.h b/arch/arm/include/asm/dcc.h
> new file mode 100644
> index 0000000..306d1fc
> --- /dev/null
> +++ b/arch/arm/include/asm/dcc.h
> @@ -0,0 +1,45 @@
> +/* Copyright (c) 2010, The Linux Foundation. All rights reserved.
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
> +/* DCC Status Bits */
> +#define DCC_STATUS_RX		(1 << 30)
> +#define DCC_STATUS_TX		(1 << 29)
> +

Why'd you move these define's here?  They don't seem to be arch specific and I don't see them used in the asm anywhere.

> +static inline u32 __dcc_getstatus(void)
> +{
> +	u32 __ret;
> +	asm volatile("mrc p14, 0, %0, c0, c1, 0	@ read comms ctrl reg"
> +		: "=r" (__ret) : : "cc");
> +
> +	return __ret;
> +}
> +
> +static inline char __dcc_getchar(void)
> +{
> +	char __c;
> +
> +	asm volatile("mrc p14, 0, %0, c0, c5, 0	@ read comms data reg"
> +		: "=r" (__c));
> +	isb();
> +
> +	return __c;
> +}
> +
> +static inline void __dcc_putchar(char c)
> +{
> +	asm volatile("mcr p14, 0, %0, c0, c5, 0	@ write a char"
> +		: /* no output register */
> +		: "r" (c));
> +	isb();
> +}
> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
> index 44fbeba..e9f0191 100644
> --- a/drivers/tty/hvc/hvc_dcc.c
> +++ b/drivers/tty/hvc/hvc_dcc.c
> @@ -1,4 +1,4 @@
> -/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
> +/* Copyright (c) 2010, The Linux Foundation. All rights reserved.
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License version 2 and
> @@ -8,57 +8,13 @@
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
>  */
> 
> -#include <linux/console.h>
> -#include <linux/delay.h>
> -#include <linux/err.h>
> -#include <linux/init.h>
> -#include <linux/moduleparam.h>
> -#include <linux/types.h>
> -
> +#include <asm/dcc.h>
> #include <asm/processor.h>
> 
> #include "hvc_console.h"
> 
> -/* DCC Status Bits */
> -#define DCC_STATUS_RX		(1 << 30)
> -#define DCC_STATUS_TX		(1 << 29)
> -
> -static inline u32 __dcc_getstatus(void)
> -{
> -	u32 __ret;
> -	asm volatile("mrc p14, 0, %0, c0, c1, 0	@ read comms ctrl reg"
> -		: "=r" (__ret) : : "cc");
> -
> -	return __ret;
> -}
> -
> -
> -static inline char __dcc_getchar(void)
> -{
> -	char __c;
> -
> -	asm volatile("mrc p14, 0, %0, c0, c5, 0	@ read comms data reg"
> -		: "=r" (__c));
> -	isb();
> -
> -	return __c;
> -}
> -
> -static inline void __dcc_putchar(char c)
> -{
> -	asm volatile("mcr p14, 0, %0, c0, c5, 0	@ write a char"
> -		: /* no output register */
> -		: "r" (c));
> -	isb();
> -}
> -
> static int hvc_dcc_put_chars(uint32_t vt, const char *buf, int count)
> {
> 	int i;
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by the Linux Foundation.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
