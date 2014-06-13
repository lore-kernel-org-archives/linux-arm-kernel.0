From: chiau.ee.chew@intel.com (Chew Chiau Ee)
Date: Fri, 13 Jun 2014 23:57:25 +0800
Subject: [PATCH v2] spi/pxa2xx: fix incorrect SW mode chipselect setting for
 BayTrail LPSS SPI
Message-ID: <1402675045-22460-1-git-send-email-chiau.ee.chew@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chew, Chiau Ee <chiau.ee.chew@intel.com>

It was observed that after module removal followed by insertion,
the SW mode chipselect is not properly set. Thus causing transfer
failure due to incorrect CS toggling.

Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
---
 drivers/spi/spi-pxa2xx.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index a98df7e..fe79210 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -118,6 +118,7 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	 */
 	orig = readl(drv_data->ioaddr + offset + SPI_CS_CONTROL);
 
+	/* Test SPI_CS_CONTROL_SW_MODE bit enabling */
 	value = orig | SPI_CS_CONTROL_SW_MODE;
 	writel(value, drv_data->ioaddr + offset + SPI_CS_CONTROL);
 	value = readl(drv_data->ioaddr + offset + SPI_CS_CONTROL);
@@ -126,10 +127,13 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 		goto detection_done;
 	}
 
-	value &= ~SPI_CS_CONTROL_SW_MODE;
+	orig = readl(drv_data->ioaddr + offset + SPI_CS_CONTROL);
+
+	/* Test SPI_CS_CONTROL_SW_MODE bit disabling */
+	value = orig & ~SPI_CS_CONTROL_SW_MODE;
 	writel(value, drv_data->ioaddr + offset + SPI_CS_CONTROL);
 	value = readl(drv_data->ioaddr + offset + SPI_CS_CONTROL);
-	if (value != orig) {
+	if (value != (orig & ~SPI_CS_CONTROL_SW_MODE)) {
 		offset = 0x800;
 		goto detection_done;
 	}
-- 
1.7.4.4
