From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 07 Sep 2016 01:57:11 +0200
Subject: [PATCH v2 02/10] driver core: Functional dependencies tracking
 support
In-Reply-To: <20160728152831.GA1929@wunner.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
 <2841548.NIYVpJFBcH@vostro.rjw.lan> <20160728152831.GA1929@wunner.de>
Message-ID: <1546158.G8Vnv1pldV@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 28, 2016 05:28:31 PM Lukas Wunner wrote:
> On Thu, Jul 28, 2016 at 02:30:31AM +0200, Rafael J. Wysocki wrote:
> > On Monday, July 25, 2016 12:48:32 AM Lukas Wunner wrote:
> > > On Thu, Jul 21, 2016 at 02:25:15AM +0200, Rafael J. Wysocki wrote:
> > > > On Thursday, July 21, 2016 01:25:53 AM Lukas Wunner wrote:
> > > > > I guess I could amend portdrv to return -EPROBE_DEFER on Macs if
> > > > > no driver is bound to the NHI. Doesn't feel pretty to me though.
> > > > > 
> > > > > Ultimately this seems to be the same issue as with calling
> > > > > dev_pm_domain_set() for a bound device. Perhaps device_link_add()
> > > > > can likewise be allowed if a runtime PM ref is held for the devices
> > > > > and the call happens under lock_system_sleep()?
> > > > 
> > > > No, the whole synchronization scheme in the links code would have had to be
> > > > changed for that to really work.
> > > > 
> > > > And it really is about what is needed (at least in principle) to run your
> > > > device.  If you think you need device X with a driver to handle device Y
> > > > correctly, then either you need it all the time, from probe to remove, or
> > > > you just don't really need it at all.
> > > 
> > > Real life isn't as simple as that.
> > > 
> > > In this case, we have consumers (hotplug ports) which are doing fine
> > > if the driver for the supplier (NHI) is not loaded. But once it loads,
> > > the links must be in place.
> > 
> > Hmm.
> > 
> > What if it is not loaded and the system suspends.  Will everything work
> > as expected after the subsequent resume?
> 
> The short answer is yes.

OK

I think it's possible to add a link flag to address this case.

Namely, if that flag is passed to device_link_add(), the link will be
added in the DEVICE_LINK_ACTIVE state right away, but that will need to
be synchronized against all possible transitions of the consumer device
(at least).

It's better to do that in a separate patch for this reason IMO.

Thanks,
Rafael
