From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  1 Apr 2011 10:39:23 +0800
Subject: [PATCH 4/9] ARM: pxa: use gpio reset
In-Reply-To: <1301625568-16583-3-git-send-email-haojian.zhuang@marvell.com>
References: <040101>
	<1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1301625568-16583-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Watchdog reset will clear RTC and some configuration registers. GPIO reset
doesn't have this impact. So replace watchdog reset by gpio reset.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/include/mach/pxa3xx-regs.h |    8 ++++++++
 arch/arm/mach-pxa/reset.c                    |   16 ++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h b/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
index e4fb466..28bc2a9 100644
--- a/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
+++ b/arch/arm/mach-pxa/include/mach/pxa3xx-regs.h
@@ -37,6 +37,14 @@
 #define PVCR		__REG(0x40F50100)	/* Power Manager Voltage Change Control Register */
 #define PCMD(x)		__REG(0x40F50110 + ((x) << 2))
 
+#define PMCR_BIE	(1 << 0)		/* Interrupt Enable for nBATT_FAULT */
+#define PMCR_BIS	(1 << 1)		/* Interrupt Status for nBATT_FAULT */
+#define PMCR_TIE	(1 << 10)		/* Interrupt Enable for XScale Core Frequency Change */
+#define PMCR_TIS	(1 << 11)		/* Interrupt Status for XScale Core Frequency Change */
+#define PMCR_VIE	(1 << 12)		/* Interrupt Enable for VCC_APPS and VCC_SRAM Voltage Change */
+#define PMCR_VIS	(1 << 13)		/* Interrupt Status for VCC_APPS and VCC_SRAM Voltage Change */
+#define PMCR_SWGR	(1 << 31)		/* Software GPIO Reset */
+
 /*
  * Slave Power Managment Unit
  */
diff --git a/arch/arm/mach-pxa/reset.c b/arch/arm/mach-pxa/reset.c
index 01e9d64..611d537 100644
--- a/arch/arm/mach-pxa/reset.c
+++ b/arch/arm/mach-pxa/reset.c
@@ -12,6 +12,7 @@
 
 #include <mach/regs-ost.h>
 #include <mach/reset.h>
+#include <mach/pxa3xx-regs.h>
 
 unsigned int reset_status;
 EXPORT_SYMBOL(reset_status);
@@ -75,10 +76,17 @@ static void do_gpio_reset(void)
 
 static void do_hw_reset(void)
 {
-	/* Initialize the watchdog and let it fire */
-	OWER = OWER_WME;
-	OSSR = OSSR_M3;
-	OSMR3 = OSCR + 368640;	/* ... in 100 ms */
+	if (cpu_is_pxa3xx() || cpu_is_pxa95x()) {
+		/* GPIO reset that is defined in silicons */
+		PSPR = 0x5c014000;
+		PMCR = (PMCR & (PMCR_BIE | PMCR_TIE | PMCR_VIE))
+			| PMCR_SWGR;
+	} else {
+		/* Initialize the watchdog and let it fire */
+		OWER = OWER_WME;
+		OSSR = OSSR_M3;
+		OSMR3 = OSCR + 368640;	/* ... in 100 ms */
+	}
 }
 
 void arch_reset(char mode, const char *cmd)
-- 
1.5.6.5
