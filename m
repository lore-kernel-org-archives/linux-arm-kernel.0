From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Mar 2014 02:37:00 +0100
Subject: [PATCH] ARM: moxart: fix CPU selection
Message-ID: <201403270237.00850.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moxart uses an FA526 CPU core, which is ARMv4 based, not ARMv4T.
Before moxart, we had no CONFIG_MULTI_V4 option, since no ARMv4 platform
was enabled for multiplatform. This now adds the missing option, which
will give us slightly more efficient code on pure moxart kernels,
because we can build a pure FA526 kernel now rather than a combined
FA526+ARM920T kernel that we used to.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----

I've applied this one to the next/fixes-non-critical branch

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3dad961..4f85b09 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -893,6 +893,12 @@ menu "Multiple platform selection"
 
 comment "CPU Core family selection"
 
+config ARCH_MULTI_V4
+	bool "ARMv4 based platforms (FA526)"
+	depends on !ARCH_MULTI_V6_V7
+	select ARCH_MULTI_V4_V5
+	select CPU_FA526
+
 config ARCH_MULTI_V4T
 	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
 	depends on !ARCH_MULTI_V6_V7
diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
index 3795ae2..e9b45bb 100644
--- a/arch/arm/mach-moxart/Kconfig
+++ b/arch/arm/mach-moxart/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_MOXART
-	bool "MOXA ART SoC" if ARCH_MULTI_V4T
+	bool "MOXA ART SoC" if ARCH_MULTI_V4
 	select CPU_FA526
 	select ARM_DMA_MEM_BUFFERABLE
 	select USE_OF
