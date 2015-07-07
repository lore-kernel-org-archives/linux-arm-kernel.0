From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  7 Jul 2015 16:10:06 +0200
Subject: [PATCH/RFC 00/11] ARM: shmobile: Let CPG use syscon for MD pin values
Message-ID: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi,

Currently the R-Car Gen2 Clock Pulse Generator (CPG) driver obtains the
values of the MD pins by a direct call from the R-Car Gen2 platform
code. This is a bit messy, and creates a dependency between driver and
platform code.

This RFC patch series makes the CPG driver obtain the MD pin values by
reading the Mode Monitoring Register (MODEMR) using syscon and regmap
instead.  The syscon device and register offset to use are obtained from
the "renesas,modemr" property in DT, which contains a phandle to the Reset
Controller module, and the register offset of the MODEMR register inside the
RST module's register block.

For backward-compatibility with old DTs, a fallback is added to call
rcar_gen2_read_mode_pins() in the R-Car Gen2 platform code when needed.
Once backward-compatibility is deemed no longer necessary, the call to
rcar_gen2_read_mode_pins() can be removed.

Patches:
  - Patch 1 adds syscon/regmap support to the CPG driver,
  - Patches 2-5 add device nodes for the RST modules on all R-Car Gen2
    SoCs,
  - Patches 6-9 add "renesas,modemr" links on all R-Car Gen2 SoCs,
  - Patch 10 removes the old call from platform code to CPG driver,
  - Patch 11 removes the obsolete code called by the platform code from
    the CPG driver.

TODO:
  - Write DT binding docs for the RST Reset Controller Module,
  - Document the "renesas,modemr" DT property in the R-Car Gen2 CPG DT
    binding docs,
  - Extend this technique to R-Car Gen1 (r8a7778/r8a7779) and RZ
    (r7s72100) SoCs.

Dependencies:
  - This patch series is against my local tree, which a.o. contains the
    R-Car Gen2 CPG/MSTP Clock Domain and R-Car Gen2 SYSC PM Domain
    patches.  This mostly impacts the .dtsi patches.  But there's no
    functional dependency, only contextually.
  - Patch 10 (run-time) depends on patches 1-9,
  - Patch 11 (build-time) depends on patch 10.

Geert Uytterhoeven (11):
  clk: shmobile: rcar-gen2: Obtain MD pin values using syscon/regmap
  ARM: shmobile: r8a7790 dtsi: Add device node for RST module
  ARM: shmobile: r8a7791 dtsi: Add device node for RST module
  ARM: shmobile: r8a7793 dtsi: Add device node for RST module
  ARM: shmobile: r8a7794 dtsi: Add device node for RST module
  ARM: shmobile: r8a7790: Link CPG to RST using "renesas,modemr"
  ARM: shmobile: r8a7791: Link CPG to RST using "renesas,modemr"
  ARM: shmobile: r8a7793: Link CPG to RST using "renesas,modemr"
  ARM: shmobile: r8a7794: Link CPG to RST using "renesas,modemr"
  ARM: shmobile: rcar-gen2: Use syscon to configure the CPG
  clk: shmobile: rcar-gen2: Remove obsolete rcar_gen2_clocks_init()

 arch/arm/boot/dts/r8a7790.dtsi           |  6 ++++++
 arch/arm/boot/dts/r8a7791.dtsi           |  6 ++++++
 arch/arm/boot/dts/r8a7793.dtsi           |  6 ++++++
 arch/arm/boot/dts/r8a7794.dtsi           |  6 ++++++
 arch/arm/mach-shmobile/Kconfig           |  1 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c |  3 ++-
 drivers/clk/shmobile/clk-rcar-gen2.c     | 22 +++++++++++++++-------
 include/linux/clk/shmobile.h             |  1 -
 8 files changed, 42 insertions(+), 9 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
