From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 17 Jun 2014 16:46:58 +0900
Subject: [PATCH v2 00/08] ARM: shmobile: Rework include path V2
Message-ID: <20140617074658.30008.53021.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Rework include path V2

[PATCH v2 01/08] ARM: shmobile: Move intc.h, cleanup sh_intc.h usage
[PATCH v2 02/08] ARM: shmobile: Move dma-register.h
[PATCH v2 03/08] ARM: shmobile: Move clock.h
[PATCH v2 04/08] ARM: shmobile: Move most of irqs.h, keep some for pinctl
[PATCH v2 05/08] ARM: shmobile: Move common.h
[PATCH v2 06/08] ARM: shmobile: Move pm-rmobile.h, cleanup sh73xx.h
[PATCH v2 07/08] ARM: shmobile: Move pm-rcar.h, cleanup r8a7779 case
[PATCH v2 08/08] ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case

Olof, here my latest take on the header move that you requested earlier.

This particular series hopefully follows your proposed way and moves the
most common shared header files for mach-shmobile from <mach/foobar.h>
to "foobar.h" without any workaround. Left are still per-SoC header files
that will be moved once I know you are comformatble with this format.

Please note that these are only lightly compile tested with a handful
of defconfigs, but any potential issue should be trivial to fix.

Also, there are certain bits of arch/arm/mach-shmobile/include/mach/
get included from places like arch/arm/boot/compressed/ (booting
legacy kernel directly from reset vector) and also from SoC specific
legacy code under drivers/pinctrl. My proposal is to keep those users
as-is until we phase out legacy board support (2-3 kernels?), let me
know if you would like to get rid of "include/mach" sooner!

Simon, can you please this pick up and include in your rebase to v3.16-rc1?

Changes since V1:
- rebased to v3.16-rc1

