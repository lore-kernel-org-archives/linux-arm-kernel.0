From: romain.izard.pro@gmail.com (Romain Izard)
Date: Wed, 17 Oct 2018 15:36:17 +0200
Subject: Clock configuration for the SAMA5D2 NAND controller
In-Reply-To: <20181017150344.40d687d1@bbrezillon>
References: <CAGkQfmNuROsD29jR_7opiXcfPB6=FuaoxaK-hF5Ezz7r-1pBZA@mail.gmail.com>
 <20181017143849.1240d9bb@bbrezillon>
 <CAGkQfmOOv41vwYtt3rjgC6SmXOkAdASvjWt+YWAksGo-4HqvpQ@mail.gmail.com>
 <20181017150344.40d687d1@bbrezillon>
Message-ID: <CAGkQfmNdp+Si9FseRjjRG4r272kRtu=7MqwHD6OUoRKCinXO-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mer. 17 oct. 2018 ? 15:03, Boris Brezillon <boris.brezillon@bootlin.com>
a ?crit :
>
> On Wed, 17 Oct 2018 14:49:27 +0200 Romain Izard
> <romain.izard.pro@gmail.com> wrote:
>
> > Le mer. 17 oct. 2018 ? 14:38, Boris Brezillon
> > <boris.brezillon@bootlin.com> a ?crit :
> > >
[...]
> > >
> > > Is it 2 times slower or 2 times faster with the new approach? Is the
> > > new calculation providing a working solution, or do you have data
> > > corruption because of that? Is your NAND ONFI compliant?
> > >
> > - The number of clock cycles for each configured timing is larger, so
> > the access times are slower.
>
> Okay. When calculating the timings by hand, what was reference freq you
> used? Did you compare it to the clk freq we have when the NAND controller
> driver tweaks the timings?
>
I know that I did the calculations with a 83 MHz clock, but that the kernel
code used a 166 MHz clock instead. The only question is to know whether it
is me or the existing code that is right.

> > - No obvious problem has been observed during my limited testing. It is
> > possible to read and write on the Flash.
>
> That's not surprising if it's running slower than what can actually be
> achieved.
>
> > - This is with an ONFI compilant flash, that claims to support timing
> > modes from 0 to 4.
>
> Okay. We don't support EDO modes [1], so mode 4 should be rejected. Did
> you base your hand-made calculation on mode 3 or 4?
>
> [1]https://elixir.bootlin.com/linux/v4.19-rc8/source/drivers/mtd/nand/raw/atmel/nand-controller.c#L1205

As I initially calculated the timings for a SDR toggle-mode NAND, there no
timing mode to use. And the datasheet for the ONFI chip used as a first
replacement was more permissive than the original model, so I continued with
the original timings.

In the end, I'm asking these questions because I cannot access the signals
for my memory chip. Otherwise, I would just verify the duration of the
pulses on the bus.

If I get a confirmation on the subject, I can then propose a patch to fix
the SAMA5D2 device tree to use the correct clock.

Best regards,
--
Romain Izard
