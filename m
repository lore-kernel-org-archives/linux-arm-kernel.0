From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 10 Apr 2013 06:33:51 -0700
Subject: [PATCH] watchdog: Revert the AT91RM9200_WATCHDOG dependency
In-Reply-To: <1365597382-15455-1-git-send-email-nicolas.ferre@atmel.com>
References: <20130409202711.GG7867@spo001.leaseweb.com>
 <1365597382-15455-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20130410133351.GA7295@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 02:36:22PM +0200, Nicolas Ferre wrote:
> Compiling the at91rm9200_wdt.c driver without at91rm9200
> support was leading to several errors:
> 
> drivers/built-in.o: In function `at91_wdt_close':
> at91_adc.c:(.text+0xc9fe4): undefined reference to `at91_st_base'
> drivers/built-in.o: In function `at91_wdt_write':
> at91_adc.c:(.text+0xca004): undefined reference to `at91_st_base'
> drivers/built-in.o: In function `at91wdt_shutdown':
> at91_adc.c:(.text+0xca01c): undefined reference to `at91_st_base'
> drivers/built-in.o: In function `at91wdt_suspend':
> at91_adc.c:(.text+0xca038): undefined reference to `at91_st_base'
> drivers/built-in.o: In function `at91_wdt_open':
> at91_adc.c:(.text+0xca0cc): undefined reference to `at91_st_base'
> drivers/built-in.o:at91_adc.c:(.text+0xca2c8): more undefined references to
> `at91_st_base' follow
> 
> So, reverting the modification of the "depends" Kconfig line
> introduced by patch a6a1bcd37 (watchdog: at91rm9200: add DT support)
> seems to be the good solution.
> 
Really ? Why ? I mean, this was supposed to be for at91rm9200, wasn't it ?
And why would want try to compile a watchdog for at91rm9200 without at91rm9200
support ?

I understand there is a problem, I just don't see how removing that line would
solgve it.

Guenter

> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9fcc70c..e89fc31 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -117,7 +117,7 @@ config ARM_SP805_WATCHDOG
>  
>  config AT91RM9200_WATCHDOG
>  	tristate "AT91RM9200 watchdog"
> -	depends on ARCH_AT91
> +	depends on ARCH_AT91RM9200
>  	help
>  	  Watchdog timer embedded into AT91RM9200 chips. This will reboot your
>  	  system when the timeout is reached.
> -- 
> 1.8.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
