From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 20 Sep 2017 10:22:08 -0600
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170920112152.GL20805@n2100.armlinux.org.uk>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
Message-ID: <20170920162208.GB536@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 12:21:52PM +0100, Russell King - ARM Linux wrote:

> However, assumptions are made about the RTC:
> 
> 1. kernel/time/ntp.c assumes that all RTCs want to be told to set the
>    time at around 500ms into the second.
> 
> 2. drivers/rtc/systohc.c assumes that if the time being set is >= 500ms,
>    then we want to set the _next_ second.

I looked at these issues when I did the sys to HC patches and I
concluced the first problem was that the RTC read functions generally
did not return sub second resolution, either in sense of directly
returning ts_nsec, or the sense of delaying the read until a clock
tick over event.

Eg if I repeatedly booted my various embedded ARM/PPC systems, and
recorded the time offset from NTP, I got a fairly random distribution
of offsets.

Given that we couldn't seem to read back sub second resolution on my
systems, storing it more accurately did not seem important.

I think we also did some experiments with a few of the RTCs we were
using and some of them did not adjust the seconds clock phase on
write, so they seemed incapable of storing sub second data anyhow.

So.. My feeling was that we'd need driver support in each RTC driver
to enable sub section resolution.

Do you know differently?

Our pragmatic solution in our products was to have the initial time
sync from NTP step the clock even if the offset is small.

> So, the question is... how should these differences in rtc requirements
> be handled?

I think patch wise, this is something I would rather see handled
internally via the drivers and perhaps with input from DT, not via
sysctl knobs.

The HW driver should know how to read and write with sub second
resolution. If it works best with a certain value in the ts_nsec
field, then it should set something inside rtc_chip that causes the
systohc code to try and call it with that tv_nsec.

It would probably also make sense to add new ntp ops for sub second
get/set that includes the full timespec. This way the RTC driver can
provide the right adjustments and we can get rid of the +1 in
rtc_set_ntp_time and the +0.5 in rtc_hctosys for sub sec aware
drivers..

Jason
