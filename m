From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 19 May 2015 11:20:22 +0100
Subject: [PATCH 1/2] ARM: allow CPUs to be selected when non-multiplatform is
 enabled
In-Reply-To: <20150519101939.GB2067@n2100.arm.linux.org.uk>
References: <20150519101939.GB2067@n2100.arm.linux.org.uk>
Message-ID: <E1YuedK-0003tp-Dg@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit dc680b989d51 ("ARM: fix multiplatform allmodcompile") went a
little too far, and effectively prevented noMMU CPUs from ever being
selectable.

Fix this by introducing a set of CPU_CLASS_xxx configuration symbols
which control whether a class of CPU symbols are visible for selection,
and arrange for these to be set according to the multiplatform class
selected, or whenever multiplatform is itself disabled.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/Kconfig | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 8f76f0eb24ac..a342c48073b1 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -1,5 +1,17 @@
 comment "Processor Type"
 
+config CPU_CLASS_V4T
+	def_bool ARCH_MULTI_V4T || !ARCH_MULTIPLATFORM
+
+config CPU_CLASS_V5
+	def_bool ARCH_MULTI_V5 || !ARCH_MULTIPLATFORM
+
+config CPU_CLASS_V6
+	def_bool ARCH_MULTI_V6 || !ARCH_MULTIPLATFORM
+
+config CPU_CLASS_V7
+	def_bool ARCH_MULTI_V7 || !ARCH_MULTIPLATFORM
+
 # Select CPU types depending on the architecture selected.  This selects
 # which CPUs we support in the kernel image, and the compiler instruction
 # optimiser behaviour.
@@ -21,7 +33,7 @@ config CPU_ARM7TDMI
 
 # ARM720T
 config CPU_ARM720T
-	bool "Support ARM720T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
+	bool "Support ARM720T processor" if CPU_CLASS_V4T && ARCH_INTEGRATOR
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
 	select CPU_CACHE_V4
@@ -39,7 +51,7 @@ config CPU_ARM720T
 
 # ARM740T
 config CPU_ARM740T
-	bool "Support ARM740T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
+	bool "Support ARM740T processor" if CPU_CLASS_V4T && ARCH_INTEGRATOR
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
@@ -71,7 +83,7 @@ config CPU_ARM9TDMI
 
 # ARM920T
 config CPU_ARM920T
-	bool "Support ARM920T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
+	bool "Support ARM920T processor" if CPU_CLASS_V4T && ARCH_INTEGRATOR
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -89,7 +101,7 @@ config CPU_ARM920T
 
 # ARM922T
 config CPU_ARM922T
-	bool "Support ARM922T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
+	bool "Support ARM922T processor" if CPU_CLASS_V4T && ARCH_INTEGRATOR
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -127,7 +139,7 @@ config CPU_ARM925T
 
 # ARM926T
 config CPU_ARM926T
-	bool "Support ARM926T processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V5) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB)
+	bool "Support ARM926T processor" if CPU_CLASS_V5 && (ARCH_INTEGRATOR || MACH_REALVIEW_EB)
 	select CPU_32v5
 	select CPU_ABRT_EV5TJ
 	select CPU_CACHE_VIVT
@@ -163,7 +175,7 @@ config CPU_FA526
 
 # ARM940T
 config CPU_ARM940T
-	bool "Support ARM940T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
+	bool "Support ARM940T processor" if CPU_CLASS_V4T && ARCH_INTEGRATOR
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
@@ -181,7 +193,7 @@ config CPU_ARM940T
 
 # ARM946E-S
 config CPU_ARM946E
-	bool "Support ARM946E-S processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
+	bool "Support ARM946E-S processor" if CPU_CLASS_V5 && ARCH_INTEGRATOR
 	depends on !MMU
 	select CPU_32v5
 	select CPU_ABRT_NOMMU
@@ -198,7 +210,7 @@ config CPU_ARM946E
 
 # ARM1020 - needs validating
 config CPU_ARM1020
-	bool "Support ARM1020T (rev 0) processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
+	bool "Support ARM1020T (rev 0) processor" if CPU_CLASS_V5 && ARCH_INTEGRATOR
 	select CPU_32v5
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -216,7 +228,7 @@ config CPU_ARM1020
 
 # ARM1020E - needs validating
 config CPU_ARM1020E
-	bool "Support ARM1020E processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
+	bool "Support ARM1020E processor" if CPU_CLASS_V5 && ARCH_INTEGRATOR
 	depends on n
 	select CPU_32v5
 	select CPU_ABRT_EV4T
@@ -229,7 +241,7 @@ config CPU_ARM1020E
 
 # ARM1022E
 config CPU_ARM1022
-	bool "Support ARM1022E processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
+	bool "Support ARM1022E processor" if CPU_CLASS_V5 && ARCH_INTEGRATOR
 	select CPU_32v5
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_VIVT
@@ -247,7 +259,7 @@ config CPU_ARM1022
 
 # ARM1026EJ-S
 config CPU_ARM1026
-	bool "Support ARM1026EJ-S processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
+	bool "Support ARM1026EJ-S processor" if CPU_CLASS_V5 && ARCH_INTEGRATOR
 	select CPU_32v5
 	select CPU_ABRT_EV5T # But need Jazelle, but EV5TJ ignores bit 10
 	select CPU_CACHE_VIVT
@@ -358,7 +370,7 @@ config CPU_PJ4B
 
 # ARMv6
 config CPU_V6
-	bool "Support ARM V6 processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V6) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
+	bool "Support ARM V6 processor" if CPU_CLASS_V6 && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
 	select CPU_32v6
 	select CPU_ABRT_EV6
 	select CPU_CACHE_V6
@@ -371,7 +383,7 @@ config CPU_V6
 
 # ARMv6k
 config CPU_V6K
-	bool "Support ARM V6K processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V6) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
+	bool "Support ARM V6K processor" if CPU_CLASS_V6 && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
 	select CPU_32v6
 	select CPU_32v6K
 	select CPU_ABRT_EV6
@@ -385,7 +397,7 @@ config CPU_V6K
 
 # ARMv7
 config CPU_V7
-	bool "Support ARM V7 processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V7) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
+	bool "Support ARM V7 processor" if CPU_CLASS_V7 && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
 	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
-- 
2.1.0
