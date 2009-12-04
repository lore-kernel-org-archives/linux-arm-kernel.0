From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Dec 2009 10:43:11 +0000
Subject: [RFC][PATCH 03/10] arm: mxc: changes to common plat-mxc code
	to add support for i.MX5
In-Reply-To: <58eb7d14c6cf56cbc874657dff5789c47116b49e.1259893118.git.amit.kucheria@canonical.com>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<58eb7d14c6cf56cbc874657dff5789c47116b49e.1259893118.git.amit.kucheria@canonical.com>
Message-ID: <20091204104311.GD15887@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 04:47:03AM +0200, Amit Kucheria wrote:
> +#elif defined CONFIG_MXC_TZIC
> +	@ Load offset & priority of the highest priority
> +	@ interrupt pending.
> +	@ 0xD80 is HIPND0 register
> +	ldr     \irqnr, =0
> +	ldr     \irqstat, =0x0D80

Both these constants can be loaded by a 'mov' instruction.

> +1000:
> +	ldr     \tmp,   [\irqstat, \base]
> +	cmp     \tmp, #0
> +	bne     1001f
> +	addeq   \irqnr, \irqnr, #32
> +	addeq   \irqstat, \irqstat, #4
> +	cmp     \irqnr, #128
> +	blo     1000b
> +	b       2001f
> +1001:	ldr     \irqstat, =1

	mov	\irqstat, #1

> +1002:	tst     \tmp, \irqstat
> +	bne     2002f
> +	movs    \tmp, \tmp, lsr #1
> +	addne   \irqnr, \irqnr, #1
> +	bne     1002b
> +2001:
> +	ldr  \irqnr, =0

	mov	\irqnr, #0

would be better.

> diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
> index 844567e..97fb590 100644
> --- a/arch/arm/plat-mxc/time.c
> +++ b/arch/arm/plat-mxc/time.c
> @@ -25,6 +25,7 @@
>  #include <linux/irq.h>
>  #include <linux/clockchips.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>

What is the reason for adding this include?
