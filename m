From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 2 Jun 2016 07:57:46 +0200
Subject: [PATCH/RFC v3 00/22] soc: renesas: Add R-Car RST driver for
 obtaining mode pin state
In-Reply-To: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
Message-ID: <850e7e37-7c41-314d-5996-8e36e6a0d218@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.06.2016 21:20, Geert Uytterhoeven wrote:
> 	Hi all,
>
> Currently the R-Car Clock Pulse Generator (CPG) drivers obtains the
> state of the mode pins either by a call from the board code, or directly
> by using a hardcoded register access. This is a bit messy, and creates a
> dependency between driver and platform code.
>
> This RFC patch series converts the various Renesas R-Car clock drivers
> and support code from reading the mode pin states using a hardcoded
> register access to using a new R-Car RST driver.
>
> This series consists of 5 parts:
>   A. Patches 1 and 2 add DT bindings and driver code for the R-Car RST
>      driver,
>   B. Patches 3-10 add device nodes for the RST modules to the R-Car DTS
>      files,
>   C. Patches 11-16 convert the clock drivers to call into the new R-Car
>      RST driver,
>   D. Patches 17-19 remove passing mode pin state to the clock drivers
>      from the board code,
>   E. Patches 20-22 remove dead code from the clock drivers.
>
> I've kept all parts together as this is an RFC, and to avoid losing the
> bigger picture. I will split it in series per maintainer, when we have
> decided how to handle the dependencies (see below).
>
> After this, there are still a few users of rcar_gen2_read_mode_pins()
> left in board code, which should be converted in one way or another.
> However, all R-Car clock drivers will rely on the presence in DT of a
> device node for the RST module.  Backwards compatibility with old DTBs
> is retained only for R-Car Gen2, which has fallback code calling into
> rcar_gen2_read_mode_pins().
>
> As is usually the case with moving functionality from board code to DT,
> there are lots of hard dependencies:
>   - The DT updates in Part B can be merged as soon as the DT bindings in
>     Part A have been approved,
>   - The clock driver updates in Part C depend functionally on the driver
>     code in Part A,
>   - The board code cleanups in Part D depend on the clock driver updates
>     in Part C,
>   - The block driver cleanups in part E depend on the board code
>     cleanups in part D.
>
> This series has evolved over time, cfr.
>   - "[PATCH/RFC 00/11] ARM: shmobile: Let CPG use syscon for MD pin
>     values" (http://www.spinics.net/lists/linux-clk/msg01478.html),
>   - "[PATCH 00/10] arm64: renesas: Obtain MD pin values using
>     syscon/regmap".
>     (http://www.spinics.net/lists/linux-sh/msg44757.html)
>
> Changes compared to v2:
>   - Use "renesas,<soctype>-rst" instead of "renesas,rst-<soctype>",
>   - Drop "syscon" compatible value and "renesas,modemr" property, use a
>     real driver instead,
>   - Add support for R-Car M1A, H1, and M3-W.
>
> Changes compared to v1:
>   - Add support for R-Car H3.
>
> An alternative and broader solution was proposed by Simon Horman as
> "[PATCH/RFC 0/6] boot-mode-reg: Add core"
> (http://www.spinics.net/lists/linux-sh/msg45969.html).
>
> This patch series is against renesas-drivers.
> It has been tested on r8a7778/bockw, r8a7779/marzen, r8a7791/koelsch,
> and r8a7795/salvator-x.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (22):
>   reset: Add renesas,rst DT bindings
>   soc: renesas: Add R-Car RST driver
>   ARM: dts: r8a7778: Add device node for RESET/WDT module
>   ARM: dts: r8a7779: Add device node for RESET/WDT module
>   ARM: dts: r8a7790: Add device node for RST module
>   ARM: dts: r8a7791: Add device node for RST module
>   ARM: dts: r8a7793: Add device node for RST module
>   ARM: dts: r8a7794: Add device node for RST module
>   arm64: renesas: r8a7795 dtsi: Add device node for RST module
>   arm64: renesas: r8a7796 dtsi: Add device node for RST module
>   clk: renesas: r8a7778: Obtain mode pin values using R-Car RST driver
>   clk: renesas: r8a7779: Obtain mode pin values from R-Car RST driver
>   clk: renesas: rcar-gen2: Obtain mode pin values using RST driver
>   clk: renesas: r8a7795: Obtain mode pin values from R-Car RST driver
>   clk: renesas: r8a7796: Obtain mode pin values from R-Car RST driver
>   clk: renesas: rcar-gen3-cpg: Remove obsolete
>     rcar_gen3_read_mode_pins()
>   ARM: shmobile: r8a7778: Stop passing mode pins state to clock driver
>   ARM: shmobile: r8a7779: Stop passing mode pins state to clock driver
>   ARM: shmobile: rcar-gen2: Stop passing mode pins state to clock driver
>   clk: renesas: r8a7778: Remove obsolete r8a7778_clocks_init()
>   clk: renesas: r8a7779: Remove obsolete r8a7779_clocks_init()
>   clk: renesas: rcar-gen2: Remove obsolete rcar_gen2_clocks_init()
>
>  .../devicetree/bindings/reset/renesas,rst.txt      | 35 ++++++++
>  arch/arm/boot/dts/r8a7778.dtsi                     |  5 ++
>  arch/arm/boot/dts/r8a7779.dtsi                     |  5 ++
>  arch/arm/boot/dts/r8a7790.dtsi                     |  5 ++
>  arch/arm/boot/dts/r8a7791.dtsi                     |  5 ++
>  arch/arm/boot/dts/r8a7793.dtsi                     |  5 ++
>  arch/arm/boot/dts/r8a7794.dtsi                     |  5 ++
>  arch/arm/mach-shmobile/setup-r8a7778.c             | 15 ----
>  arch/arm/mach-shmobile/setup-r8a7779.c             | 27 -------
>  arch/arm/mach-shmobile/setup-rcar-gen2.c           |  6 +-
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  5 ++
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  5 ++
>  drivers/clk/renesas/clk-r8a7778.c                  | 26 +++---
>  drivers/clk/renesas/clk-r8a7779.c                  | 18 ++---
>  drivers/clk/renesas/clk-rcar-gen2.c                | 17 ++--
>  drivers/clk/renesas/r8a7795-cpg-mssr.c             |  8 +-
>  drivers/clk/renesas/r8a7796-cpg-mssr.c             |  8 +-
>  drivers/clk/renesas/rcar-gen3-cpg.c                | 17 ----
>  drivers/clk/renesas/rcar-gen3-cpg.h                |  1 -
>  drivers/soc/renesas/Makefile                       |  5 ++
>  drivers/soc/renesas/rcar-rst.c                     | 94 ++++++++++++++++++++++
>  include/linux/clk/renesas.h                        |  4 -
>  include/linux/soc/renesas/rcar-rst.h               |  6 ++
>  23 files changed, 227 insertions(+), 100 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt
>  create mode 100644 drivers/soc/renesas/rcar-rst.c
>  create mode 100644 include/linux/soc/renesas/rcar-rst.h


Whole series:

Acked-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks!

Dirk
