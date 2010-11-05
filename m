From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Nov 2010 10:35:41 +0100
Subject: [PATCH] mmci: reset voltage after power off.
Message-ID: <1288949741-9712-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@stericsson.com>

At power off, reset OCR mask to be the highest possible voltage
supported for the current mmc host.

This solves the re-initialization during the power up sequence.
The voltage may have been decreased due to the card accepts a lower
voltage than the voltage used during the initialization sequence.
We need to reset the voltage to by the host highest possible value
since according to specification the initialization must always be
done at high voltage.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/core/core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8f86d70..508ed2b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -940,6 +940,13 @@ static void mmc_power_off(struct mmc_host *host)
 {
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
+
+	/*
+	 * Reset ocr mask to be the highest possible voltage supported for
+	 * this mmc host. This value will be used at next power up.
+	 */
+	host->ocr = 1 << (fls(host->ocr_avail) - 1);
+
 	if (!mmc_host_is_spi(host)) {
 		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 		host->ios.chip_select = MMC_CS_DONTCARE;
-- 
1.6.3.3
