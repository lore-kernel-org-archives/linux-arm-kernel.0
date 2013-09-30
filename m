From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 30 Sep 2013 16:06:44 +0100
Subject: [RFC PATCH 0/3] MCPM/TC2 support for CPU powerdown synchronisation
Message-ID: <1380553607-3271-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds MCPM support for detecting when a CPU is safely powered
down, and provides an implementation for TC2.

This is sufficient to for working kexec with real power management on
TC2.  To test it, you'll also need:

  * CONFIG_KEXEC=y
  * CONFIG_PROC_DEVICE_TREE=y
  * CONFIG_MCPM=y
  * CONFIG_ARCH_VEXPRESS_TC2_PM=y
  * sufficiently new kexec-tools
    (git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
    v2.0.4 worked for me)

To prevent CPUs from running off into the weeds across kexec, this
series requires Lorenzo's patch
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/200917.html
(arm: vexpress: tc2: fix hotplug/idle/kexec race on cluster power down).

Dave Martin (3):
  ARM: mcpm: Factor out logical-to-physical CPU translation
  ARM: mcpm: Implement cpu_kill() to synchronise on powerdown
  ARM: vexpress/TC2: Implement MCPM power_down_finish()

 arch/arm/common/mcpm_entry.c    |    5 ++++
 arch/arm/common/mcpm_platsmp.c  |   27 +++++++++++++++---
 arch/arm/include/asm/mcpm.h     |   31 ++++++++++++++++++++
 arch/arm/mach-vexpress/spc.c    |   39 +++++++++++++++++++++++++
 arch/arm/mach-vexpress/spc.h    |    1 +
 arch/arm/mach-vexpress/tc2_pm.c |   60 +++++++++++++++++++++++++++++++++++----
 6 files changed, 154 insertions(+), 9 deletions(-)

-- 
1.7.9.5
