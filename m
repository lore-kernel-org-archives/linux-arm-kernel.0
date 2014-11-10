From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Nov 2014 18:52:31 +0100
Subject: [PATCH v3] ARM: fix multiplatform allmodcompile
Message-ID: <1415641951-19753-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 68f3b875f7848f5304472184a4634148c5330cbd
"ARM: integrator: make the Integrator multiplatform"
broke allmodconfig like this:

>> arch/arm/include/asm/cmpxchg.h:114:2: error: #error
"SMP is not supported on this platform"
(etc)

This is due to the fact that as we turned on multiplatform
for the Integrator, this enabled a lot of non-applicable
CPU's to be selected for its multiplatform images, due to
a lot of "depends on ARCH_INTEGRATOR" restrictions in
arch/arm/mm/Kconfig for the different ARM CPU types.

Fix this by restricting the CPU selections to respective
multiplatform config, which now becomes a subset of the
possible Integrator configurations, or alternatively the
non-multiplatform config plus ARCH_INTEGRATOR, i.e.:

if (!ARCH_MULTIPLATFORM || ARCH_MULTI_Vx) &&
   (ARCH_INTEGRATOR || ARCH_FOO ...)

Since the Integrator has been converted to multiplatform,
this will often take the short form:

if (ARCH_MULTI_Vx && ARCH_INTEGRATOR)

If no other non-multiplatform platforms are elegible.

Reported-by: Build bot for Mark Brown <broonie@kernel.org>
Reported-by: Kbuild test robot <fengguang.wu@intel.com>
Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
If this v3 version looks OK to everyone, please apply it
to the ARM SoC tree wherever mu multiplatform mess landed.
---
 arch/arm/mm/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index ae69809a9e47..179a100493f5 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -21,7 +21,7 @@ config CPU_ARM7TDMI
 
 # ARM720T
 config CPU_ARM720T
-	bool "Support ARM720T processor" if ARCH_INTEGRATOR
+	bool "Support ARM720T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
 	select CPU_CACHE_V4
@@ -39,7 +39,7 @@ config CPU_ARM720T
 
 # ARM740T
 config CPU_ARM740T
-	bool "Support ARM740T processor" if ARCH_INTEGRATOR
+	bool "Support ARM740T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
@@ -71,7 +71,7 @@ config CPU_ARM9TDMI
 
 # ARM920T
 config CPU_ARM920T
-	bool "Support ARM920T processor" if ARCH_INTEGRATOR
+	bool "Support ARM920T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -89,7 +89,7 @@ config CPU_ARM920T
 
 # ARM922T
 config CPU_ARM922T
-	bool "Support ARM922T processor" if ARCH_INTEGRATOR
+	bool "Support ARM922T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -127,7 +127,7 @@ config CPU_ARM925T
 
 # ARM926T
 config CPU_ARM926T
-	bool "Support ARM926T processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB
+	bool "Support ARM926T processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V5) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB)
 	select CPU_32v5
 	select CPU_ABRT_EV5TJ
 	select CPU_CACHE_VIVT
@@ -163,7 +163,7 @@ config CPU_FA526
 
 # ARM940T
 config CPU_ARM940T
-	bool "Support ARM940T processor" if ARCH_INTEGRATOR
+	bool "Support ARM940T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
@@ -181,7 +181,7 @@ config CPU_ARM940T
 
 # ARM946E-S
 config CPU_ARM946E
-	bool "Support ARM946E-S processor" if ARCH_INTEGRATOR
+	bool "Support ARM946E-S processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
 	depends on !MMU
 	select CPU_32v5
 	select CPU_ABRT_NOMMU
@@ -198,7 +198,7 @@ config CPU_ARM946E
 
 # ARM1020 - needs validating
 config CPU_ARM1020
-	bool "Support ARM1020T (rev 0) processor" if ARCH_INTEGRATOR
+	bool "Support ARM1020T (rev 0) processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
 	select CPU_32v5
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -216,7 +216,7 @@ config CPU_ARM1020
 
 # ARM1020E - needs validating
 config CPU_ARM1020E
-	bool "Support ARM1020E processor" if ARCH_INTEGRATOR
+	bool "Support ARM1020E processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
 	depends on n
 	select CPU_32v5
 	select CPU_ABRT_EV4T
@@ -229,7 +229,7 @@ config CPU_ARM1020E
 
 # ARM1022E
 config CPU_ARM1022
-	bool "Support ARM1022E processor" if ARCH_INTEGRATOR
+	bool "Support ARM1022E processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
 	select CPU_32v5
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_VIVT
@@ -247,7 +247,7 @@ config CPU_ARM1022
 
 # ARM1026EJ-S
 config CPU_ARM1026
-	bool "Support ARM1026EJ-S processor" if ARCH_INTEGRATOR
+	bool "Support ARM1026EJ-S processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
 	select CPU_32v5
 	select CPU_ABRT_EV5T # But need Jazelle, but EV5TJ ignores bit 10
 	select CPU_CACHE_VIVT
@@ -358,7 +358,7 @@ config CPU_PJ4B
 
 # ARMv6
 config CPU_V6
-	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
+	bool "Support ARM V6 processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V6) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
 	select CPU_32v6
 	select CPU_ABRT_EV6
 	select CPU_CACHE_V6
@@ -371,7 +371,7 @@ config CPU_V6
 
 # ARMv6k
 config CPU_V6K
-	bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
+	bool "Support ARM V6K processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V6) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
 	select CPU_32v6
 	select CPU_32v6K
 	select CPU_ABRT_EV6
@@ -385,7 +385,7 @@ config CPU_V6K
 
 # ARMv7
 config CPU_V7
-	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
+	bool "Support ARM V7 processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V7) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
 	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
-- 
1.9.3
