From: slemieux.tyco@gmail.com (slemieux.tyco at gmail.com)
Date: Thu, 18 Feb 2016 16:35:24 -0500
Subject: [PATCH 2/2] arm: lpc32xx: restart: support "cmd" from userspace
In-Reply-To: <1455831324-8909-1-git-send-email-slemieux.tyco@gmail.com>
References: <1455831324-8909-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <1455831324-8909-3-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Add the support to verify if a "cmd" is passed from the userspace program rebooting the system;
- if a valid "cmd" is available, it will be handle;
- If the received "cmd" is not supported, the default reboot mode is used.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 arch/arm/mach-lpc32xx/common.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 9eb9f22..ba61839 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -196,6 +196,19 @@ void __init lpc32xx_map_io(void)
 
 void lpc23xx_restart(enum reboot_mode mode, const char *cmd)
 {
+	/*
+	 * Verify if a "cmd" passed from the userspace program rebooting
+	 * the system; if available, and handle it.
+	 * - For details, see the 'reboot' syscall in kernel/reboot.c
+	 * - If the received "cmd" is not supported, use the default mode.
+	 */
+	if (cmd) {
+		if (cmd[0] == 'h')
+			mode = REBOOT_HARD;
+		else if (cmd[0] == 's')
+			mode = REBOOT_SOFT;
+	}
+
 	/* Make sure WDT clocks are enabled */
 	__raw_writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN,
 		LPC32XX_CLKPWR_TIMER_CLK_CTRL);
-- 
1.8.3.1
