From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 21 Apr 2016 00:51:32 +0800
Subject: [PATCH 3/3] mmc: core: support hs speed mode if hs200 mode fails
In-Reply-To: <1461171092-30631-1-git-send-email-aisheng.dong@nxp.com>
References: <1461171092-30631-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1461171092-30631-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently if mmc_select_hs200 mode switch fails, MMC core
can only use legacy mode to run the card.
Let's retry HS speed mode if HS200 fails.

Before the fix:
mmc0: mmc_select_hs200 failed, error -74
: switch to mmc0 failed
mmc0: new MMC card at address 0001
mmcblk0: mmc0:0001 Q2J55L 7.12 GiB
mmcblk0boot0: mmc0:0001 Q2J55L partition 1 2.00 MiB
mmcblk0boot1: mmc0:0001 Q2J55L partition 2 2.00 MiB
mmcblk0rpmb: mmc0:0001 Q2J55L partition 3 4.00 MiB
 mmcblk0: p1 p2

After the fix:
mmc0: mmc_select_hs200 failed, error -74
mmc0: new DDR MMC card at address 0001
mmcblk0: mmc0:0001 Q2J55L 7.12 GiB
mmcblk0boot0: mmc0:0001 Q2J55L partition 1 2.00 MiB
mmcblk0boot1: mmc0:0001 Q2J55L partition 2 2.00 MiB
mmcblk0rpmb: mmc0:0001 Q2J55L partition 3 4.00 MiB
 mmcblk0: p1 p2

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/core/mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 55c8201..b573dc7 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1315,7 +1315,8 @@ static int mmc_select_timing(struct mmc_card *card)
 
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
 		err = mmc_select_hs200(card);
-	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
+
+	if (err && (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS))
 		err = mmc_select_hs(card);
 
 	if (err && err != -EBADMSG)
-- 
1.9.1
