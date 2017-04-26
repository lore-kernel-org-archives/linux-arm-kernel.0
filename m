From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Apr 2017 15:12:01 +0200
Subject: [PATCH v4 5/7] pinctrl: aramda-37xx: Add irqchip support
In-Reply-To: <CACRpkdYYRe4A+Zj+fDpC9SA1pgaVSgewYGB_vCNoWNRXWTtTGQ@mail.gmail.com>
 (Linus Walleij's message of "Wed, 26 Apr 2017 14:03:15 +0200")
References: <cover.65d0e6796fecf1fe6c5d07b981160b54dc9b4acd.1491405475.git-series.gregory.clement@free-electrons.com>
 <70ffe3343c13d01737bf74e5de4898d0c0be07a0.1491405475.git-series.gregory.clement@free-electrons.com>
 <CACRpkdZ=mVXBbVf1iHg8nQ6pYUkvpB+egH+stoMrkD8V_vaYpg@mail.gmail.com>
 <87zif38qu2.fsf@free-electrons.com>
 <CACRpkdYYRe4A+Zj+fDpC9SA1pgaVSgewYGB_vCNoWNRXWTtTGQ@mail.gmail.com>
Message-ID: <87inlr8g9q.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On mer., avril 26 2017, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Wed, Apr 26, 2017 at 11:23 AM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>>  On lun., avril 24 2017, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>>>> +               spin_lock_irqsave(&info->irq_lock, flags);
>>>> +               status = readl_relaxed(info->base + IRQ_STATUS + 4 * i);
>>>> +               /* Manage only the interrupt that was enabled */
>>>> +               status &= readl_relaxed(info->base + IRQ_EN + 4 * i);
>>>> +               spin_unlock_irqrestore(&info->irq_lock, flags);
>>>> +               while (status) {
>>>> +                       u32 hwirq = ffs(status) - 1;
>>>> +                       u32 virq = irq_find_mapping(d, hwirq +
>>>> +                                                    i * GPIO_PER_REG);
>>>> +
>>>> +                       generic_handle_irq(virq);
>>>> +                       status &= ~BIT(hwirq);
>>>> +               }
>>>
>>> You hae a problem here is a new IRQ appears while you are inside
>>> of this loop. You need to re-read the status register for each iteration
>>> (and &= with the IRQ_EN I guess).
>>
>> If a new IRQ appears during the loop, then the irq handler will be
>> called again because the cause of this new IRQ won't have been acked
>> yet. So I think we're fine here.
>
> That *might* be true. It is true if the CPU gets a level IRQ from the
> GPIO controller. But hardware dealing with edge IRQs can be very
> quirky here, and just send a pulse on the line to the CPU if the
> CPU-bound IRQ is also just edge triggered. And then that
> pulse would potentially be missed while dealing with the current
> IRQ in this handler. (And exactly this happened to us on other
> hardware.)

OK thanks for sharing your experience, you convinced me, I am going to
send a new version of the patch with this fix.


>
> But anyway: why let the irq handler be called again if you can avoid
> it?
> You would avoid a double context switch by just checking it again
> in the loop before exiting the handler. And that can be really nice
> for latency-sensitive stuff.


I wanted to avoid an uncached access in each loop if it was not
necessary. But as we finally need it, I will do it.


Gregory



>
> Yours,
> Linus Walleij

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
