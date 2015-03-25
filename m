From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 25 Mar 2015 15:04:28 -0700
Subject: [PATCH v2 0/3] clk: sunxi: Add muxable AHB clock to fix hstimer
 issues
In-Reply-To: <20150325215309.GN23664@lukather>
References: <1427217729-10017-1-git-send-email-wens@csie.org>
 <20150325185152.GM23664@lukather>
 <CAGb2v66e=ssx=gPMVkc=u0WbhtwCHgbR2Vg3Q3wNTSsBZniaMA@mail.gmail.com>
 <20150325215309.GN23664@lukather>
Message-ID: <CAGb2v66JqdGLZSAtAds+On3vBe-9Z=o7eQM0MPh42A5jx1fO-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 2:53 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Mar 25, 2015 at 01:13:46PM -0700, Chen-Yu Tsai wrote:
>> On Wed, Mar 25, 2015 at 11:51 AM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Wed, Mar 25, 2015 at 01:22:06AM +0800, Chen-Yu Tsai wrote:
>> >> Hi everyone,
>> >>
>> >> This is v2 of the sun5i muxable AHB clock series.
>> >>
>> >> Changes since v1:
>> >>
>> >>   - Dropped patches 1~3 that are merged
>> >>   - Extend comments to clarify what the "base factor clock" refers to,
>> >>     and what the divs clocks outputs should be.
>> >>
>> >>
>> >> This series adds support for the muxable ahb clock on sun5/7i. The mux
>> >> has inputs such as the axi clock, the cpu clock on sun5i, and pll6 with
>> >> various dividers. The goal is to have ahb muxed to pll6, which should
>> >> be a fixed rate albeit configurable clock. This fixes issues with
>> >> cpufreq changing the cpu frequency, which would affect the hstimer
>> >> clocked from ahb.
>> >>
>> >> Patch 1 makes divs clocks explicitly specify in the driver which output
>> >> is the base factor clock, instead of always putting it in last. This is
>> >> done to ensure DT bindings compatibility when we add outputs.
>> >>
>> >> Patch 2 adds the new pll6/4 output, which is used on sun7i as an input
>> >> to ahb mux.
>> >>
>> >> Patch 3 updates the dtsi files with the new drivers.
>> >>
>> >> The series is also available at
>> >>
>> >>     https://github.com/wens/linux/commits/sun5i-ahb-v2
>> >
>> > Applied all three. I think it would be great to convert the later SoCs
>> > to that too, just to make sure we have the same policy on all SoCs.
>>
>> For sun6i this is already doable. We just move the assignment from the
>> dmaengine node to the clock node.
>
> Yep.

Sent out a patch as part of the sun6i cpufreq series.

>> For sun8i the default divider results in 300 MHz for AHB, which might
>> be too fast.
>
> I guess you're talking about AHB1? APB2 should be muxed to PLL6 as
> well.

Ah, AHB1 yes. Is APB2 muxed from OSC 24MHz too slow?

>> And we can't do clock rate assignment yet. The clock drivers need
>> to be split out.
>
> Why?

The clock rate is propagated down the tree from the root OSC 24M
clock. Unfortunately it is registered after all the A23 clocks,
due to the way the sunxi clock driver works. So at the time the
AHB1 clock is registered, the parent clocks all have rate=0,
as there is no proper reference value for all the factor clocks
to calculate their rates.

ChenYu

>> For sun9i it is already the default.
>
> Perfect.
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
