From: horms@verge.net.au (Simon Horman)
Date: Mon, 1 Jul 2013 16:55:44 +0900
Subject: [PATCH 04/04] ARM: shmobile: Use default ->init_irq() on sh73a0
In-Reply-To: <20130701060140.21728.27213.sendpatchset@w520>
References: <20130701060103.21728.83833.sendpatchset@w520>
 <20130701060140.21728.27213.sendpatchset@w520>
Message-ID: <20130701075543.GX14567@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 03:01:40PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove redundant irqchip_init() callback. The default case
> of NULL will result in invoking irqchip_init() anyway.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 --
>  arch/arm/mach-shmobile/setup-sh73a0.c          |    2 --
>  2 files changed, 4 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/board-kzm9g-reference.c
> +++ work/arch/arm/mach-shmobile/board-kzm9g-reference.c	2013-06-28 16:04:39.000000000 +0900
> @@ -24,7 +24,6 @@
>  #include <linux/gpio.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> -#include <linux/irqchip.h>
>  #include <linux/input.h>
>  #include <linux/of_platform.h>
>  #include <linux/pinctrl/machine.h>
> @@ -99,7 +98,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-refere
>  	.map_io		= sh73a0_map_io,
>  	.init_early	= sh73a0_init_delay,
>  	.nr_irqs	= NR_IRQS_LEGACY,
> -	.init_irq	= irqchip_init,
>  	.init_machine	= kzm_init,
>  	.init_time	= shmobile_timer_init,
>  	.dt_compat	= kzm9g_boards_compat_dt,
> --- 0007/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2013-06-28 16:04:47.000000000 +0900
> @@ -22,7 +22,6 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> -#include <linux/irqchip.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_platform.h>
>  #include <linux/delay.h>
> @@ -983,7 +982,6 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH7
>  	.map_io		= sh73a0_map_io,
>  	.init_early	= sh73a0_init_delay,
>  	.nr_irqs	= NR_IRQS_LEGACY,
> -	.init_irq	= irqchip_init,
>  	.init_machine	= sh73a0_add_standard_devices_dt,
>  	.dt_compat	= sh73a0_boards_compat_dt,
>  MACHINE_END

Hi Magnus,

as per my remark about the emev2, I accidently dropped a patch
from Maxime Ripard which corresponds to the setup-sh73a0.c portion of
your above patch. Accordingly I have re-queued up Maxime's patch for v3.12
and applied the board-kzm9g-reference.c portion of your patch as follows.
I have altered the title, partially so it uses the same scheme
used by Maxime's patches and partially to reflect that it
now only covers the kzm9g board.

The result will be in the cleanup branch the next time that I push my tree,
most likely later this afternoon.

commit 083c11c998f17c3ef4f2fc066424d6762254344b
Author: Magnus Damm <damm@opensource.se>
Date:   Mon Jul 1 15:01:40 2013 +0900

    ARM: shmobile: kzm9g: Remove init_irq declaration in machine description
    
    Remove redundant irqchip_init() callback. The default case
    of NULL will result in invoking irqchip_init() anyway.
    
    Signed-off-by: Magnus Damm <damm@opensource.se>
    [ horms+renesas at verge.net.au: Trimmed patch to remove portion
      that updates the sh73a0 SoC and altered the subject to
      use the same format as the patch that updates the sh73a0. ]
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 44055fe..41092bb 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -24,7 +24,6 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/irqchip.h>
 #include <linux/input.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
@@ -99,7 +98,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= irqchip_init,
 	.init_machine	= kzm_init,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= kzm9g_boards_compat_dt,
