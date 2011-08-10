From: olof@lixom.net (Olof Johansson)
Date: Wed, 10 Aug 2011 03:59:41 -0700
Subject: [PATCH 4/5 V2] ARM: tegra: paz00: add clocks
	requiredforusboperation
In-Reply-To: <201108101250.48324.marvin24@gmx.de>
References: <201108092126.28521.marvin24@gmx.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04A06873BB@HQMAIL01.nvidia.com>
	<201108101024.57494.marvin24@gmx.de>
	<201108101250.48324.marvin24@gmx.de>
Message-ID: <CAOesGMjmkchniG5Nd2M3wW8_RXQbSQQzspMVGGvbmF5Naf94SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 3:50 AM, Marc Dietich <marvin24@gmx.de> wrote:
>> > Marc Dietrich wrote at Tuesday, August 09, 2011 1:26 PM:
>> > > On Tuesday 09 August 2011 20:35:45 you wrote:
>> > > > [...]
>> > > > Do you need the pll_p_out4 entry? What's that driving? Check in
>> > > > /sys/kernel/debug/clock/clock_tree (/sys/kernel/debug is debugfs).
>> > >
>> > > I think it is only required to setup the correct (non-standard?)
>> > > frequency. Seems all other boards use 108 MHz which cause one of the
>> > > ports to fail. Don't ask me for details ...
>> >
>> > ...
>> >
>> > > root at ac100:~# cat /sys/kernel/debug/clock/clock_tree
>> > >
>> > > ? ?clock ? ? ? ? ? ? ? ? ? ? ? ? ?state ?ref div ? ? ?rate
>> > >
>> > > --------------------------------------------------------------
>> > >
>> > > ? ?clk_m ? ? ? ? ? ? ? ? ? ? ? ? ?on ? ? 9 ? ? ? ? ? ?12000000
>> >
>> > ...
>> >
>> > > ? ? ? pll_p ? ? ? ? ? ? ? ? ? ? ? on ? ? 10 ?x18 ? ? ?216000000
>> >
>> > ...
>> >
>> > > ? ? ? ? ?pll_p_out4 ? ? ? ? ? ? ? on ? ? 3 ? 9 ? ? ? ?24000000
>> > >
>> > > ? ? ? ? ? ? sclk ? ? ? ? ? ? ? ? ?on ? ? 2 ? ? ? ? ? ?24000000
>> > >
>> > > ? ? ? ? ? ? ? ?avp.sclk ? ? ? ? ? off ? ?0 ? ? ? ? ? ?24000000
>> > > ? ? ? ? ? ? ? ?cop ? ? ? ? ? ? ? ?on ? ? 1 ? ? ? ? ? ?24000000
>> > > ? ? ? ? ? ? ? ?hclk ? ? ? ? ? ? ? on ? ? 2 ? 1 ? ? ? ?24000000
>> > >
>> > > ? ? ? ? ? ? ? ? ? pclk ? ? ? ? ? ?on ? ? 2 ? 2 ? ? ? ?12000000
>> > >
>> > > ? ? ? ? ? ? ? ? ? ? ?apbdma ? ? ? on ? ? 1 ? 1 ? ? ? ?12000000
>> >
>> > Hmm. That's pretty odd.
>> >
>> > With the standard kernel the device ships with, what does the clock tree
>> > under pll_p_out4 look like? It'd be very interesting to compare that. If
>> > that setup is the same as what this patch sets up, the patch seems fine.
>>
>> unfortunately, there is no such think in .32 kernel (the kernel deliverd
>> with the device), and I don't think I can port it over.
>>
>> > As far as I know all the clocks there are both unrelated to USB, and
>> > internal to the device, so the board shouldn't have any effect. In
>> > particular, avp.sclk/cop are for the internal media CPU/DSP, hclk/pclk
>> > are the internal AHB/APB bus clocks, and apbdma is for an internal DMA
>> > engine, currently only used for audio in the mainline kernel at least.
>>
>> Does this mean that the internal busses you mentioned are also running at
>> low speed? Would this be a hugh performance penality?
>
> maybe this is why in the commit mentioned below sclk is bind to pll_c_out1 and
> set to 108 MHz again.
>
> But I cannot see this change in the current seaboard clock table (optimized
> away?). Maybe someone with a seaboard could check this.

We moved some of this to common.c, and should be posting those patches
in a while. It doesn't make sense to run sclk on pll_m, since that one
scales with memory clock scaling.


-Olof
