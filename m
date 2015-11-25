From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:32:20 +0100
Subject: [PATCH 07/10] ARM: integrator: use explicit core module options
In-Reply-To: <1448469143-447355-1-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
Message-ID: <1448469143-447355-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency with the other platforms, this remove the CPU
selection logic in mm/Kconfig that was only used by integrator,
and adds specific options for each available core tile and core
module, which in turn select the correct CPUs.

This is consistent with the new way that we do it for realview
and all other platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/Kconfig | 132 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 115 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 02d083489a26..e936cf420b48 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_INTEGRATOR
+menuconfig ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family" if (ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6)
 	select ARM_AMBA
 	select ARM_PATCH_PHYS_VIRT if MMU
@@ -23,8 +23,6 @@ config ARCH_INTEGRATOR
 
 if ARCH_INTEGRATOR
 
-menu "Integrator Options"
-
 config ARCH_INTEGRATOR_AP
 	bool "Support Integrator/AP and Integrator/PP2 platforms"
 	select CLKSRC_MMIO
@@ -36,19 +34,6 @@ config ARCH_INTEGRATOR_AP
 	  Include support for the ARM(R) Integrator/AP and
 	  Integrator/PP2 platforms.
 
-config ARCH_INTEGRATOR_CP
-	bool "Support Integrator/CP platform"
-	select ARCH_CINTEGRATOR
-	select ARM_TIMER_SP804
-	select SERIAL_AMBA_PL011 if TTY
-	select SERIAL_AMBA_PL011_CONSOLE if TTY
-	select SOC_BUS
-	help
-	  Include support for the ARM(R) Integrator CP platform.
-
-config ARCH_CINTEGRATOR
-	bool
-
 config INTEGRATOR_IMPD1
 	bool "Include support for Integrator/IM-PD1"
 	depends on ARCH_INTEGRATOR_AP
@@ -63,6 +48,119 @@ config INTEGRATOR_IMPD1
 	  To compile this driver as a module, choose M here: the
 	  module will be called impd1.
 
-endmenu
+config INTEGRATOR_CM7TDMI
+	bool "Integrator/CM7TDMI core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V4 && !MMU
+	select CPU_ARM7TDMI
+
+config INTEGRATOR_CM720T
+	bool "Integrator/CM720T core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V4T
+	select CPU_ARM720T
+
+config INTEGRATOR_CM740T
+	bool "Integrator/CM740T core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V4T && !MMU
+	select CPU_ARM740T
+
+config INTEGRATOR_CM920T
+	bool "Integrator/CM920T core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V4T
+	select CPU_ARM920T
+
+config INTEGRATOR_CM922T_XA10
+	bool "Integrator/CM922T-XA10 core module"
+	depends on ARCH_MULTI_V4T
+	depends on ARCH_INTEGRATOR_AP
+	select CPU_ARM922T
+
+config INTEGRATOR_CM926EJS
+	bool "Integrator/CM926EJ-S core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V5
+	select CPU_ARM926T
+
+config INTEGRATOR_CM940T
+	bool "Integrator/CM940T core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V4T && !MMU
+	select CPU_ARM940T
+
+config INTEGRATOR_CM946ES
+	bool "Integrator/CM946E-S core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V5 && !MMU
+	select CPU_ARM946E
+
+config INTEGRATOR_CM966ES
+	bool "Integrator/CM966E-S core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on BROKEN # no kernel support
+
+config INTEGRATOR_CM10200E_REV0
+	bool "Integrator/CM10200E rev.0 core module"
+	depends on ARCH_INTEGRATOR_AP && n
+	depends on ARCH_MULTI_V5
+	select CPU_ARM1020
+
+config INTEGRATOR_CM10200E
+	bool "Integrator/CM10200E core module"
+	depends on ARCH_INTEGRATOR_AP && n
+	depends on ARCH_MULTI_V5
+	select CPU_ARM1020E
+
+config INTEGRATOR_CM10220E
+	bool "Integrator/CM10220E core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V5
+	select CPU_ARM1022
+
+config INTEGRATOR_CM1026EJS
+	bool "Integrator/CM1026EJ-S core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V5
+	select CPU_ARM1026
+
+config INTEGRATOR_CM1136JFS
+	bool "Integrator/CM1136JF-S core module"
+	depends on ARCH_INTEGRATOR_AP
+	depends on ARCH_MULTI_V6
+	select CPU_V6
+
+config ARCH_INTEGRATOR_CP
+	bool "Support Integrator/CP platform"
+	depends on (!MMU || ARCH_MULTI_V5 || ARCH_MULTI_V6)
+	select ARM_TIMER_SP804
+	select SERIAL_AMBA_PL011 if TTY
+	select SERIAL_AMBA_PL011_CONSOLE if TTY
+	select SOC_BUS
+	help
+	  Include support for the ARM(R) Integrator CP platform.
+
+config INTEGRATOR_CT7T
+	bool "Integrator/CT7TD (ARM7TDMI) core tile"
+	depends on ARCH_INTEGRATOR_CP
+	depends on ARCH_MULTI_V4T && !MMU
+	select CPU_ARM7TDMI
+
+config INTEGRATOR_CT926
+	bool "Integrator/CT926 (ARM926EJ-S) core tile"
+	depends on ARCH_INTEGRATOR_CP
+	depends on ARCH_MULTI_V5
+	select CPU_ARM926T
+
+config INTEGRATOR_CTB36
+	bool "Integrator/CTB36 (ARM1136JF-S) core tile"
+	depends on ARCH_INTEGRATOR_CP
+	depends on ARCH_MULTI_V6
+	select CPU_V6
+
+config ARCH_CINTEGRATOR
+	depends on ARCH_INTEGRATOR_CP
+	def_bool y
 
 endif
-- 
2.1.0.rc2
