From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue,  8 Oct 2013 22:35:38 +0200
Subject: [PATCH 6/9] spi: spi-bfin5xx: replace platform_driver_probe to
 support deferred probing
In-Reply-To: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1381264542-29396-7-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subsystems like pinctrl and gpio rightfully make use of deferred probing at
core level. Now, deferred drivers won't be retried if they don't have a .probe
function specified in the driver struct. Fix this driver to have that, so the
devices it supports won't get lost in a deferred probe.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/spi/spi-bfin5xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index 45bdf73..a563bd5 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -1462,12 +1462,13 @@ static struct platform_driver bfin_spi_driver = {
 	},
 	.suspend	= bfin_spi_suspend,
 	.resume		= bfin_spi_resume,
-	.remove		= bfin_spi_remove,
+	.probe = bfin_spi_probe,
+	.remove = bfin_spi_remove,
 };
 
 static int __init bfin_spi_init(void)
 {
-	return platform_driver_probe(&bfin_spi_driver, bfin_spi_probe);
+	return platform_driver_register(&bfin_spi_driver);
 }
 subsys_initcall(bfin_spi_init);
 
-- 
1.8.4.rc3
