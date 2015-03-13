From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 Mar 2015 14:16:13 +0100
Subject: [GIT PULL] at91: cleanup for 4.1 #1
Message-ID: <1426252573-9291-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Big PM cleanup by Wenyou this time. I'll add other cleanup material by
Alexandre on top of it real soon.
Note that these patches are stacked on top of all the "fixes" tags that you
already took (at91-fixes3): it was needed for avoiding conflicts in the PM code.

Thanks, best regards,

The following changes since commit 5e7f82d73057a4b99643999e02c036cfbf1ed3ba:

  Merge tag 'at91-fixes3' into at91-4.1-cleanup (2015-03-12 15:30:03 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup

for you to fetch changes up to 385acc0dac88d79447a03a1363072fc258429dec:

  ARM: at91/pm: flush data cache and clean, invalidate and disable the L2 cache (2015-03-13 13:34:55 +0100)

----------------------------------------------------------------
First batch of cleanup for 4.1:
- little phy fixup that is not needed anymore
- hudge cleanup of the PM code:
  - removal of "use slow clock" option => always use this for suspend to RAM
  - quicker suspend as the asm function is copied only once to SRAM
  - use of the same asm function for "standby" and "mem" types of suspend
    actions
  - adaptation to the ARMv7 processors

----------------------------------------------------------------
Boris Brezillon (1):
      ARM: at91: remove ksz8081 phy fixup registration for sama5d4ek board

Sylvain Rochet (1):
      ARM: at91/pm_slowclock: remove clocks which are already stopped when entering slow clock mode

Wenyou Yang (12):
      ARM: at91: pm: change at91_pm_set_standby() to static
      ARM: at91/pm_slowclock: remove the unused code related with SLOWDOWN_MASTER_CLOCK
      ARM: at91: move "select SRAM" under SOC_AT91SAM9 and SOC_SAMA5
      ARM: at91/pm: remove CONFIG_AT91_SLOW_CLOCK config option
      ARM: at91/pm_slowclock: create the procedure to handle the sdram self-refresh
      ARM: at91/pm: move the copying the sram function to the sram initialization phase
      ARM: at91/pm: standby mode uses same sram function as suspend to memory mode
      ARM: at91/pm: rename file name: pm_slowclock.S --> pm_suspend.S
      ARM: at91/pm: rename function name: at91_slow_clock() --> at91_pm_suspend_sram_fn()
      ARM: at91/pm: remove unused void (*at91_pm_standby)(void)
      ARM: at91/pm_suspend: add the WFI instruction support for ARMv7
      ARM: at91/pm: flush data cache and clean, invalidate and disable the L2 cache

 arch/arm/mach-at91/Kconfig        |  18 +-
 arch/arm/mach-at91/Makefile       |   2 +-
 arch/arm/mach-at91/pm.c           | 139 +++++++-------
 arch/arm/mach-at91/pm.h           |  14 +-
 arch/arm/mach-at91/pm_slowclock.S | 335 ----------------------------------
 arch/arm/mach-at91/pm_suspend.S   | 338 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/sama5.c        |  20 ---
 7 files changed, 418 insertions(+), 448 deletions(-)
 delete mode 100644 arch/arm/mach-at91/pm_slowclock.S
 create mode 100644 arch/arm/mach-at91/pm_suspend.S

-- 
Nicolas Ferre
