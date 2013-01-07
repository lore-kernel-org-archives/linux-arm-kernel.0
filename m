From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon,  7 Jan 2013 12:21:49 +0100
Subject: [PATCH 07/16] dmaengine: ste_dma40: support fixed physical channel
 allocation
In-Reply-To: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
References: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1357557718-15676-8-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gerald Baeza <gerald.baeza@stericsson.com>

This patch makes existing use_fixed_channel field (of stedma40_chan_cfg
structure) applicable to physical channels.

Signed-off-by: Gerald Baeza <gerald.baeza@stericsson.com>
Tested-by: Yannick Fertre <yannick.fertre@stericsson.com>
Reviewed-by: Per Forlin <per.forlin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/dma/ste_dma40.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 9f8964a..5feab7db9 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1711,10 +1711,12 @@ static int d40_allocate_channel(struct d40_chan *d40c, bool *first_phy_user)
 	int i;
 	int j;
 	int log_num;
+	int num_phy_chans;
 	bool is_src;
 	bool is_log = d40c->dma_cfg.mode == STEDMA40_MODE_LOGICAL;
 
 	phys = d40c->base->phy_res;
+	num_phy_chans = d40c->base->num_phy_chans;
 
 	if (d40c->dma_cfg.dir == STEDMA40_PERIPH_TO_MEM) {
 		dev_type = d40c->dma_cfg.src_dev_type;
@@ -1735,12 +1737,19 @@ static int d40_allocate_channel(struct d40_chan *d40c, bool *first_phy_user)
 	if (!is_log) {
 		if (d40c->dma_cfg.dir == STEDMA40_MEM_TO_MEM) {
 			/* Find physical half channel */
-			for (i = 0; i < d40c->base->num_phy_chans; i++) {
-
+			if (d40c->dma_cfg.use_fixed_channel) {
+				i = d40c->dma_cfg.phy_channel;
 				if (d40_alloc_mask_set(&phys[i], is_src,
 						       0, is_log,
 						       first_phy_user))
 					goto found_phy;
+			} else {
+				for (i = 0; i < num_phy_chans; i++) {
+					if (d40_alloc_mask_set(&phys[i], is_src,
+						       0, is_log,
+						       first_phy_user))
+						goto found_phy;
+				}
 			}
 		} else
 			for (j = 0; j < d40c->base->num_phy_chans; j += 8) {
-- 
1.7.12.1
