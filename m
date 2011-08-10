From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 10 Aug 2011 08:24:46 -0700
Subject: [PATCH 4/5 V2] ARM: tegra: paz00: add clocks required
	forusboperation
In-Reply-To: <201108101024.57494.marvin24@gmx.de>
References: <201108092126.28521.marvin24@gmx.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04A06873BB@HQMAIL01.nvidia.com>
	<201108101024.57494.marvin24@gmx.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04A0687486@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietich wrote at Wednesday, August 10, 2011 2:25 AM:
> Hi Stephen,
> 
> > Marc Dietrich wrote at Tuesday, August 09, 2011 1:26 PM:
> > > On Tuesday 09 August 2011 20:35:45 you wrote:
> > > > [...]
> > > > Do you need the pll_p_out4 entry? What's that driving? Check in
> > > > /sys/kernel/debug/clock/clock_tree (/sys/kernel/debug is debugfs).
> > >
> > > I think it is only required to setup the correct (non-standard?)
> > > frequency. Seems all other boards use 108 MHz which cause one of the
> > > ports to fail. Don't ask me for details ...
...
> > As far as I know all the clocks there are both unrelated to USB, and
> > internal to the device, so the board shouldn't have any effect. In
> > particular, avp.sclk/cop are for the internal media CPU/DSP, hclk/pclk
> > are the internal AHB/APB bus clocks, and apbdma is for an internal DMA
> > engine, currently only used for audio in the mainline kernel at least.
> 
> Does this mean that the internal busses you mentioned are also running at low
> speed? Would this be a hugh performance penality?

Yes, I think this will cause a lower bus speed. I don't know how much
performance impact this will have; probably mainly just peripheral register
accesses, so not too much of a big deal.

> > I guess I'll ask a few people internally to see if they have a clue why
> > your change might be necessary.
> 
> Also take a look at seaboard, it has the same clock setting and especially
> commit dfb625f934dd40baf29ee6c43e4f130b524411a1 in the chromeos kernel:

Ah yes, DAP_MCLK1/2 don't show up in the clock table. That certainly
explains everything. So, I withdraw any objections to this patch. Do
you want to follow it up with one that reparents sclk? I can test that
on Harmony, Seaboard, and TrimSlice if you want. If not, I'll see if I
can work on that a little later...

> commit dfb625f934dd40baf29ee6c43e4f130b524411a1
> Author: Vincent Palatin <vpalatin@chromium.org>
> Date:   Wed Apr 13 07:26:08 2011 -0400
> 
>     CHROMIUM: tegra: seaboard: fix ULPI transceiver clock
> 
>     On our seaboard-based platforms, pll_p_out4 is used to clock
>     (through DAP_MCLK2) the external USB ULPI transceiver between the USB2
>     port to mini-PCIe modem. And it needs to be set at 24Mhz for the
>     tranceiver to work correctly.
>     Revert the sclk parent to pll_c out1 (as it was before the last change)
>     since it needs to stay clocked at 108MHz.
> 
>     Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> 
>     BUG=chrome-os-partner:3167
>     TEST=Check that the Gobi modem is appearing in lsusb listing
>     Use the kaen DVT for browsing and suspending
> 
>     Review URL: http://codereview.chromium.org/6825076
> 
>     Change-Id: Ia9b1bbc7860da732fb8edbbcf0bce60e82d6d8ed

-- 
nvpublic
