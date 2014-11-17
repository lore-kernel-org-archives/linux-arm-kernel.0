From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 17 Nov 2014 17:12:35 -0500 (EST)
Subject: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
In-Reply-To: <20141117220238.GE5258@dtor-ws>
Message-ID: <Pine.LNX.4.44L0.1411171708010.4838-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Dmitry Torokhov wrote:

> > >  Except buses
> > > usually call pm_generic_runtime_resume() which ends up fetching driver's
> > > callbacks. Maybe pm_generic_runtime_*() need be a bit smarter?
> > 
> > No, the bus subsystem needs to be smarter.  It shouldn't call 
> > pm_generic_runtime_resume() if the driver hasn't been probed yet, or if 
> > the driver has already been unbound from the device.
> 
> But that code wold be exactly the same for all buses, right? So why
> can't pm_generic_runtime_resume() be smarter?

It would not be the same for all buses.  Each bus will have its own way 
of recognizing whether or not a driver has been probed (i.e., by 
checking some field in the bus-specific part of the device structure).

> However, is it allowed to call pm_runtime_get_sync() on devices that
> didn't issue pm_runtime_enable()?

Yes.  But the bus has to issue pm_runtime_enable() before probing the 
driver, because the driver will expect runtime PM to work properly 
while its probe routine runs.  For example, the probe routine might 
want to leave the device in a runtime-suspended state.  It can't do 
that if the device isn't enabled for runtime PM.

Alan Stern
