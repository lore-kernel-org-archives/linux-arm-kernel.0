From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Mon, 12 Mar 2012 18:38:53 +0100
Subject: [PATCH] gpio/mxs: support irqs triggered by both edges
In-Reply-To: <CACxGe6uOtgqb1GcBUCDY3L7B5THg1_set0pNcxkzZihr2y9==Q@mail.gmail.com>
 (Grant Likely's message of "Mon, 12 Mar 2012 11:17:27 -0600")
References: <1329745925-7868-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <20120312163503.AEBC73E07B0@localhost>
 <lyhaxt4usz.fsf@ensc-virt.intern.sigma-chemnitz.de>
 <CACxGe6uOtgqb1GcBUCDY3L7B5THg1_set0pNcxkzZihr2y9==Q@mail.gmail.com>
Message-ID: <lyd38h4t3m.fsf@ensc-virt.intern.sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

>>>> iMX28 silicon does not support irqs triggered by both gpio edges. Patch
>>>> emulates this behavior by configuring such irqs as level triggered and
>>>> by switching polarity in the interrupt handler.
>>>
>>> That looks dodgy and hacky. ?This will definitely miss interrupts if
>>> they come in too fast.
>>
>> Because patch calculates the trigger from the actual level, there should
>> not be missed more interrupts than with native edge-both support.
>
> Edge interrupt controllers latch interrupt requests. so that nothing
> gets missed.  Level interrupt controllers do not.

iMX28 hardware sets interrupt status only but never clears it[1]. E.g. when
the requested level has been seen, the interrupt is pending until software
clears it.  It does not matter whether level changes back or stays asserted.


> So, if the irq line toggles 3 times before the handling code gets
> executed, then the kernel will still only recognize 1 irq, not 3.

There is no difference to edge triggered interrupts. When the trigger
events happen too fast, not all of them can be handled. But both for
edge and for level triggered interrupts, the interrupt handler will be
executed at least once.



Enrico

Footnotes: 
[1]  see figure "Figure 9-5. GPIO Interrupt Generation", page 688 in
     "i.MX28 Applications Processor Reference Manual, Rev. 1, 2010"
