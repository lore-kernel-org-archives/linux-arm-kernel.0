From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 21 May 2011 19:27:36 +0200
Subject: spitz pm: adjust messages
In-Reply-To: <20110521122450.GA6954@elf.ucw.cz>
References: <20110521122450.GA6954@elf.ucw.cz>
Message-ID: <201105211927.36619.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, May 21, 2011 02:24:50 PM Pavel Machek wrote:
> Charger error is something that should be reported to the syslog; do
> it. If temperature reading fails, we do not want to charge the
> battery, anyway.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/arch/arm/mach-pxa/sharpsl_pm.c
> b/arch/arm/mach-pxa/sharpsl_pm.c index 785880f..513588c 100644
> --- a/arch/arm/mach-pxa/sharpsl_pm.c
> +++ b/arch/arm/mach-pxa/sharpsl_pm.c
> @@ -317,6 +302,8 @@ static void sharpsl_charge_off(void)
> 
>  static void sharpsl_charge_error(void)
>  {
> +	dev_warn(sharpsl_pm.dev, "Charger Error\n");
> +
>  	sharpsl_pm_led(SHARPSL_LED_ERROR);
>  	sharpsl_pm.machinfo->charge(0);
>  	sharpsl_pm.charge_mode = CHRG_ERROR;
> @@ -513,8 +500,10 @@ static int sharpsl_check_battery_temp(void)
>  	val = get_select_val(buff);
> 
>  	dev_dbg(sharpsl_pm.dev, "Temperature: %d\n", val);
> -	if (val > sharpsl_pm.machinfo->charge_on_temp) {
> -		printk(KERN_WARNING "Not charging: temperature out of limits.\n");
> +	/* FIXME: this should catch battery read errors, but we should
> +	   probably avoid charging in <0C temperatures, too. */
> +	if ((val < 0) || (val > sharpsl_pm.machinfo->charge_on_temp)) {
> +		dev_warn(sharpsl_pm.dev, "Not charging: temperature %d out of
> limits.\n", val); return -1;
>  	}

Acked-by: Marek Vasut <marek.vasut@gmail.com>
