From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 18 Nov 2014 23:10:18 +0100
Subject: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
In-Reply-To: <1824493.p8QbHUZx3Z@vostro.rjw.lan>
References: <20141118171831.GC3003@dtor-ws> <20141118210229.GI3003@dtor-ws>
 <1824493.p8QbHUZx3Z@vostro.rjw.lan>
Message-ID: <2146731.F0GMumVzg0@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 18, 2014 10:58:17 PM Rafael J. Wysocki wrote:
> On Tuesday, November 18, 2014 01:02:29 PM Dmitry Torokhov wrote:
> > On Tue, Nov 18, 2014 at 10:17:46PM +0100, Rafael J. Wysocki wrote:
> > > On Tuesday, November 18, 2014 10:03:18 PM Rafael J. Wysocki wrote:
> > > > On Tuesday, November 18, 2014 12:04:38 PM Dmitry Torokhov wrote:
> > > > > On Tue, Nov 18, 2014 at 09:14:56PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Tuesday, November 18, 2014 09:55:15 AM Dmitry Torokhov wrote:
> > > > > > > On Tue, Nov 18, 2014 at 12:44:22PM -0500, Alan Stern wrote:
> > > > > > > > On Tue, 18 Nov 2014, Dmitry Torokhov wrote:
> > > > > > > > 
> > > > > > > > > OK. Another question then: pm_runtime_get_noresume() does literally this:
> > > > > > > > > 
> > > > > > > > > 	atomic_inc(&dev->power.usage_count);
> > > > > > > > > 
> > > > > > > > > So who is responsible for actually waking up parent device and/or power
> > > > > > > > > domain? Is it simply missing because we did not really have PM domains
> > > > > > > > > before?
> > > > > > > > 
> > > > > > > > Ths bus is responsible for making sure that all the standard resources
> > > > > > > > are available -- that is, all the resources that would be needed by a
> > > > > > > > normal device on that bus.  Anything beyond that (such as
> > > > > > > > special-purpose clocks) has to be set up by the driver.
> > > > > > > > 
> > > > > > > > Thus the bus would insure that the device was powered, its parent was
> > > > > > > > resumed, and the usual clock inputs were enabled.  And of course, one
> > > > > > > > mechanism for doing this is to runtime-resume the power domain.
> > > > > > > 
> > > > > > > This does not sound like anything bus-specific. Can we move powering on
> > > > > > > the domain before probing into the driver core, similarly to the default
> > > > > > > pin selection by pinctrl?
> > > > > > 
> > > > > > We could do that for genpd if devices were added to domains before registering
> > > > > > (those devices).  Otherwise, there's no guarantee that all has been set up yet.
> > > > > > 
> > > > > > Note that this would only be the case for genpd, not for the ACPI PM domain
> > > > > > in particular, for example.  The reason why is that the ACPI PM domain cannot
> > > > > > be used along with bus types that provide non-trivial PM callbacks, so pretty
> > > > > > much the bus type's ->probe needs to decide whether or not to use it.
> > > > > 
> > > > > In genpd code there is a notion of providers that match devices and
> > > > > domains. Can we do the same for ACPI and stuff all that knowledge into
> > > > > it's "provider"?
> > > > 
> > > > It is in ACPI like that too, but not in the form of the ACPI PM domain.
> > > > 
> > > > > IOW why ACPI is that special?
> > > > 
> > > > The ACPI PM domain is there specifically for bus types that don't provide
> > > > non-trivial PM callbacks to avoid duplication of code (if it didn't exist,
> > > > all of the bus types in question would need to provide callbacks with
> > > > optional ACPI handling in them).  That's all about it.
> > > > 
> > > > And there are bus types that provide non-trivial PM callbacks *and* use
> > > > ACPI in them, like PCI, and that is more interleaved with the native PM
> > > > in there.  For those bus types we can't add devices to the ACPI PM domain
> > > > just because they have ACPI companion objects.
> > > > 
> > > > I'm not really sure why it is important here, though.  We're talking about
> > > > genpd, aren't we?
> > > > 
> > > > I just wanted to indicate that the PM domains concept is not only about
> > > > handling power domains and not all of its use cases can be shoehorned into
> > > > the same scheme.
> > > 
> > > And by the way, things worked just fine for the ACPI PM domain before commit
> > > 46420dd73b80 (PM / Domains: Add APIs to attach/detach a PM domain for a device)
> > > which put the ACPI PM domain and genpd into one bag, which was a mistake,
> > > because they are different things.
> > >
> > 
> > Can we maybe settle on the naming then so that we do not mix them up in
> > the future? For me PM domain is group of devices that share certain
> > power constraints so that they have to be powered up and down together.
> > Is this definition is not correct (for genpd at least)?
> 
> It is correct for genpd, it isn't correct for the ACPI PM domain.
> 
> > And what is the proper definition for ACPI PM domain?
> 
> I agree that the terminology is (somewhat?) confusing.
> 
> From the code perspective, using a PM domain object is a way to provide PM
> callbacks that will be executed for a subset of devices instead of or in
> addition to the bus type (or class or device type) callbacks.  Of course,
> that applies to proper power domains in particular, but it can also apply
> to broader sets of devices.  In the ACPI PM domain case this covers devices
> with ACPI power management support (or more precisely, devices with ACPI
> companion objects that can provide PM support).  In this context the word
> "domain" means as much as "area of control" (which is a proper dictionary
> definition of it AFAICS).
> 
> genpd is all about proper power domains, like you said.
> 
> That's why I'm saying that they are different and clamping them both
> together was a mistake.  I overlooked that, my bad.

For completeness, please let me quote the changelog of commit
564b905ab10d (PM / Domains: Rename struct dev_power_domain to struct dev_pm_domain)
dealing with this particular thing:

    The naming convention used by commit 7538e3db6e015e890825fbd9f86599b
    (PM: Add support for device power domains), which introduced the
    struct dev_power_domain type for representing device power domains,
    evidently confuses some developers who tend to think that objects
    of this type must correspond to "power domains" as defined by
    hardware, which is not the case.  Namely, at the kernel level, a
    struct dev_power_domain object can represent arbitrary set of devices
    that are mutually dependent power management-wise and need not belong
    to one hardware power domain.  To avoid that confusion, rename struct
    dev_power_domain to struct dev_pm_domain and rename the related
    pointers in struct device and struct pm_clk_notifier_block from
    pwr_domain to pm_domain.

And that should be explicitly explained in the PM documentation which I'm going
to do.

Rafael
