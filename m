From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 18 Nov 2014 01:26:38 +0100
Subject: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
In-Reply-To: <20141117232604.GB2049@dtor-ws>
References: <20141117220238.GE5258@dtor-ws>
 <9731926.0Og5ZNPBtE@vostro.rjw.lan> <20141117232604.GB2049@dtor-ws>
Message-ID: <3008804.zFmDfsDlAH@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 17, 2014 03:26:04 PM Dmitry Torokhov wrote:
> On Tue, Nov 18, 2014 at 12:28:26AM +0100, Rafael J. Wysocki wrote:
> > On Monday, November 17, 2014 02:17:00 PM Dmitry Torokhov wrote:
> > > On Mon, Nov 17, 2014 at 05:12:35PM -0500, Alan Stern wrote:
> > > > On Mon, 17 Nov 2014, Dmitry Torokhov wrote:
> > > > 
> > > > > > >  Except buses
> > > > > > > usually call pm_generic_runtime_resume() which ends up fetching driver's
> > > > > > > callbacks. Maybe pm_generic_runtime_*() need be a bit smarter?
> > > > > > 
> > > > > > No, the bus subsystem needs to be smarter.  It shouldn't call 
> > > > > > pm_generic_runtime_resume() if the driver hasn't been probed yet, or if 
> > > > > > the driver has already been unbound from the device.
> > > > > 
> > > > > But that code wold be exactly the same for all buses, right? So why
> > > > > can't pm_generic_runtime_resume() be smarter?
> > > > 
> > > > It would not be the same for all buses.  Each bus will have its own way 
> > > > of recognizing whether or not a driver has been probed (i.e., by 
> > > > checking some field in the bus-specific part of the device structure).
> > > > 
> > > > > However, is it allowed to call pm_runtime_get_sync() on devices that
> > > > > didn't issue pm_runtime_enable()?
> > > > 
> > > > Yes.  But the bus has to issue pm_runtime_enable() before probing the 
> > > > driver, because the driver will expect runtime PM to work properly 
> > > > while its probe routine runs.  For example, the probe routine might 
> > > > want to leave the device in a runtime-suspended state.  It can't do 
> > > > that if the device isn't enabled for runtime PM.
> > > 
> > > That means that runtime PM will be enabled for all devices on given bus
> > > while up till now drivers were deciding if their devices should be
> > > runtime-pm-managed or not.
> > 
> > That's not the case for PCI drivers.
> > 
> > > I do not think we are quite ready for this.
> > 
> > We have to do that if power domains are in use, however, because if at least
> > one device in a power domain in enabled for runtime PM, that will affect the
> > other devices in that domain.
> > 
> > We could make a rule to keep a domail always up if at least one device in it
> > has runtime PM disabled, but that is equivalent to enabling runtime PM for
> > that device, powering the domain up and bumping up the device's usage counter.
> 
> What will driver will see if it tries to check pm_runtime_active()?
> Would not it get unexpected result if the driver did not call
> pm_runtime_enable() on it's device?

Well, that part was supposed to depend on the bus type.  For example, it
won't be unexpected for PCI drivers, because runtime PM is always enabled
for PCI devices (although it may be blocked as I described).

A problem arises if a power domain is used along with a bus type that doesn't
enable runtime PM for devices by default and drivers are expected to do that.
That could be addressed by powering up a PM domain (and bumping up its usage
counter) when adding a device to it and keeping it up until all of the devices
in it are runtime suspended, but then it also should be turned off eventually
if there are no drivers for any of those devices.

Rafael
