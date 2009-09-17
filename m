From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 17 Sep 2009 14:08:07 +0200
Subject: [PATCH 4/5] U300 SSP/SPI board setup and test
Message-ID: <1253189287-31449-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a U300 board configuration for the PL022 SSP/SPI
PrimeCell driver recently merged to the 2.6.31-rc series.
Further it adds a dummy loopback SPI chip that can be used
for testing the SPI functionality on a running system using
the loopback mode of PL022.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
----
This requires the previously posted padmux enhancements to
be applied first.
---
 arch/arm/mach-u300/Kconfig        |   12 ++
 arch/arm/mach-u300/Makefile       |    2 +
 arch/arm/mach-u300/core.c         |    6 +
 arch/arm/mach-u300/dummyspichip.c |  290 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-u300/spi.c          |  124 ++++++++++++++++
 arch/arm/mach-u300/spi.h          |   26 ++++
 6 files changed, 460 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-u300/dummyspichip.c
 create mode 100644 arch/arm/mach-u300/spi.c
 create mode 100644 arch/arm/mach-u300/spi.h

diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index 337b9aa..801b21e 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -81,6 +81,18 @@ config MACH_U300_SEMI_IS_SHARED
 		Memory Interface) from both from access and application
 		side.
 
+config MACH_U300_SPIDUMMY
+	bool "SSP/SPI dummy chip"
+	select SPI
+	select SPI_MASTER
+	select SPI_PL022
+	help
+		This creates a small kernel module that creates a dummy
+		SPI device to be used for loopback tests. Regularly used
+		to test reference designs. If you're not testing SPI,
+		you don't need it. Selecting this will activate the
+		SPI framework and ARM PL022 support.
+
 comment "All the settings below must match the bootloader's settings"
 
 config MACH_U300_ACCESS_MEM_SIZE
diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index 24950e0..4941f89 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -9,3 +9,5 @@ obj-		:=
 
 obj-$(CONFIG_ARCH_U300)	          += u300.o
 obj-$(CONFIG_MMC)                 += mmc.o
+obj-$(CONFIG_SPI_PL022)           += spi.o
+obj-$(CONFIG_MACH_U300_SPIDUMMY)  += dummyspichip.o
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 2e9b8cc..8019aa6 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -32,6 +32,7 @@
 
 #include "clock.h"
 #include "mmc.h"
+#include "spi.h"
 
 /*
  * Static I/O mappings that are needed for booting the U300 platforms. The
@@ -611,6 +612,8 @@ void __init u300_init_devices(void)
 	/* Wait for the PLL208 to lock if not locked in yet */
 	while (!(readw(U300_SYSCON_VBASE + U300_SYSCON_CSR) &
 		 U300_SYSCON_CSR_PLL208_LOCK_IND));
+	/* Initialize SPI device with some board specifics */
+	u300_spi_init(&pl022_device);
 
 	/* Register the AMBA devices in the AMBA bus abstraction layer */
 	u300_clock_primecells();
@@ -622,6 +625,9 @@ void __init u300_init_devices(void)
 
 	u300_assign_physmem();
 
