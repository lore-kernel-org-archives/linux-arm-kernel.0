From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 11 Jun 2014 02:18:44 +0200
Subject: [PATCH 02/24] drivercore: Bind/unbind power domain on probe/remove
In-Reply-To: <53977BC1.5000301@gmail.com>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
 <20140610212731.GA11191@kroah.com> <53977BC1.5000301@gmail.com>
Message-ID: <2753039.YD6R0RpJkS@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 10, 2014 11:42:25 PM Tomasz Figa wrote:
> On 10.06.2014 23:27, Greg Kroah-Hartman wrote:
> > On Tue, Jun 10, 2014 at 11:27:45PM +0200, Rafael J. Wysocki wrote:
> >> On Tuesday, June 10, 2014 02:53:26 PM Ulf Hansson wrote:
> >>> On 10 June 2014 14:11, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>> On Tue, Jun 10, 2014 at 12:51 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>>> From: Tomasz Figa <t.figa@samsung.com>
> >>>>>
> >>>>> On a number of platforms, devices are part of controllable power
> >>>>> domains, which need to be enabled before such devices can be accessed
> >>>>> and may be powered down when the device is idle to save some power.
> >>>>> This means that on systems that support power domain control using
> >>>>> generic power domains subsystem, it is necessary to add device to its
> >>>>> power domain before binding a driver to it and remove it from its power
> >>>>> domain after its driver is unbound to make sure that an unused device
> >>>>> does not affect power domain state.
> >>>>>
> >>>>> Since this is not limited to particular busses and specific
> >>>>> archs/platforms,
> >>>>
> >>>> Actually, this isn't correrct.  It is limited to the platforms that
> >>>> use Device Trees now.
> >>>
> >>> Correct, we should update the commit message/docs.
> >>>
> >>>>
> >>>> Moreover, it is not consistent with the way we add devices to the ACPI PM
> >>>> domain, which is the ACPI counterpart of this.
> >>>
> >>> I am not sure why you think consistency for ACPI is important here.
> >>> ACPI PM will still be able to handle it's domain/device registering as
> >>> before. There are even other pm_domains that don't use genpd which
> >>> need to handle this themselves.
> >>
> >> My point is that doing things like that in different places for different
> >> firmware interfaces is confusing and likely to lead to coding mistakes in
> >> the future.
> >>
> >>> Or are you saying that you prefer bus notifiers in favour of making
> >>> use of the driver core for this matter?
> >>
> >> Well, please grep for acpi_dev_pm_attach() and see where it is done.
> >> Surely not in drivers/base/dd.c.  Also I'm not sure why you're talking
> >> about bus notifiers in this context.
> >>
> >>> Shouldn't the driver core handle most of the common things for a device
> >>> driver?
> >>
> >> Common, yes.  Platform-specific, no.
> >>
> >>> Let's compare how the pinctrls are being managed in the driver core, for
> >>> example.
> >>
> >> pinctrl has Device Trees support only at the moment (as far as firmware
> >> interfaces go) and quite frankly I'm not sure if/how we'll need to change
> >> it to cover ACPI as well.
> >>
> >> But for power domains, please keep that stuff away from dd.c.  That is,
> >> unless Greg specifically disagrees with me and decides to apply this
> >> patch regardless. :-)
> > 
> > Nope, no disagreement from me toward you at all here, keep up the good
> > work :)
> 
> OK, so proposed solution is to put this in:
> 
> - platform_drv_probe(),
> - spi_drv_probe(),
> - i2c_device_probe(),
> - amba_probe(),

Yes.  Specifically, those are bus types that don't do their own power
management.

> ...
> 
> - and any other bus type, which can have devices instantiated from DT.

And doesn't do its own power management, in which case it will need to
incorporate PM domains handling into its code in a more sophisticated way,
most likely.

> If this is what you mean, I still think putting this in dd is cleaner
> and more scalable, but I'm not going to insist, as I believe you have
> good reasons to prefer this approach over current one.

It may look cleaner, but need not be correct.

Rafael
