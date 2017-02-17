From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 17 Feb 2017 11:38:24 +0100
Subject: [PATCH v2 6/6] spi: loopback-test: add option to use vmalloc'ed
 buffers
In-Reply-To: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
Message-ID: <1487327904-28311-7-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using vmalloc'ed buffers will use one SG entry for each page,
that may provoke DMA errors for large transfers.
Also vmalloc'ed buffers may cause errors on CPU's with VIVT cache.
Add this option to catch these errors when testing.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-loopback-test.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 50e620f..86686dd 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -55,6 +55,12 @@ module_param(run_only_test, int, 0);
 MODULE_PARM_DESC(run_only_test,
 		 "only run the test with this number (0-based !)");
 
+/* use vmalloc'ed buffers */
+int use_vmalloc;
+module_param(use_vmalloc, int, 0644);
+MODULE_PARM_DESC(use_vmalloc,
+		 "use vmalloc'ed buffers instead of kmalloc'ed");
+
 /* the actual tests to execute */
 static struct spi_test spi_tests[] = {
 	{
@@ -965,13 +971,19 @@ int spi_test_run_tests(struct spi_device *spi,
 	/* allocate rx/tx buffers of 128kB size without devm
 	 * in the hope that is on a page boundary
 	 */
-	rx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
+	if (use_vmalloc)
+		rx = vmalloc(SPI_TEST_MAX_SIZE_PLUS);
+	else
+		rx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
 	if (!rx) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	tx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
+	if (use_vmalloc)
+		tx = vmalloc(SPI_TEST_MAX_SIZE_PLUS);
+	else
+		tx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
 	if (!tx) {
 		ret = -ENOMEM;
 		goto out;
@@ -999,8 +1011,13 @@ int spi_test_run_tests(struct spi_device *spi,
 	}
 
 out:
-	kfree(rx);
-	kfree(tx);
+	if (use_vmalloc) {
+		vfree(rx);
+		vfree(tx);
+	} else {
+		kfree(rx);
+		kfree(tx);
+	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_test_run_tests);
-- 
2.7.4
