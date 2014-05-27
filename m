From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 May 2014 17:49:46 +0200
Subject: PXA 2xx devictree port and clock infrastructure
In-Reply-To: <20140527154303.GA6835@leverpostej>
References: <87zji3cr3d.fsf@free.fr> <201405271717.48783.arnd@arndb.de>
 <20140527154303.GA6835@leverpostej>
Message-ID: <4580668.Rz95HmpxUr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 May 2014 16:43:03 Mark Rutland wrote:
> On Tue, May 27, 2014 at 04:17:48PM +0100, Arnd Bergmann wrote:
> > On Tuesday 27 May 2014, Robert Jarzmik wrote:
> > > I'm playing with devicetree to port the mioa701 machine code to devicetree (or
> > > rather to eliminate the mioa701 machine code).
> > > 
> > > While porting the pxa2xx device drivers, I came to a question about the clock
> > > infrastructure, and I'd need a bit of guidance.
> > > 
> > > Many drivers, in their probe code are doing something like :
> > >         1) regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >         2) irq = platform_get_irq(pdev, 0);
> > >         3) clk = clk_get(&pdev->dev, NULL);
> > > 
> > > Points 1 and 2 are straightforward with DT. Point 3 is not so obvious to me.
> > > 
> > > As there is no platform data anymore, the clock infrastructure wants to match
> > > the OF device (in my case udc at 40600000) with the registered
> > > clocks. Unfortunately, the registered clock is named "pxa27x-udc", which works
> > > well in "platform data" devices, but not in devicetree populated devices.
> > > 
> > > Therefore, I'd like to know what to do, and an example in another platform would
> > > be great. Should I create a clkdev driver in drivers/clk, or is there another
> > > ... faster way ? And Daniel, you probably solved it already for
> > > arch/arm/mach-pxa/pxa-dt.c, didn't you ?
> > 
> > There are generally three ways of doing this:
> > 
> > a) use an auxdata table to reassign the device names to what they
> >    used to be
> > b) change the clkdev lookup to also include the new names (e.g. "40600000.udc")
> > c) write a DT-aware clock driver and list all clocks in DT
> 
> Out of these, c would be my preferred solution. It would match the
> solutions for problems 1 and 2, and it's almost inevitable that later
> we'll want DT clocks anyway...

Right, that is the general recommendation at least. I'm always a bit cautious
when it comes to PXA because I don't expect that platform to fully get
converted to DT in the long run, and very little new work is going on there.

OTOH, if people like Robert and Daniel do this for fun, it's definitely
great to see the full solution.

Note that the more modern version of PXA is MMP, which currently uses a)
and I definitely want that converted to c) eventually, independent of what
happens with PXA.

	Arnd
