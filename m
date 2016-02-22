From: slemieux.tyco@gmail.com (slemieux.tyco at gmail.com)
Date: Mon, 22 Feb 2016 11:55:42 -0500
Subject: [PATCH v2 4/5] watchdog: pnx4008: restart: support "cmd" from
 userspace
In-Reply-To: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <1456160143-26761-5-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Added support to verify if a "cmd" is passed from the userspace program rebooting the system;
- if a valid "cmd" is available, handle it;
- If the received "cmd" is not supported, use the default reboot mode.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v1 to v2:
- Rename patch title;
  was "arm: lpc32xx: restart: support "cmd" from userspace"
- Add change to "pnx-4008" driver instead of "mach-lpc32xx".

 drivers/watchdog/pnx4008_wdt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 2275fd4..5f34299 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -133,6 +133,19 @@ static void pnx4008_wdt_sys_reset(enum reboot_mode mode, const char *cmd)
 	/* Make sure WDT clocks are enabled */
 	writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN, LPC32XX_CLKPWR_TIMER_CLK_CTRL);
 
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
 	if (mode == REBOOT_SOFT) {
 		/* Force match output active */
 		writel(EXT_MATCH0, WDTIM_EMR(wdt_base));
-- 
1.8.3.1
