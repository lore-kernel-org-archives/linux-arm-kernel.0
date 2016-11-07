From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 7 Nov 2016 10:30:05 +0100
Subject: [PATCH v4 00/23] soc: renesas: Add R-Car RST driver for obtaining
 mode pin state
In-Reply-To: <20161104194914.GB16026@codeaurora.org>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdVbpuv94x-ocTSDoEj+SbnESDbkuMXsXExQvoyZepp+Zg@mail.gmail.com>
 <20161031081923.GF18195@verge.net.au>
 <CAMuHMdXA-hemOT=ZysEfettei9=HsDddGhqddkw38hwRrdeagw@mail.gmail.com>
 <20161031232537.GT16026@codeaurora.org>
 <CAMuHMdXOW4Ubafu=x9pCw_W-MtLGe3N974dbfHCH5TJuUAeYrQ@mail.gmail.com>
 <20161104194914.GB16026@codeaurora.org>
Message-ID: <CAMuHMdUL3GcOoNjd78wn_m0YRQvh8D5RGcC+RaRxEDpQCQxB5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Nov 4, 2016 at 8:49 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 11/02, Geert Uytterhoeven wrote:
>> On Tue, Nov 1, 2016 at 12:25 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> >
>> > Would the pull requests for clk also have dts changes at the base
>> > of the tree? Perhaps clk side can just ack the clk patches and
>>
>> Yes they would: this is moving functionality from platform code to DT.
>> Without the DT updates, it will break bisection (except for R-Car Gen2,
>> where we have fallback code to handle old DTBs).
>>
>> > then have it all routed through arm-soc? The only worry I have is
>> > if we need to make some sort of change in clk side that conflicts
>> > with these changes. I don't usually like taking dts changes
>> > through clk tree, so I'd like to avoid that if possible.
>>
>> Everything could go through arm-soc only with your Acked-by.
>> However, there are new clock drivers pending on this series.
>> Either they have to go through arm-soc, too, or this series would
>> be pulled into the clk tree with these new clock drivers.
>>
>> > Part E could happen anytime after everything else happens, so
>> > that doesn't seem like a concern.
>>
>> Part E can indeed by postponed.
>> But if parts A-D are applied together, there's no reason to postpone part E.
>>
>> > Part C could also be made to
>> > only call into the new reset drivers if the reset dts nodes are
>> > present? If that's done then we could merge clk patches anytime
>> > and remove the dead code and the node search at some later time
>> > when everything has settled?
>>
>> That would require adding more backwards compatibility code for
>> old DTBs, even for platform where we're not interested in maintaining
>> that. In addition, Part C depends on the header file for the reset driver
>> to compile the clock driver, even if you would add some DT detection,
>> and on the reset driver to link. So I'm afraid this is not feasible.
>
> TL;DR: Sounds fine, I'll be on the lookout for the PR.

Thank you very much!

> Longer version: Let me step back a bit and actually think about
> this longer than 2 minutes. From what I see
> rcar_rst_read_mode_pins() already returns -ENODEV if the nodes
> aren't present. Great.
>
> So clk tree could be given a pull for the clk patches, part C, on
> top of part A, the reset driver. If the rcar_rst_read_mode_pins()
> returns failure because the node is missing, we fall back to the
> old style of doing things. Some drivers already do that anyway,

For R-Car Gen2, we want to keep backwards compatibility for a while.
But not for the others, and I didn't want to add more code that was going
to be removed again soon.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
