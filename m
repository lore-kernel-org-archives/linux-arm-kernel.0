From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Oct 2011 12:48:11 +0100
Subject: [PATCH 0/4] ARM: EXYNOS4: Support generic Power domain
	framework for EXYNOS4210
In-Reply-To: <201110021347.02146.rjw@sisk.pl>
References: <4E4360B2.2060508@samsung.com> <201108140139.46434.rjw@sisk.pl>
	<001701cc80d2$02ee4940$08cadbc0$%kim@samsung.com>
	<201110021347.02146.rjw@sisk.pl>
Message-ID: <20111002114811.GU11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 01:47:01PM +0200, Rafael J. Wysocki wrote:
> On Sunday, October 02, 2011, Kukjin Kim wrote:
> > Hmm... Even though each driver cannot know the given situation, the driver
> > can know each own clock should be alive or not. I think, if clock gating
> > (enable, disable clock) is required, it should be handled in each driver. In
> > addition, the clock and power are not always one-on-one match.
> 
> If the driver is to be portable and there's no guarantee that the
> clocks configuration on all systems it's supposed to be working with will
> always be the same, the driver shouldn't handle clocks directly.

How do these misconceptions start?

The clock API.  Drivers are supposed to get a clock (source) when they
initialize.  Drivers then enable and disable the clock as they _themselves_
require the use of that clock.

The clock enable is counted such that if there is at least one user of
the clock, it will be enabled.  It is not a forced 'off' when disable is
called - the number of enable calls must be balanced by the same number
of disable calls for the clock itself to be disabled.

Drivers are _expected_ to do this themselves.  Or the runtime PM stuff
if that's what they're doing.
