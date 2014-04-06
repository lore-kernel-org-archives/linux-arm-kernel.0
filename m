From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 Apr 2014 15:12:58 +0100
Subject: leds-pwm - does anyone care for it?
Message-ID: <20140406141257.GR7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So during the last three months, I've sent a patch twice for leds-pwm,
and both times it's been completely ignored.

Today, I find that OMAP4430 SDP fails to boot due to an oops caused by
this driver in the workqueue code - it frees structures which contain
queued workqueues if we're booting with DT and it can't find the PWM
device.

If I look closer at this driver, I find that it doesn't of_node_put()
the OF node in the case of devm_of_pwm_get() failure... I'm sure these
aren't the only problems.

Then there's the three entirely separately coded cleanup paths - the
removal function, the cleanup for failure in the OF code, and the
cleanup for failure in the non-OF case.  This is where the oops stems
from because the author of the patch adding the work queue only fixed
up two of these sites - the ones which applied to his case and never
bothered with the third.

I'm going to fix this latest failure in the driver, and send a patch
later today, and I will hope for a timely response.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
