From: joe@perches.com (Joe Perches)
Date: Sat, 30 Jul 2016 09:30:45 -0700
Subject: [PATCH v2] ARM: pxa: fix GPIO double shifts
In-Reply-To: <1469877735-30127-1-git-send-email-robert.jarzmik@free.fr>
References: <1469877735-30127-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1469896245.3998.113.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2016-07-30 at 13:22 +0200, Robert Jarzmik wrote:
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

It may be better to change the charger_wakeup callback return
value from unsigned long to bool and modify the other use in
spitz_pm.c?

$ git grep -w charger_wakeup
arch/arm/mach-pxa/corgi_pm.c:???.charger_wakeup??= corgi_charger_wakeup,
arch/arm/mach-pxa/sharpsl_pm.c:?????????????????if (sharpsl_pm.machinfo->charger_wakeup() != 0)
arch/arm/mach-pxa/sharpsl_pm.c:?????????if (sharpsl_pm.machinfo->charger_wakeup())
arch/arm/mach-pxa/sharpsl_pm.h: unsigned long (*charger_wakeup)(void);
arch/arm/mach-pxa/spitz_pm.c:???.charger_wakeup???= spitz_charger_wakeup,

> Fixes: 9bf448c66d4b ("ARM: pxa: use generic gpio operation instead of
> gpio register")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: replaced binary ORs with logical ORs after assembly comparison
> ---
> ?arch/arm/mach-pxa/corgi_pm.c | 8 +++-----
> ?arch/arm/mach-pxa/spitz_pm.c | 5 ++---
> ?2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
> index d9206811be9b..8dc39d602884 100644
> --- a/arch/arm/mach-pxa/corgi_pm.c
> +++ b/arch/arm/mach-pxa/corgi_pm.c
> @@ -135,11 +135,9 @@ static unsigned long corgi_charger_wakeup(void)
> ?{
> ?	unsigned long ret;
> ?
> -	ret = (!gpio_get_value(CORGI_GPIO_AC_IN) << GPIO_bit(CORGI_GPIO_AC_IN))
> -		| (!gpio_get_value(CORGI_GPIO_KEY_INT)
> -		<< GPIO_bit(CORGI_GPIO_KEY_INT))
> -		| (!gpio_get_value(CORGI_GPIO_WAKEUP)
> -		<< GPIO_bit(CORGI_GPIO_WAKEUP));
> +	ret = !gpio_get_value(CORGI_GPIO_AC_IN)
> +		|| !gpio_get_value(CORGI_GPIO_KEY_INT)
> +		|| !gpio_get_value(CORGI_GPIO_WAKEUP);
> ?	return ret;
> ?}
> ?
> diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
> index ea9f9034cb54..dd85869f6f99 100644
> --- a/arch/arm/mach-pxa/spitz_pm.c
> +++ b/arch/arm/mach-pxa/spitz_pm.c
> @@ -168,9 +168,8 @@ static int spitz_should_wakeup(unsigned int resume_on_alarm)
> ?static unsigned long spitz_charger_wakeup(void)
> ?{
> ?	unsigned long ret;
> -	ret = ((!gpio_get_value(SPITZ_GPIO_KEY_INT)
> -		<< GPIO_bit(SPITZ_GPIO_KEY_INT))
> -		| gpio_get_value(SPITZ_GPIO_SYNC));
> +	ret = !gpio_get_value(SPITZ_GPIO_KEY_INT)
> +		|| gpio_get_value(SPITZ_GPIO_SYNC);
> ?	return ret;
> ?}
> ?
