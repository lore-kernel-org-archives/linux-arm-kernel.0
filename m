From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Sun, 23 May 2010 14:34:55 +0200
Subject: [PATCH] s3c24xx fix: freeze during suspend/resume on s3c24xx
	if some	GPIO banks not present
In-Reply-To: <4BF8F30B.9040704@ru.mvista.com>
References: <4BF8B232.9020903@vscht.cz> <4BF8F30B.9040704@ru.mvista.com>
Message-ID: <4BF920EF.2050800@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 23.5.2010 11:19, Sergei Shtylyov napsal(a):
> Hello.
> 
> Pinkava J. wrote:
> 
>> When saving GPIOs during suspend/resume we need skip missing GPIO banks, not
>> trying get corresponding chip again and again in infinite loop.
> 
>     I didn't see any infinite loops there -- *continue* itself leads to 
> incrementing 'gpio_nr', no?

No, it would have to be:

for (gpio_nr = 0; gpio_nr < S3C_GPIO_END; gpio_nr++) {
...

try create simple test program for your self

/* test.c */
main()
{
	int x;
	for(x = 0; x < 10; /* x++ */ )
	{
		printf("x  = %d", x);
	}
}

Compile usign:

gcc test.c

Run

./a.out

> 
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
