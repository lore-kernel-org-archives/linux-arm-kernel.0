From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 30 Oct 2018 10:49:03 +0100
Subject: Clock configuration for the SAMA5D2 NAND controller
In-Reply-To: <CAGkQfmMphvck9rraYq+o8zA254q7ETYyniiUV-QBsUR9X+OFKQ@mail.gmail.com>
References: <CAGkQfmNuROsD29jR_7opiXcfPB6=FuaoxaK-hF5Ezz7r-1pBZA@mail.gmail.com>
 <CAGkQfmMphvck9rraYq+o8zA254q7ETYyniiUV-QBsUR9X+OFKQ@mail.gmail.com>
Message-ID: <20181030104903.518f1fdd@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,

Romain Izard <romain.izard.pro@gmail.com> wrote on Wed, 17 Oct 2018
12:42:28 +0200:

> +linux-mtd, linux-clk
> 
> Le mer. 10 oct. 2018 ? 19:05, Romain Izard
> <romain.izard.pro@gmail.com> a ?crit :
> >
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
> >
> > For me, the issue is due to the clock configuration declared in the SAMA5D2
> > device tree: The reference clock used by the nand-controller driver is the
> > clock for its parent node, which is directly the Master Clock. And on my
> > end, what I understood when writing the clock settings for my bootloader was
> > that the reference clock was the HSMC clock, which derives from the H32MX
> > clock, which runs at half the rate of the Master Clock.
> >
> > The documentation for the SAMA5D2 is not very precise on this topic, so I
> > would like to have some feedback. Is the clock used as a reference for the
> > chip select configuration registers the Master Clock itself, or is it the
> > peripheral clock for the HSMC module ?
> >

FYI I had the same issue on the Marvell NAND controller: the actual
frequency of the controller clock was half of the "parent" clock
retrieved by clk_get_rate(), hence I needed to double the clock period
for the timings derivation in ->setup_data_interface().

If you can't get more feedback from SAMA5 people and if this works for
you, please send a patch with a nice comment.


Thanks,
Miqu?l
