From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 7 Oct 2014 18:06:38 +0200
Subject: [PATCH 20/44] power/reset: restart-poweroff: Register with
 kernel poweroff handler
In-Reply-To: <1412659726-29957-21-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-21-git-send-email-linux@roeck-us.net>
Message-ID: <20141007160638.GE19005@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 10:28:22PM -0700, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of seting pm_power_off
> directly.  Register as poweroff handler of last resort since the driver
> does not really power off the system but executes a restart.

I would not say last resort, this is how it is designed to work. There
is no way to turn the power off from with linux, it is designed that
u-boot will put the hardware into minimal power consumption until the
"power" button is pressed.

Other than that, 

Acked-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew

> 
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/power/reset/restart-poweroff.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
> index edd707e..5437697 100644
> --- a/drivers/power/reset/restart-poweroff.c
> +++ b/drivers/power/reset/restart-poweroff.c
> @@ -12,35 +12,34 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/notifier.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_platform.h>
>  #include <linux/module.h>
> +#include <linux/pm.h>
>  #include <linux/reboot.h>
> -#include <asm/system_misc.h>
>  
> -static void restart_poweroff_do_poweroff(void)
> +static int restart_poweroff_do_poweroff(struct notifier_block *this,
> +					unsigned long unused1, void *unused2)
>  {
>  	reboot_mode = REBOOT_HARD;
>  	machine_restart(NULL);
> +
> +	return NOTIFY_DONE;
>  }
>  
> +static struct notifier_block restart_poweroff_handler = {
> +	.notifier_call = restart_poweroff_do_poweroff,
> +};
> +
>  static int restart_poweroff_probe(struct platform_device *pdev)
>  {
> -	/* If a pm_power_off function has already been added, leave it alone */
> -	if (pm_power_off != NULL) {
> -		dev_err(&pdev->dev,
> -			"pm_power_off function already registered");
> -		return -EBUSY;
> -	}
> -
> -	pm_power_off = &restart_poweroff_do_poweroff;
> -	return 0;
> +	return register_poweroff_handler(&restart_poweroff_handler);
>  }
>  
>  static int restart_poweroff_remove(struct platform_device *pdev)
>  {
> -	if (pm_power_off == &restart_poweroff_do_poweroff)
> -		pm_power_off = NULL;
> +	unregister_poweroff_handler(&restart_poweroff_handler);
>  
>  	return 0;
>  }
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
