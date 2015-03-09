From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 09 Mar 2015 12:13:54 +0100
Subject: [PATCH v4 8/9] clocksource: atmel-st: use syscon/regmap
In-Reply-To: <20150306084727.GH3989@piout.net>
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425570594-13124-9-git-send-email-alexandre.belloni@free-electrons.com>
 <54F96896.6040204@linaro.org> <20150306084727.GH3989@piout.net>
Message-ID: <54FD8072.5010803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2015 09:47 AM, Alexandre Belloni wrote:
> On 06/03/2015 at 09:43:02 +0100, Daniel Lezcano wrote :
>> On 03/05/2015 04:49 PM, Alexandre Belloni wrote:
>>> The register range from the system timer is also used by the watchdog driver.
>>> Use a regmap to handle concurrent accesses.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>> ---
>>>   drivers/clocksource/timer-atmel-st.c | 99 ++++++++++++++----------------------
>>>   1 file changed, 37 insertions(+), 62 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
>>> index 7d062ab32674..c4a52e32675e 100644
>>> --- a/drivers/clocksource/timer-atmel-st.c
>>> +++ b/drivers/clocksource/timer-atmel-st.c
>>> @@ -24,19 +24,19 @@
>>>   #include <linux/irq.h>
>>>   #include <linux/clockchips.h>
>>>   #include <linux/export.h>
>>> -#include <linux/of.h>
>>> -#include <linux/of_address.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/mfd/syscon/atmel-st.h>
>>>   #include <linux/of_irq.h>
>>> +#include <linux/regmap.h>
>>>
>>>   #include <asm/mach/time.h>
>>>
>>> -#include <mach/at91_st.h>
>>> -#include <mach/hardware.h>
>>> -
>>>   static unsigned long last_crtr;
>>>   static u32 irqmask;
>>>   static struct clock_event_device clkevt;
>>> +static struct regmap *regmap_st;
>>>
>>> +#define AT91_SLOW_CLOCK		32768
>>>   #define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
>>>
>>>   /*
>>> @@ -46,11 +46,11 @@ static struct clock_event_device clkevt;
>>>    */
>>>   static inline unsigned long read_CRTR(void)
>>>   {
>>> -	unsigned long x1, x2;
>>> +	unsigned int x1, x2;
>>>
>>> -	x1 = at91_st_read(AT91_ST_CRTR);
>>> +	regmap_read(regmap_st, AT91_ST_CRTR, &x1);
>>>   	do {
>>> -		x2 = at91_st_read(AT91_ST_CRTR);
>>> +		regmap_read(regmap_st, AT91_ST_CRTR, &x2);
>>>   		if (x1 == x2)
>>>   			break;
>>>   		x1 = x2;
>>> @@ -63,7 +63,10 @@ static inline unsigned long read_CRTR(void)
>>>    */
>>>   static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
>>>   {
>>> -	u32	sr = at91_st_read(AT91_ST_SR) & irqmask;
>>> +	u32 sr;
>>> +
>>> +	regmap_read(regmap_st, AT91_ST_SR, &sr);
>>> +	sr &= irqmask;
>>>
>>>   	/*
>>>   	 * irqs should be disabled here, but as the irq is shared they are only
>>> @@ -96,7 +99,7 @@ static struct irqaction at91rm9200_timer_irq = {
>>>   	.name		= "at91_tick",
>>>   	.flags		= IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
>>>   	.handler	= at91rm9200_timer_interrupt,
>>> -	.irq		= NR_IRQS_LEGACY + AT91_ID_SYS,
>>> +	.irq		= 0,
>>
>> Is this change related to regmap ?
>>
>
> It is related to the removing of hardware.h. I can do that in a separate
> patch if you prefer.

Yeah, because it is not obvious to see a connection between the removal 
of hardware.h and the syscon/regmap changes.

I would suggest you create a patch to replace setup_irq with 
register_irq so that will remove this structure and the irq 
initialization to zero.

>> By the way, perhaps take the opportunity to replace setup_irq by request_irq
>> (and check the return value) ?
>>
>
> I tried and it fails, I didn't investigate yet.

It shouldn't be a big deal, register_irq is more or less a wrapper to 
setup_irq.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
