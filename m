From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  4 Jul 2014 11:44:55 +0200
Subject: [PATCH 0/8] cpufreq support for Marvell Armada XP
Message-ID: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike, Viresh, Rafael, Jason, Gregory, Andrew, Sebastian,

This series of commits adds cpufreq support for the Marvell Armada XP
processor. Adding this support involves touching several different
areas:

 - The core clock framework, to add a new clk_set_rate() notifier. See
   below for the explanation. This should go through Mike Turquette's
   tree. This is PATCH 01/08.

 - Addition of an Armada XP cpufreq driver. This should go through the
   cpufreq maintainers, Viresh Kumar and Rafael J. Wysocki. This is
   PATCH 02/08.

 - Improvements to the existing Armada XP cpu-clock driver. This
   should also go through Mike Turquette's tree, probably thanks to a
   pull request to be sent by the mvebu platform maintainers. This is
   PATCH 03/08.

 - Extension of the Marvell EBU PMSU code in arch/arm/mach-mvebu/ to
   implement a clock notifier needed for the dynamic frequency change
   procedure. This patch should go through the mvebu maintainers
   tree. This is PATCH 05/08. Note that this patch has a build
   dependency on PATCH 01/08, while all other patches don't have any
   other build dependency.

 - Misc other small changes (defconfigs, Device Tree, SMP
   initialization code) that are specific to the mvebu platform, also
   to be handled by the mvebu maintainers. Those are patches 4, 6, 7
   and 8.

The only tricky part in this series is the addition of the
APPLY_RATE_CHANGE clock notifier. All the details about why a new
clock notifier is needed are exposed in the commit log of the first
patch, "clk: add an APPLY_RATE_CHANGE notifier event during
clk_set_rate()". Please read carefully this commit log to understand
the reasons for this proposed clock notifier.

Basically, the issue is that the procedure to change the CPU clock
frequency involves touching registers managed by the CPU clock driver,
but also registers from the PMSU which is used for a wide range of
power management activities, and is therefore handled by platform
specific code in mach-mvebu.

Jason, this patch series is based on 3.16-rc3, but it applies fine
even with mvebu/fixes and mvebu/soc merged (which contain some PMSU
changes), so I haven't based the patch series on those branches.

Thanks,

Thomas

Thomas Petazzoni (8):
  clk: add an APPLY_RATE_CHANGE notifier event during clk_set_rate()
  cpufreq: add driver for Armada XP
  clk: mvebu: extend clk-cpu for dynamic frequency scaling
  ARM: mvebu: ensure CPU clocks are enabled
  ARM: mvebu: extend PMSU code to support dynamic frequency scaling
  ARM: mvebu: update Armada XP DT for dynamic frequency scaling
  ARM: mvebu: allow enabling of cpufreq on Armada XP
  ARM: mvebu: update mvebu_v7_defconfig with cpufreq support

 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   5 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
 arch/arm/configs/mvebu_v7_defconfig                |   1 +
 arch/arm/mach-mvebu/Kconfig                        |   1 +
 arch/arm/mach-mvebu/platsmp.c                      |   1 +
 arch/arm/mach-mvebu/pmsu.c                         | 168 +++++++++++++++++++++
 drivers/clk/clk.c                                  |   3 +
 drivers/clk/mvebu/clk-cpu.c                        |  79 +++++++++-
 drivers/cpufreq/Kconfig.arm                        |   6 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/armadaxp-cpufreq.c                 | 112 ++++++++++++++
 include/linux/clk.h                                |   4 +
 12 files changed, 375 insertions(+), 8 deletions(-)
 create mode 100644 drivers/cpufreq/armadaxp-cpufreq.c

-- 
2.0.0
