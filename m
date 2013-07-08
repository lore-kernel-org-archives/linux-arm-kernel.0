From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Jul 2013 11:36:21 -0600
Subject: CPU hotplug issue w/ 0647065 clocksource: Add generic dummy timer
 driver
Message-ID: <51DAF895.1020700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU hotplug (replug) on Tegra HW seems to be occasionally broken due to
commit 0647065 "clocksource: Add generic dummy timer driver" in
linux-next. Reverting that commit solves the issue.

The symptom is that ~10% of the time, when re-plugging CPU1 (in a 2-core
system, after unplugging it about 1 second before), I'll see the
following WARN trigger in clockevents_program_event():

> int clockevents_program_event(struct clock_event_device *dev, ktime_t expires,
> 			      bool force)
> {
> 	unsigned long long clc;
> 	int64_t delta;
> 	int rc;
> 
> 	if (unlikely(expires.tv64 < 0)) {
> 		WARN_ON_ONCE(1);
> 		return -ETIME;
> 	}

This appears to be because in tick_handle_periodic_broadcast(),
dev->next_event == KTIME_MAX. The system then hangs; I think that loop
just keeps adding tick_period onto next_event, which doesn't manage to
get to an acceptable value for a long time, if ever!

Do you have any idea why this could happen? I assume that during
switching between the dummy timer added by that patch, and the real
Tegra timer (drivers/clocksource/tegra20_timer.c) the Tegra timer's
dev->next_event is temporarily set to KTIME_MAX, but somehow the timer
IRQ handling goes off while the device is in this temporary state? The
timer core seems to take steps to prevent this though, i.e. callilng
spin_lock_irqsave() in places.

If I modify tick_handle_periodic_broadcast() to check for a negative
dev->next_event and simply return in that case, the system seems to work
fine, and I do see tick_handle_periodic_broadcast() being called at a
later time, so obviously something is coming along later and programming
the HW to generate additional events. On this HW, I believe struct
clock_event_device.set_next_event is being used to emulate the periodic
broadcast using a one-shot timer, rather than using the HW's native
periodic capability, probably due to CONFIG_NO_HZ.

Any hints greatly appreciated!
