From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 11 Jun 2010 17:26:54 +0200
Subject: [PATCH 04/13] DMAENGINE: ste_dma40: config checks
Message-ID: <1276270014-1498-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Added various configuration checks.

Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/include/plat/ste_dma40.h |    2 +-
 drivers/dma/ste_dma40.c                        |   29 ++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/ste_dma40.h b/arch/arm/plat-nomadik/include/plat/ste_dma40.h
index 4d12ea4..fdc1306 100644
--- a/arch/arm/plat-nomadik/include/plat/ste_dma40.h
+++ b/arch/arm/plat-nomadik/include/plat/ste_dma40.h
@@ -98,7 +98,7 @@ struct stedma40_half_channel_info {
 };
 
 enum stedma40_xfer_dir {
-	STEDMA40_MEM_TO_MEM,
+	STEDMA40_MEM_TO_MEM = 1,
 	STEDMA40_MEM_TO_PERIPH,
 	STEDMA40_PERIPH_TO_MEM,
 	STEDMA40_PERIPH_TO_PERIPH
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index c1b278f..b4ff2b1 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1000,14 +1000,39 @@ static int d40_validate_conf(struct d40_chan *d40c,
 	bool is_log = (conf->channel_type & STEDMA40_CHANNEL_IN_OPER_MODE)
 		== STEDMA40_CHANNEL_IN_LOG_MODE;
 
-	if (d40c->dma_cfg.dir == STEDMA40_MEM_TO_PERIPH &&
+	if (!conf->dir) {
+		dev_err(&d40c->chan.dev->device, "[%s] Invalid direction.\n",
+			__func__);
+		res = -EINVAL;
+	}
+
+	if (conf->dst_dev_type != STEDMA40_DEV_DST_MEMORY &&
+	    d40c->base->plat_data->dev_tx[conf->dst_dev_type] == 0 &&
+	    d40c->amba_addr == 0) {
+
+		dev_err(&d40c->chan.dev->device,
+			"[%s] Invalid TX channel address (%d)\n",
+			__func__, conf->dst_dev_type);
+		res = -EINVAL;
+	}
+
+	if (conf->src_dev_type != STEDMA40_DEV_SRC_MEMORY &&
+	    d40c->base->plat_data->dev_rx[conf->src_dev_type] == 0 &&
+	    d40c->amba_addr == 0) {
+		dev_err(&d40c->chan.dev->device,
+			"[%s] Invalid RX channel address (%d)\n",
+			__func__, conf->src_dev_type);
+		res = -EINVAL;
+	}
+
+	if (conf->dir == STEDMA40_MEM_TO_PERIPH &&
 	    dst_event_group == STEDMA40_DEV_DST_MEMORY) {
 		dev_err(&d40c->chan.dev->device, "[%s] Invalid dst\n",
 			__func__);
 		res = -EINVAL;
 	}
 
-	if (d40c->dma_cfg.dir == STEDMA40_PERIPH_TO_MEM &&
+	if (conf->dir == STEDMA40_PERIPH_TO_MEM &&
 	    src_event_group == STEDMA40_DEV_SRC_MEMORY) {
 		dev_err(&d40c->chan.dev->device, "[%s] Invalid src\n",
 			__func__);
-- 
1.6.3.3
