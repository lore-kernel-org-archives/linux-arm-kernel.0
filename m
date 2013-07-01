From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 01 Jul 2013 22:22:21 +0400
Subject: [PATCH] N900: fix operation on emulator
In-Reply-To: <20130701140315.GA15318@amd.pavel.ucw.cz>
References: <20130613132624.GA3464@amd.pavel.ucw.cz>
 <20130613141001.GF8164@atomide.com> <20130613142809.GA3775@amd.pavel.ucw.cz>
 <20130613145724.GH8164@atomide.com> <20130613155240.GB3775@amd.pavel.ucw.cz>
 <20130613161418.GJ8164@atomide.com> <20130613230808.GA14876@amd.pavel.ucw.cz>
 <20130614055629.GM8164@atomide.com>
 <20130614212816.GA31768@atrey.karlin.mff.cuni.cz>
 <20130617111031.GQ20992@atomide.com>
 <20130701140315.GA15318@amd.pavel.ucw.cz>
Message-ID: <51D1C8DD.6040409@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/01/2013 06:03 PM, Pavel Machek wrote:

> Errata workarounds for N900 hardware actually break operation on
> emulator. Fix it.

> This approach was suggested by Pali Roh?r <pali.rohar@gmail.com>
> (thanks!).

> (Also explain what "sleep_ind" led actually does).

    Looks like unrelated change and probably worth another patch?

> Signed-off-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index 74f83a5..81f7b9f 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -33,9 +33,12 @@
>   #include "pm.h"
>   #include "sdram-nokia.h"
>   #include "board-rx51-secure.h"
> +#include "soc.h"
>
>   #define RX51_GPIO_SLEEP_IND 162
>
> +/* This lights up left part of keyboard */
> +
>   static struct gpio_led gpio_leds[] = {
>   	{
>   		.name	= "sleep_ind",
> @@ -107,9 +110,11 @@ static void __init rx51_init(void)
>   	rx51_camera_init();
>
>   #ifdef CONFIG_ARM_ERRATA_430973
> -	printk(KERN_INFO "RX-51: Enabling ARM errata 430973 workaround.\n");
> -	/* set IBE to 1 */
> -	rx51_secure_update_aux_cr(1 << 6, 0);
> +	if (omap_type() == OMAP2_DEVICE_TYPE_SEC) {
> +		printk(KERN_INFO "RX-51: Enabling ARM errata 430973 workaround.\n");

    How about pr_info() instead?

WBR, Sergei
