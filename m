From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  8 Jun 2016 11:27:52 +0100
Subject: [PATCH v2] mmc: core: Only change mode if mmc_select_bus_width() is
 successful.
Message-ID: <1465381672-9772-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc_select_bus_width() returns bus width (4 or 8) on success or
zero if unsupported. So only change mode if setting the bus width
is successful.

Fixes f741494 mmc: fix mmc mode selection for HS-DDR and higher
Fixes: 287980e (remove lots of IS_ERR_VALUE abuses)

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Arnd Bergmann <arnd@arndb.de>

---

v2: Rebase on v4.7-rc2 which includes a fix from Chen-Yu and update
    commit message.
---
 drivers/mmc/core/mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5d438ad..aafb73d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 	 * switch to HS200 mode if bus width is set successfully.
 	 */
 	err = mmc_select_bus_width(card);
-	if (err >= 0) {
+	if (err > 0) {
 		val = EXT_CSD_TIMING_HS200 |
 		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	} else if (mmc_card_hs(card)) {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
-		if (err >= 0) {
+		if (err > 0) {
 			err = mmc_select_hs_ddr(card);
 			if (err)
 				goto free_card;
-- 
1.9.1
