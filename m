From: boojin.kim@samsung.com (Boojin Kim)
Date: Fri,  2 Sep 2011 09:44:44 +0900
Subject: [PATCH v8 16/16] ARM: SAMSUNG: Remove Samsung specific enum type for
	dma direction
In-Reply-To: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314924284-25554-17-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the samsung specific enum type 's3c2410_dmasrc'
and uses 'dma_data_direction' instead.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/include/mach/dma.h         |    2 +-
 arch/arm/mach-s3c2412/dma.c                      |    4 ++--
 arch/arm/mach-s3c64xx/dma.c                      |   10 +++++-----
 arch/arm/mach-s3c64xx/include/mach/dma.h         |    2 +-
 arch/arm/plat-s3c24xx/dma.c                      |   10 +++++-----
 arch/arm/plat-samsung/include/plat/dma-s3c24xx.h |    2 +-
 arch/arm/plat-samsung/include/plat/dma.h         |    9 +++------
 arch/arm/plat-samsung/s3c-dma-ops.c              |    5 +----
 drivers/mmc/host/s3cmci.c                        |    6 +++---
 9 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/dma.h b/arch/arm/mach-s3c2410/include/mach/dma.h
index 4e485ba..ae8e482 100644
--- a/arch/arm/mach-s3c2410/include/mach/dma.h
+++ b/arch/arm/mach-s3c2410/include/mach/dma.h
@@ -174,7 +174,7 @@ struct s3c2410_dma_chan {
 	struct s3c2410_dma_client *client;
 
 	/* channel configuration */
-	enum s3c2410_dmasrc	 source;
+	enum dma_data_direction	 source;
 	enum dma_ch		 req_ch;
 	unsigned long		 dev_addr;
 	unsigned long		 load_timeout;
diff --git a/arch/arm/mach-s3c2412/dma.c b/arch/arm/mach-s3c2412/dma.c
index 7abecfc..b4fc3ba 100644
--- a/arch/arm/mach-s3c2412/dma.c
+++ b/arch/arm/mach-s3c2412/dma.c
@@ -148,11 +148,11 @@ static struct s3c24xx_dma_map __initdata s3c2412_dma_mappings[] = {
 
 static void s3c2412_dma_direction(struct s3c2410_dma_chan *chan,
 				  struct s3c24xx_dma_map *map,
-				  enum s3c2410_dmasrc dir)
+				  enum dma_data_direction dir)
 {
 	unsigned long chsel;
 
-	if (dir == S3C2410_DMASRC_HW)
+	if (dir == DMA_FROM_DEVICE)
 		chsel = map->channels_rx[0];
 	else
 		chsel = map->channels[0];
diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index 204bfaf..67c97fa 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -147,14 +147,14 @@ static void s3c64xx_dma_fill_lli(struct s3c2410_dma_chan *chan,
 	u32 control0, control1;
 
 	switch (chan->source) {
-	case S3C2410_DMASRC_HW:
+	case DMA_FROM_DEVICE:
 		src = chan->dev_addr;
 		dst = data;
 		control0 = PL080_CONTROL_SRC_AHB2;
 		control0 |= PL080_CONTROL_DST_INCR;
 		break;
 
-	case S3C2410_DMASRC_MEM:
+	case DMA_TO_DEVICE:
 		src = data;
 		dst = chan->dev_addr;
 		control0 = PL080_CONTROL_DST_AHB2;
@@ -416,7 +416,7 @@ EXPORT_SYMBOL(s3c2410_dma_enqueue);
 
 
 int s3c2410_dma_devconfig(enum dma_ch channel,
-			  enum s3c2410_dmasrc source,
+			  enum dma_data_direction source,
 			  unsigned long devaddr)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
@@ -437,11 +437,11 @@ int s3c2410_dma_devconfig(enum dma_ch channel,
 	pr_debug("%s: peripheral %d\n", __func__, peripheral);
 
 	switch (source) {
-	case S3C2410_DMASRC_HW:
+	case DMA_FROM_DEVICE:
 		config = 2 << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		config |= peripheral << PL080_CONFIG_SRC_SEL_SHIFT;
 		break;
-	case S3C2410_DMASRC_MEM:
+	case DMA_TO_DEVICE:
 		config = 1 << PL080_CONFIG_FLOW_CONTROL_SHIFT;
 		config |= peripheral << PL080_CONFIG_DST_SEL_SHIFT;
 		break;
diff --git a/arch/arm/mach-s3c64xx/include/mach/dma.h b/arch/arm/mach-s3c64xx/include/mach/dma.h
index 74fdf25..fe1a98c 100644
--- a/arch/arm/mach-s3c64xx/include/mach/dma.h
+++ b/arch/arm/mach-s3c64xx/include/mach/dma.h
@@ -99,7 +99,7 @@ struct s3c2410_dma_chan {
 	unsigned char		 peripheral;
 
 	unsigned int		 flags;
-	enum s3c2410_dmasrc	 source;
+	enum dma_data_direction	 source;
 
 
 	dma_addr_t		dev_addr;
diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index 539bd0e..53754bc 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -1094,14 +1094,14 @@ EXPORT_SYMBOL(s3c2410_dma_config);
  *
  * configure the dma source/destination hardware type and address
  *
- * source:    S3C2410_DMASRC_HW: source is hardware
- *            S3C2410_DMASRC_MEM: source is memory
+ * source:    DMA_FROM_DEVICE: source is hardware
+ *            DMA_TO_DEVICE: source is memory
  *
  * devaddr:   physical address of the source
 */
 
 int s3c2410_dma_devconfig(enum dma_ch channel,
-			  enum s3c2410_dmasrc source,
+			  enum dma_data_direction source,
 			  unsigned long devaddr)
 {
 	struct s3c2410_dma_chan *chan = s3c_dma_lookup_channel(channel);
@@ -1131,7 +1131,7 @@ int s3c2410_dma_devconfig(enum dma_ch channel,
 	 hwcfg |= S3C2410_DISRCC_INC;
 
 	switch (source) {
-	case S3C2410_DMASRC_HW:
+	case DMA_FROM_DEVICE:
 		/* source is hardware */
 		pr_debug("%s: hw source, devaddr=%08lx, hwcfg=%d\n",
 			 __func__, devaddr, hwcfg);
@@ -1142,7 +1142,7 @@ int s3c2410_dma_devconfig(enum dma_ch channel,
 		chan->addr_reg = dma_regaddr(chan, S3C2410_DMA_DIDST);
 		break;
 
-	case S3C2410_DMASRC_MEM:
+	case DMA_TO_DEVICE:
 		/* source is memory */
 		pr_debug("%s: mem source, devaddr=%08lx, hwcfg=%d\n",
 			 __func__, devaddr, hwcfg);
diff --git a/arch/arm/plat-samsung/include/plat/dma-s3c24xx.h b/arch/arm/plat-samsung/include/plat/dma-s3c24xx.h
index 336d5ac..1982829 100644
--- a/arch/arm/plat-samsung/include/plat/dma-s3c24xx.h
+++ b/arch/arm/plat-samsung/include/plat/dma-s3c24xx.h
@@ -47,7 +47,7 @@ struct s3c24xx_dma_selection {
 
 	void	(*direction)(struct s3c2410_dma_chan *chan,
 			     struct s3c24xx_dma_map *map,
-			     enum s3c2410_dmasrc dir);
+			     enum dma_data_direction dir);
 };
 
 extern int s3c24xx_dma_init_map(struct s3c24xx_dma_selection *sel);
diff --git a/arch/arm/plat-samsung/include/plat/dma.h b/arch/arm/plat-samsung/include/plat/dma.h
index 3610760..b906112 100644
--- a/arch/arm/plat-samsung/include/plat/dma.h
+++ b/arch/arm/plat-samsung/include/plat/dma.h
@@ -10,17 +10,14 @@
  * published by the Free Software Foundation.
 */
 
+#include <linux/dma-mapping.h>
+
 enum s3c2410_dma_buffresult {
 	S3C2410_RES_OK,
 	S3C2410_RES_ERR,
 	S3C2410_RES_ABORT
 };
 
-enum s3c2410_dmasrc {
-	S3C2410_DMASRC_HW,		/* source is memory */
-	S3C2410_DMASRC_MEM		/* source is hardware */
-};
-
 /* enum s3c2410_chan_op
  *
  * operation codes passed to the DMA code by the user, and also used
@@ -112,7 +109,7 @@ extern int s3c2410_dma_config(enum dma_ch channel, int xferunit);
 */
 
 extern int s3c2410_dma_devconfig(enum dma_ch channel,
-		enum s3c2410_dmasrc source, unsigned long devaddr);
+		enum dma_data_direction source, unsigned long devaddr);
 
 /* s3c2410_dma_getposition
  *
diff --git a/arch/arm/plat-samsung/s3c-dma-ops.c b/arch/arm/plat-samsung/s3c-dma-ops.c
index 33ab324..582333c 100644
--- a/arch/arm/plat-samsung/s3c-dma-ops.c
+++ b/arch/arm/plat-samsung/s3c-dma-ops.c
@@ -48,10 +48,7 @@ static unsigned s3c_dma_request(enum dma_ch dma_ch,
 	data->ch = dma_ch;
 	list_add_tail(&data->node, &dma_list);
 
-	if (info->direction == DMA_FROM_DEVICE)
-		s3c2410_dma_devconfig(dma_ch, S3C2410_DMASRC_HW, info->fifo);
-	else
-		s3c2410_dma_devconfig(dma_ch, S3C2410_DMASRC_MEM, info->fifo);
+	s3c2410_dma_devconfig(dma_ch, info->direction, info->fifo);
 
 	if (info->cap == DMA_CYCLIC)
 		s3c2410_dma_setflags(dma_ch, S3C2410_DMAF_CIRCULAR);
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index a04f87d..03cfdab 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -913,9 +913,9 @@ request_done:
 }
 
 static void s3cmci_dma_setup(struct s3cmci_host *host,
-			     enum s3c2410_dmasrc source)
+			     enum dma_data_direction source)
 {
-	static enum s3c2410_dmasrc last_source = -1;
+	static enum dma_data_direction last_source = -1;
 	static int setup_ok;
 
 	if (last_source == source)
@@ -1087,7 +1087,7 @@ static int s3cmci_prepare_dma(struct s3cmci_host *host, struct mmc_data *data)
 
 	BUG_ON((data->flags & BOTH_DIR) == BOTH_DIR);
 
-	s3cmci_dma_setup(host, rw ? S3C2410_DMASRC_MEM : S3C2410_DMASRC_HW);
+	s3cmci_dma_setup(host, rw ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	s3c2410_dma_ctrl(host->dma, S3C2410_DMAOP_FLUSH);
 
 	dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-- 
1.7.1
