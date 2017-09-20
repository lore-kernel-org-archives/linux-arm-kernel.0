From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 20 Sep 2017 11:16:25 -0600
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170920165141.GP20805@n2100.armlinux.org.uk>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
Message-ID: <20170920171625.GB5249@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 05:51:41PM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 20, 2017 at 10:22:08AM -0600, Jason Gunthorpe wrote:
> > On Wed, Sep 20, 2017 at 12:21:52PM +0100, Russell King - ARM Linux wrote:
> > 
> > > However, assumptions are made about the RTC:
> > > 
> > > 1. kernel/time/ntp.c assumes that all RTCs want to be told to set the
> > >    time at around 500ms into the second.
> > > 
> > > 2. drivers/rtc/systohc.c assumes that if the time being set is >= 500ms,
> > >    then we want to set the _next_ second.
> > 
> > I looked at these issues when I did the sys to HC patches and I
> > concluced the first problem was that the RTC read functions generally
> > did not return sub second resolution, either in sense of directly
> > returning ts_nsec, or the sense of delaying the read until a clock
> > tick over event.
> 
> The boot time problem can be resolved by using hwclock to set the
> system time in userspace - there are distros that do exactly that.
> For example, debian has a udev rule:

Okay, that part I didn't know, thanks.

> > I think patch wise, this is something I would rather see handled
> > internally via the drivers and perhaps with input from DT, not via
> > sysctl knobs.
> 
> I sort-of agree as far as the time offset information goes, but there's
> a complication that we only open the RTC to set the time at the point in
> time that we want to set it - while the RTC is closed, the RTC driver
> module could be removed and replaced by a different RTC driver which
> replaces the existing device.

Yes, the ntp code would have to open the rtc initially and record the
offset. Each time it goes to write it would have to check the offset
it got against what the device wants and, if necessary, reschedule
the update if the ts_nsec is not correct. That should handle
infrequent dynamic changes..

> So, we _do_ need a knob to turn that kernel timekeeping facility on and
> off in addition to the "are we NTP sync'd" status.

Sure, that makes sense as a sysctl

> > The HW driver should know how to read and write with sub second
> > resolution. If it works best with a certain value in the ts_nsec
> > field, then it should set something inside rtc_chip that causes the
> > systohc code to try and call it with that tv_nsec.
> 
> The problem is deeper than the systohc.c code - the timing of the call
> made into the systohc.c code is decided by kernel/time/ntp.c, and
> currently is within a tick of 500ms past the second.

Right, I was thinking about the entire systohc process, including the
part in ntp.c

> Do we have any sub-second aware drivers?  None of my RTCs are, and I
> don't think it's fair for RTC drivers to sleep when getting a request
> to set the time.

I would call any RTC that can change the phase of the seconds clock as
sub-second capable. Currently, I think that only the CMOS driver is
really a sub-second aware driver, and the rest of the RTC stack has been
sort of hardcoded around what it does..

My thinking was adding a new sub-second entry point would let us keep
the existing assumptions above while having a cleaner entry point that
allows fixing the RTC drivers gradually. Eg you have tested PCF, so it
could use the subsecond entry and define the proper ts_nsec value/etc.

> The userspace API doesn't do that, and the workqueue involved in
> setting NTP time is probably run using shared system_power_efficient_wq
> resources, so blocking there will be detrimental to other works queued
> on that.

I think the NTP path should be non blocking, and rely on the ntp.c
code calling into the driver with the desired tv_nsec.

However, it also makes sense to provide a blocking sub-second user
space API that would have the required sleep to make setting the time
work properly. This way we can hide the desired tv_nsec implementation
detail from userspace completely.

eg I assume hwclock also has the built in 0.5s assumption when trying
to write to the RTC?

The same would be true for read, I think it would be cleaner to have a
kernel uapi that reads the time with subsecond accuracy than to have
hwclock implement a spinning loop in userspace. That gives drivers
more options in how they measure the second tick over. The common code
would just provide a simple loop like we see in hwclock.

Jason
