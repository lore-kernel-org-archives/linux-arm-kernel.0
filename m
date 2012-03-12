From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 12 Mar 2012 11:17:27 -0600
Subject: [PATCH] gpio/mxs: support irqs triggered by both edges
In-Reply-To: <lyhaxt4usz.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <1329745925-7868-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <20120312163503.AEBC73E07B0@localhost>
 <lyhaxt4usz.fsf@ensc-virt.intern.sigma-chemnitz.de>
Message-ID: <CACxGe6uOtgqb1GcBUCDY3L7B5THg1_set0pNcxkzZihr2y9==Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 11:02 AM, Enrico Scholz
<enrico.scholz@sigma-chemnitz.de> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>
>>> iMX28 silicon does not support irqs triggered by both gpio edges. Patch
>>> emulates this behavior by configuring such irqs as level triggered and
>>> by switching polarity in the interrupt handler.
>>
>> That looks dodgy and hacky. ?This will definitely miss interrupts if
>> they come in too fast.
>
> Because patch calculates the trigger from the actual level, there should
> not be missed more interrupts than with native edge-both support.

Edge interrupt controllers latch interrupt requests. so that nothing
gets missed.  Level interrupt controllers do not.  So, if the irq line
toggles 3 times before the handling code gets executed, then the
kernel will still only recognize 1 irq, not 3.

>> I don't like this approach. ?What do you need it for?
>
> some drivers (e.g. gpio-keys, otg gpio-vbus, gpio-charger) are requesting
> gpio based interrupts with IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
> flags. ?It is not possible to use such drivers without having EDGE_BOTH
> support.
>
>
> Enrico



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
