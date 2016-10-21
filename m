From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 15:17:14 +0200
Subject: [PATCH v4 00/23] soc: renesas: Add R-Car RST driver for obtaining
 mode pin state
Message-ID: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

        Hi Philipp, Mike, Stephen, Simon, Magnus,
	(see questions *** below!)

Currently the R-Car Clock Pulse Generator (CPG) drivers obtains the
state of the mode pins either by a call from the platform code, or
directly by using a hardcoded register access. This is a bit messy, and
creates a dependency between driver and platform code.

This patch series converts the various Renesas R-Car clock drivers
and support code from reading the mode pin states using a hardcoded
register access to using a new minimalistic R-Car RST driver.

All R-Car clock drivers will rely on the presence in DT of a device node
for the RST module.  Backwards compatibility with old DTBs is retained
only for R-Car Gen2, which has fallback code using its own private copy
of rcar_gen2_read_mode_pins().

After this, there is still one remaining user of
rcar_gen2_read_mode_pins() left in platform code. A patch series to
remove that user has already been posted, though ("[PATCH/RFT 0/4] ARM:
shmobile: R-Car Gen2: Allow booting secondary CPU cores in debug mode").
Since v3, the other user has been removed in commit 9f5ce39ddb8f68b3
("ARM: shmobile: rcar-gen2: Obtain extal frequency from DT").

This series consists of 5 parts:
  A. Patches 1 and 2 add DT bindings and driver code for the R-Car RST
     driver,
  B. Patches 3-11 add device nodes for the RST modules to the R-Car DTS
     files,
  C. Patches 12-17 convert the clock drivers to call into the new R-Car
     RST driver,
  D. Patches 18-20 remove passing mode pin state to the clock drivers
     from the platform code,
  E. Patches 21-23 remove dead code from the clock drivers.

As is usually the case with moving functionality from platform code to
DT, there are lots of hard dependencies:
  - The DT updates in Part B can be merged as soon as the DT bindings in
    Part A have been approved,
  - The clock driver updates in Part C depend functionally on the driver
    code in Part A, and on the DT updates in Part B,
  - The board code cleanups in Part D depend on the clock driver updates
    in Part C,
  - The block driver cleanups in part E depend on the board code
    cleanups in part D.

Hence to maintain the required lockstep between SoC driver, clock
drivers, shmobile platform code, and shmobile DT, I propose to queue up
all patches in a single branch against v4.9-rc1, and send pull requests
to both Mike/Stephen (clock) and Simon (rest).

***

  - Philip: While this is a driver for a reset-controller, currently it
    doesn't provide any reset-controller functionality. Hence I added it
    to drivers/soc/renesas/. Is that OK for you?

  - Mike/Stephen/Simon/Magnus: Are you OK with the suggested merge
    approach above?

This series has evolved over time, cfr.:
  - "[PATCH/RFC v3 00/22] soc: renesas: Add R-Car RST driver for
    obtaining mode pin state"
    (http://www.spinics.net/lists/linux-renesas-soc/msg04289.html),
  - "[PATCH/RFC 00/11] ARM: shmobile: Let CPG use syscon for MD pin
    values" (http://www.spinics.net/lists/linux-clk/msg01478.html),
  - "[PATCH 00/10] arm64: renesas: Obtain MD pin values using
    syscon/regmap".
    (http://www.spinics.net/lists/linux-sh/msg44757.html)

Changes compared to v3:
  - Add Acked-by, Reviewed-by,
  - Add support for R-Car V2H,
  - Add support for RZ/G1M and RZ/G1E,
  - Remove the initcall and the rcar_rst_base check in rcar_rst_init(),
    as rcar_rst_init() is only used as a support function for
    rcar_rst_read_mode_pins(),
  - Refer to rcar_rst_gen2 for R-Car Gen3 instead of providing an
    identical copy,
  - Use our own private copy of rcar_gen2_read_mode_pins() instead of
    the one in the R-Car Gen2 platform code, as the latter is planned to
    be removed,
  - Rebase on top of "ARM: shmobile: rcar-gen2: Obtain extal frequency
    from DT",

Changes compared to v2:
  - Use "renesas,<soctype>-rst" instead of "renesas,rst-<soctype>",
  - Drop "syscon" compatible value and "renesas,modemr" property, use a
    real driver instead,
  - Add support for R-Car M1A, H1, and M3-W.

Changes compared to v1:
  - Add support for R-Car H3.

This patch series is against v4.9-rc1. When applying it to
renesas-devel-20161021-v4.9-rc1, there's a small conflict in
drivers/soc/renesas/Makefile (both sides added lines).

For your convenience, this series is also available in the
topic/rcar-rst-v4 branch of my renesas-drivers git repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
This has been tested on r8a7778/bockw, r8a7779/marzen, r8a7791/koelsch,
r8a7795/salvator-x, and r8a7796/salvator-x.

Thanks!

Geert Uytterhoeven (23):
  reset: Add renesas,rst DT bindings
  soc: renesas: Add R-Car RST driver
  ARM: dts: r8a7778: Add device node for RESET/WDT module
  ARM: dts: r8a7779: Add device node for RESET/WDT module
  ARM: dts: r8a7790: Add device node for RST module
  ARM: dts: r8a7791: Add device node for RST module
  ARM: dts: r8a7792: Add device node for RST module
  ARM: dts: r8a7793: Add device node for RST module
  ARM: dts: r8a7794: Add device node for RST module
  arm64: renesas: r8a7795 dtsi: Add device node for RST module
  arm64: renesas: r8a7796 dtsi: Add device node for RST module
  clk: renesas: r8a7778: Obtain mode pin values using R-Car RST driver
  clk: renesas: r8a7779: Obtain mode pin values from R-Car RST driver
  clk: renesas: rcar-gen2: Obtain mode pin values using RST driver
  clk: renesas: r8a7795: Obtain mode pin values from R-Car RST driver
  clk: renesas: r8a7796: Obtain mode pin values from R-Car RST driver
  clk: renesas: rcar-gen3-cpg: Remove obsolete
    rcar_gen3_read_mode_pins()
  ARM: shmobile: r8a7778: Stop passing mode pins state to clock driver
  ARM: shmobile: r8a7779: Stop passing mode pins state to clock driver
  ARM: shmobile: rcar-gen2: Stop passing mode pins state to clock driver
  clk: renesas: r8a7778: Remove obsolete r8a7778_clocks_init()
  clk: renesas: r8a7779: Remove obsolete r8a7779_clocks_init()
  clk: renesas: rcar-gen2: Remove obsolete rcar_gen2_clocks_init()

 .../devicetree/bindings/reset/renesas,rst.txt      | 37 +++++++++
 arch/arm/boot/dts/r8a7778.dtsi                     |  5 ++
 arch/arm/boot/dts/r8a7779.dtsi                     |  5 ++
 arch/arm/boot/dts/r8a7790.dtsi                     |  5 ++
 arch/arm/boot/dts/r8a7791.dtsi                     |  5 ++
 arch/arm/boot/dts/r8a7792.dtsi                     |  5 ++
 arch/arm/boot/dts/r8a7793.dtsi                     |  5 ++
 arch/arm/boot/dts/r8a7794.dtsi                     |  5 ++
 arch/arm/mach-shmobile/setup-r8a7778.c             | 15 ----
 arch/arm/mach-shmobile/setup-r8a7779.c             | 27 -------
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |  5 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  5 ++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  5 ++
 drivers/clk/renesas/clk-r8a7778.c                  | 26 +++---
 drivers/clk/renesas/clk-r8a7779.c                  | 18 ++---
 drivers/clk/renesas/clk-rcar-gen2.c                | 32 ++++++--
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |  8 +-
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |  8 +-
 drivers/clk/renesas/rcar-gen3-cpg.c                | 17 ----
 drivers/clk/renesas/rcar-gen3-cpg.h                |  1 -
 drivers/soc/renesas/Makefile                       |  5 ++
 drivers/soc/renesas/rcar-rst.c                     | 92 ++++++++++++++++++++++
 include/linux/clk/renesas.h                        |  4 -
 include/linux/soc/renesas/rcar-rst.h               |  6 ++
 24 files changed, 246 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt
 create mode 100644 drivers/soc/renesas/rcar-rst.c
 create mode 100644 include/linux/soc/renesas/rcar-rst.h

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
