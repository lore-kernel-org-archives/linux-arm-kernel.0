From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 26 Oct 2016 14:00:24 +0200
Subject: [PATCH v4 00/23] soc: renesas: Add R-Car RST driver for obtaining
 mode pin state
In-Reply-To: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdVbpuv94x-ocTSDoEj+SbnESDbkuMXsXExQvoyZepp+Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

On Fri, Oct 21, 2016 at 3:17 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Currently the R-Car Clock Pulse Generator (CPG) drivers obtains the
> state of the mode pins either by a call from the platform code, or
> directly by using a hardcoded register access. This is a bit messy, and
> creates a dependency between driver and platform code.
>
> This patch series converts the various Renesas R-Car clock drivers
> and support code from reading the mode pin states using a hardcoded
> register access to using a new minimalistic R-Car RST driver.
>
> All R-Car clock drivers will rely on the presence in DT of a device node
> for the RST module.  Backwards compatibility with old DTBs is retained
> only for R-Car Gen2, which has fallback code using its own private copy
> of rcar_gen2_read_mode_pins().
>
> After this, there is still one remaining user of
> rcar_gen2_read_mode_pins() left in platform code. A patch series to
> remove that user has already been posted, though ("[PATCH/RFT 0/4] ARM:
> shmobile: R-Car Gen2: Allow booting secondary CPU cores in debug mode").
> Since v3, the other user has been removed in commit 9f5ce39ddb8f68b3
> ("ARM: shmobile: rcar-gen2: Obtain extal frequency from DT").
>
> This series consists of 5 parts:
>   A. Patches 1 and 2 add DT bindings and driver code for the R-Car RST
>      driver,
>   B. Patches 3-11 add device nodes for the RST modules to the R-Car DTS
>      files,
>   C. Patches 12-17 convert the clock drivers to call into the new R-Car
>      RST driver,
>   D. Patches 18-20 remove passing mode pin state to the clock drivers
>      from the platform code,
>   E. Patches 21-23 remove dead code from the clock drivers.
>
> As is usually the case with moving functionality from platform code to
> DT, there are lots of hard dependencies:
>   - The DT updates in Part B can be merged as soon as the DT bindings in
>     Part A have been approved,
>   - The clock driver updates in Part C depend functionally on the driver
>     code in Part A, and on the DT updates in Part B,
>   - The board code cleanups in Part D depend on the clock driver updates
>     in Part C,
>   - The block driver cleanups in part E depend on the board code
>     cleanups in part D.
>
> Hence to maintain the required lockstep between SoC driver, clock
> drivers, shmobile platform code, and shmobile DT, I propose to queue up
> all patches in a single branch against v4.9-rc1, and send pull requests
> to both Mike/Stephen (clock) and Simon (rest).
>
> ***

>   - Mike/Stephen/Simon/Magnus: Are you OK with the suggested merge
>     approach above?

Is this OK for you?

I'd like to move forward with this, as this is a prerequisite for adding
support for new SoCs (RZ/G) without adding more copies of
rcar_gen2_read_mode_pins(), and removing that function from platform code
for good.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
