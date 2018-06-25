From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:05:26 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Arm SoC Updates for v4.19
Message-ID: <cover.1529934908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC arm SoC updates for v4.19.


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-soc-for-v4.19

for you to fetch changes up to c44e182e537492baaa37303fc0ee299222fce921:

  ARM: shmobile: convert to SPDX identifier (2018-06-18 12:00:29 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Arm SoC Updates for v4.19

* Convert to SPDX identifier

* Remove legacy SMP fallback code

  Geert Uytterhoeven says "R-Car H2 and M2-W have been supporting SMP
  enablement from DT using the "renesas,apmu" enable-method since v4.8.
  A legacy fallback was left in place for backwards compatibility with old
  DTBs.

  This patch series removes the legacy SMP fallbacks for R-Car H2 and
  M2-W, and consolidates their support in the common R-Car Gen2 machine
  definition.2

* APMU cleanups after legacy SMP fallback removal
  - Move cpu_leave_lowpower() from HOTPLUG_CPU || SUSPEND section to the
    SUSPEND section as it is only used for suspend
  - Remove shmobile_smp_apmu_prepare_cpus() as it is no longer used
  - Remove platsmp-apmu.h

* Drop legacy SYSC fallbacks

  Geert Uytterhoeven says "When DT SYSC support was introduced in v4.7,
  legacy fallbacks were kept to keep secondary CPUs working on R-Car H1,
  H2, and M2-W using old DTBs.  However, the time has come to drop these
  fallbacks, and clean up the resulting code"

----------------------------------------------------------------
Geert Uytterhoeven (14):
      ARM: shmobile: r8a7790: Remove legacy SMP fallback code
      ARM: shmobile: r8a7790: Use common R-Car Gen2 machine definition
      ARM: shmobile: r8a7791: Remove legacy SMP fallback code
      ARM: shmobile: r8a7791: Use common R-Car Gen2 machine definition
      ARM: shmobile: Remove unused shmobile_smp_init_fallback_ops()
      ARM: shmobile: apmu: Move cpu_leave_lowpower() to SUSPEND section
      ARM: shmobile: apmu: Remove obsolete shmobile_smp_apmu_prepare_cpus()
      ARM: shmobile: apmu: Remove platsmp-apmu.h
      ARM: shmobile: rcar-gen2: Remove explicit SYSC config and init
      ARM: shmobile: r8a7779: Stop powering down secondary CPUs during early boot
      soc: renesas: rcar-sysc: Provide helpers to power up/down CPUs
      ARM: shmobile: r8a7779: Use rcar_sysc_power_{down,up}_cpu()
      ARM: shmobile: r8a7779: Remove explicit SYSC config and init
      soc: renesas: rcar-sysc: Drop legacy handling

Wolfram Sang (1):
      ARM: shmobile: convert to SPDX identifier

 arch/arm/include/debug/renesas-scif.S              |   5 +-
 arch/arm/mach-shmobile/Makefile                    |   6 +-
 arch/arm/mach-shmobile/common.h                    |   1 -
 arch/arm/mach-shmobile/headsmp-apmu.S              |   5 +-
 arch/arm/mach-shmobile/platsmp-apmu.c              | 245 +++++++++------------
 arch/arm/mach-shmobile/platsmp-apmu.h              |  32 ---
 arch/arm/mach-shmobile/platsmp.c                   |   9 -
 arch/arm/mach-shmobile/pm-r8a7779.c                |  41 ----
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |  25 ---
 arch/arm/mach-shmobile/r8a7779.h                   |   2 -
 arch/arm/mach-shmobile/r8a7790.h                   |   7 -
 arch/arm/mach-shmobile/r8a7791.h                   |   7 -
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c |  10 +-
 arch/arm/mach-shmobile/setup-emev2.c               |  10 +-
 arch/arm/mach-shmobile/setup-r7s72100.c            |  10 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c             |  10 +-
 arch/arm/mach-shmobile/setup-r8a7740.c             |  10 +-
 arch/arm/mach-shmobile/setup-r8a7778.c             |  10 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |  10 +-
 arch/arm/mach-shmobile/setup-r8a7790.c             |  38 ----
 arch/arm/mach-shmobile/setup-r8a7791.c             |  39 ----
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |  16 +-
 arch/arm/mach-shmobile/setup-sh73a0.c              |  10 +-
 arch/arm/mach-shmobile/smp-emev2.c                 |  10 +-
 arch/arm/mach-shmobile/smp-r8a7779.c               |  64 +-----
 arch/arm/mach-shmobile/smp-r8a7790.c               |  71 ------
 arch/arm/mach-shmobile/smp-r8a7791.c               |  53 -----
 drivers/soc/renesas/rcar-sysc.c                    |  64 ++++--
 include/linux/soc/renesas/rcar-sysc.h              |  13 +-
 29 files changed, 166 insertions(+), 667 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/platsmp-apmu.h
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7779.c
 delete mode 100644 arch/arm/mach-shmobile/r8a7790.h
 delete mode 100644 arch/arm/mach-shmobile/r8a7791.h
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7790.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7791.c
 delete mode 100644 arch/arm/mach-shmobile/smp-r8a7790.c
 delete mode 100644 arch/arm/mach-shmobile/smp-r8a7791.c
