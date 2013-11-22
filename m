From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 22 Nov 2013 23:46:10 +0400
Subject: [PATCH 7/9] ARM: sa1100: move gpio irq handling to GPIO driver
In-Reply-To: <20131122174528.GB16735@n2100.arm.linux.org.uk>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
 <1384505280-25389-8-git-send-email-dbaryshkov@gmail.com>
 <20131122174528.GB16735@n2100.arm.linux.org.uk>
Message-ID: <CALT56yM1rf7onJNu6L9tG52RrmDXcuWSoa=JfpakZRO+e7vnEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Nov 22, 2013 at 9:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 15, 2013 at 12:47:58PM +0400, Dmitry Eremin-Solenikov wrote:
>> mach-sa1100's irq.c contains a mixture of system and GPIO irqs handling.
>> Split out GPIO irqchip to gpio-sa1100.c. To decouple first 11 GPIO IRQs
>> handling, make IRQ0-IRQ10 use chained irq handler that just passes the
>> IRQ to GPIO IRQs.
>>
>> Also during this refactoring introduce irq domain support for sa1100
>> gpio irqs.
>
> I'm not sure I quite like this change... How much testing has this had?
> I'd much prefer that this code just isn't touched because of all the
> problems we've had here in years back with IRQs from CF cards being
> dropped and the like.  This was very hard to get right, especially when
> interacting with the SA1111.

How can we just check that? And what was the problem with CF IRQs?
Sorry, if I'm asking dumb questions, I really missed that part of the history.

I can go the way Linus Walleij originally did:
1) switch to irq domain / hwirq
2) integrate static variables to containers

And only after that in a separate patch(set)

3) Move GPIO IRQ handling to gpio-sa1100.

What do you think?

>
>> @@ -136,3 +301,58 @@ static int __init sa1100_gpio_init(void)
>>       return platform_driver_register(&sa1100_gpio_driver);
>>  }
>>  postcore_initcall(sa1100_gpio_init);
>> +
>> +#ifdef CONFIG_PM
>> +static unsigned long saved_gplr;
>> +static unsigned long saved_gpdr;
>> +static unsigned long saved_grer;
>> +static unsigned long saved_gfer;
>> +
>> +static int sa1100_gpio_suspend(void)
>> +{
>> +     struct sa1100_gpio_chip *sgc = chip;
>> +     saved_gplr = readl_relaxed(sgc->regbase + GPLR_OFFSET);
>> +     saved_gpdr = readl_relaxed(sgc->regbase + GPDR_OFFSET);
>> +     saved_grer = readl_relaxed(sgc->regbase + GRER_OFFSET);
>> +     saved_gfer = readl_relaxed(sgc->regbase + GFER_OFFSET);
>> +
>> +     /* Clear GPIO transition detect bits */
>> +     writel_relaxed(0xffffffff, sgc->regbase + GEDR_OFFSET);
>> +
>> +     /* FIXME: Original code also reprogramed GRER/GFER here,
>> +      * I don't see the purpose though.
>> +     GRER = PWER & sgc->gpio_rising;
>> +     GFER = PWER & sgc->gpio_falling;
>> +      */
>
> So you thought you'd just comment it out because you don't understand...
> Not really the way things are done.  If you don't understand something,
> you shouldn't be touching the code.

Thus I have the big FIXME.

> In this case, it's quite simple.  GRER and GFER need to be programmed
> with the interrupts which we want to be active for _each_ mode of the
> system.

I see. I will put this back in the next iteration, but see below please.

> Therefore, if we want to have certain GPIOs triggering wakeups (iow,
> those GPIOs which have had enable_irq_wake() called on them) but not
> those which haven't, we need to reprogram GRER and GFER with the
> GPIOs which can wake the system up.

I thought so. I was puzzled, because that would mean, that we want to wake
up from a GPIO, which is masked in GPIO_IRQ_mask, but enabled in PWER.
Is that the real scenario/usecase? If we/kernel has disabled IRQ
through _mask_irq,
I thought, we didn't expect events from that pin (including wakeup), did we?


-- 
With best wishes
Dmitry