Thanks to Geert and Arnd for review support!

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---

 arch/arm/mach-shmobile/board-ape6evm-reference.c         |    2 
 arch/arm/mach-shmobile/board-ape6evm.c                   |    4 
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |    2 
 arch/arm/mach-shmobile/board-armadillo800eva.c           |    6 
 arch/arm/mach-shmobile/board-bockw-reference.c           |    2 
 arch/arm/mach-shmobile/board-bockw.c                     |    4 
 arch/arm/mach-shmobile/board-genmai-reference.c          |    4 
 arch/arm/mach-shmobile/board-genmai.c                    |    4 
 arch/arm/mach-shmobile/board-koelsch-reference.c         |    8 
 arch/arm/mach-shmobile/board-koelsch.c                   |    6 
 arch/arm/mach-shmobile/board-kzm9g-reference.c           |    2 
 arch/arm/mach-shmobile/board-kzm9g.c                     |    4 
 arch/arm/mach-shmobile/board-lager-reference.c           |    8 
 arch/arm/mach-shmobile/board-lager.c                     |    5 
 arch/arm/mach-shmobile/board-mackerel.c                  |   10 
 arch/arm/mach-shmobile/board-marzen-reference.c          |    4 
 arch/arm/mach-shmobile/board-marzen.c                    |    4 
 arch/arm/mach-shmobile/clock-r7s72100.c                  |    2 
 arch/arm/mach-shmobile/clock-r8a73a4.c                   |    4 
 arch/arm/mach-shmobile/clock-r8a7740.c                   |    4 
 arch/arm/mach-shmobile/clock-r8a7778.c                   |    4 
 arch/arm/mach-shmobile/clock-r8a7779.c                   |    4 
 arch/arm/mach-shmobile/clock-r8a7790.c                   |    5 
 arch/arm/mach-shmobile/clock-r8a7791.c                   |    6 
 arch/arm/mach-shmobile/clock-sh7372.c                    |    4 
 arch/arm/mach-shmobile/clock-sh73a0.c                    |    4 
 arch/arm/mach-shmobile/clock.c                           |    6 
 arch/arm/mach-shmobile/clock.h                           |   56 ++
 arch/arm/mach-shmobile/common.h                          |   56 ++
 arch/arm/mach-shmobile/console.c                         |    2 
 arch/arm/mach-shmobile/dma-register.h                    |   84 ++++
 arch/arm/mach-shmobile/include/mach/clock.h              |   56 --
 arch/arm/mach-shmobile/include/mach/common.h             |   56 --
 arch/arm/mach-shmobile/include/mach/dma-register.h       |   84 ----
 arch/arm/mach-shmobile/include/mach/intc.h               |  290 --------------
 arch/arm/mach-shmobile/include/mach/irqs.h               |   17 
 arch/arm/mach-shmobile/include/mach/pm-rcar.h            |   15 
 arch/arm/mach-shmobile/include/mach/pm-rmobile.h         |   63 ---
 arch/arm/mach-shmobile/include/mach/r8a7740.h            |    2 
 arch/arm/mach-shmobile/include/mach/r8a7779.h            |   12 
 arch/arm/mach-shmobile/include/mach/r8a7790.h            |    2 
 arch/arm/mach-shmobile/include/mach/rcar-gen2.h          |    8 
 arch/arm/mach-shmobile/include/mach/sh7372.h             |    4 
 arch/arm/mach-shmobile/intc-sh7372.c                     |    5 
 arch/arm/mach-shmobile/intc-sh73a0.c                     |    5 
 arch/arm/mach-shmobile/intc.h                            |  290 ++++++++++++++
 arch/arm/mach-shmobile/irqs.h                            |   21 +
 arch/arm/mach-shmobile/platsmp-apmu.c                    |    2 
 arch/arm/mach-shmobile/platsmp-scu.c                     |    2 
 arch/arm/mach-shmobile/platsmp.c                         |    2 
 arch/arm/mach-shmobile/pm-r8a7740.c                      |    4 
 arch/arm/mach-shmobile/pm-r8a7779.c                      |   15 
 arch/arm/mach-shmobile/pm-r8a7790.c                      |    2 
 arch/arm/mach-shmobile/pm-rcar.c                         |    2 
 arch/arm/mach-shmobile/pm-rcar.h                         |   15 
 arch/arm/mach-shmobile/pm-rmobile.c                      |    2 
 arch/arm/mach-shmobile/pm-rmobile.h                      |   63 +++
 arch/arm/mach-shmobile/pm-sh7372.c                       |    4 
 arch/arm/mach-shmobile/pm-sh73a0.c                       |    2 
 arch/arm/mach-shmobile/rcar-gen2.h                       |    8 
 arch/arm/mach-shmobile/setup-emev2.c                     |    2 
 arch/arm/mach-shmobile/setup-r7s72100.c                  |    4 
 arch/arm/mach-shmobile/setup-r8a73a4.c                   |    6 
 arch/arm/mach-shmobile/setup-r8a7740.c                   |    8 
 arch/arm/mach-shmobile/setup-r8a7778.c                   |    4 
 arch/arm/mach-shmobile/setup-r8a7779.c                   |    4 
 arch/arm/mach-shmobile/setup-r8a7790.c                   |    7 
 arch/arm/mach-shmobile/setup-r8a7791.c                   |    6 
 arch/arm/mach-shmobile/setup-rcar-gen2.c                 |    4 
 arch/arm/mach-shmobile/setup-sh7372.c                    |    8 
 arch/arm/mach-shmobile/setup-sh73a0.c                    |    7 
 arch/arm/mach-shmobile/smp-emev2.c                       |    2 
 arch/arm/mach-shmobile/smp-r8a7779.c                     |    4 
 arch/arm/mach-shmobile/smp-r8a7790.c                     |    4 
 arch/arm/mach-shmobile/smp-r8a7791.c                     |    4 
 arch/arm/mach-shmobile/smp-sh73a0.c                      |    2 
 76 files changed, 723 insertions(+), 726 deletions(-)
