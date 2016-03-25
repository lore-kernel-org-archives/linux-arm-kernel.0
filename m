From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Mar 2016 22:39:22 +0000
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <10747635.WkGeFaKqdy@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <4319407.5A4b1VspuB@wuerfel> <20160325155032.GH2566@sirena.org.uk>
 <10747635.WkGeFaKqdy@wuerfel>
Message-ID: <20160325223922.GG5028@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2016 at 09:58:40PM +0100, Arnd Bergmann wrote:
> On Friday 25 March 2016 15:50:32 Mark Brown wrote:

> > Why are we even doing that though?  Like I say it just seems pointlessly
> > unhelpful for users.  Are we really saying that every single system has
> > to go through and manually modify their DT so that they can use this
> > entirely in SoC feature?  That doesn't seem like winning...

> I don't remember the exact details, but I think we had come up with
> a generic constraint solving algorithm to pick appropriate windows for
> each device with a (close to) minimal use of physical address space,

So there are some complicated constraints that make it hard to allocate
from the bus space?

> > > way: if we just use the existing binding, the spi host driver can
> > > simply call devm_ioremap_resource() to see if there is a map
> > > for a given chipselect and otherwise fall back to the current
> > > mode.

> > Why does the binding have to be in the client device to do that?

> I don't understand the question. The client device here is the SPI
> controller, right? That doesn't need to have a special binding, it
> just needs to list the registers relative to the mbus address space
> like any other device, and that is independent of how we implement
> it.

If you're saying we're doing a binding per chip select presumably that
binding appears in the SPI device even if it's the controller driver
that parses it.  This was what the original patch did, I pushed back
since it's a fairly common pattern for poor quality bindings where
people for some reason want to add per device properties for whatever
new feature they want to support instead of doing it at the controller
level (and ideally just doing it without requring any configuration).

> It looks like Stefan's patch tricks here by creating an incompatible
> binding for mbus that bypasses the address mapping.

I've not looked at the patch and honestly nobody has been talking about
any generic binding, all I've seen is the per device property in the
original patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160325/7b887cd7/attachment.sig>
