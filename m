From: Barry.Song@csr.com (Barry Song)
Date: Mon, 18 Aug 2014 18:00:12 +0800
Subject: [PATCH] mmc: core: sd: check card write-protect lock while resuming
Message-ID: <1408356012-18867-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Minda Chen <Minda.Chen@csr.com>

After suspending, unplug the sdcard, and set sd WP lock,
insert it again, then resume the system. resume codes do
not check the the sdcard write-proctect lock. now check
it.

Signed-off-by: Minda Chen <Minda.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/core/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 0c44510..890557a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -910,6 +910,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	int err;
 	u32 cid[4];
 	u32 rocr = 0;
+	bool oldro, ro;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -922,6 +923,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
 			return -ENOENT;
 
+		if (host->ops->get_ro) {
+			ro = host->ops->get_ro(host) ? true : false;
+			oldro = mmc_card_readonly(oldcard) ? true : false;
+			if (oldro ^ ro)
+				return -ENOENT;
+		}
 		card = oldcard;
 	} else {
 		/*
-- 
2.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
