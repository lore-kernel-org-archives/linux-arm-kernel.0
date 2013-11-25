From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 25 Nov 2013 16:15:28 +0400
Subject: [RFC 13/17] ARM: shmobile: marzen-reference: Initialize CPG device
In-Reply-To: <1385342312-1967-14-git-send-email-horms+renesas@verge.net.au>
References: <1385342312-1967-1-git-send-email-horms+renesas@verge.net.au>
 <1385342312-1967-14-git-send-email-horms+renesas@verge.net.au>
Message-ID: <52933F60.8090208@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-11-2013 5:18, Simon Horman wrote:

> On multiplatform kernels clocks are handled by the CCF CPG driver. It
> must be explicitly initialized by a call to rcar_gen2_clocks_init() with

    You meant r8a7779_clocks_init() instead?

> the value of the boot mode pins.

> Based on similar work for the Koelsch board by Laurent Pinchart.

> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/board-marzen-reference.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

> diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
> index 782907f..3a7c0fc 100644
> --- a/arch/arm/mach-shmobile/board-marzen-reference.c
> +++ b/arch/arm/mach-shmobile/board-marzen-reference.c
[...]
> @@ -28,11 +29,17 @@
>   #include <asm/mach/arch.h>
>
>
> -static void __init marzen_init(void)
> +static void __init marzen_init_timer(void)
>   {
>   #ifdef CONFIG_COMMON_CLK
> -	of_clk_init(NULL);
> -#else
> +	r8a7779_clocks_init(r8a7779_read_mode_pins());
> +#endif
> +	clocksource_of_init();
> +}
> +
> +static void __init marzen_init(void)
> +{
> +#ifndef CONFIG_COMMON_CLK
>   	r8a7779_clock_init();
>   #endif
>   	r8a7779_add_standard_devices_dt();

WBR, Sergei
