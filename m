From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jan 2016 23:41:45 +0100
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20160112220058.GE6588@sirena.org.uk>
References: <1440159857.19360.50.camel@debian.org>
 <4468027.N4Q71mzei0@wuerfel> <20160112220058.GE6588@sirena.org.uk>
Message-ID: <6044522.tqmlJ5a48h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 January 2016 22:00:58 Mark Brown wrote:
> On Tue, Jan 12, 2016 at 10:49:57PM +0100, Arnd Bergmann wrote:
> 
> > I see in the Armada 370 datasheet that the controller actually supports an
> > interrupt driven mode, which should be much better in principle than blocking
> > the CPU during the entire transfer. There may of course be a good reason
> > why the driver has never used interrupts, but it was originally introduced
> > in Orion5x, so maybe there was a bug that has been fixed in the meantime.
> 
> There's also the potential for the overhead from interrupts to be worse
> than the overhead for busy waiting, but given how badly we're coping now
> it's worth another look.

Possible, yes. Right now, we do a udelay(1), which I think waits between one and
two microseconds normally, so we are probably adding extra latency of under
one microsecond per byte by not polling constantly. If the interrupt latency
from device-ready to entering the code is more than that, we can assume that
the transfer ends up being slower. There is also some time spent for getting
back out of the interrupt handler, but that's no worse than doing nothing
in udelay().

> I did also see a patch today that suggested that at least some of these
> controllers have some kind of memory mapped mode but I don't know
> exactly how that works (the patch was a little unclear).  There was some
> suggestion that it performed well and if there's a free general purpose
> DMA controller it might be able to work with this mode too.

There is the "xor" DMA engine that has a memcpy mode, but setting this up
to point at the right mbus translation window is going to be interesting.

	Arnd
