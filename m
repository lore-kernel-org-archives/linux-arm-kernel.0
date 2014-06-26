From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 26 Jun 2014 07:12:06 +0200
Subject: [PATCH 09/13] AT91: PIT: (Almost) remove the global variables
In-Reply-To: <1403701605-26678-10-git-send-email-maxime.ripard@free-electrons.com>
References: <1403701605-26678-1-git-send-email-maxime.ripard@free-electrons.com>
 <1403701605-26678-10-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <53ABABA6.1060205@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

On 25/06/2014 15:06, Maxime Ripard wrote:
> The timer driver is using some global variables to define some variables it has
> to use in most of its functions, like the base address.
>
> Use some container_of calls to have a single dynamic (and local) variable to
> hold this content.
>
> The only exception is in the !DT case, where the call chain to
> at91sam926x_ioremap_pit and then at91sam926x_pit_init as init_time makes it
> hard for the moment to pass the physical address of the timer.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-at91/at91sam926x_time.c | 179 ++++++++++++++++++++--------------
>  1 file changed, 108 insertions(+), 71 deletions(-)
>
> diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
> index 9678ac391a81..f2c463567beb 100644
> --- a/arch/arm/mach-at91/at91sam926x_time.c
> +++ b/arch/arm/mach-at91/at91sam926x_time.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/slab.h>
>  

[...]

>  	unsigned	bits;
> @@ -186,67 +195,95 @@ static void __init at91sam926x_pit_common_init(unsigned int pit_irq)
>  	 * Use our actual MCK to figure out how many MCK/16 ticks per
>  	 * 1/HZ period (instead of a compile-time constant LATCH).
>  	 */
> -	pit_rate = clk_get_rate(mck) / 16;
> -	pit_cycle = (pit_rate + HZ/2) / HZ;
> -	WARN_ON(((pit_cycle - 1) & ~AT91_PIT_PIV) != 0);
> +	pit_rate = clk_get_rate(data->mck) / 16;
> +	data->cycle = (pit_rate + HZ/2) / HZ;

You could use DIV_ROUND_CLOSEST here.

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
