From: romain.izard.pro@gmail.com (Romain Izard)
Date: Wed, 17 Oct 2018 14:49:27 +0200
Subject: Clock configuration for the SAMA5D2 NAND controller
In-Reply-To: <20181017143849.1240d9bb@bbrezillon>
References: <CAGkQfmNuROsD29jR_7opiXcfPB6=FuaoxaK-hF5Ezz7r-1pBZA@mail.gmail.com>
 <20181017143849.1240d9bb@bbrezillon>
Message-ID: <CAGkQfmOOv41vwYtt3rjgC6SmXOkAdASvjWt+YWAksGo-4HqvpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mer. 17 oct. 2018 ? 14:38, Boris Brezillon
<boris.brezillon@bootlin.com> a ?crit :
>
> Hi Romain,
>
> On Wed, 10 Oct 2018 19:05:06 +0200
> Romain Izard <romain.izard.pro@gmail.com> wrote:
>
> > Hello,
> >
> > While evaluating a new flash memory chip for my product based on a SAMA5D2
> > chip, I tried to update my software to use the latest device tree bindings.
> >
> > Until now, I was using the legacy bindings for the NAND controller, that
> > preserved the timings configured by the bootloader in the EBI registers. The
> > bindings introduced in Linux 4.13 are used together with the NAND driver to
> > reconfigure the timings of the memory interface to match the speed profile
> > declared by some NAND components.
> >
> > However, when comparing the timings in the registers, there was a large
> > difference between what I calculated by hand in the past and the values
> > configured by the drivers. The difference was in fact a 2 factor.
>
> Is it 2 times slower or 2 times faster with the new approach? Is the
> new calculation providing a working solution, or do you have data
> corruption because of that? Is your NAND ONFI compliant?
>
- The number of clock cycles for each configured timing is larger, so the
access times are slower.
- No obvious problem has been observed during my limited testing. It
is possible to read and write on the Flash.
- This is with an ONFI compilant flash, that claims to support timing
modes from 0 to 4.

> > For me, the issue is due to the clock configuration declared in the SAMA5D2
> > device tree: The reference clock used by the nand-controller driver is the
> > clock for its parent node, which is directly the Master Clock. And on my
> > end, what I understood when writing the clock settings for my bootloader was
> > that the reference clock was the HSMC clock, which derives from the H32MX
> > clock, which runs at half the rate of the Master Clock.
>
> Hm, it's probably based on the clock driving the EBI/SMC logic.
>
> >
> > The documentation for the SAMA5D2 is not very precise on this topic, so I
> > would like to have some feedback. Is the clock used as a reference for the
> > chip select configuration registers the Master Clock itself, or is it the
> > peripheral clock for the HSMC module ?
>
> I'd say the periph clock driving the HSMC module, but I'm not sure.
>
> Nicolas, Tudor, can you help us with that?

Best regards,
-- 
Romain Izard
