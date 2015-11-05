From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Nov 2015 14:46:37 +0900
Subject: [PATCH/RFC] ARM: shmobile: Introduce ARCH_RENESAS
Message-ID: <1446702397-24078-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this patch is to start the process of replacing both
ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI with ARCH_RENESAS. The motivation
being that as time has moved on Renesas has become a name than shmobile for
the majority Renesas 32-bit ARM based SoCs. The name is, conveniently, also
applicable to (older) Renesas SH based SoCs and (newer) ARM64 based SoCs
although this patch only addresses 32-bit ARM.

It is envisaged that follow up work may address migrating both
SH SoCs and drivers from ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI to
ARCH_RENESAS.

Proposed support for the r8a7795 ARM64 based SoC already uses ARCH_RENESAS
which selects ARCH_SHMOBILE.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
* ARM64 patch is
  "[PATCH v12 1/7] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support"
  http://www.spinics.net/lists/arm-kernel/msg455822.html
---
 arch/arm/configs/multi_v7_defconfig |  2 +-
 arch/arm/configs/shmobile_defconfig |  2 +-
 arch/arm/mach-shmobile/Kconfig      | 10 +++++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a5c6ebf39b0a..dc4a216e2e41 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -73,7 +73,7 @@ CONFIG_MACH_SPEAR1340=y
 CONFIG_ARCH_STI=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_EXYNOS5420_MCPM=y
-CONFIG_ARCH_SHMOBILE_MULTI=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A73A4=y
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 3aef019c0de7..cc8ece33a7e3 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -9,7 +9,7 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
-CONFIG_ARCH_SHMOBILE_MULTI=y
+CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A73A4=y
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 88734a5e10ca..676e11d44e41 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,6 +1,8 @@
 config ARCH_SHMOBILE
 	bool
-	select ZONE_DMA if ARM_LPAE
+
+config ARCH_SHMOBILE_MULTI
+	bool
 
 config PM_RCAR
 	bool
@@ -29,10 +31,11 @@ config ARCH_RMOBILE
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
-menuconfig ARCH_SHMOBILE_MULTI
+config ARCH_RENESAS
 	bool "Renesas ARM SoCs" if ARCH_MULTI_V7
 	depends on MMU
 	select ARCH_SHMOBILE
+	select ARCH_SHMOBILE_MULTI
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select ARM_GIC
@@ -40,8 +43,9 @@ menuconfig ARCH_SHMOBILE_MULTI
 	select NO_IOPORT_MAP
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
+	select ZONE_DMA if ARM_LPAE
 
-if ARCH_SHMOBILE_MULTI
+if ARCH_RENESAS
 
 #comment "Renesas ARM SoCs System Type"
 
-- 
2.1.4
