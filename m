From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 09 Dec 2013 15:17:04 +0100
Subject: questions of cpuidle
In-Reply-To: <52A5C846.30308@linaro.org>
References: <52A5C846.30308@linaro.org>
Message-ID: <52A5D0E0.7050201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 02:40 PM, Alex Shi wrote:
>
> Sorry for a idiot of cpuidle.
>
> I just find few cpu set TIMER_STOP on cpuidle, like omap4 and big.Little
> driver. Does that mean other ARM cpu or x86 cpu can get the timer
> interrupt in cpuidle?
>
> If the timer stopped during cpuidle, does that means at least one cpu
> cann't get into deep c-state since system need a cpu to wake up other
> deep c-state cpu? Or sth I missed?
>
> If the cpu stopped the interrupt during deep c-state and without
> monitor/mwait support, which kind of ipi can wake the cpu? I mean like a
> x86 cpu, APIC stopped in c3 mode, but actually ipi send via apic bus. So
> I don't know which ipi work?

Hi Alex,

there are several timers on the system, the local and the external. On 
ARM we find the local timers twd. Depending on the depth of the idle 
state, they can be shutdown.

All the cpus can go to a deep idle state because the timer expiration 
will be delegated to a timer which does not belong to the power domain 
of the idle state.

The idle state contains the flag TIMER_STOP when the idle state power 
downs the local timer.

The cpuidle common framework checks this flag when entering the idle 
state and calls clock_events_notify(ENTER/EXIT). That tells the time 
framework to switch to another timer on the system in replacement of the 
local one.

The external timer will be programmed to the next event and will store 
the cpu which is concerned by this expiration. This timer is called the 
broadcast timer.

When the broadcast timer expires there are two cases:

* if the timer has the CLOCK_EVT_FEAT_DYNIRQ set, when the time 
framework switched to this timer as described above, it also set the irq 
affinity to the cpu. So no IPI happens because the interrupt occurs 
directly to the targeted cpu

* if the timer has *no* CLOCK_EVT_FEAT_DYNIRQ set, then the interrupt 
will occur to any cpus belonging to the cpumask (usually cpu0), and if 
the timer must expires for another cpu then an IPI is emitted to the 
cpu. The IPI is the IPI_TIMER.

Concerning the wake up of the cpu: the cpu disabled the irq and goes to 
sleep, it is up to the firmware to wake up the cpu when an interrupt 
occurs. It will exits its sleep state, call clock_events_notify(EXIT), 
by this way re-switching to the local timer, and then re-enabling the 
local interrupt which leads to the interrupt handler.

There are some more informations in the wiki page [1].

   -- Daniel

[1] https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/WakeUpSources

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
