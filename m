From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 20 Jul 2013 23:48:30 +0200
Subject: [PATCH 06/10] ARM: clps711x: Add CLPS711X clocksource driver
In-Reply-To: <20130720074441.9882b71183e5eadd535da6c1@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-7-git-send-email-shc_work@mail.ru>
 <51E94F7E.4030404@linaro.org>
 <20130720074441.9882b71183e5eadd535da6c1@mail.ru>
Message-ID: <51EB05AE.2050105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2013 05:44 AM, Alexander Shiyan wrote:
> On Fri, 19 Jul 2013 16:38:54 +0200
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> (Added Thomas and John in Cc in case they want to review the patch).
>>
>> On 07/18/2013 08:34 PM, Alexander Shiyan wrote:
>>> This adds the clocksource driver for Cirrus Logic CLPS711X series SoCs.
>>> Designed primarily for migration CLPS711X subarch for multiplatform & DT,
>>> for this as the "OF" and "not-OF" calls implemented.
>>
>> When a new driver is submitted, I ask for a more detailed changelog
>> about the driver itself: how it works, any specificities, etc ...
>>
>> That will help people to understand the code better at least for the review.
> 
> Basically, this series is a port of the CLPS711X subsystems in places specially
> designed for this purpose. Additionally added to the standard description of the
> subsystem for use with DT.
> As for specs, I'm a little confused by this question. In this case, I'm doing
> is not anything new for this CPU. The CPU has two timers and I use both to
> provide the correct time sources.

I understand there is nothing extra in the code but I was talking about
some specificity of the driver if there are (eg. timer must be disabled
with disable/enable irq).

>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>> ---
>>>  arch/arm/Kconfig                      |   2 -
>>>  drivers/clocksource/Kconfig           |   6 ++
>>>  drivers/clocksource/Makefile          |   1 +
>>>  drivers/clocksource/clps711x-clksrc.c | 151 ++++++++++++++++++++++++++++++++++
>>>  4 files changed, 158 insertions(+), 2 deletions(-)
>>>  create mode 100644 drivers/clocksource/clps711x-clksrc.c
> [...]
>>> +#define CLPS711X_SYSCON1	(0x0100)
>>> +#define CLPS711X_TC1D		(0x0300)
>>> +#define CLPS711X_TC2D		(0x0340)
>>
>> Alignment.
> 
> Alignment? Do not see any problems.
> Wrong alignment in this case is the result of quote.

Ok.

>>> +static struct {
>>> +	void __iomem	*tc1d;
>>> +	int		irq;
>>> +} *clps711x_clksrc;
>>
>> You don't need to define this structure, the struct clock_event_device
>> already contains a field with irq.
> 
> Thank you, I will know.
> 
> [...]
>>> +static void clps711x_clockevent_set_mode(enum clock_event_mode mode,
>>> +					 struct clock_event_device *evt)
>>> +{
>>> +	disable_irq(clps711x_clksrc->irq);
>>
>> Do you really need to disable the interrupt to re-enable it right after ?
> 
> That was the original implementation. Perhaps the best solution is to disable
> interrupt by CLOCK_EVT_MODE_SHUTDOWN and enable it back by CLOCK_EVT_MODE_RESUME.
> 
>>> +> +	switch (mode) {
>>> +	case CLOCK_EVT_MODE_PERIODIC:
>>> +		enable_irq(clps711x_clksrc->irq);
>>> +		break;
>>> +	case CLOCK_EVT_MODE_ONESHOT:
>>> +		/* Not supported */
>>> +	case CLOCK_EVT_MODE_SHUTDOWN:
>>> +	case CLOCK_EVT_MODE_UNUSED:
>>> +	case CLOCK_EVT_MODE_RESUME:
>>> +		/* Left event sources disabled, no more interrupts appear */
>>> +		break;
>>> +	}
>>> +}
>>
>> I am not expert in interrupts, but it is possible this interrupt could
>> be shared ?
> 
> Timer interrupt? No.
> 
>> There isn't a register to enable/disable the timer ?
> 
> Unfortunately, no. The timer is running always, except STDBY CPU state,
> so we can control it only by enable/disable interrupt.

Ok.

> [...]
>>> +static struct irqaction clps711x_timer_irq = {
>>> +	.name		= "clps711x-timer",
>>> +	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
>>
>> Why do you need IRQF_IRQPOOL ?
> 
> linux/interrupt.h:
>  * IRQF_IRQPOLL - Interrupt is used for polling (only the interrupt that is
>  *                registered first in an shared interrupt is considered for
>  *                performance reasons)
> 
> I do not see need this flag, but in fact, this flag is traditionally used
> in almost all subsystems of this type.

So IIUC, IRQPOLL is to switch to polling mode when a lot of interrupts
occur, right ?

> [...]
>>> +	tmp = readl(syscon1);
>>> +	/* TC1 in free running mode */
>>> +	tmp &= ~SYSCON1_TC1M;
>>> +	/* TC2 in prescale mode */
>>> +	tmp |= SYSCON1_TC2M;
>>> +	writel(tmp, syscon1);
>>
>> Could you encapsulate these calls inside a static inline function with a
>> more detailed comment please ?
> 
> Why static inline?
> There is a comment line for each bit, You think this is not enough?

I prefer to encapsulate readl/writel calls inside a small function with
an explicit name, comments are still welcome.

> [...]
>>> +void __init clps711x_clksrc_init(phys_addr_t phys_base, int irq)
>>
>> Is this function called somewhere ? I don't see the function definition ?
> 
> It is defined in the patch [9/10] for non-DT case.

Ok, thanks.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
