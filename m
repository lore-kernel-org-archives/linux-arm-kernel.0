From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Aug 2015 10:47:56 +0100
Subject: [PATCH 3/3] [v2] hvc_dcc: disable user-space access to DCC
In-Reply-To: <1438992995-22610-3-git-send-email-timur@codeaurora.org>
References: <1438992995-22610-1-git-send-email-timur@codeaurora.org>
 <1438992995-22610-3-git-send-email-timur@codeaurora.org>
Message-ID: <20150810094755.GE1604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 01:16:35AM +0100, Timur Tabi wrote:
> If the DCC driver loads, then disable user-space access to the DCC so that
> we don't have two entities trying to access the DCC at the same time.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  arch/arm/include/asm/dcc.h   | 15 +++++++++++++++
>  arch/arm64/include/asm/dcc.h | 11 +++++++++++
>  drivers/tty/hvc/hvc_dcc.c    |  2 ++
>  3 files changed, 28 insertions(+)
> 
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
> +
> +#endif
> diff --git a/arch/arm64/include/asm/dcc.h b/arch/arm64/include/asm/dcc.h
> index fcb8d7d..a6496f2 100644
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
> +	asm volatile ("mrs %0, mdscr_el1\n"
> +		"	orr %0, %0, #4096\n" /* Set the TDCC bit */

So this is the same as your "1 << 12" for arch/arm/. Shouldn't we
#define that someplace common?

> +		"	msr mdscr_el1, %0\n"
> +		: "=r" (val));
> +}
> +
>  #endif
> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
> index 47654ea..e260acb 100644
> --- a/drivers/tty/hvc/hvc_dcc.c
> +++ b/drivers/tty/hvc/hvc_dcc.c
> @@ -76,6 +76,8 @@ static int __init hvc_dcc_console_init(void)
>  	if (!hvc_dcc_check())
>  		return -ENODEV;
>  
> +	__dcc_initialize();
> +
>  	/* Returns -1 if error */
>  	ret = hvc_instantiate(0, 0, &hvc_dcc_get_put_ops);

Can this driver be built as a module and unloaded? If so, should we
re-enable userspace access when the kernel doesn't need it anymore?

Finally, have you checked the behaviour on CPU hotplug? It looks like we
zero mdscr_el1 in the cold boot path. The alternative is to set this bit
there and never allow userspace access. Do you know of any compelling
use-cases where userspace accesses the DCC directly?

Will
