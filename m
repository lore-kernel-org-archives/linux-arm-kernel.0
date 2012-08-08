From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 16:47:25 +0200
Subject: [PATCH 08/11] mtd/omap2: fix dmaengine_slave_config error handling
In-Reply-To: <1344437248-20560-1-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
Message-ID: <1344437248-20560-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added dmaengine support in the omap2 nand driver
potentially causes an undefined return value from the
omap_nand_probe function when dmaengine_slave_config
reports an error. Let's handle this by returning the
same error back to the caller.

Without this patch, building omap2plus_defconfig results in:

drivers/mtd/nand/omap2.c: In function 'omap_nand_probe':
drivers/mtd/nand/omap2.c:1154:6: warning: 'err' may be used uninitialized in this function [-Wuninitialized]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/mtd/nand/omap2.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index e9309b3..ac4fd75 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1245,7 +1245,6 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 			goto out_release_mem_region;
 		} else {
 			struct dma_slave_config cfg;
-			int rc;
 
 			memset(&cfg, 0, sizeof(cfg));
 			cfg.src_addr = info->phys_base;
@@ -1254,10 +1253,10 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 			cfg.src_maxburst = 16;
 			cfg.dst_maxburst = 16;
-			rc = dmaengine_slave_config(info->dma, &cfg);
-			if (rc) {
+			err = dmaengine_slave_config(info->dma, &cfg);
+			if (err) {
 				dev_err(&pdev->dev, "DMA engine slave config failed: %d\n",
-					rc);
+					err);
 				goto out_release_mem_region;
 			}
 			info->nand.read_buf   = omap_read_buf_dma_pref;
-- 
1.7.10
