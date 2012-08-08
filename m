From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 16:47:27 +0200
Subject: [PATCH 10/11] spi/s3c64xx: improve error handling
In-Reply-To: <1344437248-20560-1-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
Message-ID: <1344437248-20560-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a device tree definition os an s3c64xx SPI master is missing
a "controller-data" subnode, the newly added s3c64xx_get_slave_ctrldata
function might use uninitialized memory in place of that node,
which was correctly reported by gcc.

Without this patch, building s3c6400_defconfig results in:

drivers/spi/spi-s3c64xx.c: In function 's3c64xx_get_slave_ctrldata.isra.25':
drivers/spi/spi-s3c64xx.c:841:5: warning: 'data_np' may be used uninitialized in this function [-Wuninitialized]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 646a765..cfa2c35 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -826,7 +826,7 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 				struct spi_device *spi)
 {
 	struct s3c64xx_spi_csinfo *cs;
-	struct device_node *slave_np, *data_np;
+	struct device_node *slave_np, *data_np = NULL;
 	u32 fb_delay = 0;
 
 	slave_np = spi->dev.of_node;
-- 
1.7.10
