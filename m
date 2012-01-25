From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:44:39 +0000
Subject: Common clock API for i.MX
In-Reply-To: <CAKGA1bm_rLyMB-Xr-XZQHQRVDySu9JuCoVZL=FFv9sa1y6eD1A@mail.gmail.com>
References: <CAKGA1bkHgnJQs3_n6QtQjf-8xaPn0YnxMmE2Q=+opWcsp10zQA@mail.gmail.com>
 <20120125084533.GD1068@n2100.arm.linux.org.uk>
 <CAKGA1bm_rLyMB-Xr-XZQHQRVDySu9JuCoVZL=FFv9sa1y6eD1A@mail.gmail.com>
Message-ID: <20120125144439.GH1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 07:45:15AM -0600, Matt Sealey wrote:
> On Wed, Jan 25, 2012 at 2:45 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jan 24, 2012 at 07:54:08PM -0600, Matt Sealey wrote:
> >> Hi Arnd/RMK/Sascha,
> >>
> >> We're trying to bring up a good batch of drivers here for MX51 and
> >> EfikaMX systems and noticed that the released 3.2 kernel doesn't
> >> include the common clock stuff that all the other platforms seem to be
> >> using.
> >
> > As far as I know, it still isn't ready (if it was, surely it would've
> > been merged?)
> >
> > Grepping for clk_prepare() it looks like very few people have converted
> > over to this - it's just the AMBA stuff, a few bits of OMAP and MXS.
> > So even if the common clock stuff comes in, almost nothing will be able
> > to use it:
> >
> > arch/arm/common/sa1111.c
> > arch/arm/common/timer-sp.c
> > arch/arm/mach-omap2/clock2xxx.c
> > arch/arm/mach-omap2/clock.h
> > arch/arm/mach-omap2/prcm.c
> > arch/arm/mach-omap2/clock2430_data.c
> > arch/arm/mach-omap2/clock2xxx.h
> > arch/arm/mach-omap2/clock2420_data.c
> > arch/arm/mach-mxs/clock-mx23.c
> > arch/arm/mach-mxs/clock.c
> > arch/arm/mach-mxs/timer.c
> > arch/arm/mach-mxs/system.c
> > arch/arm/mach-mxs/clock-mx28.c
> > arch/arm/mach-mxs/mach-mx28evk.c
> > arch/arm/kernel/smp_twd.c
> > drivers/gpio/gpio-pxa.c
> > drivers/tty/serial/amba-pl011.c
> > drivers/tty/serial/mxs-auart.c
> > drivers/tty/serial/amba-pl010.c
> > drivers/amba/bus.c
> > drivers/net/ethernet/freescale/fec.c
> > drivers/net/can/flexcan.c
> > drivers/video/omap2/dss/dsi.c
> > drivers/video/amba-clcd.c
> > drivers/video/mxsfb.c
> > drivers/staging/tidspbridge/include/dspbridge/clk.h
> > drivers/staging/tidspbridge/core/dsp-clock.c
> > drivers/spi/spi-pl022.c
> > drivers/mmc/host/mmci.c
> > drivers/mmc/host/mxs-mmc.c
> > drivers/dma/mxs-dma.c
> > drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> >
> > My conclusion, therefore, is that there's very little actual interest
> > amongst the ARM community to move towards a common clk API.
> 
> Maybe it's a chicken-egg thing; nobody wants to work on it until someone else
> has done some legwork? :)

That was the precise problem which clk_prepare() was meant to solve.
Precisely nothing was happening in terms of mainline with all the
discussions going around in circles.

We managed to settle on how to solve the problem where some platforms
want different characteristics from clk_enable(), and nothing happened.
The discussion kept going around in circles.

The whole point of getting clk_prepare() in early was to avoid a big-bang
day where everything had to be converted in one big step when a platform
decides to use the common API.

We know _definitely_ that a common API is going to need clk_prepare(),
which is why I invested time into kicking that off.  Given the lack of
uptake of it, I don't know why I bothered - I don't even know why I
bothered getting involved in the totally useless discussions first time
around.  It's just been a complete and utter waste of my time.

Like many things in the ARM community, trying to motivate people is an
impossibility.  It can be seen time and time again.  Like the restart
changes.

It's times like this I don't know why I bother.  That's why I've been
hacking on the old SA11x0 platforms since Christmas.  At least I don't
have to deal with trying to get concensus between arguing factions
which _never_ makes progress even when there's agreement.  I don't have
to bother with kicking people to get them to update their own hairy code.
With obsolete hardware there _aren't_ any factions to kick together to
agree.

As I said, I've lost interest in the common clk API.  Totally.  Completely.
I really don't care so long as it doesn't create difficulties for me and
the platforms I care about.  That's all I'm going to care about over the
common clk API in future.  Not whether it solves other peoples problems.
Call me selfish, but I think it's one of the times I'm justified to be
given how much work I've tried to put in to that area.
