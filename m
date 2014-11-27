From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 27 Nov 2014 17:06:35 +0100
Subject: [PATCH 07/11] ARM: at91: remove all !DT related configuration options
In-Reply-To: <cover.1417103399.git.nicolas.ferre@atmel.com>
References: <cover.1417103399.git.nicolas.ferre@atmel.com>
Message-ID: <c25faa4f7981be39610b3ed9fd313973c8c894fc.1417103399.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OLD_CLK_AT91 & OLD_IRQ_AT91 were only selected by entries in Kconfig.non_dt
that are now gone. So we remove all this legacy stuff and select the proper
options in the SOC_ entries.

As USE_OF is now selected directly in arch/arm/Kconfig AT91 entry, we can
safely remove it everywhere in this file.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 826e50b63d7e..231893d71658 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -15,23 +15,10 @@ config HAVE_AT91_DBGU1
 config HAVE_AT91_DBGU2
 	bool
 
-config AT91_USE_OLD_CLK
-	bool
-
 config COMMON_CLK_AT91
 	bool
-	default USE_OF && !AT91_USE_OLD_CLK
 	select COMMON_CLK
 
-config OLD_CLK_AT91
-	bool
-	default AT91_USE_OLD_CLK
-
-config OLD_IRQ_AT91
-	bool
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
-
 config HAVE_AT91_SMD
 	bool
 
@@ -40,18 +27,19 @@ config HAVE_AT91_H32MX
 
 config SOC_AT91SAM9
 	bool
-	select ATMEL_AIC_IRQ if !OLD_IRQ_AT91
+	select ATMEL_AIC_IRQ
+	select COMMON_CLK_AT91
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
-	select MEMORY if USE_OF
-	select ATMEL_SDRAMC if USE_OF
+	select MEMORY
+	select ATMEL_SDRAMC
 
 config SOC_SAMA5
 	bool
 	select ATMEL_AIC5_IRQ
+	select COMMON_CLK_AT91
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-	select USE_OF
 	select MEMORY
 	select ATMEL_SDRAMC
 	select PHYLIB if NETDEVICES
@@ -109,7 +97,8 @@ endif
 if SOC_SAM_V4_V5
 config SOC_AT91RM9200
 	bool "AT91RM9200"
-	select ATMEL_AIC_IRQ if !OLD_IRQ_AT91
+	select ATMEL_AIC_IRQ
+	select COMMON_CLK_AT91
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_DBGU0
@@ -190,7 +179,6 @@ comment "Generic Board Type"
 config MACH_AT91RM9200_DT
 	bool "Atmel AT91RM9200 Evaluation Kits with device-tree support"
 	depends on SOC_AT91RM9200
-	select USE_OF
 	help
 	  Select this if you want to experiment device-tree with
 	  an Atmel RM9200 Evaluation Kit.
@@ -198,7 +186,6 @@ config MACH_AT91RM9200_DT
 config MACH_AT91SAM9_DT
 	bool "Atmel AT91SAM Evaluation Kits with device-tree support"
 	depends on SOC_AT91SAM9
-	select USE_OF
 	help
 	  Select this if you want to experiment device-tree with
 	  an Atmel Evaluation Kit.
-- 
2.1.3
