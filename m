From: shiraz.linux.kernel@gmail.com (shiraz hashim)
Date: Thu, 3 May 2012 16:45:06 +0530
Subject: smp_twd fix for adapting to cpu frequency change
Message-ID: <CAPub14_+XXjKyZVh3E8QQjY4sB4gVB=kaApuODptoizqfEUH_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

In your following patch,

    commit 4fd7f9b128107034fa925b6877fae3c275f0da86
    Author: Linus Walleij <linus.walleij@linaro.org>
    Date:   Tue Dec 13 12:48:18 2011 +0100

        ARM: 7212/1: smp_twd: reconfigure clockevents after cpufreq change

        This break-out from Colin Cross' cpufreq-aware TWD patch
        will handle the case when our localtimer's clock changes with
        the cpu clock. A cpufreq transtion notifier will be registered
        only if the platform has supplied a specified clock to the TWD.

        After a cpufreq transition, update the clockevent's frequency
        by fetching the new clock rate from the clock framework and
        reprogram the next clock event.

        The necessary changes in the clockevents framework was done by
        Thomas Gleixner in kernel v3.0.


When we handle twd_cpufreq_transition and reprogram the clock event,
the TWD_TIMER_LOAD register still contains the old load value
for CLOCK_EVT_MODE_PERIODIC case.

This results in wrong number of events generated per second.

Shouldn't we reprogram the TWD_TIMER_LOAD register to new
twd_timer_rate / HZ on frequency change as well ?

-- 
regards
Shiraz Hashim
