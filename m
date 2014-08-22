From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Fri, 22 Aug 2014 03:32:42 +0200
Subject: [PATCH v7 04/11] arm: Support restart through restart handler
 call chain
In-Reply-To: <1408495538-27480-5-git-send-email-linux@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-5-git-send-email-linux@roeck-us.net>
Message-ID: <53F69DBA.4070806@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 20.08.2014 02:45, schrieb Guenter Roeck:
> The kernel core now supports a restart handler call chain for system
> restart functions.
> 
> With this change, the arm_pm_restart callback is now optional, so
> drop its initialization and check if it is set before calling it.
> Only call the kernel restart handler if arm_pm_restart is not set.
[...]
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 81ef686..ea279f7 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -114,17 +114,13 @@ void soft_restart(unsigned long addr)
>  	BUG();
>  }
>  
> -static void null_restart(enum reboot_mode reboot_mode, const char *cmd)
> -{
> -}
> -
>  /*
>   * Function pointers to optional machine specific functions
>   */
>  void (*pm_power_off)(void);
>  EXPORT_SYMBOL(pm_power_off);
>  
> -void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd) = null_restart;
> +void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);

Stupid newbie question maybe, but isn't this variable uninitialized now,
like any non-static variable in C99? Or does the kernel assure that all
such "fields" are zero-initialized?

>  EXPORT_SYMBOL_GPL(arm_pm_restart);

(This doesn't seem to be affecting the value of arm_pm_restart, just
redeclaring it extern and adding further derived symbols.)

>  
>  /*
> @@ -230,7 +226,10 @@ void machine_restart(char *cmd)
>  	local_irq_disable();
>  	smp_send_stop();
>  
> -	arm_pm_restart(reboot_mode, cmd);
> +	if (arm_pm_restart)

Here we seem to be relying on arm_pm_restart to be NULL when not
callable. I.e., wondering whether it's ruled out that the following line
is triggered due to non-zero garbage in arm_pm_restart?

Thanks,
Andreas

> +		arm_pm_restart(reboot_mode, cmd);
> +	else
> +		do_kernel_restart(cmd);
>  
>  	/* Give a grace period for failure to restart of 1s */
>  	mdelay(1000);

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
