From: girishks2000@gmail.com (Girish K S)
Date: Mon, 15 Apr 2013 14:10:28 +0530
Subject: [PATCH V3 RESEND 3/5] spi: s3c64xx: Added provision for non-gpio i/o's
In-Reply-To: <1366015230-18243-1-git-send-email-ks.giri@samsung.com>
References: <1366015230-18243-1-git-send-email-ks.giri@samsung.com>
Message-ID: <1366015230-18243-2-git-send-email-ks.giri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Girish K S <girishks2000@gmail.com>

Currently the drivers supports only the GPIO based i/o pins.
But there are Exynos SoC's that use the same controller with
dedicated i/o pins.

This patch  provides provision to support gpio/dedicated pins.
The decision is made by parsing the "gpios" property in the spi
node.

Signed-off-by: Girish K S <ks.giri@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index a6fdc71..79de18f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1111,6 +1111,9 @@ static int s3c64xx_spi_parse_dt_gpio(struct s3c64xx_spi_driver_data *sdd)
 	struct device *dev = &sdd->pdev->dev;
 	int idx, gpio, ret;
 
+	if (!of_find_property(dev->of_node, "gpios", NULL))
+		return 0;
+
 	/* find gpios for mosi, miso and clock lines */
 	for (idx = 0; idx < 3; idx++) {
 		gpio = of_get_gpio(dev->of_node, idx);
@@ -1137,6 +1140,11 @@ free_gpio:
 static void s3c64xx_spi_dt_gpio_free(struct s3c64xx_spi_driver_data *sdd)
 {
 	unsigned int idx;
+	struct device *dev = &sdd->pdev->dev;
+
+	if (!of_find_property(dev->of_node, "gpios", NULL))
+		return;
+
 	for (idx = 0; idx < 3; idx++)
 		gpio_free(sdd->gpios[idx]);
 }
-- 
1.7.5.4
