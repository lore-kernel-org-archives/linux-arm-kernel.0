From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Dec 2015 21:40:07 +0000
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <1451500639.14341.6.camel@collins>
References: <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk> <568088B4.6090207@ti.com>
 <1451342963.14631.13.camel@collins> <5681D7A8.2030101@ti.com>
 <1451387613.18148.9.camel@collins> <568323B7.7080101@ti.com>
 <1451464521.2531.4.camel@collins>
 <20151230163307.GW16023@sirena.org.uk>
 <1451500639.14341.6.camel@collins>
Message-ID: <20151231214007.GC16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2015 at 07:37:19PM +0100, Paul Kocialkowski wrote:
> Le mercredi 30 d?cembre 2015 ? 16:33 +0000, Mark Brown a ?crit :
> > On Wed, Dec 30, 2015 at 09:35:21AM +0100, Paul Kocialkowski wrote:

> > > In my opinion, it would be more elegant to adapt the core regulator
> > > framework to first enable the GPIO and then call the regulator enable
> > > ops callback instead of handling the GPIO in the driver.

> > Why would we want to actively manage both things at runtime?  It's more
> > work, what do we gain from it?

> Well, I figured that it would be best to disable the EN pin when we're
> not using any of the regulators, since that allows the chip to enter
> standby mode (and thus consume less power).

This doesn't sound like it's anything to do with the regulators, that's
a chip wide power management function which should be implemented via
runtime PM if there's any value in implementing it at all (if the device
is a primary PMIC normally this would be handled by the CPU core when it
enters low power state without any software).  It's not something we
should be considering on a per regulator basis since it's at the chip
level and on a per regulator basis it's not doing anything useful for
the reasons above.

> It also doesn't hurt regulators that only use a GPIO for enable.

It causes problems for any device with an optional GPIO,  it means that
we end up mantaining both GPIO and register which as I've said a couple
of times now defeats the point of having the GPIO.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151231/d1194fca/attachment.sig>
