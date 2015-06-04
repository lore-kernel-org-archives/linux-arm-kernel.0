From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 4 Jun 2015 10:39:03 +0800
Subject: [GIT PULL v2 2/4] ARM: imx: soc updates for 4.2
Message-ID: <20150604023903.GB17189@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 - Rebase to only share imx7d clock ID header with imx/dt branch
 - Fix gpt timer issues found by linux-next testing

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.2

for you to fetch changes up to 0be5da9dc249391e3310cc2351e7af5ce211ac49:

  ARM: imx: imx7d requires anatop (2015-06-03 14:52:31 +0800)

----------------------------------------------------------------
The i.MX SoC updates for 4.2:
 - Add new SoC i.MX7D support, which integrates two Cortex-A7 and one
   Cortex-M4 cores.
 - Support suspend from IRAM on i.MX53, so that DDR pins can be set to
   high impedance for more power saving during suspend.
 - Move i.MX clock drivers from arch/arm/mach-imx to drivers/clk/imx.
 - Move i.MX GPT timer driver from arch/arm/mach-imx into
   drivers/clocksource.
 - A couple of clock driver update for VF610 and i.MX6Q.
 - A few random code correction and improvement.

----------------------------------------------------------------
Anson Huang (3):
      ARM: imx: using unsigned variable for do_div
      ARM: imx7d: add low level debug uart support
      ARM: imx: add msl support for imx7d

Arnd Bergmann (2):
      ARM: imx: make imx51/3 suspend optional
      ARM: imx: imx7d requires anatop

Fabio Estevam (2):
      clk: imx: clk-cpu: Include "clk.h" header file
      ARM: imx: mmdc: Include "common.h" header file

Frank Li (3):
      dt-bindings: add imx7d clock ID definitions
      ARM: clk: imx: update pllv3 to support imx7
      ARM: imx: add imx7d clk tree support

Joe Perches (1):
      ARM: mach-imx: iomux-imx31: Use DECLARE_BITMAP

Krzysztof Kozlowski (1):
      ARM: imx: Constify irq_domain_ops

Martin Fuzzey (1):
      ARM: imx53: Set DDR pins to high impedance when in suspend to RAM.

Mirza Krak (1):
      ARM: imx: clk-v610: Add clock for I2C2 and I2C3

Shawn Guo (26):
      ARM: imx: use dynamic mapping for timer
      ARM: imx: use dynamic mapping for CCM
      ARM: imx: move revision definitions and declarations into a header
      ARM: imx5: let pm code map CCM block on its own
      ARM: imx6: set initial power mode in pm function
      ARM: imx6: let pm code map CCM block on its own
      ARM: imx6: do not use cpu_is_xxx() in clock driver
      ARM: imx: add clk-pllv1 type support
      ARM: imx: remove inclusions of platform headers
      ARM: imx: move clock drivers into drivers/clk
      MAINTAINERS: add new folders into IMX entry
      ARM: imx: drop epit timer initialization from imx35 clock driver
      ARM: imx6: initialize CCM_CLPCR_LPM into RUN mode earlier
      ARM: imx: use relaxed IO accessor in timer driver
      ARM: imx: move timer resources into a structure
      ARM: imx: define an enum for gpt timer device type
      ARM: imx: initialize gpt device type for DT boot
      ARM: imx: setup tctl register in device specific function
      ARM: imx: set up .set_next_event hook via imx_gpt_data
      ARM: imx: move clock event variables into imx_timer
      ARM: imx: define gpt register offset per device type
      ARM: imx: get rid of variable timer_base
      ARM: imx: provide gpt device specific irq functions
      ARM: imx: remove platform headers from timer driver
      ARM: imx: move timer driver into drivers/clocksource
      clocksource: timer-imx-gpt: remove include of <asm/mach/time.h>

Shenwei Wang (2):
      ARM: imx: Remove the duplicated function declaration
      ARM: imx: Correct the comments in time.c

Stefan Agner (1):
      ARM: imx: clk-vf610: enable debug access port by default

