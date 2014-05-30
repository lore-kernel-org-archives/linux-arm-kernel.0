From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 30 May 2014 22:18:13 +0200
Subject: [PATCH 0/5] CPU hotplug for Marvell Armada XP
Message-ID: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Gregory, Sebastian,

This patch series adds support for CPU hotplug on Marvell Armada
XP. It heavily re-uses the logic added by Gregory Clement to support
cpuidle on Armada XP: when a CPU is brought offline through the CPU
hotplug mechanism, it is put into the same "deep idle" state used by
cpuidle. When the CPU is brought back online, it is taken out of the
"deep idle" state.

This series was successfully tested using CPU hotplug directly, using
/sys/devices/system/cpu/cpuX/online. It was also successfully tested
using kexec, which highlighted a few additional issues in the CPU
hotplug implementation, for which the fixes are present in this patch
series.

A few details about the patches:

 * The first three patches are just minor preparation patches.

 * The fourth patch is the actual CPU hotplug implementation for
   Armada XP. It's actually pretty simple.

 * The fifth patch is not a mach-mvebu/ patch, but a drivers/irqchip/
   patch that fixes a problem that was uncovered by testing kexec.

The patch series applies on the current mvebu/soc branch of Jason
Cooper.

Thomas

Thomas Petazzoni (5):
  ARM: mvebu: remove stub implementation of CPU hotplug on Armada
    375/38x
  ARM: mvebu: slightly refactor/rename PMSU idle related functions
  ARM: mvebu: export PMSU idle enter/exit functions
  ARM: mvebu: implement CPU hotplug support for Armada XP
  irqchip: irq-armada-370-xp: mask all interrupts during initialization

 arch/arm/mach-mvebu/Makefile        |  1 -
 arch/arm/mach-mvebu/armada-370-xp.h |  3 +++
 arch/arm/mach-mvebu/common.h        |  2 --
 arch/arm/mach-mvebu/hotplug.c       | 31 ------------------------
 arch/arm/mach-mvebu/platsmp-a9.c    |  3 ---
 arch/arm/mach-mvebu/platsmp.c       | 48 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.c          | 15 ++++--------
 drivers/irqchip/irq-armada-370-xp.c | 17 +++++++++++--
 8 files changed, 71 insertions(+), 49 deletions(-)
 delete mode 100644 arch/arm/mach-mvebu/hotplug.c

-- 
1.9.3
