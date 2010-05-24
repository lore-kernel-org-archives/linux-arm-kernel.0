From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 24 May 2010 04:32:23 +0100
Subject: [PATCH] s3c24xx fix: freeze during suspend/resume on s3c24xx
	if some GPIO banks not present
In-Reply-To: <4BF8F30B.9040704@ru.mvista.com>
References: <4BF8B232.9020903@vscht.cz> <4BF8F30B.9040704@ru.mvista.com>
Message-ID: <20100524033223.GC7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 23, 2010 at 01:19:07PM +0400, Sergei Shtylyov wrote:
> Hello.
>
> Pinkava J. wrote:
>
>> When saving GPIOs during suspend/resume we need skip missing GPIO banks, not
>> trying get corresponding chip again and again in infinite loop.
>
>    I didn't see any infinite loops there -- *continue* itself leads to  
> incrementing 'gpio_nr', no?

no, I made a bit of a mess playing with this patch, so this should fix
it (now applied).

Really I could do with a list of all registered s3c_gpio_chips to allow
for a more efficient implementation, but it is a bit late for that for
this merge window.

>> Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
>> ---
>>  arch/arm/plat-samsung/pm-gpio.c |    8 ++++++--
>>  1 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
>> index d50ab9d..7df03f8 100644
>> --- a/arch/arm/plat-samsung/pm-gpio.c
>> +++ b/arch/arm/plat-samsung/pm-gpio.c
>> @@ -331,8 +331,10 @@ void s3c_pm_save_gpios(void)
>>
>>  	for (gpio_nr = 0; gpio_nr < S3C_GPIO_END;) {
>>  		ourchip = s3c_gpiolib_getchip(gpio_nr);
>> -		if (!ourchip)
>> +		if (!ourchip) {
>> +			gpio_nr++;
>>  			continue;
>> +		}
>>
>>  		s3c_pm_save_gpio(ourchip);
>>
>> @@ -369,8 +371,10 @@ void s3c_pm_restore_gpios(void)
>>
>>  	for (gpio_nr = 0; gpio_nr < S3C_GPIO_END;) {
>>  		ourchip = s3c_gpiolib_getchip(gpio_nr);
>> -		if (!ourchip)
>> +		if (!ourchip) {
>> +			gpio_nr++;
>>  			continue;
>> +		}
>>
>>  		s3c_pm_resume_gpio(ourchip);
>
> WBR, Sergei
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
