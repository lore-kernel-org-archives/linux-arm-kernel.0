From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Oct 2011 10:23:24 +0100
Subject: [PATCH v5 08/11] ARM: pxa: use generic gpio operation instead
	of gpio register
In-Reply-To: <1318858517-22494-9-git-send-email-haojian.zhuang@marvell.com>
References: <1318858517-22494-1-git-send-email-haojian.zhuang@marvell.com>
	<1318858517-22494-9-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20111027092324.GG19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2011 at 09:35:14PM +0800, Haojian Zhuang wrote:
> Remove the code of accessing gpio register. Use the generic read
> operation instead.

This patch looks buggy.

> @@ -90,7 +92,7 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
>  {
>  	int is_resume = 0;
>  
> -	dev_dbg(sharpsl_pm.dev, "GPLR0 = %x,%x\n", GPLR0, PEDR);
> +	dev_dbg(sharpsl_pm.dev, "GPLR0 = %x,%x\n", charger_gpios[4].gpio, PEDR);

This code used to read the GPLR0 register and report its value.  With
this change, it how reads the GPIO number and prints that instead.  So
formerly it reported the current state of a set of GPIO signals and
now it reports a gpio number.

>  
>  	if ((PEDR & GPIO_bit(CORGI_GPIO_AC_IN))) {
>  		if (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN)) {
> @@ -124,14 +126,18 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
>  
>  static unsigned long corgi_charger_wakeup(void)
>  {
> -	return ~GPLR0 & ( GPIO_bit(CORGI_GPIO_AC_IN) | GPIO_bit(CORGI_GPIO_KEY_INT) | GPIO_bit(CORGI_GPIO_WAKEUP) );
> +	unsigned long gplr0;
> +	gplr0 = gpio_get_value(charger_gpios[3].gpio);
> +	return ~gplr0 & ( GPIO_bit(CORGI_GPIO_AC_IN) | GPIO_bit(CORGI_GPIO_KEY_INT) | GPIO_bit(CORGI_GPIO_WAKEUP) );

This also looks very wrong.  gpio_get_value() can return a boolean 0 or 1
value, but you're treating it as a bitmask.

>  }
>  
>  unsigned long corgipm_read_devdata(int type)
>  {
> +	unsigned long gplr0 = 0;
>  	switch(type) {
>  	case SHARPSL_STATUS_ACIN:
> -		return ((GPLR(CORGI_GPIO_AC_IN) & GPIO_bit(CORGI_GPIO_AC_IN)) != 0);
> +		gplr0 = gpio_get_value(charger_gpios[3].gpio);
> +		return ((gplr0 & GPIO_bit(CORGI_GPIO_AC_IN)) != 0);

Ditto.

>  	case SHARPSL_STATUS_LOCK:
>  		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
>  	case SHARPSL_STATUS_CHRGFULL:
> diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
> index 094279a..adf87ed 100644
> --- a/arch/arm/mach-pxa/spitz_pm.c
> +++ b/arch/arm/mach-pxa/spitz_pm.c
> @@ -41,6 +41,7 @@ static int spitz_last_ac_status;
>  static struct gpio spitz_charger_gpios[] = {
>  	{ SPITZ_GPIO_KEY_INT,	GPIOF_IN, "Keyboard Interrupt" },
>  	{ SPITZ_GPIO_SYNC,	GPIOF_IN, "Sync" },
> +	{ SPITZ_GPIO_AC_IN,     GPIOF_IN, "Charger Detection" },
>  	{ SPITZ_GPIO_ADC_TEMP_ON, GPIOF_OUT_INIT_LOW, "ADC Temp On" },
>  	{ SPITZ_GPIO_JK_B,	  GPIOF_OUT_INIT_LOW, "JK B" },
>  	{ SPITZ_GPIO_CHRG_ON,	  GPIOF_OUT_INIT_LOW, "Charger On" },
> @@ -169,14 +170,18 @@ static int spitz_should_wakeup(unsigned int resume_on_alarm)
>  
>  static unsigned long spitz_charger_wakeup(void)
>  {
> -	return (~GPLR0 & GPIO_bit(SPITZ_GPIO_KEY_INT)) | (GPLR0 & GPIO_bit(SPITZ_GPIO_SYNC));
> +	unsigned long gplr0;
> +	gplr0 = gpio_get_value(spitz_charger_gpios[0].gpio);
> +	return (~gplr0 & GPIO_bit(SPITZ_GPIO_KEY_INT)) | (gplr0 & GPIO_bit(SPITZ_GPIO_SYNC));

Ditto.

>  }
>  
>  unsigned long spitzpm_read_devdata(int type)
>  {
> +	unsigned long gplr = 0;
>  	switch (type) {
>  	case SHARPSL_STATUS_ACIN:
> -		return (((~GPLR(SPITZ_GPIO_AC_IN)) & GPIO_bit(SPITZ_GPIO_AC_IN)) != 0);
> +		gplr = gpio_get_value(spitz_charger_gpios[2].gpio);
> +		return ((~gplr & GPIO_bit(SPITZ_GPIO_AC_IN)) != 0);

Ditto.

>  	case SHARPSL_STATUS_LOCK:
>  		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
>  	case SHARPSL_STATUS_CHRGFULL:
> -- 
> 1.7.2.5
> 
