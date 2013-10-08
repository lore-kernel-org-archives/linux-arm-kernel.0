From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue,  8 Oct 2013 22:35:40 +0200
Subject: [PATCH 8/9] spi: spi-s3c64xx: replace platform_driver_probe to
 support deferred probing
In-Reply-To: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1381264542-29396-9-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subsystems like pinctrl and gpio rightfully make use of deferred probing at
core level. Now, deferred drivers won't be retried if they don't have a .probe
function specified in the driver struct. Fix this driver to have that, so the
devices it supports won't get lost in a deferred probe.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/spi/spi-s3c64xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 512b889..3df81c6 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1633,6 +1633,7 @@ static struct platform_driver s3c64xx_spi_driver = {
 		.pm = &s3c64xx_spi_pm,
 		.of_match_table = of_match_ptr(s3c64xx_spi_dt_match),
 	},
+	.probe = s3c64xx_spi_probe,
 	.remove = s3c64xx_spi_remove,
 	.id_table = s3c64xx_spi_driver_ids,
 };
@@ -1640,7 +1641,7 @@ MODULE_ALIAS("platform:s3c64xx-spi");
 
 static int __init s3c64xx_spi_init(void)
 {
-	return platform_driver_probe(&s3c64xx_spi_driver, s3c64xx_spi_probe);
+	return platform_driver_register(&s3c64xx_spi_driver);
 }
 subsys_initcall(s3c64xx_spi_init);
 
-- 
1.8.4.rc3
