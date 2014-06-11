From: chiau.ee.chew@intel.com (Chew Chiau Ee)
Date: Wed, 11 Jun 2014 23:57:02 +0800
Subject: [PATCH] spi/pxa2xx: fix incorrect SW mode chipselect setting for
 BayTrail LPSS SPI
Message-ID: <1402502222-19520-1-git-send-email-chiau.ee.chew@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chew, Chiau Ee <chiau.ee.chew@intel.com>

It was observed that after module removal followed by insertion,
the SW mode chipselect is not properly set. Thus causing transfer
failure due to incorrect CS toggling.

Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index a98df7e..cfaf3e6 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -126,7 +126,7 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 		goto detection_done;
 	}
 
-	value &= ~SPI_CS_CONTROL_SW_MODE;
+	orig = value &= ~SPI_CS_CONTROL_SW_MODE;
 	writel(value, drv_data->ioaddr + offset + SPI_CS_CONTROL);
 	value = readl(drv_data->ioaddr + offset + SPI_CS_CONTROL);
 	if (value != orig) {
-- 
1.7.4.4
