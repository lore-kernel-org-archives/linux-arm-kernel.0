From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Jun 2013 01:09:13 +0200
Subject: [PATCH] ARM: multiplatform: always pick one CPU type
Message-ID: <201306220109.13816.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new default platform code, we can always boot using DT
without requiring a board file, but we cannot build a kernel
unless we select at least one CPU core, which breaks some
"randconfig" builds.

This adapts the ARCH_MULTI_V4T and ARCH_MULTI_V5 options so we
always default to a common CPU core if no platform was enabled
that picks something else. The default we pick for ARMv4T is
ARM920T, while for ARMv5 we pick ARM926T.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 90d2137..3c1b019 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -873,20 +873,21 @@ menu "Multiple platform selection"
 
 comment "CPU Core family selection"
 
-config ARCH_MULTI_V4
-	bool "ARMv4 based platforms (FA526, StrongARM)"
-	depends on !ARCH_MULTI_V6_V7
-	select ARCH_MULTI_V4_V5
-
 config ARCH_MULTI_V4T
 	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
 	depends on !ARCH_MULTI_V6_V7
 	select ARCH_MULTI_V4_V5
+	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
+		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \
+		CPU_ARM925T || CPU_ARM940T)
 
 config ARCH_MULTI_V5
 	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
 	depends on !ARCH_MULTI_V6_V7
 	select ARCH_MULTI_V4_V5
+	select CPU_ARM926T if (!CPU_ARM946E || CPU_ARM1020 || \
+		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
+		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
 
 config ARCH_MULTI_V4_V5
 	bool
