From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 01 Aug 2016 00:04:27 +0200
Subject: [PATCH v3] ARM: pxa: fix GPIO double shifts
In-Reply-To: <1469997882.3998.136.camel@perches.com> (Joe Perches's message of
 "Sun, 31 Jul 2016 13:44:42 -0700")
References: <1469967435-23436-1-git-send-email-robert.jarzmik@free.fr>
 <1469997882.3998.136.camel@perches.com>
Message-ID: <87shupxy50.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

Joe Perches <joe@perches.com> writes:
> trivially:
>> diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
> []
>> @@ -131,15 +131,13 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
>> ?	return is_resume;
>> ?}
>> ?
>> -static unsigned long corgi_charger_wakeup(void)
>> +static bool corgi_charger_wakeup(void)
>> ?{
>> -	unsigned long ret;
>> +	bool ret;
>> ?
>> -	ret = (!gpio_get_value(CORGI_GPIO_AC_IN) << GPIO_bit(CORGI_GPIO_AC_IN))
>> -		| (!gpio_get_value(CORGI_GPIO_KEY_INT)
>> -		<< GPIO_bit(CORGI_GPIO_KEY_INT))
>> -		| (!gpio_get_value(CORGI_GPIO_WAKEUP)
>> -		<< GPIO_bit(CORGI_GPIO_WAKEUP));
>> +	ret = !gpio_get_value(CORGI_GPIO_AC_IN)
>> +		|| !gpio_get_value(CORGI_GPIO_KEY_INT)
>> +		|| !gpio_get_value(CORGI_GPIO_WAKEUP);
>
> These might be better without the automatic use of ret
>
> 	return !gpio_get_value(CORGI_GPIO_AC_IN) ||
> 	? ? ? ?!gpio_get_value(CORGI_GPIO_KEY_INT) ||
> 	? ? ? ?!gpio_get_value(CORGI_GPIO_WAKEUP);

Yeah, I thought about this when I made the patch.

I supposed it was written this way so that a printk was easier to add, that's
why I didn't change the useless variable.

I have no strong opinion about this, so if you think it's worth it I can make
the additional change.

Cheers.

--
Robert
