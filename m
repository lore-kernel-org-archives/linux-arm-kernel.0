From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Thu,  7 Nov 2013 00:54:21 +0100
Subject: [PATCH/RFC] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
Message-ID: <1383782061-7111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SH-Mobile platforms are transitioning from non-multiplatform to
multiplatform kernel. A new ARCH_SHMOBILE_MULTI configuration symbol has
been created to group all multiplatform-enabled SH-Mobile SoCs. The
existing ARCH_SHMOBILE configuration symbol groups SoCs that haven't
been converted yet.

This arrangement works fine for the arch/ code, but lots of drivers
needed on both ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI depend on
ARCH_SHMOBILE only. In order to avoid changing them, rename
ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY, and create a new boolean
ARCH_SHMOBILE configuration symbol that is selected by both
ARCH_SHMOBILE_LEGACY and ARCH_SHMOBILE_MULTI.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/Kconfig                  | 14 ++++++++------
 arch/arm/Makefile                 |  1 -
 arch/arm/boot/compressed/Makefile |  2 +-
 arch/arm/boot/dts/Makefile        |  2 +-
 arch/arm/mach-shmobile/Kconfig    |  8 ++++++--
 drivers/Makefile                  |  2 +-
 6 files changed, 17 insertions(+), 12 deletions(-)

This patch is an alternative approach to adding ARCH_SHMOBILE_MULTI or ARM
dependencies to all the SH-Mobile-related drivers (see
http://www.spinics.net/lists/arm-kernel/msg283128.html). If accepted I will
modify the previous series to only add COMPILE_TEST support without touching
the other dependencies.

I believe this approach to be simpler. It will also not required dropping the
ARCH_SHMOBILE_MULTI dependency from all drivers when we will eventually get
rid of the non-multiplatform platforms and rename ARCH_SHMOBILE_MULTI to
ARCH_SHMOBILE.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6..588b46b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -642,8 +642,9 @@ config ARCH_MSM
 	  stack and controls some vital subsystems
 	  (clock and power control, etc).
 
-config ARCH_SHMOBILE
-	bool "Renesas SH-Mobile / R-Mobile"
+config ARCH_SHMOBILE_LEGACY
+	bool "Renesas SH-Mobile / R-Mobile (non-multiplatform)"
+	select ARCH_SHMOBILE
 	select ARM_PATCH_PHYS_VIRT
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
@@ -659,7 +660,8 @@ config ARCH_SHMOBILE
 	select PM_GENERIC_DOMAINS if PM
 	select SPARSE_IRQ
 	help
-	  Support for Renesas's SH-Mobile and R-Mobile ARM platforms.
+	  Support for Renesas's SH-Mobile and R-Mobile ARM platforms using
+	  a non-multiplatform kernel.
 
 config ARCH_RPC
 	bool "RiscPC"
@@ -1619,7 +1621,7 @@ config HZ_FIXED
 	default 200 if ARCH_EBSA110 || ARCH_S3C24XX || ARCH_S5P64X0 || \
 		ARCH_S5PV210 || ARCH_EXYNOS4
 	default AT91_TIMER_HZ if ARCH_AT91
-	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
+	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE_LEGACY
 	default 0
 
 choice
@@ -1800,8 +1802,8 @@ config ARCH_WANT_GENERAL_HUGETLB
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
-	int "Maximum zone order" if ARCH_SHMOBILE
-	range 11 64 if ARCH_SHMOBILE
+	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY
+	range 11 64 if ARCH_SHMOBILE_LEGACY
 	default "12" if SOC_AM33XX
 	default "9" if SA1111
 	default "11"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index db50b62..dca2e84 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -190,7 +190,6 @@ machine-$(CONFIG_ARCH_S5PV210)		+= s5pv210
 machine-$(CONFIG_ARCH_SA1100)		+= sa1100
 machine-$(CONFIG_ARCH_SHARK)		+= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	+= shmobile
-machine-$(CONFIG_ARCH_SHMOBILE_MULTI) 	+= shmobile
 machine-$(CONFIG_ARCH_SIRF)		+= prima2
 machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 7ac1610..bafbb4c7 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -68,7 +68,7 @@ else
 endif
 endif
 
-ifeq ($(CONFIG_ARCH_SHMOBILE),y)
+ifeq ($(CONFIG_ARCH_SHMOBILE_LEGACY),y)
 OBJS		+= head-shmobile.o
 endif
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 891b724..7d98d3a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -197,7 +197,7 @@ dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \
 	ste-ccu8540.dtb \
 	ste-ccu9540.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
+dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4bb548f..b31ceda 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,6 +1,10 @@
+config ARCH_SHMOBILE
+	bool
+
 config ARCH_SHMOBILE_MULTI
 	bool "SH-Mobile Series" if ARCH_MULTI_V7
 	depends on MMU
+	select ARCH_SHMOBILE
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
@@ -30,7 +34,7 @@ config MACH_KZM9D
 comment "SH-Mobile System Configuration"
 endif
 
-if ARCH_SHMOBILE
+if ARCH_SHMOBILE_LEGACY
 
 comment "SH-Mobile System Type"
 
@@ -288,7 +292,7 @@ source "drivers/sh/Kconfig"
 
 endif
 
-if ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI
+if ARCH_SHMOBILE
 
 menu "Timer and clock configuration"
 
diff --git a/drivers/Makefile b/drivers/Makefile
index ab93de8..8a50222 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -116,7 +116,7 @@ obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
-obj-$(CONFIG_ARCH_SHMOBILE)	+= sh/
+obj-$(CONFIG_ARCH_SHMOBILE_LEGACY)	+= sh/
 ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
 obj-y				+= clocksource/
 endif
-- 
Regards,

Laurent Pinchart
