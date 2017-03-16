From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Mar 2017 14:11:33 +0000
Subject: Applied "spi: loopback-test: add option to use vmalloc'ed buffers" to
 the spi tree
In-Reply-To: <1487872921-26628-7-git-send-email-fisaksen@baylibre.com>
Message-ID: <E1coW7p-0002m1-7z@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: loopback-test: add option to use vmalloc'ed buffers

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 576333a1fb940767e8638fafea908214682e8acd Mon Sep 17 00:00:00 2001
From: Frode Isaksen <fisaksen@baylibre.com>
Date: Thu, 23 Feb 2017 19:02:01 +0100
Subject: [PATCH] spi: loopback-test: add option to use vmalloc'ed buffers

Using vmalloc'ed buffers will use one SG entry for each page,
that may provoke DMA errors for large transfers.
Also vmalloc'ed buffers may cause errors on CPU's with VIVT cache.
Add this option to catch these errors when testing.
Note that to catch VIVT cache errors, checking the rx range
has to be disabled, so this option has been added as well.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 50e620f4e8fe..35960515382e 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -55,6 +55,18 @@ module_param(run_only_test, int, 0);
 MODULE_PARM_DESC(run_only_test,
 		 "only run the test with this number (0-based !)");
 
+/* use vmalloc'ed buffers */
+int use_vmalloc;
+module_param(use_vmalloc, int, 0644);
+MODULE_PARM_DESC(use_vmalloc,
+		 "use vmalloc'ed buffers instead of kmalloc'ed");
+
+/* check rx ranges */
+int check_ranges = 1;
+module_param(check_ranges, int, 0644);
+MODULE_PARM_DESC(check_ranges,
+		 "checks rx_buffer pattern are valid");
+
 /* the actual tests to execute */
 static struct spi_test spi_tests[] = {
 	{
@@ -492,9 +504,11 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 	int ret;
 
 	/* checks rx_buffer pattern are valid with loopback or without */
-	ret = spi_check_rx_ranges(spi, msg, rx);
-	if (ret)
-		return ret;
+	if (check_ranges) {
+		ret = spi_check_rx_ranges(spi, msg, rx);
+		if (ret)
+			return ret;
+	}
 
 	/* if we run without loopback, then return now */
 	if (!loopback)
@@ -965,13 +979,19 @@ int spi_test_run_tests(struct spi_device *spi,
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
@@ -999,8 +1019,8 @@ int spi_test_run_tests(struct spi_device *spi,
 	}
 
 out:
-	kfree(rx);
-	kfree(tx);
+	kvfree(rx);
+	kvfree(tx);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_test_run_tests);
-- 
2.11.0
