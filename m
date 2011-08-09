From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 9 Aug 2011 14:40:05 -0700
Subject: [PATCH 4/5 V2] ARM: tegra: paz00: add clocks required for
	usboperation
In-Reply-To: <201108092126.28521.marvin24@gmx.de>
References: <201108092126.28521.marvin24@gmx.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04A06873BB@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich wrote at Tuesday, August 09, 2011 1:26 PM:
> On Tuesday 09 August 2011 20:35:45 you wrote:
> > Marc Dietrich wrote at Tuesday, August 09, 2011 12:29 PM:
> > > These clocks are required for usb operation.
> > > ---
> > >
> > >  arch/arm/mach-tegra/board-paz00.c |    6 ++++++
> > >  1 files changed, 6 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-tegra/board-paz00.c
> > > b/arch/arm/mach-tegra/board-paz00.c index 45111f6..89a3dda 100644
> > > --- a/arch/arm/mach-tegra/board-paz00.c
> > > +++ b/arch/arm/mach-tegra/board-paz00.c
> > > @@ -145,6 +145,12 @@ static __initdata struct tegra_clk_init_table
> > > paz00_clk_init_table[] = {
> > >
> > >  	/* name		parent		rate		enabled */
> > >  	{ "uarta",	"pll_p",	216000000,	true },
> > >  	{ "uartd",	"pll_p",	216000000,	true },
> > >
> > > +
> > > +	{ "pll_p_out4",	"pll_p",	24000000,	true },
> >
> > Do you need the pll_p_out4 entry? What's that driving? Check in
> > /sys/kernel/debug/clock/clock_tree (/sys/kernel/debug is debugfs).
> 
> I think it is only required to setup the correct (non-standard?) frequency.
> Seems all other boards use 108 MHz which cause one of the ports to fail. Don't
> ask me for details ...
...
> root at ac100:~# cat /sys/kernel/debug/clock/clock_tree
>    clock                          state  ref div      rate
> --------------------------------------------------------------
>    clk_m                          on     9            12000000
...
>       pll_p                       on     10  x18      216000000
...
>          pll_p_out4               on     3   9        24000000
>             sclk                  on     2            24000000
>                avp.sclk           off    0            24000000
>                cop                on     1            24000000
>                hclk               on     2   1        24000000
>                   pclk            on     2   2        12000000
>                      apbdma       on     1   1        12000000

Hmm. That's pretty odd.

With the standard kernel the device ships with, what does the clock tree
under pll_p_out4 look like? It'd be very interesting to compare that. If
that setup is the same as what this patch sets up, the patch seems fine.

As far as I know all the clocks there are both unrelated to USB, and
internal to the device, so the board shouldn't have any effect. In
particular, avp.sclk/cop are for the internal media CPU/DSP, hclk/pclk
are the internal AHB/APB bus clocks, and apbdma is for an internal DMA
engine, currently only used for audio in the mainline kernel at least.

I guess I'll ask a few people internally to see if they have a clue why
your change might be necessary.

For reference, here's Harmony on something roughly like linux-next:

   clk_m                          on     7            12000000  
...
      pll_p                       on     9   x18      216000000 
...
         pll_p_out4               on     2   2        108000000 
            sclk                  on     2            108000000 
               avp.sclk           off    0            108000000 
               cop                on     1            108000000 
               hclk               on     2   1        108000000 
                  pclk            on     2   2        54000000  
                     apbdma       on     1   1        54000000

-- 
nvpublic
