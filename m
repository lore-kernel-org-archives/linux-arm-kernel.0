From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 26 May 2011 13:49:32 +0000
Subject: spitz pm: adjust messages
In-Reply-To: <20110521122450.GA6954@elf.ucw.cz>
References: <20110521122450.GA6954@elf.ucw.cz>
Message-ID: <20110526134931.GA16958@localhost.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric, it should probably be you merging this and surrounding
patches... Any comments? Merge?
							Pavel

On Sat 2011-05-21 14:24:50, Pavel Machek wrote:
> Charger error is something that should be reported to the syslog; do
> it. If temperature reading fails, we do not want to charge the
> battery, anyway.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
> index 785880f..513588c 100644
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
> +		dev_warn(sharpsl_pm.dev, "Not charging: temperature %d out of limits.\n", val);
>  		return -1;
>  	}
>  
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
