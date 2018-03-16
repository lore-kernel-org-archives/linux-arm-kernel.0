From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:34 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.17
Message-ID: <cover.1521211738.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.17.


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.17

for you to fetch changes up to 01d675f159e0f0792947fb823cf2425da4d747ad:

  ARM: shmobile: rcar-gen2: Add watchdog support (2018-03-13 20:54:16 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.17

01d675f159e0 ARM: shmobile: rcar-gen2: Add watchdog support
58adf1ba0d22 ARM: shmobile: Add watchdog support

* SoC
  - Identify R-Car V3H (r8a77980) and M3N (r8a77965)

  - Enable R-Car Gen2 regulator quirk for Stout board with H3 (r8a7790) SoC

    Marek Vaust says "Regulator setup is suboptimal on H2 Stout too. The
    Stout newly has two DA9210 regulators, so the quirk is extended to
    handle another DA9210 at i2c address 0x70."

  - Add watchdog support

    This is the SoC portion of the following solution. It is not yet
    enabled in DT as it is not functional without clock dependencies
    in place.

    Fabrizio Castro says "this series has been around for some time as RFC,
    and it has collected useful comments from the community along the way.
    The solution proposed by this patch set works for most R-Car Gen2 and
    RZ/G1 devices, but not all of them. We now know that for some R-Car
    Gen2 early revisions there is no proper software fix. Anyway, no
    product has been built around early revisions, but development boards
    mounting early revisions (basically prototypes) are still out there.
    As a result, this series isn't enabling the internal watchdog on R-Car
    Gen2 boards, developers may enable it in board specific device trees if
    needed.  This series has been tested by me on the iwg20d, iwg22d,
    Lager, Alt, and Koelsch boards.

   The problem
   ===========
   To deal with SMP on R-Car Gen2 and RZ/G1, we install a reset vector to
   ICRAM1 and we program the [S]BAR registers so that when we turn ON the
   non-boot CPUs they are redirected to the reset vector installed by Linux
   in ICRAM1, and eventually they continue the execution to RAM, where the
   SMP bring-up code will take care of the rest.  The content of the [S]BAR
   registers survives a watchdog triggered reset, and as such after the
   watchdog fires the boot core will try and execute the SMP bring-up code
   instead of jumping to the bootrom code.

   The fix
   =======
   The main strategy for the solution is to let the reset vector decide if
   it needs to jump to shmobile_boot_fn or to the bootrom code.  In a
   watchdog triggered reset scenario, since the [S]BAR registers keep their
   values, the boot CPU will jump into the newly designed reset vector, the
   assembly routine will eventually test WOVF (a bit in register RWTCSRA
   that indicates if the watchdog counter has overflown, the value of this
   bit gets retained in this scenario), and jump to the bootrom code which
   will in turn load up the bootloader, etc.  When bringing up SMP or using
   CPU hotplug, the reset vector will jump to shmobile_boot_fn instead."

* R-Car Rst
  - Add support for R-Car V3H (r8a77980) and V3H (r8a77980)

* R-Car SYSC
  - Mark rcar_sysc_matches[] __initconst

   Geert Uytterhoeven says "This frees another 1764 bytes
   (arm32/shmobile_defconfig) or 1000 bytes (arm64/renesas_defconfig) of
   memory after kernel init."

  - Fix power area parents

    Sergei Shtylyov says "According to the figure 9.2(b) of the R-Car
    Series, 3rd Generation User?s Manual: Hardware Rev. 0.80 the A2IRn and
    A2SCn power areas in R8A77970 have the A3IR area as a parent, thus the
    SYSC driver has those parents wrong.."

  - Add support for R-Car V3H (r8a77980) and V3H (r8a77980)

----------------------------------------------------------------
Fabrizio Castro (3):
      soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2
      ARM: shmobile: Add watchdog support
      ARM: shmobile: rcar-gen2: Add watchdog support

Geert Uytterhoeven (2):
      soc: renesas: rcar-sysc: Mark rcar_sysc_matches[] __initconst
      ARM: shmobile: rcar-gen2: Fix error check in regulator quirk

Jacopo Mondi (3):
      soc: renesas: Identify R-Car M3-N
      soc: renesas: rcar-sysc: Add R-Car M3-N support
      soc: renesas: rcar-rst: Add support for R-Car M3-N

Marek Vasut (1):
      ARM: shmobile: stout: enable R-Car Gen2 regulator quirk

Sergei Shtylyov (5):
      soc: renesas: identify R-Car V3H
      soc: renesas: rcar-rst: add R8A77980 support
      soc: renesas: r8a77970-sysc: fix power area parents
      dt-bindings: power: add R8A77980 SYSC power domain definitions
      soc: renesas: rcar-sysc: add R8A77980 support

 .../bindings/power/renesas,rcar-sysc.txt           |  2 +
 .../devicetree/bindings/reset/renesas,rst.txt      |  2 +
 arch/arm/mach-shmobile/common.h                    |  4 ++
 arch/arm/mach-shmobile/headsmp.S                   | 55 ++++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c              |  1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c              | 15 ++++--
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 25 ++++++----
 drivers/soc/renesas/Kconfig                        | 14 +++++-
 drivers/soc/renesas/Makefile                       |  2 +
 drivers/soc/renesas/r8a77965-sysc.c                | 37 +++++++++++++++
 drivers/soc/renesas/r8a77970-sysc.c                | 12 ++---
 drivers/soc/renesas/r8a77980-sysc.c                | 52 ++++++++++++++++++++
 drivers/soc/renesas/rcar-rst.c                     | 37 ++++++++++++---
 drivers/soc/renesas/rcar-sysc.c                    |  8 +++-
 drivers/soc/renesas/rcar-sysc.h                    |  2 +
 drivers/soc/renesas/renesas-soc.c                  | 16 +++++++
 include/dt-bindings/power/r8a77965-sysc.h          | 30 ++++++++++++
 include/dt-bindings/power/r8a77980-sysc.h          | 43 +++++++++++++++++
 18 files changed, 331 insertions(+), 26 deletions(-)
 create mode 100644 drivers/soc/renesas/r8a77965-sysc.c
 create mode 100644 drivers/soc/renesas/r8a77980-sysc.c
 create mode 100644 include/dt-bindings/power/r8a77965-sysc.h
 create mode 100644 include/dt-bindings/power/r8a77980-sysc.h
