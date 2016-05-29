From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 29 May 2016 15:04:42 +0800
Subject: [PATCH 1/3] mmc: fix mmc mode selection for HS-DDR and higher
In-Reply-To: <1464505484-3661-1-git-send-email-wens@csie.org>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
Message-ID: <1464505484-3661-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When IS_ERR_VALUE was removed from the mmc core code, it was replaced
with a simple not-zero check. This does not work, as the value checked
is the return value for mmc_select_bus_width, which returns the set
bit width on success. This made eMMC modes higher than HS-DDR unusable.

Fix this by checking for a positive return value instead.

Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/core/mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c984321d1881..aafb73d080ca 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 	 * switch to HS200 mode if bus width is set successfully.
 	 */
 	err = mmc_select_bus_width(card);
-	if (!err) {
+	if (err > 0) {
 		val = EXT_CSD_TIMING_HS200 |
 		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	} else if (mmc_card_hs(card)) {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
-		if (!err) {
+		if (err > 0) {
 			err = mmc_select_hs_ddr(card);
 			if (err)
 				goto free_card;
-- 
2.8.1
