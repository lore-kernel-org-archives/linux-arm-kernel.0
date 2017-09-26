From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 26 Sep 2017 13:58:56 +0200
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170921122852.GX20805@n2100.armlinux.org.uk>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
 <20170920224522.GB20974@obsidianresearch.com>
 <20170921122852.GX20805@n2100.armlinux.org.uk>
Message-ID: <20170926115856.x3mswsn7noewtbb2@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/2017 at 13:28:53 +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 20, 2017 at 04:45:22PM -0600, Jason Gunthorpe wrote:
> > What do you think of this untested approach in the below patch?
> 
> There's another issue.
> 
> Most drivers use rtc_device_register() or devm_rtc_device_register()
> rather than rtc_allocate_device() (which is static.)  This does not

It is static on purpose, drivers must use devm_rtc_allocate_device()
if they need to allocate the rtc before registering it. I'm in the
process of converting most drivers, including rtc_cmos as this solve
other race issues.

> give RTC drivers a chance to set rtc->time_set_nsec before the
> RTC is registered with the kernel.
> 
> Setting it after the device has been registered is racy.  So, having
> this member in struct rtc_device and assuming that drivers will override
> the value doesn't work.
> 
> It doesn't make sense to put it in rtc_class_ops as it isn't an
> operation, but we could add a callback in there which is used during
> initialisation but before registration which could be used to set this
> member.
> 

I'd prefer having drivers that need to set the value to something other
than 0 to convert to devm_rtc_allocate_device.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
