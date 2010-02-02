From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:21 -0800
Subject: [PATCH 09/16] ARM: LPC32XX: LPC32XX macro name changes and local
	macro use
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-10-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Added the LPC32XX prefix to local macro names. Added several
new local macros for register offsets.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/suspend.S |   83 ++++++++++++++++++++-------------------
 1 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/suspend.S b/arch/arm/mach-lpc32xx/suspend.S
index 1d35b34..eea6ddc 100644
--- a/arch/arm/mach-lpc32xx/suspend.S
+++ b/arch/arm/mach-lpc32xx/suspend.S
@@ -26,19 +26,22 @@
 #include <mach/hardware.h>
 
 /* Using named register defines makes the code easier to follow */
-#define WORK1_REG		r0
-#define WORK2_REG		r1
-#define SAVED_HCLK_DIV_REG	r2
-#define SAVED_HCLK_PLL_REG	r3
-#define SAVED_DRAM_CLKCTRL_REG	r4
-#define SAVED_PWR_CTRL_REG	r5
-#define CLKPWRBASE_REG		r6
-#define EMCBASE_REG		r7
-
-#define EMC_STATUS_OFFS		0x04
-#define EMC_STATUS_BUSY		0x1
-#define EMC_STATUS_SELF_RFSH	0x4
-
+#define WORK1_REG			r0
+#define WORK2_REG			r1
+#define SAVED_HCLK_DIV_REG		r2
+#define SAVED_HCLK_PLL_REG		r3
+#define SAVED_DRAM_CLKCTRL_REG		r4
+#define SAVED_PWR_CTRL_REG		r5
+#define CLKPWRBASE_REG			r6
+#define EMCBASE_REG			r7
+
+#define LPC32XX_EMC_STATUS_OFFS		0x04
+#define LPC32XX_EMC_STATUS_BUSY		0x1
+#define LPC32XX_EMC_STATUS_SELF_RFSH	0x4
+
+#define LPC32XX_CLKPWR_PWR_CTRL_OFFS	0x44
+#define LPC32XX_CLKPWR_HCLK_DIV_OFFS	0x40
+#define LPC32XX_CLKPWR_HCLKPLL_CTRL_OFFS 0x58
 	.text
 
 ENTRY(lpc32xx_sys_suspend)
