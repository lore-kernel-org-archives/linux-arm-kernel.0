From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2016 00:04:55 +0200
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160329212842.GN2350@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <3108005.nUMWsj4kjp@wuerfel> <20160329212842.GN2350@sirena.org.uk>
Message-ID: <13533301.gfdhE3AuMf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 14:28:42 Mark Brown wrote:
> On Tue, Mar 29, 2016 at 11:08:55PM +0200, Arnd Bergmann wrote:
> > On Tuesday 29 March 2016 14:00:18 Mark Brown wrote:
> 
> > > Implementing that would require the SPI core to export something
> > > providing access to the memory regions.  We don't currently do that,
> > > it'd require us to deal with the interaction with access as a SPI device
> > > (this hardware often seems to only accelerate reads so we still need to
> > > use regular SPI access for writes).
> 
> > The manual lists both read and write accesses as handled through
> > direct mode.
> 
> That is not in general the case for this sort of hardware, and there's
> also erase support to consider here.

Sorry for being unclear, I was referring to spi writes here, not flash
writes.

The MTD infrastructure handles _point internally, and I think it is
only ever used on jffs2 these days. I had assumed that _point was
used by mtd_block to implement direct_access for read-only block
based file systems as well, but it's not.

I don't think there is any device that abstracts a SPI-NOR flash
to look like RAM.

> > > I don't like having to assign windows per device, like I say it seems
> > > like more work.
> 
> > Ok, but that's something else that can be implemented independently
> > as I explained earlier: We currently rely on the windows to be assigned
> > in the DT, but it's also possible to extend the mbus driver in a way
> > that lets it pick its own windows in one way or another. It should
> 
> That's what I've been asking for but people keep saying it's not
> possible...

It's not impossible, it's just that IIRC we decided that the effort
to do this well was not reasonable compared to the benefit back
when the mbus driver got added.

I don't think anything has changed here.

> > not impact the binding for the SPI host controller in any way, the
> > binding just describes how the internal addressing is wired up to
> > the mbus in hardware, and the mbus driver takes care of mapping those
> > into CPU addresses.
> 
> If we're able to do it automatically without baking this into the DT and
> there's enough space to cope with this and PCI together then that's more
> reasonable.

Ok, good. Then let's just do the SPI host driver like all the other
mbus slaves using whatever mbus provides, and implement dynamic remapping
of mbus windows whenever someone gets too annoyed with having to 
come up with a mapping for their board.

At least by doing SPI like all the other devices, we don't make it
harder to come up with a generic algorithm for assigning the windows
at boot time.

	Arnd
