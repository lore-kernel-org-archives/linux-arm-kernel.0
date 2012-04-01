From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 1 Apr 2012 19:54:04 +0100
Subject: [PATCH/RFC] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <CACRpkdb6+2SLm1Ojw2jNkK9ejW66fw2Pcit-b3AL67wP4Hr_ow@mail.gmail.com>
References: <1333294181-27653-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdb6+2SLm1Ojw2jNkK9ejW66fw2Pcit-b3AL67wP4Hr_ow@mail.gmail.com>
Message-ID: <20120401185404.GD8971@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 07:22:46PM +0200, Linus Walleij wrote:
> On Sun, Apr 1, 2012 at 5:29 PM, Mark Brown

> > The AMBA bus regulator support is being used to model on/off switches
> > for power domains which isn't terribly idiomatic for modern kernels with

> I don't see how this solves the problem of AMBA PrimeCell probing.

I think you're misunderstanding what this fixes.  The main problem it
addresses is that as things stand platforms which have no intention of
using regulators to model power domains really ought to be providing
dummy vcores for their AMBA devices (or the AMBA bus should be doing
that).  Removing regulator usage from the AMBA core code obviously
accomplishes this, avoiding disruption to these platforms.

It does also remove the dodgy ignore the error idiom, but that's pretty
much secondary.

> We need the current code replaced with something that
> enables a power domain before probe instead, then implement
> these power domains for the in-kernel AMBA devices that need it.

> Is the default behaviour of power domains such that they will
> be enabled as soon as devices are registered but before
> any buses probe()? Because that is what is needed in this case.

Yes, this should be the case (TBH I can't actually remember if you have
to do the default in your power domain code or you just get to pick the
default state and the power domain figures it out).  If you think about
it power domains would be pretty useless if they didn't do something
sensible here - it's not like the need to power things on before
interacting with them is specific to AMBA.  As I keep saying they're
*really* simple to use and very idiomatic, drivers don't ever need to
interact with them directly at all.  They just do system and runtime
power management.

> (AMBA devices are special in this way: no other ARM things
> support auto-detection of devices using magic numbers,
> basically the DT stuff came about because noone was using
> a thing like this.)

There's at least PCI and USB as well, with more to come very soon, and
on-SoC platform devices behave in very much the same way really.

> > The impact should be minimal since currently there are no mainline
> > systems which actually provide a vcore regulator so none need updating.

> Oh yes there are:
> drivers/mfd/db8500-prcmu.c

Oh, ick.  As you say this stuff would obviously be expected to be in
arch/arm along with the rest of the platform code and quite frankly I'm
surprised that AMBA is producing textual dev_names - it's rather unusual
for a bus not to use the numeric IDs which it enumerates with which is
why I missed the code when I grepped.  The names aren't a problem, just
surprising.

> IIRC the machine will not boot (i.e. these drivers cannot even
> probe) without these regulators in place, so they get enabled by
> the AMBA bus code.

> So we need something that not just removes stuff from the
> AMBA bus, but also adds a better power domain mechanism
> and fixes up taking the above regulators.

> That said I'm all for replacing it - but I'd need to figure out the
> details on how to do that.

> We do have code for ux500 power domains. If it will will be
> enough to handle this I can try to hack it up and submit it.

This should be totally trivial, just shift your existing regulator stuff
into the power domain and out of AMBA.

Though actually given the fact that only the pl022 driver supports
turning the domain on and off at runtime and that's not one of the
drivers bound to the switchable supply in this system you'll probably
see zero impact on actual systems if you just constrain vape to be
always_on in the first instance, then work to optimise later.  With the
current mainline code I'd expect there to be at least one AMBA device
which forces the power on anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120401/f72e642f/attachment.sig>