@@ -52,57 +55,57 @@ ENTRY(lpc32xx_sys_suspend)
 	ldr	EMCBASE_REG, [WORK1_REG, #4]
 
 	ldr	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG,\
-		#LPC32XX_CLKPWR_PWR_CTRL(0)]
+		#LPC32XX_CLKPWR_PWR_CTRL_OFFS]
 	orr	WORK1_REG, SAVED_PWR_CTRL_REG, #LPC32XX_CLKPWR_SDRAM_SELF_RFSH
 
 	@ Wait for SDRAM busy status to go busy and then idle
 	@ This guarantees a small windows where DRAM isn't busy
 1:
-	ldr	WORK2_REG, [EMCBASE_REG, #EMC_STATUS_OFFS]
-	and	WORK2_REG, WORK2_REG, #EMC_STATUS_BUSY
-	cmp	WORK2_REG, #EMC_STATUS_BUSY
+	ldr	WORK2_REG, [EMCBASE_REG, #LPC32XX_EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #LPC32XX_EMC_STATUS_BUSY
+	cmp	WORK2_REG, #LPC32XX_EMC_STATUS_BUSY
 	bne	1b @ Branch while idle
 2:
-	ldr	WORK2_REG, [EMCBASE_REG, #EMC_STATUS_OFFS]
-	and	WORK2_REG, WORK2_REG, #EMC_STATUS_BUSY
-	cmp	WORK2_REG, #EMC_STATUS_BUSY
+	ldr	WORK2_REG, [EMCBASE_REG, #LPC32XX_EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #LPC32XX_EMC_STATUS_BUSY
+	cmp	WORK2_REG, #LPC32XX_EMC_STATUS_BUSY
 	beq	2b @ Branch until idle
 
 	@ Setup self-refresh with support for manual exit of
 	@ self-refresh mode
-	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
 	orr	WORK2_REG, WORK1_REG, #LPC32XX_CLKPWR_UPD_SDRAM_SELF_RFSH
-	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
-	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
+	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
 
 	@ Wait for self-refresh acknowledge, clocks to the DRAM device
 	@ will automatically stop on start of self-refresh
 3:
-	ldr	WORK2_REG, [EMCBASE_REG, #EMC_STATUS_OFFS]
-	and	WORK2_REG, WORK2_REG, #EMC_STATUS_SELF_RFSH
-	cmp	WORK2_REG, #EMC_STATUS_SELF_RFSH
+	ldr	WORK2_REG, [EMCBASE_REG, #LPC32XX_EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #LPC32XX_EMC_STATUS_SELF_RFSH
+	cmp	WORK2_REG, #LPC32XX_EMC_STATUS_SELF_RFSH
 	bne	3b @ Branch until self-refresh mode starts
 
 	@ Enter direct-run mode from run mode
 	bic	WORK1_REG, WORK1_REG, #LPC32XX_CLKPWR_SELECT_RUN_MODE
-	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
 
 	@ Safe disable of DRAM clock in EMC block, prevents DDR sync
 	@ issues on restart
 	ldr	SAVED_HCLK_DIV_REG, [CLKPWRBASE_REG,\
-		#LPC32XX_CLKPWR_HCLK_DIV(0)]
+		#LPC32XX_CLKPWR_HCLK_DIV_OFFS]
 	and	WORK2_REG, SAVED_HCLK_DIV_REG, #0xFFFFFE7F
-	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLK_DIV(0)]
+	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLK_DIV_OFFS]
 
 	@ Save HCLK PLL state and disable HCLK PLL
 	ldr	SAVED_HCLK_PLL_REG, [CLKPWRBASE_REG,\
-		#LPC32XX_CLKPWR_HCLKPLL_CTRL(0)]
+		#LPC32XX_CLKPWR_HCLKPLL_CTRL_OFFS]
 	bic	WORK2_REG, SAVED_HCLK_PLL_REG, #LPC32XX_CLKPWR_HCLKPLL_POWER_UP
-	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLKPLL_CTRL(0)]
+	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLKPLL_CTRL_OFFS]
 
 	@ Enter stop mode until an enabled event occurs
 	orr	WORK1_REG, WORK1_REG, #LPC32XX_CLKPWR_STOP_MODE_CTRL
-	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
 	nop
 	nop
 	nop
@@ -118,32 +121,32 @@ ENTRY(lpc32xx_sys_suspend)
 
 	@ Restore original HCLK PLL value and wait for PLL lock
 	str	SAVED_HCLK_PLL_REG, [CLKPWRBASE_REG,\
-		#LPC32XX_CLKPWR_HCLKPLL_CTRL(0)]
+		#LPC32XX_CLKPWR_HCLKPLL_CTRL_OFFS]
 4:
-	ldr	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLKPLL_CTRL(0)]
+	ldr	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLKPLL_CTRL_OFFS]
 	and	WORK2_REG, WORK2_REG, #LPC32XX_CLKPWR_HCLKPLL_PLL_STS
 	bne	4b
 
 	@ Re-enter run mode with self-refresh flag cleared, but no DRAM
 	@ update yet. DRAM is still in self-refresh
 	str	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG,\
-		#LPC32XX_CLKPWR_PWR_CTRL(0)]
+		#LPC32XX_CLKPWR_PWR_CTRL_OFFS]
 
 	@ Restore original DRAM clock mode to restore DRAM clocks
 	str	SAVED_HCLK_DIV_REG, [CLKPWRBASE_REG,\
-		#LPC32XX_CLKPWR_HCLK_DIV(0)]
+		#LPC32XX_CLKPWR_HCLK_DIV_OFFS]
 
 	@ Clear self-refresh mode
 	orr	WORK1_REG, SAVED_PWR_CTRL_REG,\
 		#LPC32XX_CLKPWR_UPD_SDRAM_SELF_RFSH
-	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL_OFFS]
 	str	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG,\
-		#LPC32XX_CLKPWR_PWR_CTRL(0)]
+		#LPC32XX_CLKPWR_PWR_CTRL_OFFS]
 
 	@ Wait for EMC to clear self-refresh mode
 5:
-	ldr	WORK2_REG, [EMCBASE_REG, #EMC_STATUS_OFFS]
-	and	WORK2_REG, WORK2_REG, #EMC_STATUS_SELF_RFSH
+	ldr	WORK2_REG, [EMCBASE_REG, #LPC32XX_EMC_STATUS_OFFS]
+	and	WORK2_REG, WORK2_REG, #LPC32XX_EMC_STATUS_SELF_RFSH
 	bne	5b @ Branch until self-refresh has exited
 
 	@ restore regs and return
-- 
1.6.6
