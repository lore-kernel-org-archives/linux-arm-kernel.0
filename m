From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 01 Jul 2015 17:00:28 -0700
Subject: [PATCH 4/4] hvc_dcc: disable user-space access to DCC
In-Reply-To: <1435699387-32591-4-git-send-email-timur@codeaurora.org>
References: <1435699387-32591-1-git-send-email-timur@codeaurora.org>
 <1435699387-32591-4-git-send-email-timur@codeaurora.org>
Message-ID: <55947F1C.3020904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2015 02:23 PM, Timur Tabi wrote:
> diff --git a/arch/arm/include/asm/dcc.h b/arch/arm/include/asm/dcc.h
> index b74899d..c50056b 100644
> --- a/arch/arm/include/asm/dcc.h
> +++ b/arch/arm/include/asm/dcc.h
> @@ -9,8 +9,11 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
>   */
> +#ifndef __ASM_DCC_H
> +#define __ASM_DCC_H
>  
>  #include <asm/barrier.h>
> +#include <asm/hardware/cp14.h>

That's new.

>  
>  static inline u32 __dcc_getstatus(void)
>  {
> @@ -39,3 +42,15 @@ static inline void __dcc_putchar(char c)
>  		: "r" (c));
>  	isb();
>  }
> +
> +static inline void __dcc_initialize(void)
> +{
> +	u32 val;
> +
> +	/* Disable user-space access to DCC */
> +	val = MRC14(0, c0, c1, 0);
> +	val |= 1 << 12; /* DSCR[Comms] */
> +	MCR14(val, 0, c0, c1, 0);
> +}

Nitpick: We do raw cp14 accesses for other functions in this file, so it
would be nice to be consistent throughout.

> +
> +#endif
> diff --git a/arch/arm64/include/asm/dcc.h b/arch/arm64/include/asm/dcc.h
> index fcb8d7d..7843e62 100644
> --- a/arch/arm64/include/asm/dcc.h
> +++ b/arch/arm64/include/asm/dcc.h
> @@ -49,4 +49,15 @@ static inline void __dcc_putchar(char c)
>  	isb();
>  }
>  
> +static inline void __dcc_initialize(void)
> +{
> +	u32 val;
> +
> +	/* Disable user-space access to DCC */
> +	asm ("mrs %0, mdscr_el1\n"

shouldn't this be volatile?

> +		"	orr %0, %0, #4096\n" /* Set the TDCC bit */

arm64 has some #defines in debug-monitors.h which we should probably
extend to have this bit as a #define too.

> +		"	msr mdscr_el1, %0\n"
> +		: "=r" (val));
> +}
> +
>  #endif
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
