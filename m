From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:39 +0530
Subject: [PATCH 01/14] ux500: add SOC Kconfig variables
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the different config options for SoCs DB8500 and DB5500 and
refines the SoC/CPU detection code to support the DB5500 as well via
these.  The selection between DB5500 and DB8500 is currently a simple
compile-time choice.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/Kconfig                 |   22 ++++++++++++++++++----
 arch/arm/mach-ux500/include/mach/hardware.h |   13 +++++++++++--
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index cd412a3..699588f 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -1,16 +1,30 @@
+if ARCH_U8500
+
+config UX500_SOC_COMMON
+	bool
+	default y
+	select ARM_GIC
+	select HAS_MTU
+	select NOMADIK_GPIO
+
+config UX500_SOC_DB8500
+	bool
+
+config UX500_SOC_DB5500
+	bool
+
 menu "ST-Ericsson platform type"
-	depends on ARCH_U8500
 
 comment "ST-Ericsson Multicore Mobile Platforms"
 
 config MACH_U8500_MOP
 	bool "U8500 Early Development platform"
 	default y
-	select ARM_GIC
-	select HAS_MTU
-	select NOMADIK_GPIO
+	select UX500_SOC_DB8500
 	help
 	  Include support for mop500 development platform
 	  based on U8500 architecture. The platform is based
 	  on early drop silicon version of 8500.
 endmenu
+
+endif
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 99ca89f..d86b354 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -147,14 +147,23 @@
 
 #include <asm/cputype.h>
 
+static inline bool cpu_is_u8500(void)
+{
+#ifdef CONFIG_UX500_SOC_DB8500
+	return 1;
+#else
+	return 0;
+#endif
+}
+
 static inline bool cpu_is_u8500ed(void)
 {
-	return (read_cpuid_id() & 15) == 0;
+	return cpu_is_u8500() && (read_cpuid_id() & 15) == 0;
 }
 
 static inline bool cpu_is_u8500v1(void)
 {
-	return (read_cpuid_id() & 15) == 1;
+	return cpu_is_u8500() && (read_cpuid_id() & 15) == 1;
 }
 
 #endif
-- 
1.7.0
