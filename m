From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Apr 2016 22:33:22 +0100
Subject: [PATCH v7 1/2] drivers: base: add support for registering
 notifier about deferred probe
In-Reply-To: <20160414211745.GA27692@kroah.com>
References: <1460540160-18762-1-git-send-email-m.szyprowski@samsung.com>
 <1460540160-18762-2-git-send-email-m.szyprowski@samsung.com>
 <20160413141254.GB12749@kroah.com> <570F4886.20203@samsung.com>
 <20160414211745.GA27692@kroah.com>
Message-ID: <20160414213322.GW19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 02:17:45PM -0700, Greg Kroah-Hartman wrote:
> On Thu, Apr 14, 2016 at 09:36:38AM +0200, Marek Szyprowski wrote:
> > Hello,
> > 
> > On 2016-04-13 16:12, Greg Kroah-Hartman wrote:
> > > On Wed, Apr 13, 2016 at 11:35:59AM +0200, Marek Szyprowski wrote:
> > > > This patch adds code which allow other subsystems get a notification
> > > > when deferred probe has been triggered. This way one can retry some
> > > > actions, which earlier failed with -EPROBE_DEFER error code.
> > > > 
> > > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Why would some other subsystem want/care about this?  You aren't telling
> > > them what device was deferred, and you don't need to as the bus itself
> > > already knows this information as it did the deferring!
> > > 
> > > confused,
> > 
> > This notifier is just to let others that the deferred probe has happened and
> > it is a good time to retry operation, which earlier failed due to missing
> > resources (i.e. power domains, clocks). Such case is with registering AMBA
> > device (not the driver!). During AMBA device registration, bus code has to
> > read
> > some device's registers to get its device CID/PID. To do this, device's
> > clocks
> > and power domain has to be turned on. Those however might not be available
> > that time. With this notifier, AMBA bus code is able to retry device
> > registration, which earlier failed due to missing clocks or power domain.
> 
> Ick, no, notifiers are horrid, all you are getting is that "someone"
> deferred, which makes no sense.
> 
> You know, in your bus, when you deferr a driver probe.  So do the work
> then.

You're not understanding the problem.  The problem is not at driver probe
time, the problem is at device instantiation time, which is way earlier.

We need to power up the device and enable clocks in order to read the
device's vendor and part number, which is what identifies it to the
driver.  This is also used by userspace to work out which driver module
to load.

So, we need this information to be present when the device is registered.
It's just like the PCI vendor and device IDs - in PCI, these must be
readable when the device is instantiated.

The problem that's being addressed here is that there's no way at the
moment to know when the drivers on a different bus (namely the platform
bus) have probed and are providing the clock and power domain resources
necessary to be able to read these identifying values.

I guess if you don't like a notifier, the other alternative is to
setup a delayed workqueue and have the workqueue repeatedly attempt
to register the devices until they all succeed.  That's not
particularly nice, because we'd be wasting CPU cycles running
that workqueue for no reason until all the devices get registered.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
