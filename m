From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 23:22:49 +0800
Subject: [PATCH 00/10] Support imx6q WAIT mode with coupled cpuidle
Message-ID: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6q has a low power mode named WAIT.  When all cores are in WFI,
imx6q will go into WAIT mode, and whenever there is a wakeup interrupt,
it will exit WAIT mode.  Software can configure hardware behavior during
WAIT mode, clock gating or power gating for ARM core.

The series implements ARM clock gating and power gating in WAIT mode
as two coupled cpuidle states, wait and srpg.  Though imx6q hardware
already handles sequencing, the voting provided by coupled cpuidle is
still quite useful, which will allow the system to at least get into
clock gating when one cpu wants clock gating and the other wants power
gating.

Patches 1 ~ 9 make necessary code changes to prepare for WAIT mode
enabling, and the last patch enables the feature eventually.

As WAIT mode is broken on TO1.0 silicon, the feature is only provided
for revisions later than TO1.0.

Shawn Guo (10):
  ARM: imx6q: print silicon version on boot
  ARM: imx: allow timer counter to roll over
  ARM: imx6q: select ARM and PL310 errata
  ARM: imx: initialize cpu power up counters
  ARM: imx: mask gpc interrupts initially
  ARM: imx6q: prepare imx6q_set_lpm for cpudile support
  ARM: imx6q: get v7_cpu_resume ready for cpuidle
  ARM: imx: move imx6q_cpuidle_driver into a separate file
  ARM: SMP: add function arch_send_wakeup_ipi_mask()
  ARM: imx6q: implement WAIT mode with coupled cpuidle

 arch/arm/include/asm/smp.h        |    1 +
 arch/arm/kernel/smp.c             |    5 ++
 arch/arm/mach-imx/Kconfig         |    9 ++
 arch/arm/mach-imx/Makefile        |    6 +-
 arch/arm/mach-imx/clk-imx6q.c     |   32 +++++--
 arch/arm/mach-imx/common.h        |    6 +-
 arch/arm/mach-imx/cpuidle-imx6q.c |  177 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/cpuidle.c       |    3 +
 arch/arm/mach-imx/cpuidle.h       |    5 ++
 arch/arm/mach-imx/gpc.c           |   20 +++--
 arch/arm/mach-imx/headsmp.S       |   81 ++++++++++++++++-
 arch/arm/mach-imx/mach-imx6q.c    |   45 +++++++---
 arch/arm/mach-imx/platsmp.c       |   26 ++++--
 arch/arm/mach-imx/pm-imx6q.c      |    1 -
 arch/arm/mach-imx/time.c          |    6 +-
 15 files changed, 384 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c

-- 
1.7.9.5
