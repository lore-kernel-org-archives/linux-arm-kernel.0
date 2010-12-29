From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 29 Dec 2010 14:36:43 -0700
Subject: [PATCH 1/9] spi/pxa2xx: register driver properly
In-Reply-To: <349566.41372.qm@web180301.mail.gq1.yahoo.com>
References: <20101229081120.GN8172@angua.secretlab.ca>
	<349566.41372.qm@web180301.mail.gq1.yahoo.com>
Message-ID: <20101229213642.GA15198@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 29, 2010 at 09:00:36AM -0800, David Brownell wrote:
> 
> 
> > Date: Wednesday, December 29, 2010, 12:11 AM
> > On Thu, Dec 02, 2010 at 06:47:29PM
> > +0100, Sebastian Andrzej Siewior wrote:
> > > use platform_driver_register instead of
> > platform_driver_probe. The
> > > latter only checks available devices at the time of
> > calling. So if a
> > > device gets inserter at a later point in time then the
> > driver will never
> > > play with it.
> 
> 
> I detect an effort to change the classic model for board initialization in Linux:  first set up
> and register all system/platform devices on each
> board then do the same for their drivers.  ("hardware first" ... "software second".
> 
> (Without such a change, there's no need for
>  patches like this (of which I've recently
> seen a few).
> 
> I've not seen discussion about the desirability
> of such a change.

That has never been the Linux device model.  It may be a reasonable
assumption on a large number of boards, but it is definitely not the
model.  In this case, this specific driver now needs to be bound to a
device that is registered in a pci device driver's probe routine.  The
change is completely justified.

Regarding the platform_driver_probe() pattern, I've never liked it
because it short circuits the normal device model behaviour and makes
all drivers that use it a special case.  It does recover a couple of
KB at runtime per driver, which is why I tolerate the existing users,
but doing so is effectively pinching pennies to solve a deficit in the
thousands.  I don't think it is worth it and I will not hesitate to
remove platform_device_probe() from a driver if it is possible that a
device will get registered late.

Instead of doing this per-driver special case thing, I would be far
more interested in a mechanism that allows userspace to trigger
discarding of  __devinit sections for any module at runtime, along
with the associated dropping of .probe() hooks, so that a system could
take advantage of the runtime memory savings on all drivers.

g.
