From: Dave.Martin@arm.com (Dave Martin)
Date: Tue,  1 Oct 2013 18:15:15 +0100
Subject: [PATCH v3 0/3] MCPM/TC2 support for CPU powerdown synchronisation
Message-ID: <1380647718-9178-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds MCPM support for detecting when a CPU is safely powered
down, and provides an implementation for TC2.

It should be possible to implement the same thing for PSCI using the
AFFINITY_INFO call (I need to check the semantics with Charles)

This is sufficient to for working kexec with real power management on
TC2.  To test it, you'll also need:

  * CONFIG_KEXEC=y
  * CONFIG_PROC_DEVICE_TREE=y
  * CONFIG_MCPM=y
  * CONFIG_ARCH_VEXPRESS_TC2_PM=y
  * sufficiently new kexec-tools
    (git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
    v2.0.4 worked for me)

This build on Nico's patch
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7842/1
(MCPM: don't explode if invoked without being initialized first)

To prevent CPUs from running off into the weeds across kexec, this
series requires Lorenzo's patch
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/200917.html
(arm: vexpress: tc2: fix hotplug/idle/kexec race on cluster power down).

Changes since v2:

 * Return a proper failure code if mcpm_cpu_power_down_finish() is
   called with no mcpm platforms_ops registered, or a NULL
   power_down_finish() method.  (Thanks again Nico)

 * Minor refactoring of the loop in tc2_pm_power_down_finish() to
   avoid the goto.

Changes between v1 and v2:

 * "Fix" erroneous documentation comment by switching to -errno return
   value convention for power_down_finish(), which is more informative.
   tc2_pm now returns -ETIMEDOUT on timeout.  The return is adapted to
   bool convention on return from smp_ops.cpu_kill() instead.  (Thanks,
   Nico).

 * For consistency, BUG_ON out of range cpu or cluster values
   tc2_pm_power_down_finish(), as for tc2_pm_power_down().

Changes between RFC and v1:

 * Print a big fat warning instead of branching to null if the
   power_down_finish() method is not supplied by the backend, or not
   registered.

 * Add a generous timeout of 1 second for the TC2 implementation.

 * Relax the polling interval to 10ms for TC2, since the need to poll
   more than once is rare and this is not a performance-critical path.

 * Fix some silly typos.


Dave Martin (3):
  ARM: mcpm: Factor out logical-to-physical CPU translation
  ARM: mcpm: Implement cpu_kill() to synchronise on powerdown
  ARM: vexpress/TC2: Implement MCPM power_down_finish()

 arch/arm/common/mcpm_entry.c    |   15 +++++++++
 arch/arm/common/mcpm_platsmp.c  |   27 +++++++++++++---
 arch/arm/include/asm/mcpm.h     |   31 ++++++++++++++++++
 arch/arm/mach-vexpress/spc.c    |   39 +++++++++++++++++++++++
 arch/arm/mach-vexpress/spc.h    |    1 +
 arch/arm/mach-vexpress/tc2_pm.c |   66 ++++++++++++++++++++++++++++++++++++---
 6 files changed, 170 insertions(+), 9 deletions(-)

-- 
1.7.9.5
