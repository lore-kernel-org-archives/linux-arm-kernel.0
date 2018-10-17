From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 17 Oct 2018 15:03:44 +0200
Subject: Clock configuration for the SAMA5D2 NAND controller
In-Reply-To: <CAGkQfmOOv41vwYtt3rjgC6SmXOkAdASvjWt+YWAksGo-4HqvpQ@mail.gmail.com>
References: <CAGkQfmNuROsD29jR_7opiXcfPB6=FuaoxaK-hF5Ezz7r-1pBZA@mail.gmail.com>
 <20181017143849.1240d9bb@bbrezillon>
 <CAGkQfmOOv41vwYtt3rjgC6SmXOkAdASvjWt+YWAksGo-4HqvpQ@mail.gmail.com>
Message-ID: <20181017150344.40d687d1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2018 14:49:27 +0200
Romain Izard <romain.izard.pro@gmail.com> wrote:

> Le mer. 17 oct. 2018 ? 14:38, Boris Brezillon
> <boris.brezillon@bootlin.com> a ?crit :
> >
> > Hi Romain,
> >
> > On Wed, 10 Oct 2018 19:05:06 +0200
> > Romain Izard <romain.izard.pro@gmail.com> wrote:
> >  
> > > Hello,
> > >
> > > While evaluating a new flash memory chip for my product based on a SAMA5D2
> > > chip, I tried to update my software to use the latest device tree bindings.
> > >
> > > Until now, I was using the legacy bindings for the NAND controller, that
> > > preserved the timings configured by the bootloader in the EBI registers. The
> > > bindings introduced in Linux 4.13 are used together with the NAND driver to
> > > reconfigure the timings of the memory interface to match the speed profile
> > > declared by some NAND components.
> > >
> > > However, when comparing the timings in the registers, there was a large
> > > difference between what I calculated by hand in the past and the values
> > > configured by the drivers. The difference was in fact a 2 factor.  
> >
> > Is it 2 times slower or 2 times faster with the new approach? Is the
> > new calculation providing a working solution, or do you have data
> > corruption because of that? Is your NAND ONFI compliant?
> >  
> - The number of clock cycles for each configured timing is larger, so the
> access times are slower.

Okay. When calculating the timings by hand, what was reference freq you
used? Did you compare it to the clk freq we have when the NAND
controller driver tweaks the timings?

> - No obvious problem has been observed during my limited testing. It
> is possible to read and write on the Flash.

That's not surprising if it's running slower than what can actually be
achieved.

> - This is with an ONFI compilant flash, that claims to support timing
> modes from 0 to 4.

Okay. We don't support EDO modes [1], so mode 4 should be rejected. Did
you base your hand-made calculation on mode 3 or 4?

[1]https://elixir.bootlin.com/linux/v4.19-rc8/source/drivers/mtd/nand/raw/atmel/nand-controller.c#L1205
