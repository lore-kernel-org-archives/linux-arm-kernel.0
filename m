From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 25 Oct 2012 09:26:36 -0700
Subject: [PATCH v2] gpio/omap: fix off-mode bug: clear debounce clock
 enable mask on free/reset
In-Reply-To: <50887197.8010104@ti.com> (Jon Hunter's message of "Wed, 24 Oct
 2012 17:54:15 -0500")
References: <1351098641-23917-1-git-send-email-khilman@deeprootsystems.com>
 <50887197.8010104@ti.com>
Message-ID: <87mwza4iwz.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon Hunter <jon-hunter@ti.com> writes:

> On 10/24/2012 12:10 PM, Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@ti.com>
>> 
>> When a GPIO bank is freed or shutdown, ensure that the banks
>> dbck_enable_mask is cleared also.  Otherwise, context restore on
>> subsequent off-mode transition will restore previous value from the
>> shadow copies (bank->context.debounce*) leading to mismatch state
>> between driver state and hardware state.
>> 
>> This was discovered when board code was doing
>> 
>>   gpio_request_one()
>>   gpio_set_debounce()
>>   gpio_free()
>> 
>> which was leaving the GPIO debounce settings in a confused state.  If
>> that GPIO bank is subsequently used with off-mode enabled, bogus state
>> would be restored, leaving GPIO debounce enabled which then prevented
>> the CORE powerdomain from transitioning.
>> 
>> To fix, ensure that bank->dbck_enable_mask is cleared when the bank
>> is freed/shutdown so debounce state doesn't persist.
>> 
>> Special thanks to Grazvydas Ignotas for pointing out a bug in an
>> earlier version that would've disabled debounce on any runtime PM
>> transition.
>> 
>> Reported-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Igor Grinberg <grinberg@compulab.co.il>
>> Cc: Grazvydas Ignotas <notasas@gmail.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> v2: only clear mask in free/shutdown, not in runtime PM paths, 
>>     clarified changelog   
>> Applies on v3.7-rc2.
>> 
>>  drivers/gpio/gpio-omap.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 94cbc84..113b167 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -539,6 +539,7 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
>>  	_set_gpio_irqenable(bank, gpio, 0);
>>  	_clear_gpio_irqstatus(bank, gpio);
>>  	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
>> +	bank->dbck_enable_mask = 0;
>>  }
>
> Does this need to be ...
>
> +	bank->dbck_enable_mask &= ~(GPIO_BIT(bank, gpio));
> +	_gpio_dbck_disable(bank);
>
> There could be more than one gpio using debounce and so we should only
> clear the appropriate bit. Also after clearing a bit we could see if we
> can disable the debounce clock too.

Sigh, you're right.  I'm clearly in too much of a rush with this one.
Thanks for taking the time to review. 

v3 coming right up using your suggestsion after some testing just to be
sure it fixes that bug.

Kevin
