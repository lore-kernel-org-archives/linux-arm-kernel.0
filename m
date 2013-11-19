From: horms@verge.net.au (Simon Horman)
Date: Tue, 19 Nov 2013 11:36:16 +0900
Subject: [PATCH 1/2] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
In-Reply-To: <2156495.pzTBk8szcN@avalon>
References: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2038217.6aK6L4rUYc@avalon> <20131119014539.GG17628@verge.net.au>
 <2156495.pzTBk8szcN@avalon>
Message-ID: <20131119023615.GK17628@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 02:53:01AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Tuesday 19 November 2013 10:45:40 Simon Horman wrote:
> > On Wed, Nov 13, 2013 at 01:57:48AM +0100, Laurent Pinchart wrote:
> > > On Wednesday 13 November 2013 09:53:29 Simon Horman wrote:
> > > > On Tue, Nov 12, 2013 at 02:21:04PM +0100, Laurent Pinchart wrote:
> > > > > On Tuesday 12 November 2013 14:26:25 Simon Horman wrote:
> > > > > > On Tue, Nov 12, 2013 at 02:11:37PM +0900, Simon Horman wrote:
> > > > > > > On Sat, Nov 09, 2013 at 01:33:48PM +0100, Laurent Pinchart wrote:
> > > > > > > > SH-Mobile platforms are transitioning from non-multiplatform to
> > > > > > > > multiplatform kernel. A new ARCH_SHMOBILE_MULTI configuration
> > > > > > > > symbol has been created to group all multiplatform-enabled SH-
> > > > > > > > Mobile SoCs. The existing ARCH_SHMOBILE configuration symbol
> > > > > > > > groups SoCs that haven't been converted yet.
> > > > > > > > 
> > > > > > > > This arrangement works fine for the arch/ code, but lots of
> > > > > > > > drivers needed on both ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI
> > > > > > > > depend on ARCH_SHMOBILE only. In order to avoid changing them,
> > > > > > > > rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY, and create a new
> > > > > > > > boolean ARCH_SHMOBILE configuration symbol that is selected by
> > > > > > > > both ARCH_SHMOBILE_LEGACY and ARCH_SHMOBILE_MULTI.
> > > > > > > > 
> > > > > > > > Signed-off-by: Laurent Pinchart
> > > > > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > > > > > Acked-by: Magnus Damm <damm@opensource.se>
> > > > > > > 
> > > > > > > Thanks, I have queued this up.
> > > > > > 
> > > > > > I have dropped this for now as it seems that all of the
> > > > > > shmobile defconfigs now need to be updated to use
> > > > > > ARCH_SHMOBILE_LEGACY
> > > > > > instead of ARCH_SHMOBILE.
> > > > > 
> > > > > Indeed, I forgot about that.
> > > > > 
> > > > > > It seems to me that needs to be part of this patch to avoid
> > > > > > breaking bisecatability. Any thoughts?
> > > > > 
> > > > > The only bisection this would break is the defconfig bisection. I'm
> > > > > not sure whether we need to care about that, Would that be a bit issue
> > > > > ? I'll submit a separate patch, please feel free to squash it with
> > > > > this one if you believe it should be.
> > > > 
> > > > To be honest I'm unsure.
> > > > But I think that I am leaning towards keeping the patches separate.
> > > 
> > > You got both patches, it's your call ;-)
> > 
> > I have decided to try the squash option which I have now done
> > and queued up the following:
> 
> The following patch isn't a squashed version of 1/2 and 3/2 :-)

True! Thanks for checking.

Here is what I have now:

>From 4b83ab62e154857e7fb2353a43ea02afc6783b6e Mon Sep 17 00:00:00 2001
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 9 Nov 2013 13:33:48 +0100
Subject: [PATCH] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY

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
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig                           | 14 ++++++++------
 arch/arm/Makefile                          |  1 -
 arch/arm/boot/compressed/Makefile          |  2 +-
 arch/arm/boot/dts/Makefile                 |  2 +-
 arch/arm/configs/ape6evm_defconfig         |  2 +-
 arch/arm/configs/armadillo800eva_defconfig |  2 +-
 arch/arm/configs/bockw_defconfig           |  2 +-
 arch/arm/configs/genmai_defconfig          |  2 +-
 arch/arm/configs/koelsch_defconfig         |  2 +-
 arch/arm/configs/kzm9d_defconfig           |  2 +-
 arch/arm/configs/kzm9g_defconfig           |  2 +-
 arch/arm/configs/lager_defconfig           |  2 +-
 arch/arm/configs/mackerel_defconfig        |  2 +-
 arch/arm/configs/marzen_defconfig          |  2 +-
 arch/arm/mach-shmobile/Kconfig             |  8 ++++++--
 drivers/Makefile                           |  2 +-
 16 files changed, 27 insertions(+), 22 deletions(-)

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
index 6ff3139..7f36e22 100644
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
diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
index 1ce3994..cb26c62 100644
--- a/arch/arm/configs/ape6evm_defconfig
+++ b/arch/arm/configs/ape6evm_defconfig
@@ -13,7 +13,7 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 # CONFIG_BLOCK is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A73A4=y
 CONFIG_MACH_APE6EVM=y
 # CONFIG_ARM_THUMB is not set
diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index fae939d..5abf1a2 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -15,7 +15,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7740=y
 CONFIG_MACH_ARMADILLO800EVA=y
 # CONFIG_SH_TIMER_TMU is not set
diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 8110d8a..80cff50 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -8,7 +8,7 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7778=y
 CONFIG_MACH_BOCKW=y
 CONFIG_MEMORY_START=0x60000000
diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
index 69b1531..aa0b704 100644
--- a/arch/arm/configs/genmai_defconfig
+++ b/arch/arm/configs/genmai_defconfig
@@ -12,7 +12,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R7S72100=y
 CONFIG_MACH_GENMAI=y
 # CONFIG_SH_TIMER_CMT is not set
diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 825c16d..7fd65a0 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -9,7 +9,7 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 # CONFIG_BLOCK is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7791=y
 CONFIG_MACH_KOELSCH=y
 # CONFIG_SWP_EMULATE is not set
diff --git a/arch/arm/configs/kzm9d_defconfig b/arch/arm/configs/kzm9d_defconfig
index e6aed23..e42ce37 100644
--- a/arch/arm/configs/kzm9d_defconfig
+++ b/arch/arm/configs/kzm9d_defconfig
@@ -13,7 +13,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_MACH_KZM9D=y
 CONFIG_MEMORY_START=0x40000000
diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 1ad0280..9934dbc2 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -22,7 +22,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_KZM9G=y
 CONFIG_MEMORY_START=0x41000000
diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index 35bff5e..35dc8b2 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -12,7 +12,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_MACH_LAGER=y
 # CONFIG_SH_TIMER_TMU is not set
diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index 9fb1189..a61e165 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_SH7372=y
 CONFIG_MACH_MACKEREL=y
 CONFIG_MEMORY_SIZE=0x10000000
diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index dd4aced..f21bd40 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -9,7 +9,7 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_MACH_MARZEN=y
 CONFIG_MEMORY_START=0x60000000
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 180b71f..1b7df17 100644
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
 
@@ -272,7 +276,7 @@ source "drivers/sh/Kconfig"
 
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
1.8.4
