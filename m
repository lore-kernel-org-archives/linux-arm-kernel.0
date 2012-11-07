From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Wed, 07 Nov 2012 11:40:12 +0530
Subject: [PATCH] spi: s3c64xx: Add fix for crash in spi suspend/resume
Message-ID: <1352268612-9671-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhilash Kesavan <a.kesavan@samsung.com>

The SPI driver makes a gpio_request during initialization. The requested
gpios need to be populated as part of the s3c64xx_spi_driver_data so that
they can be released during suspend and requested again during resume.

Add the missing code to save the requested gpios as part of the driver
data. This fixes a SPI driver suspend crash.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---

This was tested on spi-next branch
http://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git

With S2R patches submitted on mailing list.
http://www.spinics.net/lists/arm-kernel/msg205244.html

 drivers/spi/spi-s3c64xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 01b2f56..57900a8 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1112,7 +1112,7 @@ static int s3c64xx_spi_parse_dt_gpio(struct s3c64xx_spi_driver_data *sdd)
 			dev_err(dev, "invalid gpio[%d]: %d\n", idx, gpio);
 			goto free_gpio;
 		}
-
+		sdd->gpios[idx] = gpio;
 		ret = gpio_request(gpio, "spi-bus");
 		if (ret) {
 			dev_err(dev, "gpio [%d] request failed: %d\n",
-- 
1.7.9.5
