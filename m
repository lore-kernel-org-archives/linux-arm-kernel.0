From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri,  4 Jun 2010 07:52:27 +0200
Subject: [PATCH 1/2] backlight: Fix blanking for LMS283GF05 LCD
Message-ID: <1275630748-10722-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCD was turned on if the variable power was > 0, but that was incorrect. The
LCD has to be turned on in every case but POWERDOWN.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/video/backlight/lms283gf05.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/backlight/lms283gf05.c b/drivers/video/backlight/lms283gf05.c
index abc43a0..6a35602 100644
--- a/drivers/video/backlight/lms283gf05.c
+++ b/drivers/video/backlight/lms283gf05.c
@@ -129,7 +129,7 @@ static int lms283gf05_power_set(struct lcd_device *ld, int power)
 	struct spi_device *spi = st->spi;
 	struct lms283gf05_pdata *pdata = spi->dev.platform_data;
 
-	if (power) {
+	if (power < FB_BLANK_POWERDOWN) {
 		if (pdata)
 			lms283gf05_reset(pdata->reset_gpio,
 					pdata->reset_inverted);
-- 
1.7.1
