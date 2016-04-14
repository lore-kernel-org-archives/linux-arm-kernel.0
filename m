From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 14 Apr 2016 14:17:45 -0700
Subject: [PATCH v7 1/2] drivers: base: add support for registering
 notifier about deferred probe
In-Reply-To: <570F4886.20203@samsung.com>
References: <1460540160-18762-1-git-send-email-m.szyprowski@samsung.com>
 <1460540160-18762-2-git-send-email-m.szyprowski@samsung.com>
 <20160413141254.GB12749@kroah.com> <570F4886.20203@samsung.com>
Message-ID: <20160414211745.GA27692@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 09:36:38AM +0200, Marek Szyprowski wrote:
> Hello,
> 
> On 2016-04-13 16:12, Greg Kroah-Hartman wrote:
> > On Wed, Apr 13, 2016 at 11:35:59AM +0200, Marek Szyprowski wrote:
> > > This patch adds code which allow other subsystems get a notification
> > > when deferred probe has been triggered. This way one can retry some
> > > actions, which earlier failed with -EPROBE_DEFER error code.
> > > 
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Why would some other subsystem want/care about this?  You aren't telling
> > them what device was deferred, and you don't need to as the bus itself
> > already knows this information as it did the deferring!
> > 
> > confused,
> 
> This notifier is just to let others that the deferred probe has happened and
> it is a good time to retry operation, which earlier failed due to missing
> resources (i.e. power domains, clocks). Such case is with registering AMBA
> device (not the driver!). During AMBA device registration, bus code has to
> read
> some device's registers to get its device CID/PID. To do this, device's
> clocks
> and power domain has to be turned on. Those however might not be available
> that time. With this notifier, AMBA bus code is able to retry device
> registration, which earlier failed due to missing clocks or power domain.

Ick, no, notifiers are horrid, all you are getting is that "someone"
deferred, which makes no sense.

You know, in your bus, when you deferr a driver probe.  So do the work
then.  Don't rely on a random "signal" from a random device at a random
point in time to potentially do some sort of work.  That's looney.

> This CID/PID reading has to be done during device registration time because
> of the already deployed userspace ABI. CID/PID values are reported to
> userspace, which might rely on them to load proper driver modules.

As Russell said, it is "must", not "might", and has been that way for
over a decade, this isn't anything new.

thanks,

greg k-h
