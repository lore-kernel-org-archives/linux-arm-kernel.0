From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 8 Mar 2013 16:13:56 +0100
Subject: [PATCH 2/4] ARM: at91: introduce the core type choice to split
 ARMv4/5 and ARMv7 arch
In-Reply-To: <1362755638-20092-1-git-send-email-ludovic.desroches@atmel.com>
References: <1362755638-20092-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1362755638-20092-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

As we will introduce SAMA5, we need to distinguish the core architecture. It is
useless to show ARMv4/5 entries if we are configuring a kernel for SAMA5
devices.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/Kconfig | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 68c53c3..8b35c7f 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -6,6 +6,10 @@ config HAVE_AT91_DBGU0
 config HAVE_AT91_DBGU1
 	bool
 
+config AT91_PMC_UNIT
+	bool
+	default !ARCH_AT91X40
+
 config AT91_SAM9_ALT_RESET
 	bool
 	default !ARCH_AT91X40
@@ -27,8 +31,21 @@ config SOC_AT91SAM9
 
 menu "Atmel AT91 System-on-Chip"
 
+choice
+
+	prompt "Core type"
+
+config SOC_SAM_V4_V5
+	bool "ARM7/ARM9"
+	help
+	  Select this if you are using one of Atmel's AT91SAM9, AT91RM9200
+	  or AT91X40 SoC.
+
+endchoice
+
 comment "Atmel AT91 Processor"
 
+if SOC_SAM_V4_V5
 config SOC_AT91RM9200
 	bool "AT91RM9200"
 	select CPU_ARM920T
@@ -94,13 +111,10 @@ config SOC_AT91SAM9N12
 	help
 	  Select this if you are using Atmel's AT91SAM9N12 SoC.
 
-config AT91_PMC_UNIT
-	bool
-	default !ARCH_AT91X40
-
 # ----------------------------------------------------------
 
 source arch/arm/mach-at91/Kconfig.non_dt
+endif # SOC_SAM_V4_V5
 
 comment "Generic Board Type"
 
-- 
1.7.11.3
