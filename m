From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue,  8 Oct 2013 22:35:41 +0200
Subject: [PATCH 9/9] spi: spi-txx9: replace platform_driver_probe to support
 deferred probing
In-Reply-To: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1381264542-29396-10-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subsystems like pinctrl and gpio rightfully make use of deferred probing at
core level. Now, deferred drivers won't be retried if they don't have a .probe
function specified in the driver struct. Fix this driver to have that, so the
devices it supports won't get lost in a deferred probe.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/spi/spi-txx9.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 7c6d157..c67a1b8 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -440,6 +440,7 @@ static int txx9spi_remove(struct platform_device *dev)
 MODULE_ALIAS("platform:spi_txx9");
 
 static struct platform_driver txx9spi_driver = {
+	.probe = txx9spi_probe,
 	.remove = txx9spi_remove,
 	.driver = {
 		.name = "spi_txx9",
@@ -449,7 +450,7 @@ static struct platform_driver txx9spi_driver = {
 
 static int __init txx9spi_init(void)
 {
-	return platform_driver_probe(&txx9spi_driver, txx9spi_probe);
+	return platform_driver_register(&txx9spi_driver);
 }
 subsys_initcall(txx9spi_init);
 
-- 
1.8.4.rc3
