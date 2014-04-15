From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Apr 2014 23:38:50 +0100
Subject: [RFC PATCH v2] regmap: smbus: add support for regmap over smbus
In-Reply-To: <534D85F3.5050009@metafoo.de>
References: <1397480885-11962-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140414210429.GJ25182@sirena.org.uk>
 <534CE16D.8010508@free-electrons.com>
 <20140415100922.GN12304@sirena.org.uk>
 <534D1DDA.40207@free-electrons.com> <534D252B.8060009@metafoo.de>
 <20140415125654.GD12304@sirena.org.uk>
 <534D357F.9040906@metafoo.de>
 <20140415164613.GF12304@sirena.org.uk>
 <534D85F3.5050009@metafoo.de>
Message-ID: <20140415223849.GJ12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 09:18:11PM +0200, Lars-Peter Clausen wrote:
> On 04/15/2014 06:46 PM, Mark Brown wrote:

> >Please note what I said about convenience - if lots of devices have
> >exactly the same set of constraints to set up it's possible sensible to
> >have a standard way of specifying them.  It's going to be a bit easier
> >to just say it's smbus than to remember exactly what that means.

> Maybe, but the only shared constraint is reg_bits = 8 (and if it is pure
> smbus use_single_rw = true).

I thought there was some other stuff at the edge of the protocol, though
perhaps I misremember.  We do also have the thing with implementing the
bulk write differently.

> It's a bit of an exotic case, there seem to be only two I2C controller
> drivers in the Linux kernel that have support for both raw I2C and native
> SMBus and neither of them don't seem to be fairly recent (i2c-powermac.c and
> i2c-pasemi.c). And on the other hand most devices are SMBus compatible have

Blackfin was another - I didn't look that far to be honest since the
first few that I found did it.

> extensions like being able to write/read multiple register in one transfer
> if raw I2C access is available, which is something we want to make use of if
> available.

Sure, if the device supports it.

> And the other thing to consider is that a client driver currently has no way
> to query whether the controller driver supports native SMBus or only
> emulated SMBus. This is surely something that can be added to the I2C core,
> but this is necessarily something that we require before any SMBus support
> is added to regmap.

Right, that'll take a couple of minutes though.

> So in conclusion I think the best way forward is to create a patch that
> checks if native I2C is available, and if not falls back to either
> SMBUS_{WRITE,READ}_BYTE or SMBUS_{WRITE,READ}_WORD operations (Depending on
> whether val_bits is 8 or 16). Such a patch, I think, has the most effect for
> the least amount of work since it is rather simple and self contained and
> allows all devices which are SMBus compatible to be used with SMBus-only
> controllers. Everything else discussed in this thread (optimizations for
> special cases, convince helpers) can then be implemented on top of that.

Indeed, like I've been saying there's several orthogonal things going on
here and that's one of them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/1baf6253/attachment.sig>
