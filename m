From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 20 Oct 2014 20:27:09 +0200
Subject: [PATCH] power: reset: at91-reset: fix power down register
Message-ID: <1413829629-8705-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case of at91sam9g45_restart(), the driver is writing
AT91_DDRSDRC_LPCB_POWER_DOWN to AT91_DDRSDRC_RTR, this should actually be
AT91_DDRSDRC_LPR.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/at91-reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 3611806c9cfd..3cb36693343a 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -100,11 +100,11 @@ static void at91sam9g45_restart(enum reboot_mode mode, const char *cmd)
 		/* Disable SDRAM0 accesses */
 		"1:	str	%3, [%0, #" __stringify(AT91_DDRSDRC_RTR) "]\n\t"
 		/* Power down SDRAM0 */
-		"	str	%4, [%0, #" __stringify(AT91_DDRSDRC_RTR) "]\n\t"
+		"	str	%4, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
 		/* Disable SDRAM1 accesses */
 		"	strne	%3, [%1, #" __stringify(AT91_DDRSDRC_RTR) "]\n\t"
 		/* Power down SDRAM1 */
-		"	strne	%4, [%1, #" __stringify(AT91_DDRSDRC_RTR) "]\n\t"
+		"	strne	%4, [%1, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
 		/* Reset CPU */
 		"	str	%5, [%2, #" __stringify(AT91_RSTC_CR) "]\n\t"
 
-- 
1.9.1
