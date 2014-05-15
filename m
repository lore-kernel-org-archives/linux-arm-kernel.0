From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 14 May 2014 18:37:52 -0700
Subject: [PATCH v2 3/5] arm: Support reboot through watchdog subsystem
In-Reply-To: <1399681883-891-4-git-send-email-linux@roeck-us.net>
References: <1399681883-891-1-git-send-email-linux@roeck-us.net>
 <1399681883-891-4-git-send-email-linux@roeck-us.net>
Message-ID: <53741A70.8090606@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2014 05:31 PM, Guenter Roeck wrote:
> The watchdog subsystem provides an API to perform a system reboot.
> Use it.
>
> With this change, the arm_pm_restart callback is now optional,
> so check if it is set before calling it.
>
> Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Any comments / ack from the arm maintainers ?

Thanks,
Guenter

> ---
> v2: No change
>
>   arch/arm/kernel/process.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 81ef686..c3b7b5e 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -32,6 +32,7 @@
>   #include <linux/hw_breakpoint.h>
>   #include <linux/leds.h>
>   #include <linux/reboot.h>
> +#include <linux/watchdog.h>
>
>   #include <asm/cacheflush.h>
>   #include <asm/idmap.h>
> @@ -230,7 +231,10 @@ void machine_restart(char *cmd)
>   	local_irq_disable();
>   	smp_send_stop();
>
> -	arm_pm_restart(reboot_mode, cmd);
> +	if (arm_pm_restart)
> +		arm_pm_restart(reboot_mode, cmd);
> +
> +	watchdog_do_reboot(reboot_mode, cmd);
>
>   	/* Give a grace period for failure to restart of 1s */
>   	mdelay(1000);
>
