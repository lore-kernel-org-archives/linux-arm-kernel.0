From: robherring2@gmail.com (Rob Herring)
Date: Fri, 08 Feb 2013 11:09:02 -0600
Subject: sp804 DT initialization
Message-ID: <5115312E.1040307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm trying to move the sp804 timer init to DT based init using
CLKSRC_OF. The challenge is how do we match each timer to be used as
clksrc, clkevt, or sched_clock. Ideally we would have h/w based
properties of the timers such that we could select which one to use just
based on properties. I'm trying to avoid the use of aliases or linux
specific properties. OMAP timers are an example of describing the h/w
properties of timers to drive their selection.

sched_clock selection - What's the reason to use the 24MHz counter vs.
the sp804 on the ARM boards? Is it purely based on the higher frequency
and having more accuracy? Would this be universally true? We could make
setup_sched_clock replace it's current counter with a new one if the new
one is higher frequency.

sp804 selection - The versatile and realview boards use timer 0 for
clkevt and timer 3 for clksrc. AFAICT searching thru kernel and mail
list history, timer 0 was always used and timer 3 use is arbitrary when
clksrc support was added by Kevin. Timer 1 could be used as the clksrc,
or timer 2 and 3 could be used. Some platforms like highbank don't have
an interrupt for the 2nd timer, so that would have to be accounted for
in the selection process. Bottom line is it should not matter which ones
get used by the kernel, right?

As a side note, the integrator board does not have sp804 timers. They
are the same programming model, but they are not the sp804 dual timer.
Therefore, they should have a different compatible property and can be
handled separately for initialization.

Rob
