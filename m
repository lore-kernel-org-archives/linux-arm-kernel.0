From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 Jan 2018 16:46:37 +0100
Subject: [PATCH v4 2/6] clk: renesas: rcar-gen3: Add Z2 clock divider
 support
In-Reply-To: <20180129151928.ooh5uirmjgtyjcjm@verge.net.au>
References: <20180103121840.29316-1-horms+renesas@verge.net.au>
 <20180103121840.29316-3-horms+renesas@verge.net.au>
 <CAMuHMdXcLhFD825Xi2Uk=6_OAgLd7BEp14rWpgb7pv6rOM2H2Q@mail.gmail.com>
 <20180105140401.7iitpzdrlyqtasvz@verge.net.au>
 <CAMuHMdWk3ke6GriUdxHp_62r-REYV3P4qNiNGOcGRiCQWCyKAg@mail.gmail.com>
 <20180129142357.sw3d4f5d4hwmveua@verge.net.au>
 <CAMuHMdU734+i3n5fa1jZfzY+kanH5k07YRLJq_b_UprOh=hSNw@mail.gmail.com>
 <20180129151928.ooh5uirmjgtyjcjm@verge.net.au>
Message-ID: <CAMuHMdVNKFOPqPBPVPZ7a+jBjaOTTAioSp4JjmXE5go_iuC8_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Jan 29, 2018 at 4:19 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Jan 29, 2018 at 04:01:49PM +0100, Geert Uytterhoeven wrote:
>> On Mon, Jan 29, 2018 at 3:24 PM, Simon Horman <horms@verge.net.au> wrote:
>> > On Fri, Jan 05, 2018 at 03:35:13PM +0100, Geert Uytterhoeven wrote:
>> >> On Fri, Jan 5, 2018 at 3:04 PM, Simon Horman <horms@verge.net.au> wrote:
>> >> > On Wed, Jan 03, 2018 at 01:47:08PM +0100, Geert Uytterhoeven wrote:
>> >> >> On Wed, Jan 3, 2018 at 1:18 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
>> >> >> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> >> >> > This patch adds Z2 clock divider support for R-Car Gen3 SoC.
>> >> >> >
>> >> >> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> >> >> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> >>
>> >> >> As the CPG/MSSR driver now has suspend/resume support, do we need
>> >> >> a notifier to restore the Z or Z2 registers? Or is that handled automatically
>> >> >> by cpufreq during system resume, for both the primary and the secondary
>> >> >> CPU cores?
>> >> >
>> >> > I am a bit unsure.
>> >> >
>> >> > When using the A57 cores, which is the default case, the Z clk is queried
>> >> > by CPUFreq on resume. It appears that on my system its already set to the
>> >> > correct value but I assume if it was not then it would be reset. However,
>> >> > this does not cover Z2 clk. So perhaps to be safe we need to register
>> >> > notifiers and make sure they they play nicely with CPUFreq?
>> >>
>> >> Of course the CPU is special: unlike many other devices, it must be running
>> >> when the kernel is reentered upon system resume.
>> >> It may be running using a different frequency setting, though.
>> >> However, following "opp-suspend", the system will always suspend with the
>> >> Z clock running at 1.5GHz, which is the default?
>> >> So Z is probably OK.
>> >>
>> >> It's more interesting to check what happens when the little cores are
>> >> enabled as well (unfortunately that requires different firmware).
>> >> 1. Does cpufreq handle them correctly when they are onlined again during
>> >>    system resume?
>> >
>> > I tested this by updating the firmware on an H3 ES2.0 / Salvator-XS
>> > using the instructions at
>> > https://elinux.org/R-Car/Virtualization#Enabling_HYP_Support
>>
>> > # grep -E -w "pll[01]|z|z2" /sys/kernel/debug/clk/clk_summary
>> >           z2                              0            0  1198080000          0 0
>> >        .pll1                              1            1  3194880000          0 0
>> >        .pll0                              0            0  2995200000          0 0
>> >           z                               0            0  1497600000          0 0
>>
>> You know it's PLL2, not PLL1, you want to look at? ;-)
>
> Sorry, I will double check but I had looked at PLL2 earlier:
> I just messed things up when preparing things to post in email.
>
>> Thanks for checking, looks all good!
>
> Ok, so do you think we can merge this series with
> the off-by-one problem fixed?

Yes we can. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
