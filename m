From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Nov 2013 12:59:40 +0900
Subject: [PATCH] ARM: shmobile: Use ->init_late() on Koelsch
In-Reply-To: <20131120035434.30035.69827.sendpatchset@w520>
References: <20131120035434.30035.69827.sendpatchset@w520>
Message-ID: <20131121035938.GD31130@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 12:54:34PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Hook in shmobile_init_late() on Koelsch. This enables some PM
> related things like CPUIdle and Suspend-to-RAM.
> 
> With this patch applied it is possible to use Suspend-to-RAM:
> # echo enabled > /sys/class/tty/ttySC6/power/wakeup
> # echo mem > /sys/power/state 
> (wake by sending a character on the serial console)
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up.
Assuming all goes will I plan to push this and other updates
today or tomorrow.

> ---
> 
>  arch/arm/mach-shmobile/board-koelsch-reference.c |    2 ++
>  arch/arm/mach-shmobile/board-koelsch.c           |    3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> --- 0001/arch/arm/mach-shmobile/board-koelsch-reference.c
> +++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2013-11-20 12:26:30.000000000 +0900
> @@ -22,6 +22,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/kernel.h>
>  #include <linux/of_platform.h>
> +#include <mach/common.h>
>  #include <mach/rcar-gen2.h>
>  #include <mach/r8a7791.h>
>  #include <asm/mach/arch.h>
> @@ -47,5 +48,6 @@ DT_MACHINE_START(KOELSCH_DT, "koelsch")
>  	.init_early	= r8a7791_init_early,
>  	.init_time	= rcar_gen2_timer_init,
>  	.init_machine	= koelsch_add_standard_devices,
> +	.init_late	= shmobile_init_late,
>  	.dt_compat	= koelsch_boards_compat_dt,
>  MACHINE_END
> --- 0001/arch/arm/mach-shmobile/board-koelsch.c
> +++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-11-20 12:26:24.000000000 +0900
> @@ -92,7 +92,8 @@ static const char * const koelsch_boards
>  DT_MACHINE_START(KOELSCH_DT, "koelsch")
>  	.smp		= smp_ops(r8a7791_smp_ops),
>  	.init_early	= r8a7791_init_early,
> -	.init_machine	= koelsch_add_standard_devices,
>  	.init_time	= rcar_gen2_timer_init,
> +	.init_machine	= koelsch_add_standard_devices,
> +	.init_late	= shmobile_init_late,
>  	.dt_compat	= koelsch_boards_compat_dt,
>  MACHINE_END
> 
