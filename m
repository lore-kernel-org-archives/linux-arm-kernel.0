From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jun 2011 14:04:06 +0100
Subject: [PATCHv2 0/3] clocksource: add db8500 PRCMU timer
In-Reply-To: <4DE788B2.5060308@ti.com>
References: <1307007271-1004-1-git-send-email-mattias.wallin@stericsson.com>
	<20110602094622.GS3660@n2100.arm.linux.org.uk>
	<4DE7637B.3060901@stericsson.com>
	<20110602110137.GU3660@n2100.arm.linux.org.uk>
	<4DE77D9A.6090301@stericsson.com> <4DE788B2.5060308@ti.com>
Message-ID: <20110602130406.GW3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 06:27:22PM +0530, Santosh Shilimkar wrote:
> Earlier this year at ELC SFO, I had a discussion with
> John and Thomas on how to have a high-resolution clock-source
> and a low-resolution clock-source working together to cover
> the low power scenario and still manage to get the highest
> timer resolution.
> The idea was to do dynamic switching of clock-source
> which initially looked simple. Here the idea was to
> have this working for suspend and as well as cupidle.

I don't think you can do this, because you'll lose precision whenever you
switch from the high resolution clocksource to the low resolution
clocksource.

While you can quickly update the current time of day from the highres one,
the lowres may or may not be a long way from its next tick rollover.  So
you lose the precision whenever you switch.

However, over a suspend/resume cycle, the precision loss is normally very
small compared to the time which you have been suspended, so the %age
error also becomes very small.

With cpuidle, it becomes a completely different matter.  Here, the %age
error is much larger because of the smaller sleep periods, and chances
are we can't wait for the low-res timer to change.

So if you're using cpuidle, you really need a clocksource which runs
continuously, even in whatever states cpuidle drops you into.
