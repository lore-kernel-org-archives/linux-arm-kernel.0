From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Dec 2015 12:18:44 -0800
Subject: [PATCH v2] ARM: mm: flip priority of CONFIG_DEBUG_RODATA
In-Reply-To: <20151223200132.GW8644@n2100.arm.linux.org.uk>
References: <20151202202725.GA794@www.outflux.net>
 <20151223195129.GP2793@atomide.com>
 <20151223200132.GW8644@n2100.arm.linux.org.uk>
Message-ID: <20151223201843.GQ2793@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [151223 12:01]:
> On Wed, Dec 23, 2015 at 11:51:29AM -0800, Tony Lindgren wrote:
> > Also all omap3 boards are now oopsing in Linux next if PM is enabled:
> 
> I'm not sure that's entirely true.  My LDP3430 works fine with this
> change in place, and that has CONFIG_PM=y.  See my nightly build/boot
> results, which includes an attempt to enter hibernation.  Remember
> that last night's results are from my tree plus arm-soc's for-next.

Right but you don't have any deeper idle states enabled for your
old ldp, see the script below. It may not work properly on your ldp
because of the old silicon revision of the SoC..

> Maybe there's some other change in linux-next which, when combined
> with this change, is provoking it?

Well it seems to be the new default Kconfig options selected by
default as Geert is saying?

And it seems to require off mode enabled for idle to hit it, retention
idle does not seem to trigger it.

Regards,

Tony


8< -------------------------
#!/bin/bash

uarts=$(find /sys/class/tty/tty[SO]*/device/power/ -type d)
for uart in $uarts; do
	echo 3000 > $uart/autosuspend_delay_ms 2>&1
done

uarts=$(find /sys/class/tty/tty[SO]*/power/ -type d 2>/dev/null)
for uart in $uarts; do
	echo enabled > $uart/wakeup 2>&1
	echo auto > $uart/control 2>&1
done

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode
