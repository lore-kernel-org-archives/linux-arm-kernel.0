From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 26 Feb 2014 14:22:16 +0100
Subject: [PATCH v3 14/20] ARM: shmobile: marzen-reference: Initialize CPG
 device
In-Reply-To: <1393400016-23433-15-git-send-email-horms+renesas@verge.net.au>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-15-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1536497.cil0Vak4RG@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Wednesday 26 February 2014 16:33:30 Simon Horman wrote:
> On multiplatform kernels clocks are handled by the CCF CPG driver. It
> must be explicitly initialized by a call to r8a7779_clocks_init() with
> the value of the boot mode pins.
> 
> Based on similar work for the Koelsch board by Laurent Pinchart.
> 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/mach-shmobile/board-marzen-reference.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c
> b/arch/arm/mach-shmobile/board-marzen-reference.c index d3e8319..e261431
> 100644
> --- a/arch/arm/mach-shmobile/board-marzen-reference.c
> +++ b/arch/arm/mach-shmobile/board-marzen-reference.c
> @@ -19,7 +19,8 @@
>   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 
> USA */
> 
> -#include <linux/clk-provider.h>
> +#include <linux/clk/shmobile.h>
> +#include <linux/clocksource.h>
>  #include <linux/of_platform.h>
>  #include <mach/r8a7779.h>
>  #include <mach/common.h>
> @@ -27,11 +28,17 @@
>  #include <asm/irq.h>
>  #include <asm/mach/arch.h>
> 
> -static void __init marzen_init(void)
> +static void __init marzen_init_timer(void)
>  {
>  #ifdef CONFIG_COMMON_CLK
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
>  	r8a7779_clock_init();
>  #endif
>  	r8a7779_add_standard_devices_dt();
> @@ -48,6 +55,7 @@ DT_MACHINE_START(MARZEN, "marzen")
>  	.smp		= smp_ops(r8a7779_smp_ops),
>  	.map_io		= r8a7779_map_io,
>  	.init_early	= r8a7779_init_delay,
> +	.init_time	= marzen_init_timer,
>  	.nr_irqs	= NR_IRQS_LEGACY,
>  	.init_irq	= r8a7779_init_irq_dt,
>  	.init_machine	= marzen_init,

-- 
Regards,

Laurent Pinchart
