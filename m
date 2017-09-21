From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Sep 2017 13:28:53 +0100
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170920224522.GB20974@obsidianresearch.com>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
 <20170920224522.GB20974@obsidianresearch.com>
Message-ID: <20170921122852.GX20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 04:45:22PM -0600, Jason Gunthorpe wrote:
> What do you think of this untested approach in the below patch?

There's another issue.

Most drivers use rtc_device_register() or devm_rtc_device_register()
rather than rtc_allocate_device() (which is static.)  This does not
give RTC drivers a chance to set rtc->time_set_nsec before the
RTC is registered with the kernel.

Setting it after the device has been registered is racy.  So, having
this member in struct rtc_device and assuming that drivers will override
the value doesn't work.

It doesn't make sense to put it in rtc_class_ops as it isn't an
operation, but we could add a callback in there which is used during
initialisation but before registration which could be used to set this
member.

Thoughts?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
