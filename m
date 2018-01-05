From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 5 Jan 2018 15:35:13 +0100
Subject: [PATCH v4 2/6] clk: renesas: rcar-gen3: Add Z2 clock divider
 support
In-Reply-To: <20180105140401.7iitpzdrlyqtasvz@verge.net.au>
References: <20180103121840.29316-1-horms+renesas@verge.net.au>
 <20180103121840.29316-3-horms+renesas@verge.net.au>
 <CAMuHMdXcLhFD825Xi2Uk=6_OAgLd7BEp14rWpgb7pv6rOM2H2Q@mail.gmail.com>
 <20180105140401.7iitpzdrlyqtasvz@verge.net.au>
Message-ID: <CAMuHMdWk3ke6GriUdxHp_62r-REYV3P4qNiNGOcGRiCQWCyKAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Jan 5, 2018 at 3:04 PM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jan 03, 2018 at 01:47:08PM +0100, Geert Uytterhoeven wrote:
>> On Wed, Jan 3, 2018 at 1:18 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
>> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> >
>> > This patch adds Z2 clock divider support for R-Car Gen3 SoC.
>> >
>> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

>> As the CPG/MSSR driver now has suspend/resume support, do we need
>> a notifier to restore the Z or Z2 registers? Or is that handled automatically
>> by cpufreq during system resume, for both the primary and the secondary
>> CPU cores?
>
> I am a bit unsure.
>
> When using the A57 cores, which is the default case, the Z clk is queried
> by CPUFreq on resume. It appears that on my system its already set to the
> correct value but I assume if it was not then it would be reset. However,
> this does not cover Z2 clk. So perhaps to be safe we need to register
> notifiers and make sure they they play nicely with CPUFreq?

Of course the CPU is special: unlike many other devices, it must be running
when the kernel is reentered upon system resume.
It may be running using a different frequency setting, though.
However, following "opp-suspend", the system will always suspend with the
Z clock running at 1.5GHz, which is the default?
So Z is probably OK.

It's more interesting to check what happens when the little cores are
enabled as well (unfortunately that requires different firmware).
1. Does cpufreq handle them correctly when they are onlined again during
   system resume?
2. What happens if you offline all big cores, and enter system suspend
   running with little cores only?
   Perhaps that's prevented by the "opp-suspend" property as well?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
