From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Mar 2016 21:58:40 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160325155032.GH2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <4319407.5A4b1VspuB@wuerfel> <20160325155032.GH2566@sirena.org.uk>
Message-ID: <10747635.WkGeFaKqdy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 March 2016 15:50:32 Mark Brown wrote:
> On Fri, Mar 25, 2016 at 04:11:05PM +0100, Arnd Bergmann wrote:
> 
> > There is nothing magic in the binding if we just do the same thing
> > the flash driver does, and describe the memory range that is associated
> > with a chipselect.
> 
> Why are we even doing that though?  Like I say it just seems pointlessly
> unhelpful for users.  Are we really saying that every single system has
> to go through and manually modify their DT so that they can use this
> entirely in SoC feature?  That doesn't seem like winning...

I don't remember the exact details, but I think we had come up with
a generic constraint solving algorithm to pick appropriate windows for
each device with a (close to) minimal use of physical address space,
and we defined the DT binding for MBus in a way that would let us
implement that algorithm at a later point if we ever found we needed
it, but then decided against implementing it because it puts a lot
of complexity at the very early boot: it needs to do a deep walk
of all enabled child device nodes to find the size and alignment of
every reg property that translates into an mbus address, and figure out
a set of mbus translations that convert those into CPU phys addresses
without using too many mbus windows or too much address space.

> > > > Ok, so with the static mapping it could be done very easily, or
> > > > we need a more complex solution for the dynamic mapping.
> 
> > > Part of what I personally don't understand is why this is complicated?
> 
> > I think we'd need to add another special case in the bus driver
> > for it, which otherwise should be able to handle this in a generic
> > way: if we just use the existing binding, the spi host driver can
> > simply call devm_ioremap_resource() to see if there is a map
> > for a given chipselect and otherwise fall back to the current
> > mode.
> 
> Why does the binding have to be in the client device to do that?

I don't understand the question. The client device here is the SPI
controller, right? That doesn't need to have a special binding, it
just needs to list the registers relative to the mbus address space
like any other device, and that is independent of how we implement
it.

It looks like Stefan's patch tricks here by creating an incompatible
binding for mbus that bypasses the address mapping.

	Arnd
