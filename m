From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 18 Mar 2013 11:18:26 -0600
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130318172718.4f8f45b9@skate>
References: <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130307222004.GA2450@localhost>
 <20130307230516.GA28975@obsidianresearch.com>
 <20130308091052.18612729@skate>
 <20130308172950.GC4094@obsidianresearch.com>
 <20130318172718.4f8f45b9@skate>
Message-ID: <20130318171826.GA30886@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 05:27:18PM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Fri, 8 Mar 2013 10:29:50 -0700, Jason Gunthorpe wrote:
> 
> > > Sorry, but we _do_ want the kernel to be able to set those timings
> > > parameters, and therefore, a Device Bus driver will be needed,
> > > regardless of whether it creates the address window or not.
> > 
> > See the very good idea from Maxime Bizon about autoprobing the ONFI
> > timings directly from the NAND chip.
> 
> ONFI (Open NAND Firmware Interface) is about NAND, while the Device Bus
> driver submitted by Ezequiel is about NOR. I don't think NORs have a
> standard way of exposing their memory timings requirements. And the
> Device Bus driver is not only for NORs, but also for example for FPGAs
> connected on the memory bus.

Right, AFAIK there is no CFI property for device timings, and there is
a lot of variation of optimal timings between pin-compatible
parts.

Some kind of out-of-band indication of the flash chip and speed grade
is necessary to get optimal timings, unfortunately - no idea how you'd
fit that sensibly into a DT framework.

> Ezequiel followed the work done by Jon Hunter on the GPMC driver for
> the memory bus of OMAP SoCs, which includes the definition of timings
> in the Device Tree. To me, it seems like defining the timings in the
> Device Tree do make sense, and "ONFI" is not a good enough answer to
> get rid of the Device Bus driver submitted by Ezequiel.

As I said, I think that is fine - there is nothing wrong with a driver
to set the bus timings. But, if there are no bus timings in the DT
then the driver should not be involved at all..

Similarly the driver should require all the timings, re-using timings
left in the register with timings from the DT seems very strange..

Regards,
Jason
