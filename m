From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Wed, 30 Sep 2015 11:28:08 +0800
Subject: [PATCH] mmc: core: Fix init_card in 52Mhz
Message-ID: <1443583688-1952-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suppose that we got a data crc error, and it triggers the mmc_reset.
mmc_reset will call mmc_send_status to see if HW reset was supported.
before issue CMD13, it will do retune, and if EMMC was in HS400 mode,
it will reduce frequency to 52Mhz firstly, that results in card init
was doing at 52Mhz, So need ensure frequency is lower than 400Khz when
re-init card.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e726903..f2d0c2a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1945,6 +1945,7 @@ static int mmc_reset(struct mmc_host *host)
 
 	/* Set initial state and call mmc_set_ios */
 	mmc_set_initial_state(host);
+	mmc_set_clock(host, host->f_init);
 	mmc_host_clk_release(host);
 
 	return mmc_init_card(host, card->ocr, card);
-- 
1.8.1.1.dirty
