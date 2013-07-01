From: horms@verge.net.au (Simon Horman)
Date: Mon, 1 Jul 2013 16:52:09 +0900
Subject: [PATCH 03/04] ARM: shmobile: Use default ->init_irq() on r8a7790
In-Reply-To: <20130701060131.21728.85765.sendpatchset@w520>
References: <20130701060103.21728.83833.sendpatchset@w520>
 <20130701060131.21728.85765.sendpatchset@w520>
Message-ID: <20130701075208.GW14567@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 03:01:31PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove redundant irqchip_init() callback. The default case
> of NULL will result in invoking irqchip_init() anyway.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/board-lager.c   |    2 --
>  arch/arm/mach-shmobile/setup-r8a7790.c |    2 --
>  2 files changed, 4 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/board-lager.c
> +++ work/arch/arm/mach-shmobile/board-lager.c	2013-07-01 13:27:30.000000000 +0900
> @@ -22,7 +22,6 @@
>  #include <linux/gpio_keys.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> -#include <linux/irqchip.h>
>  #include <linux/kernel.h>
>  #include <linux/leds.h>
>  #include <linux/pinctrl/machine.h>
> @@ -104,7 +103,6 @@ static const char *lager_boards_compat_d
>  
>  DT_MACHINE_START(LAGER_DT, "lager")
>  	.init_early	= r8a7790_init_delay,
> -	.init_irq	= irqchip_init,
>  	.init_time	= r8a7790_timer_init,
>  	.init_machine	= lager_add_standard_devices,
>  	.dt_compat	= lager_boards_compat_dt,
> --- 0008/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-07-01 13:27:52.000000000 +0900
> @@ -19,7 +19,6 @@
>   */
>  
>  #include <linux/irq.h>
> -#include <linux/irqchip.h>
>  #include <linux/kernel.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_data/gpio-rcar.h>
> @@ -225,7 +224,6 @@ static const char *r8a7790_boards_compat
>  
>  DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
>  	.init_early	= r8a7790_init_delay,
> -	.init_irq	= irqchip_init,
>  	.init_time	= r8a7790_timer_init,
>  	.dt_compat	= r8a7790_boards_compat_dt,
>  MACHINE_END

Hi Magnus,

as per my remark about the emev2, I accidently dropped a patch
from Maxime Ripard which corresponds to the setup-r8a7790.c portion of
your above patch. Accordingly I have re-queued up Maxime's patch for v3.12
and applied the board-lager.c portion of your patch as follows.
I have altered the title, partially so it uses the same scheme
used by Maxime's patches and partially to reflect that it
now only covers the lager board.

The result will be in the cleanup branch the next time that I push my tree,
most likely later this afternoon.

commit 4a94ed71a7b3e17c46a23b89039cfa113fbfaa43
Author: Magnus Damm <damm@opensource.se>
Date:   Mon Jul 1 15:01:31 2013 +0900

    ARM: shmobile: lager: Remove init_irq declaration in machine description
    
    Remove redundant irqchip_init() callback. The default case
    of NULL will result in invoking irqchip_init() anyway.
    
    Signed-off-by: Magnus Damm <damm@opensource.se>
    [ horms+renesas at verge.net.au: Trimmed patch to remove portion
      that updates the r8a7790 SoC and altered the subject to
      use the same format as the patch that updates the r8a7790. ]
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index d73e21d..1e99b17 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -22,7 +22,6 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
-#include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/pinctrl/machine.h>
@@ -103,7 +102,6 @@ static const char *lager_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(LAGER_DT, "lager")
-	.init_irq	= irqchip_init,
 	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
 	.dt_compat	= lager_boards_compat_dt,
