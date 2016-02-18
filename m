From: slemieux.tyco@gmail.com (slemieux.tyco at gmail.com)
Date: Thu, 18 Feb 2016 16:35:23 -0500
Subject: [PATCH 1/2] arm: lpc32xx: restart: add support for soft reset
In-Reply-To: <1455831324-8909-1-git-send-email-slemieux.tyco@gmail.com>
References: <1455831324-8909-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <1455831324-8909-2-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Add support for explicit soft reset using the reboot mode.

The default reboot mode behavior is unchanged;
you can specified the default reboot type in the board specific file
"DT_MACHINE_START" definition using the "reboot_mode" parameter.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 arch/arm/mach-lpc32xx/common.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 716e83e..9eb9f22 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -200,9 +200,16 @@ void lpc23xx_restart(enum reboot_mode mode, const char *cmd)
 	__raw_writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN,
 		LPC32XX_CLKPWR_TIMER_CLK_CTRL);
 
-	/* Instant assert of RESETOUT_N with pulse length 1mS */
-	__raw_writel(13000, io_p2v(LPC32XX_WDTIM_BASE + 0x18));
-	__raw_writel(0x70, io_p2v(LPC32XX_WDTIM_BASE + 0xC));
+	if (mode == REBOOT_SOFT) {
+		/* Force match output active */
+		__raw_writel(0x01, io_p2v(LPC32XX_WDTIM_BASE + 0x14));
+		/* Enable internal reset on match output (RESOUT_N not asserted) */
+		__raw_writel(0x08, io_p2v(LPC32XX_WDTIM_BASE + 0xC));
+	} else {
+		/* Instant assert of RESETOUT_N with pulse length 1mS */
+		__raw_writel(13000, io_p2v(LPC32XX_WDTIM_BASE + 0x18));
+		__raw_writel(0x70, io_p2v(LPC32XX_WDTIM_BASE + 0xC));
+	}
 
 	/* Wait for watchdog to reset system */
 	while (1)
-- 
1.8.3.1