+	/* Register subdevices on the SPI bus */
+	u300_spi_register_board_devices();
+
 	/* Register the platform devices */
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
new file mode 100644
index 0000000..962f9de
--- /dev/null
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -0,0 +1,290 @@
+/*
+ * arch/arm/mach-u300/dummyspichip.c
+ *
+ * Copyright (C) 2007-2009 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ * This is a dummy loopback SPI "chip" used for testing SPI.
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/sysfs.h>
+#include <linux/mutex.h>
+#include <linux/spi/spi.h>
+#include <linux/dma-mapping.h>
+/*
+ * WARNING! Do not include this pl022-specific controller header
+ * for any generic driver. It is only done in this dummy chip
+ * because we alter the chip configuration in order to test some
+ * different settings on the loopback device. Normal chip configs
+ * shall be STATIC and not altered by the driver!
+ */
+#include <linux/amba/pl022.h>
+
+struct dummy {
+	struct device *dev;
+	struct mutex lock;
+};
+
+#define DMA_TEST_SIZE 2048
+
+/* When we cat /sys/bus/spi/devices/spi0.0/looptest this will be triggered */
+static ssize_t dummy_looptest(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct dummy *p_dummy = dev_get_drvdata(&spi->dev);
+
+	/*
+	 * WARNING! Do not dereference the chip-specific data in any normal
+	 * driver for a chip. It is usually STATIC and shall not be read
+	 * or written to. Your chip driver should NOT depend on fields in this
+	 * struct, this is just used here to alter the behaviour of the chip
+	 * in order to perform tests.
+	 */
+	struct pl022_config_chip *chip_info = spi->controller_data;
+	int status;
+	u8 txbuf[14] = {0xDE, 0xAD, 0xBE, 0xEF, 0x2B, 0xAD,
+			0xCA, 0xFE, 0xBA, 0xBE, 0xB1, 0x05,
+			0xF0, 0x0D};
+	u8 rxbuf[14];
+	u8 *bigtxbuf_virtual;
+	u8 *bigrxbuf_virtual;
+
+	if (mutex_lock_interruptible(&p_dummy->lock))
+		return -ERESTARTSYS;
+
+	bigtxbuf_virtual = kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
+	if (bigtxbuf_virtual == NULL) {
+		status = -ENOMEM;
+		goto out;
+	}
+	bigrxbuf_virtual = kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
+
+	/* Fill TXBUF with some happy pattern */
+	memset(bigtxbuf_virtual, 0xAA, DMA_TEST_SIZE);
+
+	/*
+	 * Force chip to 8 bit mode
+	 * WARNING: NEVER DO THIS IN REAL DRIVER CODE, THIS SHOULD BE STATIC!
+	 */
+	chip_info->data_size = SSP_DATA_BITS_8;
+	/* You should NOT DO THIS EITHER */
+	spi->master->setup(spi);
+
+	/* Now run the tests for 8bit mode */
+	pr_info("Simple test 1: write 0xAA byte, read back garbage byte "
+		"in 8bit mode\n");
+	status = spi_w8r8(spi, 0xAA);
+	if (status < 0)
+		pr_warning("Siple test 1: FAILURE: spi_write_then_read "
+			   "failed with status %d\n", status);
+	else
+		pr_info("Simple test 1: SUCCESS!\n");
+
+	pr_info("Simple test 2: write 8 bytes, read back 8 bytes garbage "
+		"in 8bit mode (full FIFO)\n");
+	status = spi_write_then_read(spi, &txbuf[0], 8, &rxbuf[0], 8);
+	if (status < 0)
+		pr_warning("Simple test 2: FAILURE: spi_write_then_read() "
+			   "failed with status %d\n", status);
+	else
+		pr_info("Simple test 2: SUCCESS!\n");
+
+	pr_info("Simple test 3: write 14 bytes, read back 14 bytes garbage "
+		"in 8bit mode (see if we overflow FIFO)\n");
+	status = spi_write_then_read(spi, &txbuf[0], 14, &rxbuf[0], 14);
+	if (status < 0)
+		pr_warning("Simple test 3: FAILURE: failed with status %d "
+			   "(probably FIFO overrun)\n", status);
+	else
+		pr_info("Simple test 3: SUCCESS!\n");
+
+	pr_info("Simple test 4: write 8 bytes with spi_write(), read 8 "
+		"bytes garbage with spi_read() in 8bit mode\n");
+	status = spi_write(spi, &txbuf[0], 8);
+	if (status < 0)
+		pr_warning("Simple test 4 step 1: FAILURE: spi_write() "
+			   "failed with status %d\n", status);
+	else
+		pr_info("Simple test 4 step 1: SUCCESS!\n");
+	status = spi_read(spi, &rxbuf[0], 8);
+	if (status < 0)
+		pr_warning("Simple test 4 step 2: FAILURE: spi_read() "
+			   "failed with status %d\n", status);
+	else
+		pr_info("Simple test 4 step 2: SUCCESS!\n");
+
+	pr_info("Simple test 5: write 14 bytes with spi_write(), read "
+		"14 bytes garbage with spi_read() in 8bit mode\n");
+	status = spi_write(spi, &txbuf[0], 14);
+	if (status < 0)
+		pr_warning("Simple test 5 step 1: FAILURE: spi_write() "
+			   "failed with status %d (probably FIFO overrun)\n",
+			   status);
+	else
+		pr_info("Simple test 5 step 1: SUCCESS!\n");
+	status = spi_read(spi, &rxbuf[0], 14);
+	if (status < 0)
+		pr_warning("Simple test 5 step 2: FAILURE: spi_read() "
+			   "failed with status %d (probably FIFO overrun)\n",
+			   status);
+	else
+		pr_info("Simple test 5: SUCCESS!\n");
+
+	pr_info("Simple test 6: write %d bytes with spi_write(), "
+		"read %d bytes garbage with spi_read() in 8bit mode\n",
+		DMA_TEST_SIZE, DMA_TEST_SIZE);
+	status = spi_write(spi, &bigtxbuf_virtual[0], DMA_TEST_SIZE);
+	if (status < 0)
+		pr_warning("Simple test 6 step 1: FAILURE: spi_write() "
+			   "failed with status %d (probably FIFO overrun)\n",
+			   status);
+	else
+		pr_info("Simple test 6 step 1: SUCCESS!\n");
+	status = spi_read(spi, &bigrxbuf_virtual[0], DMA_TEST_SIZE);
+	if (status < 0)
+		pr_warning("Simple test 6 step 2: FAILURE: spi_read() "
+			   "failed with status %d (probably FIFO overrun)\n",
+			   status);
+	else
+		pr_info("Simple test 6: SUCCESS!\n");
+
+
+	/*
+	 * Force chip to 16 bit mode
+	 * WARNING: NEVER DO THIS IN REAL DRIVER CODE, THIS SHOULD BE STATIC!
+	 */
+	chip_info->data_size = SSP_DATA_BITS_16;
+	/* You should NOT DO THIS EITHER */
+	spi->master->setup(spi);
+
+	pr_info("Simple test 7: write 0xAA byte, read back garbage byte "
+		"in 16bit bus mode\n");
+	status = spi_w8r8(spi, 0xAA);
+	if (status == -EIO)
+		pr_info("Simple test 7: SUCCESS! (expected failure with "
+			"status EIO)\n");
+	else if (status < 0)
+		pr_warning("Siple test 7: FAILURE: spi_write_then_read "
+			   "failed with status %d\n", status);
+	else
+		pr_warning("Siple test 7: FAILURE: spi_write_then_read "
+			   "succeeded but it was expected to fail!\n");
+
+	pr_info("Simple test 8: write 8 bytes, read back 8 bytes garbage "
+		"in 16bit mode (full FIFO)\n");
+	status = spi_write_then_read(spi, &txbuf[0], 8, &rxbuf[0], 8);
+	if (status < 0)
+		pr_warning("Simple test 8: FAILURE: spi_write_then_read() "
+			   "failed with status %d\n", status);
+	else
+		pr_info("Simple test 8: SUCCESS!\n");
+
+	pr_info("Simple test 9: write 14 bytes, read back 14 bytes garbage "
+		"in 16bit mode (see if we overflow FIFO)\n");
+	status = spi_write_then_read(spi, &txbuf[0], 14, &rxbuf[0], 14);
+	if (status < 0)
+		pr_warning("Simple test 9: FAILURE: failed with status %d "
+			   "(probably FIFO overrun)\n", status);
+	else
+		pr_info("Simple test 9: SUCCESS!\n");
+
+	pr_info("Simple test 10: write %d bytes with spi_write(), "
+	       "read %d bytes garbage with spi_read() in 16bit mode\n",
+	       DMA_TEST_SIZE, DMA_TEST_SIZE);
+	status = spi_write(spi, &bigtxbuf_virtual[0], DMA_TEST_SIZE);
+	if (status < 0)
+		pr_warning("Simple test 10 step 1: FAILURE: spi_write() "
+			   "failed with status %d (probably FIFO overrun)\n",
+			   status);
+	else
+		pr_info("Simple test 10 step 1: SUCCESS!\n");
+
+	status = spi_read(spi, &bigrxbuf_virtual[0], DMA_TEST_SIZE);
+	if (status < 0)
+		pr_warning("Simple test 10 step 2: FAILURE: spi_read() "
+			   "failed with status %d (probably FIFO overrun)\n",
+			   status);
+	else
+		pr_info("Simple test 10: SUCCESS!\n");
+
+	status = sprintf(buf, "loop test complete\n");
+	kfree(bigrxbuf_virtual);
+	kfree(bigtxbuf_virtual);
+ out:
+	mutex_unlock(&p_dummy->lock);
+	return status;
+}
+
+static DEVICE_ATTR(looptest, S_IRUGO, dummy_looptest, NULL);
+
+static int __devinit pl022_dummy_probe(struct spi_device *spi)
+{
+	struct dummy *p_dummy;
+	int status;
+
+	dev_info(&spi->dev, "probing dummy SPI device\n");
+
+	p_dummy = kzalloc(sizeof *p_dummy, GFP_KERNEL);
+	if (!p_dummy)
+		return -ENOMEM;
+
+	dev_set_drvdata(&spi->dev, p_dummy);
+	mutex_init(&p_dummy->lock);
+
+	/* sysfs hook */
+	status = device_create_file(&spi->dev, &dev_attr_looptest);
+	if (status) {
+		dev_dbg(&spi->dev, "device_create_file looptest failure.\n");
+		goto out_dev_create_looptest_failed;
+	}
+
+	return 0;
+
+out_dev_create_looptest_failed:
+	dev_set_drvdata(&spi->dev, NULL);
+	kfree(p_dummy);
+	return status;
+}
+
+static int __devexit pl022_dummy_remove(struct spi_device *spi)
+{
+	struct dummy *p_dummy = dev_get_drvdata(&spi->dev);
+
+	dev_info(&spi->dev, "removing dummy SPI device\n");
+	device_remove_file(&spi->dev, &dev_attr_looptest);
+	dev_set_drvdata(&spi->dev, NULL);
+	kfree(p_dummy);
+
+	return 0;
+}
+
+static struct spi_driver pl022_dummy_driver = {
+	.driver = {
+		.name	= "spi-dummy",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= pl022_dummy_probe,
+	.remove	= __devexit_p(pl022_dummy_remove),
+};
+
+static int __init pl022_init_dummy(void)
+{
+	return spi_register_driver(&pl022_dummy_driver);
+}
+
+static void __exit pl022_exit_dummy(void)
+{
+	spi_unregister_driver(&pl022_dummy_driver);
+}
+
+module_init(pl022_init_dummy);
+module_exit(pl022_exit_dummy);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij@stericsson.com>");
+MODULE_DESCRIPTION("PL022 SSP/SPI DUMMY Linux driver");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/mach-u300/spi.c b/arch/arm/mach-u300/spi.c
new file mode 100644
index 0000000..307d007
--- /dev/null
+++ b/arch/arm/mach-u300/spi.c
@@ -0,0 +1,124 @@
+/*
+ * arch/arm/mach-u300/spi.c
+ *
+ * Copyright (C) 2009 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ *
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ */
+#include <linux/device.h>
+#include <linux/amba/bus.h>
+#include <linux/spi/spi.h>
+#include <linux/amba/pl022.h>
+#include <linux/err.h>
+#include "padmux.h"
+
+/*
+ * The following is for the actual devices on the SSP/SPI bus
+ */
+#ifdef CONFIG_MACH_U300_SPIDUMMY
+static void select_dummy_chip(u32 chipselect)
+{
+	pr_debug("CORE: %s called with CS=0x%x (%s)\n",
+		 __func__,
+		 chipselect,
+		 chipselect ? "unselect chip" : "select chip");
+	/*
+	 * Here you would write the chip select value to the GPIO pins if
+	 * this was a real chip (but this is a loopback dummy).
+	 */
+}
+
+struct pl022_config_chip dummy_chip_info = {
+	/* Nominally this is LOOPBACK_DISABLED, but this is our dummy chip! */
+	.lbm = LOOPBACK_ENABLED,
+	/*
+	 * available POLLING_TRANSFER and INTERRUPT_TRANSFER,
+	 * DMA_TRANSFER does not work
+	 */
+	.com_mode = INTERRUPT_TRANSFER,
+	.iface = SSP_INTERFACE_MOTOROLA_SPI,
+	/* We can only act as master but SSP_SLAVE is possible in theory */
+	.hierarchy = SSP_MASTER,
+	/* 0 = drive TX even as slave, 1 = do not drive TX as slave */
+	.slave_tx_disable = 0,
+	/* LSB first */
+	.endian_tx = SSP_TX_LSB,
+	.endian_rx = SSP_RX_LSB,
+	.data_size = SSP_DATA_BITS_8, /* used to be 12 in some default */
+	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
+	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
+	.clk_phase = SSP_CLK_FALLING_EDGE,
+	.clk_pol = SSP_CLK_POL_IDLE_LOW,
+	.ctrl_len = SSP_BITS_12,
+	.wait_state = SSP_MWIRE_WAIT_ZERO,
+	.duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
+	/*
+	 * This is where you insert a call to a function to enable CS
+	 * (usually GPIO) for a certain chip.
+	 */
+	.cs_control = select_dummy_chip,
+};
+#endif
+
+static struct spi_board_info u300_spi_devices[] = {
+#ifdef CONFIG_MACH_U300_SPIDUMMY
+	{
+		/* A dummy chip used for loopback tests */
+		.modalias       = "spi-dummy",
+		/* Really dummy, pass in additional chip config here */
+		.platform_data  = NULL,
+		/* This defines how the controller shall handle the device */
+		.controller_data = &dummy_chip_info,
+		/* .irq - no external IRQ routed from this device */
+		.max_speed_hz   = 1000000,
+		.bus_num        = 0, /* Only one bus on this chip */
+		.chip_select    = 0,
+		/* Means SPI_CS_HIGH, change if e.g low CS */
+		.mode           = 0,
+	},
+#endif
+};
+
+static struct pl022_ssp_controller ssp_platform_data = {
+	/* If you have several SPI buses this varies, we have only bus 0 */
+	.bus_id = 0,
+	/* Set this to 1 when we think we got DMA working */
+	.enable_dma = 0,
+	/*
+	 * On the APP CPU GPIO 4, 5 and 6 are connected as generic
+	 * chip selects for SPI. (Same on U330, U335 and U365.)
+	 * TODO: make sure the GPIO driver can select these properly
+	 * and do padmuxing accordingly too.
+	 */
+	.num_chipselect = 3,
+};
+
+
+void __init u300_spi_init(struct amba_device *adev)
+{
+	struct pmx *pmx;
+
+	adev->dev.platform_data = &ssp_platform_data;
+	/*
+	 * Setup padmuxing for SPI. Since this must always be
+	 * compiled into the kernel, pmx is never released.
+	 */
+	pmx = pmx_get(&adev->dev, U300_APP_PMX_SPI_SETTING);
+
+	if (IS_ERR(pmx))
+		dev_warn(&adev->dev, "Could not get padmux handle\n");
+	else {
+		int ret;
+
+		ret = pmx_activate(&adev->dev, pmx);
+		if (IS_ERR_VALUE(ret))
+			dev_warn(&adev->dev, "Could not activate padmuxing\n");
+	}
+
+}
+void __init u300_spi_register_board_devices(void)
+{
+	/* Register any SPI devices */
+	spi_register_board_info(u300_spi_devices, ARRAY_SIZE(u300_spi_devices));
+}
diff --git a/arch/arm/mach-u300/spi.h b/arch/arm/mach-u300/spi.h
new file mode 100644
index 0000000..bd3d867
--- /dev/null
+++ b/arch/arm/mach-u300/spi.h
@@ -0,0 +1,26 @@
+/*
+ * arch/arm/mach-u300/spi.h
+ *
+ * Copyright (C) 2009 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ *
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ */
+#ifndef SPI_H
+#define SPI_H
+#include <linux/amba/bus.h>
+
+#ifdef CONFIG_SPI_PL022
+void __init u300_spi_init(struct amba_device *adev);
+void __init u300_spi_register_board_devices(void);
+#else
+/* Compile out SPI support if PL022 is not selected */
+static inline void __init u300_spi_init(struct amba_device *adev)
+{
+}
+static inline void __init u300_spi_register_board_devices(void)
+{
+}
+#endif
+
+#endif
-- 
1.6.2.1
