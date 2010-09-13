From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 13 Sep 2010 10:44:30 -0700
Subject: [PATCH -devel] arm: kconfig: enable SMP for MSM targets
Message-ID: <1284399870-7194-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This just adds ARCH_MSM_SCORPIONMP to allow SMP selection for
SMP. MSM is unique in that it doesn't enable SCU or TWD.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/Kconfig          |    9 +++++----
 arch/arm/mach-msm/Kconfig |    2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6cbfd4c..22f5089 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1148,10 +1148,11 @@ config SMP
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
@@ -1234,7 +1235,7 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP
 	default y
-	select HAVE_ARM_TWD
+	select HAVE_ARM_TWD if !ARCH_MSM_SCORPIONMP
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 47264a7..cc59b0c 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -35,6 +35,8 @@ config  ARCH_MSM_ARM11
 	bool
 config  ARCH_MSM_SCORPION
 	bool
+config  ARCH_MSM_SCORPIONMP
+	bool
 
 config  MSM_VIC
 	bool
-- 
1.7.0.4
