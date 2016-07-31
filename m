From: joe@perches.com (Joe Perches)
Date: Sun, 31 Jul 2016 13:44:42 -0700
Subject: [PATCH v3] ARM: pxa: fix GPIO double shifts
In-Reply-To: <1469967435-23436-1-git-send-email-robert.jarzmik@free.fr>
References: <1469967435-23436-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1469997882.3998.136.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-07-31 at 14:17 +0200, Robert Jarzmik wrote:
> The commit 9bf448c66d4b ("ARM: pxa: use generic gpio operation instead of
> gpio register") from Oct 17, 2011, leads to the following static checker
> warning:
> ? arch/arm/mach-pxa/spitz_pm.c:172 spitz_charger_wakeup()
> ? warn: double left shift '!gpio_get_value(SPITZ_GPIO_KEY_INT)
> ????????<< (1 << ((SPITZ_GPIO_KEY_INT) & 31))'
> 
> As Dan reported, the value is shifted three times :
> ?- once by gpio_get_value(), which returns either 0 or BIT(gpio)
> ?- once by the shift operation '<<'
> ?- a last time by GPIO_bit(gpio) which is BIT(gpio)
> 
> Therefore the calculation lead to a chained or operator of :
> ?- (1 << gpio) << (1 << gpio) = (2^gpio)^gpio = 2 ^ (gpio * gpio)
> 
> It is be sheer luck the former statement works, only because each gpio
> used is strictly smaller than 6, and therefore 2^(gpio^2) never
> overflows a 32 bits value, and because it is used as a boolean value to
> check a gpio activation.
> 
> As the xxx_charger_wakeup() functions are used as a true/false detection
> mechanism, take that opportunity to change their prototypes from integer
> return value to boolean one.
> 
> Fixes: 9bf448c66d4b ("ARM: pxa: use generic gpio operation instead of
> gpio register")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: replaced binary ORs with logical ORs after assembly comparison
> Since v2: changed charger_wakeup prototype to bool foo()

Thanks Robert

trivially:
> diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
[]
> @@ -131,15 +131,13 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
> ?	return is_resume;
> ?}
> ?
> -static unsigned long corgi_charger_wakeup(void)
> +static bool corgi_charger_wakeup(void)
> ?{
> -	unsigned long ret;
> +	bool ret;
> ?
> -	ret = (!gpio_get_value(CORGI_GPIO_AC_IN) << GPIO_bit(CORGI_GPIO_AC_IN))
> -		| (!gpio_get_value(CORGI_GPIO_KEY_INT)
> -		<< GPIO_bit(CORGI_GPIO_KEY_INT))
> -		| (!gpio_get_value(CORGI_GPIO_WAKEUP)
> -		<< GPIO_bit(CORGI_GPIO_WAKEUP));
> +	ret = !gpio_get_value(CORGI_GPIO_AC_IN)
> +		|| !gpio_get_value(CORGI_GPIO_KEY_INT)
> +		|| !gpio_get_value(CORGI_GPIO_WAKEUP);

These might be better without the automatic use of ret

	return !gpio_get_value(CORGI_GPIO_AC_IN) ||
	? ? ? ?!gpio_get_value(CORGI_GPIO_KEY_INT) ||
	? ? ? ?!gpio_get_value(CORGI_GPIO_WAKEUP);

and

> diff --git a/arch/arm/mach-pxa  /spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
[]
> @@ -165,12 +165,12 @@ static int spitz_should_wakeup(unsigned int resume_on_alarm)
> ?	return is_resume;
> ?}
> ?
> -static unsigned long spitz_charger_wakeup(void)
> +static bool spitz_charger_wakeup(void)
> ?{
> -	unsigned long ret;
> -	ret = ((!gpio_get_value(SPITZ_GPIO_KEY_INT)
> -		<< GPIO_bit(SPITZ_GPIO_KEY_INT))
> -		| gpio_get_value(SPITZ_GPIO_SYNC));
> +	bool ret;
> +
> +	ret = !gpio_get_value(SPITZ_GPIO_KEY_INT)
> +		|| gpio_get_value(SPITZ_GPIO_SYNC);
> ?	return ret;
> ?}

	return !gpio_get_value(SPITZ_GPIO_KEY_INT) ||
	       gpio_get_value(SPITZ_GPIO_SYNC);
