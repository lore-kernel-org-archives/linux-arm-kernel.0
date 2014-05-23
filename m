From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 May 2014 17:27:18 +0100
Subject: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
In-Reply-To: <537F3610.3050104@redhat.com>
References: <537DC832.3020006@redhat.com>
 <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com>
 <537DE1AA.5050606@redhat.com> <537E31F7.1030505@gmail.com>
 <537F1148.3010102@redhat.com>
 <20140523112239.GB12304@sirena.org.uk>
 <537F3610.3050104@redhat.com>
Message-ID: <20140523162718.GE22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 01:50:40PM +0200, Hans de Goede wrote:
> On 05/23/2014 01:22 PM, Mark Brown wrote:

> > Would it not be better to have this be something in the driver struct
> > rather than in the device tree?  Putting a compatible in there would be
> > encoding details of the Linux implementation in the DT which doesn't
> > seem right especially since these are details we're thinking of changing
> > later on.

> The compatible is not a Linux specific thing, it is a marking saying
> that something needs to take care of enabling the clks (and whatever
> else we will make part of the binding for this compatible), before
> scanning the mmc bus.

We could just say that the mere presence of a child node with the right
properties is sufficient to trigger the bus to do the startup?

> > Something like have the driver set flags saying if it wants
> > to do complicated things.

> Chicken <-> egg, we won't know which driver to use before we've probed
> the mmc bus, and we cannot probe the bus before enabling the clks, etc.

If the device is sufficiently complicated to need a special power up
sequence I'd expect we'd be able to have a compatible string which would
provide enough information for us to figure things out.

> >> FWIW if we ever get truely complex cases I think modeling the
> >> power-up hardware as a pmic platform device is not a bad idea,
> >> we would then need to have a generic mmc-host pmic property, which
> >> would be used both to do the initial powerup before scanning, as
> >> well as for the sdio device driver to get a handle to the pmic,
> >> for run time power-management (if desired).

> > I don't know if this will ever apply to SDIO but with other buses the
> > complicated bits come when the driver wants to take over some of the
> > power management do things like turn some of the supplies or clocks on
> > and off independently at runtime for low power modes.

> Hmm, good point in that case actually having these things in the
> child node makes most sense, because then the driver can find them
> their. Note that the mmc core enabling things does not mean that
> the driver cannot later disable them if needed.

Right, that's good idea for solving the problem - the child device can
either share the reference with the bus or have some way of getting at
the object the bus requested depending on what's sensible.  Only
potentia complication I can think of with that approach is a device with
multiple bus interfaces (I'm mainly thinking of SDIO vs SPI) but it
doesn't seem to hard to deal with that in the bus adaption layers of the
drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/1c798047/attachment.sig>
