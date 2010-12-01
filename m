From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Wed, 1 Dec 2010 22:38:01 +0200
Subject: Fwd: AT91 Interrupt nesting/priority disabled since kernel 2.6.35
In-Reply-To: <AANLkTi=YV2-P-7OKPHPwQo7mBM0OL=E3QwPKnWH=rpmq@mail.gmail.com>
References: <AANLkTi=YV2-P-7OKPHPwQo7mBM0OL=E3QwPKnWH=rpmq@mail.gmail.com>
Message-ID: <AANLkTi=oFGbb=QmK_P138kP10vZ2TS_-Ly5wwnGZkKGC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---------- Forwarded message ----------
From: Itai Levi <itai.levi.devel@gmail.com>
Date: Wed, Dec 1, 2010 at 9:57 PM
Subject: AT91 Interrupt nesting/priority disabled since kernel 2.6.35
To: Andrew Victor <avictor.za@gmail.com>, linux at maxim.org.za


Hello Andrew,

mach-at91 makes use of interrupt priority and nesting, which can be
set via a call to at91samXXXX_init_interrupts(). This utilises the
processor's internal IRQ priority mechanism.
This worked fine up to kernel 2.6.34.x, but not since kernel 2.6.35
Kernel 2.6.35 introduced a patch (here) (the diff) that disables all
IRQs while handling interrupts. This is done by removing the lines
that re-enabled them. As a result, no other interrupt can nest into
the current interrupt. This makes all ARM interrupt priorities
(related to nesting) completely ineffective.
I can add at this point, that as far as I checked, mach-at91 is the
only ARM mach that uses the processor's interrupt priorities (others
like OMAP or IXP do not).

There is a discussion of this patch here.

I can think of some ways to deal with this problem:

Give up interrupt priorities as others do + remove the priority code
from arm/mach-at91/...
As Ingo Molnar suggests, re-enable interrupts inside the all the at91
IRQ handlers (drivers etc.), thus preserving the old behaviour. But
now we have to remember to do this for every new driver...
Use threaded-interrupts (handler run as thread) and make use of thread
priorities. Again - change all existing at91 drivers (also, setting
interrupt-thread priority is not supported yet).
Convince the commiters to re-enable the interrupts as before 2.6.35

What do you think?
Maybe you can forward this mail to others. I don't know who should be
addressed in this matter.

Thank's a lot,
Itai.
