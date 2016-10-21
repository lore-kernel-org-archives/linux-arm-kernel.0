From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Oct 2016 17:45:30 +0200
Subject: [PATCH v4 00/23] soc: renesas: Add R-Car RST driver for
 obtaining mode pin state
In-Reply-To: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1477064730.2508.24.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

     A. Hi Geert,

Am Freitag, den 21.10.2016, 15:17 +0200 schrieb Geert Uytterhoeven:
>         Hi Philipp, Mike, Stephen, Simon, Magnus,
> 	(see questions *** below!)
> 
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

I think you should add a binding doc even though the DT bindings are
still trivial.

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
> 
>   - Philip: While this is a driver for a reset-controller, currently it
>     doesn't provide any reset-controller functionality. Hence I added it
>     to drivers/soc/renesas/. Is that OK for you?

Absolutely, as long as the driver isn't even a reset controller
provider, this is the right place.

regards
Philipp
