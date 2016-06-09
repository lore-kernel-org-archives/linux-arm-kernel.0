From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Jun 2016 09:10:13 +0200
Subject: [PATCH 07/12] mmc: core: export the alive operation
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465456218-28354-8-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depending of the type of card there is a different operation to know
if the  car is alive. However, the access to this operation are private.
This patch introduce a new function allowing to know if the card is alive
by using the appropriate operation.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/core/core.c  | 7 +++++++
 include/linux/mmc/card.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8b4dfd45433b..3dce095c5f89 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2464,6 +2464,13 @@ int mmc_hw_reset(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_hw_reset);
 
+
+int card_alive(struct mmc_card *card)
+{
+	return card->host->bus_ops->alive(card->host);
+}
+EXPORT_SYMBOL(card_alive);
+
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
 	host->f_init = freq;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index eb0151bac50c..287a0b12d8ba 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -526,6 +526,7 @@ struct mmc_driver {
 	void (*shutdown)(struct mmc_card *);
 };
 
+extern int card_alive(struct mmc_card *);
 extern int mmc_register_driver(struct mmc_driver *);
 extern void mmc_unregister_driver(struct mmc_driver *);
 
-- 
2.5.0
