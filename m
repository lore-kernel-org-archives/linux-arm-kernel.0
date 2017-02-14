From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Feb 2017 10:01:51 +0800
Subject: [linux-sunxi] Re: Allwinner A31 framebuffer fails with new CCU
 clock bindings
In-Reply-To: <1487022097.7145.43.camel@settrans.net>
References: <1486814920.7145.19.camel@settrans.net>
 <20170213095207.tsqcigfhyftm5ohk@lukather>
 <1487022097.7145.43.camel@settrans.net>
Message-ID: <CAGb2v67wgDZx1nXKVEUcgbgm=50FwSceVQkz-vtBXZrj7YLx9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 5:41 AM, Bob Ham <rah@settrans.net> wrote:
> On Mon, 2017-02-13 at 10:52 +0100, Maxime Ripard wrote:
>> On Sat, Feb 11, 2017 at 12:08:40PM +0000, Bob Ham wrote:
>> > On IRC, MoeIcenowy requested the contents
>> > of /sys/kernel/debug/clk/clk_summary.  I don't know how useful it will
>> > be but I've put up two versions, one from the bad commit and another
>> > from the previous, good commit in the bisect:
>> >
>> > http://settrans.net/~rah/misc/sun6i-a31-bad-fb-clk_summary-good.txt
>> > http://settrans.net/~rah/misc/sun6i-a31-bad-fb-clk_summary-bad.txt
>>
>> Are you sure the good one works? None of the display clocks are
>> enabled.
>
> Definitely.  Here's clk_summary from an even earlier kernel from Debian,
> 4.7.8-1:
>
> http://settrans.net/~rah/misc/sun6i-a31-bad-fb-clk_summary-good-4.7.8-1.txt
>
> And to make super sure, he's a *screenshot* of a terminal in X running
> on that kernel, showing every line with "0" in the second column:
>
> http://settrans.net/~rah/misc/sun6i-a31-bad-fb-clk_summary-good-4.7.8-1.png
>
> Does this imply something odd in this hardware or a problem with the
> kernel?
>
>
>> Could you add "clk_ignore_unused" to the kernel boot parameters and
>> see if it works?
>
> That does indeed work.  On the same kernel which produced
> sun6i-a31-bad-fb-clk_summary-bad.txt, with clk_ignore_unused added to
> the boot parameters, the console continues to show output all through
> booting and X runs fine.  Here is the clk_summary:
>
> http://settrans.net/~rah/misc/sun6i-a31-bad-fb-clk_summary-clk_ignore_unused.txt
>
> Can I ask what clk_ignore_unused does that might have fixed this?

clk_ignore_unused tells the kernel not to disable any unused clocks
that were enabled by default or by the bootloader.

In this case I think I've identified the problem. The enable bit offset
for the hdmi-ddc clock is wrong, and actually pointing to the main hdmi
module clock.

I'll send a patch for it.

Regards
ChenYu
