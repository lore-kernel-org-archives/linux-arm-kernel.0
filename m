From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Oct 2014 09:00:48 +0100
Subject: [PATCH 12/44] mfd: ab8500-sysctrl: Register with kernel poweroff
 handler
In-Reply-To: <1412659726-29957-13-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-13-git-send-email-linux@roeck-us.net>
Message-ID: <20141007080048.GB25331@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 06 Oct 2014, Guenter Roeck wrote:

> Register with kernel poweroff handler instead of setting pm_power_off
> directly. Register with a low priority value of 64 to reflect that
> the original code only sets pm_power_off if it was not already set.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/mfd/ab8500-sysctrl.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
> index 8e0dae5..677438f 100644
> --- a/drivers/mfd/ab8500-sysctrl.c
> +++ b/drivers/mfd/ab8500-sysctrl.c
> @@ -6,6 +6,7 @@

[...]

> +static int ab8500_power_off(struct notifier_block *this, unsigned long unused1,
> +			    void *unused2)
>  {
>  	sigset_t old;
>  	sigset_t all;
> @@ -34,11 +36,6 @@ static void ab8500_power_off(void)
>  	struct power_supply *psy;
>  	int ret;
>  
> -	if (sysctrl_dev == NULL) {
> -		pr_err("%s: sysctrl not initialized\n", __func__);
> -		return;
> -	}

Can you explain the purpose of this change please?

>  	/*
>  	 * If we have a charger connected and we're powering off,
>  	 * reboot into charge-only mode.
> @@ -83,8 +80,15 @@ shutdown:
>  					 AB8500_STW4500CTRL1_SWRESET4500N);
>  		(void)sigprocmask(SIG_SETMASK, &old, NULL);
>  	}
> +
> +	return NOTIFY_DONE;
>  }

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
