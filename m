From: noralf@tronnes.org (=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=)
Date: Wed, 17 Jun 2015 16:04:04 +0200
Subject: [PATCH v3] watchdog: bcm2835: Fix poweroff behaviour
Message-ID: <1434549844-11704-1-git-send-email-noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently poweroff/halt results in a reboot on the Raspberry Pi.
The firmware uses the RSTS register to know which partiton to
boot from. The partiton value is spread into bits
0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
the firmware to indicate halt.

The firmware made this change in 19 Aug 2013 and was matched
by the downstream commit:
Changes for new NOOBS multi partition booting from gsh

Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
---

v2: Fix typo in commit message

v3: Only Raspberry Pi is supported so it's ok to just modify
    the poweroff function (Stephen Warrren)

 drivers/watchdog/bcm2835_wdt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 7116968..43dbf5b 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -36,6 +36,13 @@
 #define PM_RSTC_WRCFG_FULL_RESET	0x00000020
 #define PM_RSTC_RESET			0x00000102

+/*
+ * The Raspberry Pi firmware uses the RSTS register to know which partiton
+ * to boot from. The partiton value is spread into bits 0, 2, 4, 6, 8, 10.
+ * Partiton 63 is a special partition used by the firmware to indicate halt.
+ */
+#define PM_RSTS_RASPBERRYPI_HALT	0x555
+
 #define SECS_TO_WDOG_TICKS(x) ((x) << 16)
 #define WDOG_TICKS_TO_SECS(x) ((x) >> 16)

@@ -151,8 +158,7 @@ static void bcm2835_power_off(void)
 	 * hard reset.
 	 */
 	val = readl_relaxed(wdt->base + PM_RSTS);
-	val &= PM_RSTC_WRCFG_CLR;
-	val |= PM_PASSWORD | PM_RSTS_HADWRH_SET;
+	val |= PM_PASSWORD | PM_RSTS_RASPBERRYPI_HALT;
 	writel_relaxed(val, wdt->base + PM_RSTS);

 	/* Continue with normal reset mechanism */
--
2.2.2
