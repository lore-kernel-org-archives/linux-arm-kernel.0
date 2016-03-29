From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 23:08:55 +0200
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160329210018.GL2350@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <7339827.UeYZLZET5g@wuerfel> <20160329210018.GL2350@sirena.org.uk>
Message-ID: <3108005.nUMWsj4kjp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 14:00:18 Mark Brown wrote:
> On Tue, Mar 29, 2016 at 10:04:59PM +0200, Arnd Bergmann wrote:
> > On Tuesday 29 March 2016 12:52:30 Mark Brown wrote:
> 
> > > Well, we currently don't have any XIP or whatever support at all, it's
> > > still only in the SPI operations so it's academic - that'd be a future
> > > issue if we did start doing things that accessed the memory map outside
> > > of the SPI flow.
> 
> > Isn't this just about implementing .point()/.unpoint() in the spi-nor
> > driver?
> 
> Implementing that would require the SPI core to export something
> providing access to the memory regions.  We don't currently do that,
> it'd require us to deal with the interaction with access as a SPI device
> (this hardware often seems to only accelerate reads so we still need to
> use regular SPI access for writes).

The manual lists both read and write accesses as handled through
direct mode.

> > > For me the simplest thing seems like just using one window for all the
> > > devices, it seems more likely to deliver useful results without the
> > > system integrator having to think about how to configure this for
> > > optimisation.
> 
> > Do you mean single-window mode? I don't see the difference to the other
> > modes, but that's certainly fine with me if it helps.
> 
> I don't like having to assign windows per device, like I say it seems
> like more work.

Ok, but that's something else that can be implemented independently
as I explained earlier: We currently rely on the windows to be assigned
in the DT, but it's also possible to extend the mbus driver in a way
that lets it pick its own windows in one way or another. It should
not impact the binding for the SPI host controller in any way, the
binding just describes how the internal addressing is wired up to
the mbus in hardware, and the mbus driver takes care of mapping those
into CPU addresses.

	Arnd
