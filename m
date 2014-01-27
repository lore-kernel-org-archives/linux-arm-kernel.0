From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 26 Jan 2014 22:42:19 -0800
Subject: [PATCH v3 04/15] watchdog: orion: Handle IRQ
In-Reply-To: <20140127063040.GA17506@localhost>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390310774-20781-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <52DE84A6.6090909@roeck-us.net> <20140127063040.GA17506@localhost>
Message-ID: <52E5FFCB.5000802@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2014 10:30 PM, Ezequiel Garcia wrote:
> Hi Guenter,
>
> On Tue, Jan 21, 2014 at 06:31:02AM -0800, Guenter Roeck wrote:
> [..]
>>> @@ -131,6 +138,19 @@ static int orion_wdt_probe(struct platform_device *pdev)
>>>    	if (!wdt_reg)
>>>    		return -ENOMEM;
>>>
>>> +	irq = platform_get_irq(pdev, 0);
>>> +	if (irq > 0) {
>>
>> 0 is a valid interrupt number, and platform_get_irq returns an error code on errors.
>> Should be >= 0.
>>
>
> I'm revisiting this one. I believe this is not the hardware interrupt
> number, but the one mapped into virq space. So, 0 is not a valid
> interrupt number.
>
> Right?
>

Hi,

If so, the entire interrupt numbering scheme appears broken. Conceptually it should
not make a difference where the interrupt is coming from. If the virq system
returns 0 for invalid (non-configured) interrupts, and non-configured 'real'
interrupts are reported as -ENXIO, all bets are off. How would a driver know
what to expect ? And how would one be expected to review such non-deterministic
code ?

FWIW, platform_get_irq() does return -ENXIO for invalid interrupts. If there
is an independent notion of "0 is an invalid interrupt", it is well hidden.

Anyway, if you think the driver should treat 0 as invalid interrupt, go ahead.
Who am I to know. Just please don't use my Reviewed-by in this case.

Thanks,
Guenter
