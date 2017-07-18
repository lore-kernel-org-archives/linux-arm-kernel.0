From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 18 Jul 2017 16:26:24 +0200
Subject: [PATCH v2 0/3] ARM: renesas: Enable SMP on R-Car E2
Message-ID: <1500387987-9240-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This patch series enables SMP on R-Car E2 (r8a7794).
The main hurdle here is that R-Car Gen2 boot loaders do not initialize the
arch_timer CNTVOFF register, which thus needs workarounds on Linux.

  - The first patch adds a definition for MON_MODE, as suggested by Marc
    Zyngier,
  - The second patch makes sure CNTVOFF is initialized for boot and
    secondary Cortex-A15 and Cortex-A7 CPU cores, like is already done
    for the boot Cortex-A7 CPU core.  Without this, the ARM arch timer
    does not work on secondary CPU cores.
    This patch depends on "[PATCH v2] ARM: shmobile: rcar-gen2: Correct
    arch timer frequency on RZ/G1E".
  - The third patch adds the required infrastructure (APMU device node
    and corresponding enable-method) to DT.
    Obviously this must not be applied on a branch that does not contain
    the first two patches!

Due to dependencies, I think it is easiest if the ARM maintainers provide
their Acked-by for patch 1, so the whole series can go in through Simon's
Renesas tree.

Changes compared to v1:
  - New patch "[PATCH v2 1/3] ARM: Add definition for monitor mode",
  - Initialize CNTVOFF on Cortex-A15, too,
  - Use *_MODE definitions instead of hardcoded values,
  - Reduce duplication by calling the asm version from C,
  - Always build headsmp-apmu.o on R-Car Gen2.

This has been tested on r8a7794/alt (dual Cortex-A7), and regression-tested
on r8a7790/lager (quad Cortex-A15), and r8a7791/koelsch, r8a7791/porter,
r8a7792/blanche, and r8a7793/gose (dual Cortex-A15).

Thanks!

Geert Uytterhoeven (2):
  ARM: Add definition for monitor mode
  ARM: shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15

Sergei Shtylyov (1):
  ARM: dts: r8a7794: Add SMP support

 arch/arm/boot/dts/r8a7794.dtsi           |  7 ++++++
 arch/arm/include/uapi/asm/ptrace.h       |  1 +
 arch/arm/mach-shmobile/Makefile          |  1 +
 arch/arm/mach-shmobile/common.h          |  2 ++
 arch/arm/mach-shmobile/headsmp-apmu.S    | 37 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c    |  2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 20 ++---------------
 7 files changed, 51 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/headsmp-apmu.S

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
