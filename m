From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:28:58 +0100
Subject: [PATCH 01/62] ARM: at91: split out at91x40 into a top-level option
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91x40 is different from all the other at91 machines, and it is
impossible to build a kernel that works on both this SoC and
any of the others, even though it is possible to build a noMMU
kernel for any at91 machine.

By turning at91x40 into a separate top-level option, we explicitly
forbid enabling invalid configurations that include mutually exclusive
machines.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/Kconfig        | 22 ++++++++++++++++++----
 arch/arm/mach-at91/Kconfig.non_dt |  8 +-------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index ae6617e..7209c5b 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -64,11 +64,22 @@ choice
 
 	prompt "Core type"
 
+config ARCH_AT91X40
+	bool "ARM7/ARM9 AT91X40"
+	depends on !MMU
+	select CPU_ARM7TDMI
+	select ARCH_USES_GETTIMEOFFSET
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
+
+	help
+	  Select this if you are using one of Atmel's AT91X40 SoC.
+
 config SOC_SAM_V4_V5
-	bool "ARM7/ARM9"
+	bool "ARM7/ARM9 AT91SAM9/AT91RM9200"
 	help
-	  Select this if you are using one of Atmel's AT91SAM9, AT91RM9200
-	  or AT91X40 SoC.
+	  Select this if you are using one of Atmel's AT91SAM9 or
+	  AT91RM9200 SoC.
 
 config SOC_SAM_V7
 	bool "Cortex A5"
@@ -177,9 +188,12 @@ config SOC_AT91SAM9N12
 	  Select this if you are using Atmel's AT91SAM9N12 SoC.
 
 # ----------------------------------------------------------
+endif # SOC_SAM_V4_V5
+
 
+if SOC_SAM_V4_V5 || ARCH_AT91X40
 source arch/arm/mach-at91/Kconfig.non_dt
-endif # SOC_SAM_V4_V5
+endif
 
 comment "Generic Board Type"
 
diff --git a/arch/arm/mach-at91/Kconfig.non_dt b/arch/arm/mach-at91/Kconfig.non_dt
index 1f73e9b..44ace32 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -5,6 +5,7 @@ config HAVE_AT91_DATAFLASH_CARD
 
 choice
 	prompt "Atmel AT91 Processor Devices for non DT boards"
+	depends on !ARCH_AT91X40
 
 config ARCH_AT91_NONE
 	bool "None"
@@ -39,13 +40,6 @@ config ARCH_AT91SAM9G45
 	select SOC_AT91SAM9G45
 	select AT91_USE_OLD_CLK
 
-config ARCH_AT91X40
-	bool "AT91x40"
-	depends on !MMU
-	select ARCH_USES_GETTIMEOFFSET
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
-
 endchoice
 
 config ARCH_AT91SAM9G20
-- 
1.8.3.2
