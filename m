From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 23 Nov 2010 08:50:15 -0800
Subject: [GIT PULL] Kconfig changes for MSM to enable SMP
Message-ID: <1290531015.4165.19.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

I've been trying to get these in for a while now. They're just Kconfig
changes that allow MSM to use SMP. One of the patch does have a slight
clean up where it moves the "\" out one space under "config SMP". I
think that was the product of some feedback I received.

Please pull, or let me know if you want them done differently.

Daniel

--

The following changes since commit 3561d43fd289f590fdae672e5eb831b8d5cf0bf6:

  Linux 2.6.37-rc3 (2010-11-21 15:18:56 -0800)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/dwalker/linux-msm.git for-russell

Daniel Walker (2):
      arm: kconfig: enable SMP for MSM targets
      arm: kconfig: dis-allow hotplug on MSM

 arch/arm/Kconfig          |   10 ++++++----
 arch/arm/mach-msm/Kconfig |    2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db524e7..c8fa144 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1205,10 +1205,11 @@ config SMP
 	depends on EXPERIMENTAL
 	depends on GENERIC_CLOCKEVENTS
 	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
-		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
-		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4
+		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
+		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
+		 ARCH_MSM_SCORPIONMP
 	select USE_GENERIC_SMP_HELPERS
-	select HAVE_ARM_SCU
+	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -1283,6 +1284,7 @@ config NR_CPUS
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && HOTPLUG && EXPERIMENTAL
+	depends on !ARCH_MSM
 	help
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
@@ -1291,7 +1293,7 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP
 	default y
-	select HAVE_ARM_TWD
+	select HAVE_ARM_TWD if !ARCH_MSM_SCORPIONMP
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index dbbcfeb..31e5fd6 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -49,6 +49,8 @@ endchoice
 
 config MSM_SOC_REV_A
 	bool
+config  ARCH_MSM_SCORPIONMP
+	bool
 
 config  ARCH_MSM_ARM11
 	bool

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
