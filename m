From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 15:31:49 +0000
Subject: [PATCH 00/11] Recently pending ARM fixes
Message-ID: <20120119153149.GB1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Below is a summary of a new set of ARM fixes which I've queued up
today (so far).  The big one is the revert of the changes to
rtc-sa1100.c, which completely broke the driver.  Of the remainder,
the bulk are sorting out a few section mismatch warnings.

The two remaining patches fix a build error with collie and some
RCU problems seen on SMP platforms, and two other minor patches.

Most people won't have much interest in this set of fixes, except
for the rcu patch, so I probably won't push this to Linus for a
few days (which means the number could grow.)

 arch/arm/Kconfig                  |    2 +-
 arch/arm/kernel/setup.c           |    3 +-
 arch/arm/kernel/smp.c             |   10 +-
 arch/arm/mach-pxa/devices.c       |   20 ---
 arch/arm/mach-pxa/pxa25x.c        |    2 -
 arch/arm/mach-pxa/pxa27x.c        |    2 -
 arch/arm/mach-pxa/pxa300.c        |    1 -
 arch/arm/mach-pxa/pxa320.c        |    1 -
 arch/arm/mach-pxa/pxa3xx.c        |    1 -
 arch/arm/mach-pxa/pxa95x.c        |    1 -
 arch/arm/mach-sa1100/clock.c      |   91 +++--------
 arch/arm/mach-sa1100/collie.c     |    5 +-
 arch/arm/mach-sa1100/cpu-sa1100.c |    2 +-
 arch/arm/mach-sa1100/generic.c    |   20 ---
 arch/arm/mach-vexpress/ct-ca9x4.c |    4 +-
 arch/arm/mm/init.c                |    2 +-
 drivers/rtc/Kconfig               |    2 +-
 drivers/rtc/rtc-sa1100.c          |  295 ++++++++++++++-----------------------
 18 files changed, 155 insertions(+), 309 deletions(-)

Fabio Estevam (1):
      ARM: 7277/1: setup.c: Fix build warning by removing unneeded header file

Kees Cook (1):
      ARM: 7279/1: standardize /proc/iomem "Kernel code" name

Russell King (9):
      Revert "ARM: sa1100: clean up of the clock support"
      Revert "ARM: pxa: add dummy clock for sa1100-rtc"
      Revert "RTC: sa1100: support sa1100, pxa and mmp soc families"
      Revert "RTC: sa1100: remove redundant code of setting alarm"
      ARM: sa11x0: fix collie build error
      ARM: sa11x0: fix section mismatch in cpu-sa1100.c
      ARM: fix a section mismatch warning with our use of memblock
      ARM: vexpress: fix two section mismatch warnings
      ARM: fix rcu stalls on SMP platforms
