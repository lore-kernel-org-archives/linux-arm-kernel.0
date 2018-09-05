From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  5 Sep 2018 11:18:28 +0200
Subject: [PATCH] ARM: u300: Delete dummy SPI chip
Message-ID: <20180905091828.30170-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's been told to me a few times that this kernel module
should not exist, instead we should use the loopback test
from userspace if need be. If a kernel module is required
for testing SPI, it should be generic and put in
drivers/spi/*.

Delete this driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly to the ARM SoC
tree, I do not intend to send any more U300 related patches
this kernel cycle.
---
 arch/arm/mach-u300/Kconfig        |  13 --
 arch/arm/mach-u300/Makefile       |   1 -
 arch/arm/mach-u300/dummyspichip.c | 276 ------------------------------
 3 files changed, 290 deletions(-)
 delete mode 100644 arch/arm/mach-u300/dummyspichip.c

diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index 4f43c1cd5db0..c3c8bf54f033 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -29,17 +29,4 @@ config U300_DEBUG
 	help
 		Debug support for U300 in sysfs, procfs etc.
 
-config MACH_U300_SPIDUMMY
-	depends on ARCH_U300
-	bool "SSP/SPI dummy chip"
-	select SPI
-	select SPI_MASTER
-	select SPI_PL022
-	help
-		This creates a small kernel module that creates a dummy
-		SPI device to be used for loopback tests. Regularly used
-		to test reference designs. If you're not testing SPI,
-		you don't need it. Selecting this will activate the
-		SPI framework and ARM PL022 support.
-
 endif
diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index 87d37de054b6..5a8804fa8776 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -4,5 +4,4 @@
 
 obj-y		:= core.o
 
-obj-$(CONFIG_MACH_U300_SPIDUMMY)  += dummyspichip.o
 obj-$(CONFIG_REGULATOR_AB3100)    += regulator.o
diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
deleted file mode 100644
index 68fe986ca42e..000000000000
--- a/arch/arm/mach-u300/dummyspichip.c
+++ /dev/null
@@ -1,276 +0,0 @@
-/*
- * arch/arm/mach-u300/dummyspichip.c
- *
- * Copyright (C) 2007-2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * This is a dummy loopback SPI "chip" used for testing SPI.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/sysfs.h>
-#include <linux/mutex.h>
-#include <linux/spi/spi.h>
-#include <linux/dma-mapping.h>
-#include <linux/slab.h>
-/*
- * WARNING! Do not include this pl022-specific controller header
- * for any generic driver. It is only done in this dummy chip
- * because we alter the chip configuration in order to test some
- * different settings on the loopback device. Normal chip configs
- * shall be STATIC and not altered by the driver!
- */
-#include <linux/amba/pl022.h>
-
-struct dummy {
-	struct device *dev;
-	struct mutex lock;
-};
-
-#define DMA_TEST_SIZE 2048
-
-/* When we cat /sys/bus/spi/devices/spi0.0/looptest this will be triggered */
-static ssize_t dummy_looptest(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	struct dummy *p_dummy = dev_get_drvdata(&spi->dev);
-
-	/*
-	 * WARNING! Do not dereference the chip-specific data in any normal
-	 * driver for a chip. It is usually STATIC and shall not be read
-	 * or written to. Your chip driver should NOT depend on fields in this
-	 * struct, this is just used here to alter the behaviour of the chip
-	 * in order to perform tests.
-	 */
-	int status;
-	u8 txbuf[14] = {0xDE, 0xAD, 0xBE, 0xEF, 0x2B, 0xAD,
-			0xCA, 0xFE, 0xBA, 0xBE, 0xB1, 0x05,
-			0xF0, 0x0D};
-	u8 rxbuf[14];
-	u8 *bigtxbuf_virtual;
-	u8 *bigrxbuf_virtual;
-
-	if (mutex_lock_interruptible(&p_dummy->lock))
-		return -ERESTARTSYS;
-
-	bigtxbuf_virtual = kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
-	if (bigtxbuf_virtual == NULL) {
-		status = -ENOMEM;
-		goto out;
-	}
-	bigrxbuf_virtual = kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
-
-	/* Fill TXBUF with some happy pattern */
-	memset(bigtxbuf_virtual, 0xAA, DMA_TEST_SIZE);
-
-	/*
-	 * Force chip to 8 bit mode
-	 * WARNING: NEVER DO THIS IN REAL DRIVER CODE, THIS SHOULD BE STATIC!
-	 */
-	spi->bits_per_word = 8;
-	/* You should NOT DO THIS EITHER */
-	spi->master->setup(spi);
-
-	/* Now run the tests for 8bit mode */
-	pr_info("Simple test 1: write 0xAA byte, read back garbage byte "
-		"in 8bit mode\n");
-	status = spi_w8r8(spi, 0xAA);
-	if (status < 0)
-		pr_warn("Simple test 1: FAILURE: spi_write_then_read failed with status %d\n",
-			status);
-	else
-		pr_info("Simple test 1: SUCCESS!\n");
-
-	pr_info("Simple test 2: write 8 bytes, read back 8 bytes garbage "
-		"in 8bit mode (full FIFO)\n");
-	status = spi_write_then_read(spi, &txbuf[0], 8, &rxbuf[0], 8);
-	if (status < 0)
-		pr_warn("Simple test 2: FAILURE: spi_write_then_read() failed with status %d\n",
-			status);
-	else
-		pr_info("Simple test 2: SUCCESS!\n");
-
-	pr_info("Simple test 3: write 14 bytes, read back 14 bytes garbage "
-		"in 8bit mode (see if we overflow FIFO)\n");
-	status = spi_write_then_read(spi, &txbuf[0], 14, &rxbuf[0], 14);
-	if (status < 0)
-		pr_warn("Simple test 3: FAILURE: failed with status %d (probably FIFO overrun)\n",
-			status);
-	else
-		pr_info("Simple test 3: SUCCESS!\n");
-
-	pr_info("Simple test 4: write 8 bytes with spi_write(), read 8 "
-		"bytes garbage with spi_read() in 8bit mode\n");
-	status = spi_write(spi, &txbuf[0], 8);
-	if (status < 0)
-		pr_warn("Simple test 4 step 1: FAILURE: spi_write() failed with status %d\n",
-			status);
-	else
-		pr_info("Simple test 4 step 1: SUCCESS!\n");
-	status = spi_read(spi, &rxbuf[0], 8);
-	if (status < 0)
-		pr_warn("Simple test 4 step 2: FAILURE: spi_read() failed with status %d\n",
-			status);
-	else
-		pr_info("Simple test 4 step 2: SUCCESS!\n");
-
-	pr_info("Simple test 5: write 14 bytes with spi_write(), read "
-		"14 bytes garbage with spi_read() in 8bit mode\n");
-	status = spi_write(spi, &txbuf[0], 14);
-	if (status < 0)
-		pr_warn("Simple test 5 step 1: FAILURE: spi_write() failed with status %d (probably FIFO overrun)\n",
-			status);
-	else
-		pr_info("Simple test 5 step 1: SUCCESS!\n");
-	status = spi_read(spi, &rxbuf[0], 14);
-	if (status < 0)
-		pr_warn("Simple test 5 step 2: FAILURE: spi_read() failed with status %d (probably FIFO overrun)\n",
-			status);
-	else
-		pr_info("Simple test 5: SUCCESS!\n");
-
-	pr_info("Simple test 6: write %d bytes with spi_write(), "
-		"read %d bytes garbage with spi_read() in 8bit mode\n",
-		DMA_TEST_SIZE, DMA_TEST_SIZE);
-	status = spi_write(spi, &bigtxbuf_virtual[0], DMA_TEST_SIZE);
-	if (status < 0)
-		pr_warn("Simple test 6 step 1: FAILURE: spi_write() failed with status %d (probably FIFO overrun)\n",
-			status);
-	else
-		pr_info("Simple test 6 step 1: SUCCESS!\n");
-	status = spi_read(spi, &bigrxbuf_virtual[0], DMA_TEST_SIZE);
-	if (status < 0)
-		pr_warn("Simple test 6 step 2: FAILURE: spi_read() failed with status %d (probably FIFO overrun)\n",
-			status);
-	else
-		pr_info("Simple test 6: SUCCESS!\n");
-
-
-	/*
-	 * Force chip to 16 bit mode
-	 * WARNING: NEVER DO THIS IN REAL DRIVER CODE, THIS SHOULD BE STATIC!
-	 */
-	spi->bits_per_word = 16;
-	/* You should NOT DO THIS EITHER */
-	spi->master->setup(spi);
-
-	pr_info("Simple test 7: write 0xAA byte, read back garbage byte "
-		"in 16bit bus mode\n");
-	status = spi_w8r8(spi, 0xAA);
-	if (status == -EIO)
-		pr_info("Simple test 7: SUCCESS! (expected failure with "
-			"status EIO)\n");
-	else if (status < 0)
-		pr_warn("Simple test 7: FAILURE: spi_write_then_read failed with status %d\n",
-			status);
-	else
-		pr_warn("Simple test 7: FAILURE: spi_write_then_read succeeded but it was expected to fail!\n");
-
-	pr_info("Simple test 8: write 8 bytes, read back 8 bytes garbage "
-		"in 16bit mode (full FIFO)\n");
-	status = spi_write_then_read(spi, &txbuf[0], 8, &rxbuf[0], 8);
-	if (status < 0)
-		pr_warn("Simple test 8: FAILURE: spi_write_then_read() failed with status %d\n",
-			status);
-	else
-		pr_info("Simple test 8: SUCCESS!\n");
-
-	pr_info("Simple test 9: write 14 bytes, read back 14 bytes garbage "
-		"in 16bit mode (see if we overflow FIFO)\n");
-	status = spi_write_then_read(spi, &txbuf[0], 14, &rxbuf[0], 14);
-	if (status < 0)
-		pr_warn("Simple test 9: FAILURE: failed with status %d (probably FIFO overrun)\n",
-			status);
-	else
-		pr_info("Simple test 9: SUCCESS!\n");
-
-	pr_info("Simple test 10: write %d bytes with spi_write(), "
-	       "read %d bytes garbage with spi_read() in 16bit mode\n",
-	       DMA_TEST_SIZE, DMA_TEST_SIZE);
-	status = spi_write(spi, &bigtxbuf_virtual[0], DMA_TEST_SIZE);
-	if (status < 0)
-		pr_warn("Simple test 10 step 1: FAILURE: spi_write() failed with status %d (probably FIFO overrun)\n",
-			status);
-	else
-		pr_info("Simple test 10 step 1: SUCCESS!\n");
-
-	status = spi_read(spi, &bigrxbuf_virtual[0], DMA_TEST_SIZE);
-	if (status < 0)
-		pr_warn("Simple test 10 step 2: FAILURE: spi_read() failed with status %d (probably FIFO overrun)\n",
-			status);
-	else
-		pr_info("Simple test 10: SUCCESS!\n");
-
-	status = sprintf(buf, "loop test complete\n");
-	kfree(bigrxbuf_virtual);
-	kfree(bigtxbuf_virtual);
- out:
-	mutex_unlock(&p_dummy->lock);
-	return status;
-}
-
-static DEVICE_ATTR(looptest, S_IRUGO, dummy_looptest, NULL);
-
-static int pl022_dummy_probe(struct spi_device *spi)
-{
-	struct dummy *p_dummy;
-	int status;
-
-	dev_info(&spi->dev, "probing dummy SPI device\n");
-
-	p_dummy = kzalloc(sizeof *p_dummy, GFP_KERNEL);
-	if (!p_dummy)
-		return -ENOMEM;
-
-	dev_set_drvdata(&spi->dev, p_dummy);
-	mutex_init(&p_dummy->lock);
-
-	/* sysfs hook */
-	status = device_create_file(&spi->dev, &dev_attr_looptest);
-	if (status) {
-		dev_dbg(&spi->dev, "device_create_file looptest failure.\n");
-		goto out_dev_create_looptest_failed;
-	}
-
-	return 0;
-
-out_dev_create_looptest_failed:
-	dev_set_drvdata(&spi->dev, NULL);
-	kfree(p_dummy);
-	return status;
-}
-
-static int pl022_dummy_remove(struct spi_device *spi)
-{
-	struct dummy *p_dummy = dev_get_drvdata(&spi->dev);
-
-	dev_info(&spi->dev, "removing dummy SPI device\n");
-	device_remove_file(&spi->dev, &dev_attr_looptest);
-	dev_set_drvdata(&spi->dev, NULL);
-	kfree(p_dummy);
-
-	return 0;
-}
-
-static const struct of_device_id pl022_dummy_dt_match[] = {
-	{ .compatible = "arm,pl022-dummy" },
-	{},
-};
-
-static struct spi_driver pl022_dummy_driver = {
-	.driver = {
-		.name	= "spi-dummy",
-		.of_match_table = pl022_dummy_dt_match,
-	},
-	.probe	= pl022_dummy_probe,
-	.remove	= pl022_dummy_remove,
-};
-
-module_spi_driver(pl022_dummy_driver);
-MODULE_AUTHOR("Linus Walleij <linus.walleij@stericsson.com>");
-MODULE_DESCRIPTION("PL022 SSP/SPI DUMMY Linux driver");
-MODULE_LICENSE("GPL");
-- 
2.17.1
