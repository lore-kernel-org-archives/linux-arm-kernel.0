From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 09 Feb 2012 14:40:40 +0100
Subject: [PATCH 1/2] ARM: ixp4xx: fix compilation, add gpiolib support
In-Reply-To: <20120209091124.GR889@n2100.arm.linux.org.uk>
References: <1328729069-21308-1-git-send-email-mkl@blackshift.org>
 <1328729069-21308-2-git-send-email-mkl@blackshift.org>
 <20120209091124.GR889@n2100.arm.linux.org.uk>
Message-ID: <4F33CCD8.6050407@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2012 10:11 AM, Russell King - ARM Linux wrote:
> On Wed, Feb 08, 2012 at 08:24:28PM +0100, Marc Kleine-Budde wrote:
>> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
>> index 3841ab4..963f752 100644
>> --- a/arch/arm/mach-ixp4xx/common.c
>> +++ b/arch/arm/mach-ixp4xx/common.c
>> @@ -36,6 +36,7 @@
>>  #include <asm/page.h>
>>  #include <asm/irq.h>
>>  #include <asm/sched_clock.h>
>> +#include <asm/gpio.h>
> 
> linux/gpio.h

Done.

> 
>> diff --git a/arch/arm/mach-ixp4xx/include/mach/gpio.h b/arch/arm/mach-ixp4xx/include/mach/gpio.h
>> index 83d6b4e..093dfad 100644
>> --- a/arch/arm/mach-ixp4xx/include/mach/gpio.h
>> +++ b/arch/arm/mach-ixp4xx/include/mach/gpio.h
>> @@ -27,49 +27,31 @@
>>  
>>  #include <linux/kernel.h>
>>  #include <mach/hardware.h>
>> +#include <asm-generic/gpio.h>			/* cansleep wrappers */
>>  
>>  #define __ARM_GPIOLIB_COMPLEX
>>  
>> -static inline int gpio_request(unsigned gpio, const char *label)
>> -{
>> -	return 0;
>> -}
>> -
>> -static inline void gpio_free(unsigned gpio)
>> -{
>> -	might_sleep();
>> -
>> -	return;
>> -}
>> -
>> -static inline int gpio_direction_input(unsigned gpio)
>> -{
>> -	gpio_line_config(gpio, IXP4XX_GPIO_IN);
>> -	return 0;
>> -}
>> -
>> -static inline int gpio_direction_output(unsigned gpio, int level)
>> -{
>> -	gpio_line_set(gpio, level);
>> -	gpio_line_config(gpio, IXP4XX_GPIO_OUT);
>> -	return 0;
>> -}
>> +#define NR_BUILTIN_GPIO 16
>>  
>>  static inline int gpio_get_value(unsigned gpio)
>>  {
>> -	int value;
>> -
>> -	gpio_line_get(gpio, &value);
>> -
>> -	return value;
>> +	if (gpio < NR_BUILTIN_GPIO) {
>> +		int value;
>> +		gpio_line_get(gpio, &value);
>> +		return value;
>> +	} else
>> +		return __gpio_get_value(gpio);
>>  }
>>  
>>  static inline void gpio_set_value(unsigned gpio, int value)
>>  {
>> -	gpio_line_set(gpio, value);
>> +	if (gpio < NR_BUILTIN_GPIO)
>> +		gpio_line_set(gpio, value);
>> +	else
>> +		__gpio_set_value(gpio, value);
>>  }
>>  
>> -#include <asm-generic/gpio.h>			/* cansleep wrappers */
>> +#define gpio_cansleep __gpio_cansleep
>>  
>>  extern int gpio_to_irq(int gpio);
>>  #define gpio_to_irq gpio_to_irq
> 
> Does anything on ixp4xx require fast access to on-chip GPIOs?  If not,

I don't know the ixp4xx hardware enough. Can someone comment on this?

> it would be much better to get rid of this and just use the standard
> wrapping, which can be done by changing this entire file to be just a
> single line:
> 
> /* empty */

I have to remove the ixp4xx specific gpio_to_irq and irq_to_gpio
functions or keep the #define gpio_to_irq gpio_to_irq.

It compiles now, I'll test on the hardware when I'm home.

regards,
Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120209/2ac9b2c9/attachment.sig>