S?bastien Szymanski (1):
      ARM: clk-imx6q: refine sata's parent

 MAINTAINERS                                        |   2 +
 arch/arm/Kconfig.debug                             |  13 +-
 arch/arm/include/debug/imx-uart.h                  |  15 +-
 arch/arm/mach-imx/Kconfig                          |  11 +-
 arch/arm/mach-imx/Makefile                         |  31 +-
 arch/arm/mach-imx/anatop.c                         |   5 +-
 arch/arm/mach-imx/common.h                         |  15 +-
 arch/arm/mach-imx/cpu.c                            |   3 +
 arch/arm/mach-imx/cpuidle-imx6q.c                  |   4 +-
 arch/arm/mach-imx/cpuidle-imx6sl.c                 |   4 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |   4 +-
 arch/arm/mach-imx/gpc.c                            |   2 +-
 arch/arm/mach-imx/hardware.h                       |   1 +
 arch/arm/mach-imx/iomux-imx31.c                    |   2 +-
 arch/arm/mach-imx/mach-imx6q.c                     |   1 +
 arch/arm/mach-imx/mach-imx6sl.c                    |   1 +
 arch/arm/mach-imx/mach-imx6sx.c                    |   1 +
 arch/arm/mach-imx/mach-imx7d.c                     |  43 ++
 arch/arm/mach-imx/mmdc.c                           |   2 +
 arch/arm/mach-imx/mx27.h                           |   4 -
 arch/arm/mach-imx/mx3x.h                           |   7 -
 arch/arm/mach-imx/mxc.h                            |  24 +-
 arch/arm/mach-imx/pm-imx5.c                        | 205 ++++-
 arch/arm/mach-imx/pm-imx6.c                        |  38 +-
 arch/arm/mach-imx/suspend-imx53.S                  | 139 ++++
 arch/arm/mach-imx/time.c                           | 385 ---------
 drivers/clk/Makefile                               |   1 +
 drivers/clk/imx/Makefile                           |  26 +
 {arch/arm/mach-imx => drivers/clk/imx}/clk-busy.c  |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-cpu.c   |   1 +
 .../mach-imx => drivers/clk/imx}/clk-fixup-div.c   |   0
 .../mach-imx => drivers/clk/imx}/clk-fixup-mux.c   |   0
 .../clk/imx}/clk-gate-exclusive.c                  |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-gate2.c |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx1.c  |  17 +-
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx21.c |  14 +-
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx25.c |   6 +-
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx27.c |  15 +-
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx31.c |  35 +-
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx35.c |  36 +-
 .../mach-imx => drivers/clk/imx}/clk-imx51-imx53.c |   5 +-
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6q.c |  36 +-
 .../arm/mach-imx => drivers/clk/imx}/clk-imx6sl.c  |   7 -
 .../arm/mach-imx => drivers/clk/imx}/clk-imx6sx.c  |   6 -
 drivers/clk/imx/clk-imx7d.c                        | 860 +++++++++++++++++++++
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pfd.c   |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv1.c |  33 +-
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv2.c |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv3.c |  13 +-
 {arch/arm/mach-imx => drivers/clk/imx}/clk-vf610.c |   4 +
 {arch/arm/mach-imx => drivers/clk/imx}/clk.c       |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk.h       |  14 +-
 drivers/clocksource/Kconfig                        |   6 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-imx-gpt.c                | 540 +++++++++++++
 include/dt-bindings/clock/imx7d-clock.h            | 450 +++++++++++
 include/dt-bindings/clock/vf610-clock.h            |   3 +-
 include/soc/imx/revision.h                         |  37 +
 include/soc/imx/timer.h                            |  26 +
 59 files changed, 2593 insertions(+), 561 deletions(-)
 create mode 100644 arch/arm/mach-imx/mach-imx7d.c
 create mode 100644 arch/arm/mach-imx/suspend-imx53.S
 delete mode 100644 arch/arm/mach-imx/time.c
 create mode 100644 drivers/clk/imx/Makefile
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-busy.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-cpu.c (99%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-div.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-mux.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate-exclusive.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate2.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx1.c (91%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx21.c (95%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx25.c (98%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx27.c (97%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx31.c (91%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx35.c (94%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx51-imx53.c (99%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6q.c (98%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6sl.c (99%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6sx.c (99%)
 create mode 100644 drivers/clk/imx/clk-imx7d.c
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pfd.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv1.c (75%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv2.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv3.c (96%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-vf610.c (98%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk.h (94%)
 create mode 100644 drivers/clocksource/timer-imx-gpt.c
 create mode 100644 include/dt-bindings/clock/imx7d-clock.h
 create mode 100644 include/soc/imx/revision.h
 create mode 100644 include/soc/imx/timer.h
