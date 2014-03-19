From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:39 +0100
Subject: [PATCH 42/62] ARM: realview: use explicit core tile config options
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-43-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The realview platform can be used with numerous core tiles,
which have to be enabled in the CPU menu at the moment, and
the user has to know at configuration time which CPUs can
be enabled in the same kernel.

Most importantly, it is not a valid configuration to select
both ARMv5 and ARMv6/v7 based CPU cores in the same kernel,
and trying that leads to compile errors.

To make it possible to use realview on randconfig kernels,
and to simplify manual configuration, this lists all
supported combinations of machines and core tiles explicitly
and ensures that we cannot enable the ARM926T CPU if any
ARMv6 or v7 CPU is already enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/Kconfig | 57 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig            |  8 +++---
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 9db2029..938fd06 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -8,6 +8,38 @@ config MACH_REALVIEW_EB
 	  Include support for the ARM(R) RealView(R) Emulation Baseboard
 	  platform.
 
+config REALVIEW_EB_ARM926
+	bool "Support ARM926EJ-S Tile"
+	depends on MACH_REALVIEW_EB && !(CPU_V6 || CPU_V6K || CPU_V7)
+	select CPU_ARM926T
+	help
+	  Enable support for the ARM926 tile fitted to the
+	  Realview(R) Emulation Baseboard platform.
+
+config REALVIEW_EB_ARM1136
+	bool "Support ARM1136J(F)-S Tile"
+	depends on MACH_REALVIEW_EB
+	select CPU_V6
+	help
+	  Enable support for the ARM1136 tile fitted to the
+	  Realview(R) Emulation Baseboard platform.
+
+config REALVIEW_EB_ARM1176
+	bool "Support ARM1176JZ(F)-S Tile"
+	depends on MACH_REALVIEW_EB
+	select CPU_V6K
+	help
+	  Enable support for the ARM1176 tile fitted to the
+	  Realview(R) Emulation Baseboard platform.
+
+config REALVIEW_EB_V7
+	bool "Support Cortex-A5/A7/A8/A9/A12/A15 Tile"
+	depends on MACH_REALVIEW_EB
+	select CPU_V7
+	help
+	  Enable support for Cortex-A class ARMv7-A uniprocessor tiles
+	  fitted to the Realview(R) Emulation Baseboard platform.
+
 config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9 Tile"
 	depends on MACH_REALVIEW_EB
@@ -101,6 +133,31 @@ config MACH_REALVIEW_PBX
 	  Include support for the ARM(R) RealView(R) Platform Baseboard
 	  Explore.
 
+config REALVIEW_PBX_ARM1136
+	bool "Support ARM1136J(F)-S Tile"
+	depends on MACH_REALVIEW_PBX
+	select CPU_V6
+	help
+	  Enable support for the ARM1136 tile fitted to the
+	  Realview(R) Platform Baseboard Explore.
+
+config REALVIEW_PBX_ARM1176
+	bool "Support ARM1176JZ(F)-S Tile"
+	depends on MACH_REALVIEW_PBX
+	select CPU_V6K
+	help
+	  Enable support for the ARM1176 tile fitted to the
+	  Realview(R) Platform Baseboard Explore.
+
+config REALVIEW_PBX_V7
+	bool "Support Cortex-A5/A7/A8/A9/A12/A15 Tile"
+	depends on MACH_REALVIEW_PBX
+	select CPU_V7
+	help
+	  Enable support for Cortex-A class ARMv7-A uniprocessor tiles
+	  fitted to the Realview(R) Platform Baseboard Explore.
+
+
 config REALVIEW_HIGH_PHYS_OFFSET
 	bool "High physical base address for the RealView platform"
 	depends on MMU && !MACH_REALVIEW_PB1176
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 297b63b..8c94496 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -127,7 +127,7 @@ config CPU_ARM925T
 
 # ARM926T
 config CPU_ARM926T
-	bool "Support ARM926T processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB
+	bool "Support ARM926T processor" if ARCH_INTEGRATOR
 	select CPU_32v5
 	select CPU_ABRT_EV5TJ
 	select CPU_CACHE_VIVT
@@ -358,7 +358,7 @@ config CPU_PJ4B
 
 # ARMv6
 config CPU_V6
-	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
+	bool "Support ARM V6 processor" if ARCH_INTEGRATOR
 	select CPU_32v6
 	select CPU_ABRT_EV6
 	select CPU_CACHE_V6
@@ -371,7 +371,7 @@ config CPU_V6
 
 # ARMv6k
 config CPU_V6K
-	bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
+	bool "Support ARM V6K processor" if ARCH_INTEGRATOR
 	select CPU_32v6
 	select CPU_32v6K
 	select CPU_ABRT_EV6
@@ -385,7 +385,7 @@ config CPU_V6K
 
 # ARMv7
 config CPU_V7
-	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
+	bool "Support ARM V7 processor" if ARCH_INTEGRATOR
 	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
-- 
1.8.3.2
