From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 2 Nov 2016 10:02:53 +0100
Subject: [PATCH v4 00/23] soc: renesas: Add R-Car RST driver for obtaining
 mode pin state
In-Reply-To: <20161031232537.GT16026@codeaurora.org>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdVbpuv94x-ocTSDoEj+SbnESDbkuMXsXExQvoyZepp+Zg@mail.gmail.com>
 <20161031081923.GF18195@verge.net.au>
 <CAMuHMdXA-hemOT=ZysEfettei9=HsDddGhqddkw38hwRrdeagw@mail.gmail.com>
 <20161031232537.GT16026@codeaurora.org>
Message-ID: <CAMuHMdXOW4Ubafu=x9pCw_W-MtLGe3N974dbfHCH5TJuUAeYrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for your answers!

On Tue, Nov 1, 2016 at 12:25 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/31, Geert Uytterhoeven wrote:
>> Hi Mike, Stephen, Arnd, Olof, Kevin,
>>
>> Is the merge strategy [see ##### below] OK for you?
>> Thanks a lot!
>>
>> On Mon, Oct 31, 2016 at 9:19 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Wed, Oct 26, 2016 at 02:00:24PM +0200, Geert Uytterhoeven wrote:
>> >> On Fri, Oct 21, 2016 at 3:17 PM, Geert Uytterhoeven
>> >> <geert+renesas@glider.be> wrote:
>> >> > Currently the R-Car Clock Pulse Generator (CPG) drivers obtains the
>> >> > state of the mode pins either by a call from the platform code, or
>> >> > directly by using a hardcoded register access. This is a bit messy, and
>> >> > creates a dependency between driver and platform code.
>> >> >
>> >> > This patch series converts the various Renesas R-Car clock drivers
>> >> > and support code from reading the mode pin states using a hardcoded
>> >> > register access to using a new minimalistic R-Car RST driver.
>> >> >
>> >> > All R-Car clock drivers will rely on the presence in DT of a device node
>> >> > for the RST module.  Backwards compatibility with old DTBs is retained
>> >> > only for R-Car Gen2, which has fallback code using its own private copy
>> >> > of rcar_gen2_read_mode_pins().
>> >> >
>> >> > After this, there is still one remaining user of
>> >> > rcar_gen2_read_mode_pins() left in platform code. A patch series to
>> >> > remove that user has already been posted, though ("[PATCH/RFT 0/4] ARM:
>> >> > shmobile: R-Car Gen2: Allow booting secondary CPU cores in debug mode").
>> >> > Since v3, the other user has been removed in commit 9f5ce39ddb8f68b3
>> >> > ("ARM: shmobile: rcar-gen2: Obtain extal frequency from DT").
>> >> >
>> >> > This series consists of 5 parts:
>> >> >   A. Patches 1 and 2 add DT bindings and driver code for the R-Car RST
>> >> >      driver,
>> >> >   B. Patches 3-11 add device nodes for the RST modules to the R-Car DTS
>> >> >      files,
>> >> >   C. Patches 12-17 convert the clock drivers to call into the new R-Car
>> >> >      RST driver,
>> >> >   D. Patches 18-20 remove passing mode pin state to the clock drivers
>> >> >      from the platform code,
>> >> >   E. Patches 21-23 remove dead code from the clock drivers.
>> >> >
>> >> > As is usually the case with moving functionality from platform code to
>> >> > DT, there are lots of hard dependencies:
>> >> >   - The DT updates in Part B can be merged as soon as the DT bindings in
>> >> >     Part A have been approved,
>> >> >   - The clock driver updates in Part C depend functionally on the driver
>> >> >     code in Part A, and on the DT updates in Part B,
>> >> >   - The board code cleanups in Part D depend on the clock driver updates
>> >> >     in Part C,
>> >> >   - The block driver cleanups in part E depend on the board code
>> >> >     cleanups in part D.
>> >> >
>> >> > Hence to maintain the required lockstep between SoC driver, clock
>> >> > drivers, shmobile platform code, and shmobile DT, I propose to queue up
>> >> > all patches in a single branch against v4.9-rc1, and send pull requests
>> >> > to both Mike/Stephen (clock) and Simon (rest).
>> >> >
>> >> > ***
>> >>
>> >> >   - Mike/Stephen/Simon/Magnus: Are you OK with the suggested merge
>> >> >     approach above?
>> >>
>> >> Is this OK for you?
>>
>> #####
>>
>> (link to the full series at
>>  https://groups.google.com/forum/#!topic/linux.kernel/fLSFsjOgPT8)
>
> Would the pull requests for clk also have dts changes at the base
> of the tree? Perhaps clk side can just ack the clk patches and

Yes they would: this is moving functionality from platform code to DT.
Without the DT updates, it will break bisection (except for R-Car Gen2,
where we have fallback code to handle old DTBs).

> then have it all routed through arm-soc? The only worry I have is
> if we need to make some sort of change in clk side that conflicts
> with these changes. I don't usually like taking dts changes
> through clk tree, so I'd like to avoid that if possible.

Everything could go through arm-soc only with your Acked-by.
However, there are new clock drivers pending on this series.
Either they have to go through arm-soc, too, or this series would
be pulled into the clk tree with these new clock drivers.

> Part E could happen anytime after everything else happens, so
> that doesn't seem like a concern.

Part E can indeed by postponed.
But if parts A-D are applied together, there's no reason to postpone part E.

> Part C could also be made to
> only call into the new reset drivers if the reset dts nodes are
> present? If that's done then we could merge clk patches anytime
> and remove the dead code and the node search at some later time
> when everything has settled?

That would require adding more backwards compatibility code for
old DTBs, even for platform where we're not interested in maintaining
that. In addition, Part C depends on the header file for the reset driver
to compile the clock driver, even if you would add some DT detection,
and on the reset driver to link. So I'm afraid this is not feasible.

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
