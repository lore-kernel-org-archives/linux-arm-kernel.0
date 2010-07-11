From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 11 Jul 2010 02:43:25 +0200
Subject: [PATCH 2/2] SPI: make the moved loopback test work
Message-ID: <1278809005-29948-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This completes the move of the SPI test chip out of the U300
architecture by modifying the loopback test to register itself on
every PL022 master if it is compiled in. Also updates some minor
things like naming to make the code stricter.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/Kconfig        |   12 ----
 arch/arm/mach-u300/Makefile       |    1 -
 arch/arm/mach-u300/spi.c          |   61 -------------------
 drivers/spi/Kconfig               |   13 ++++
 drivers/spi/Makefile              |    1 +
 drivers/spi/amba-pl022-looptest.c |  120 +++++++++++++++++++++++++++++-------
 drivers/spi/amba-pl022-looptest.h |   11 ++++
 drivers/spi/amba-pl022.c          |    6 ++
 8 files changed, 127 insertions(+), 98 deletions(-)
 create mode 100644 drivers/spi/amba-pl022-looptest.h

diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index 801b21e..337b9aa 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -81,18 +81,6 @@ config MACH_U300_SEMI_IS_SHARED
 		Memory Interface) from both from access and application
 		side.
 
-config MACH_U300_SPIDUMMY
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
 comment "All the settings below must match the bootloader's settings"
 
 config MACH_U300_ACCESS_MEM_SIZE
diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index fab46fe..1f0f4b8 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -10,6 +10,5 @@ obj-		:=
 obj-$(CONFIG_ARCH_U300)	          += u300.o
 obj-$(CONFIG_MMC)                 += mmc.o
 obj-$(CONFIG_SPI_PL022)           += spi.o
-obj-$(CONFIG_MACH_U300_SPIDUMMY)  += dummyspichip.o
 obj-$(CONFIG_I2C_STU300)          += i2c.o
 obj-$(CONFIG_REGULATOR_AB3100)    += regulator.o
diff --git a/arch/arm/mach-u300/spi.c b/arch/arm/mach-u300/spi.c
index f0e887b..0790cce 100644
--- a/arch/arm/mach-u300/spi.c
+++ b/arch/arm/mach-u300/spi.c
@@ -16,68 +16,8 @@
 /*
  * The following is for the actual devices on the SSP/SPI bus
  */
-#ifdef CONFIG_MACH_U300_SPIDUMMY
-static void select_dummy_chip(u32 chipselect)
-{
-	pr_debug("CORE: %s called with CS=0x%x (%s)\n",
-		 __func__,
-		 chipselect,
-		 chipselect ? "unselect chip" : "select chip");
-	/*
-	 * Here you would write the chip select value to the GPIO pins if
-	 * this was a real chip (but this is a loopback dummy).
-	 */
-}
-
-struct pl022_config_chip dummy_chip_info = {
-	/* Nominally this is LOOPBACK_DISABLED, but this is our dummy chip! */
-	.lbm = LOOPBACK_ENABLED,
-	/*
-	 * available POLLING_TRANSFER and INTERRUPT_TRANSFER,
-	 * DMA_TRANSFER does not work
-	 */
-	.com_mode = INTERRUPT_TRANSFER,
-	.iface = SSP_INTERFACE_MOTOROLA_SPI,
-	/* We can only act as master but SSP_SLAVE is possible in theory */
-	.hierarchy = SSP_MASTER,
-	/* 0 = drive TX even as slave, 1 = do not drive TX as slave */
-	.slave_tx_disable = 0,
-	/* LSB first */
-	.endian_tx = SSP_TX_LSB,
-	.endian_rx = SSP_RX_LSB,
-	.data_size = SSP_DATA_BITS_8, /* used to be 12 in some default */
-	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
-	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
-	.clk_phase = SSP_CLK_SECOND_EDGE,
-	.clk_pol = SSP_CLK_POL_IDLE_LOW,
-	.ctrl_len = SSP_BITS_12,
-	.wait_state = SSP_MWIRE_WAIT_ZERO,
-	.duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
-	/*
-	 * This is where you insert a call to a function to enable CS
-	 * (usually GPIO) for a certain chip.
-	 */
-	.cs_control = select_dummy_chip,
-};
-#endif
 
 static struct spi_board_info u300_spi_devices[] = {
-#ifdef CONFIG_MACH_U300_SPIDUMMY
-	{
-		/* A dummy chip used for loopback tests */
-		.modalias       = "spi-dummy",
-		/* Really dummy, pass in additional chip config here */
-		.platform_data  = NULL,
-		/* This defines how the controller shall handle the device */
-		.controller_data = &dummy_chip_info,
-		/* .irq - no external IRQ routed from this device */
-		.max_speed_hz   = 1000000,
-		.bus_num        = 0, /* Only one bus on this chip */
-		.chip_select    = 0,
-		/* Means SPI_CS_HIGH, change if e.g low CS */
-		.mode           = 0,
-	},
-#endif
 };
 
 static struct pl022_ssp_controller ssp_platform_data = {
@@ -94,7 +34,6 @@ static struct pl022_ssp_controller ssp_platform_data = {
 	.num_chipselect = 3,
 };
 
-
 void __init u300_spi_init(struct amba_device *adev)
 {
 	struct pmx *pmx;
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 91c2f4f..9e584dc 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -227,6 +227,19 @@ config SPI_PL022
 	  controller. If you have an embedded system with an AMBA(R)
 	  bus and a PL022 controller, say Y or M here.
 
+config SPI_PL022_LOOPTEST
+	bool "PL022 loopback chip"
+	depends on SPI_PL022
+	help
+	  The PL022 supports a loopback mode where the output is
+	  looped back to the input for testing.
+
+	  This creates a small kernel module that creates a dummy
+	  SPI device on each PL022 SPI bus to be used for loopback
+	  tests. You find the device in the /sys filesystem, e.g.
+	  /sys/bus/spi/devices/spi0.0/looptest and the test is run by
+	  issuing cat <looptest>.
+
 config SPI_PPC4xx
 	tristate "PPC4xx SPI Controller"
 	depends on PPC32 && 4xx && SPI_MASTER
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index e9cbd18..9ac8e95 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_SPI_OMAP24XX)		+= omap2_mcspi.o
 obj-$(CONFIG_SPI_OMAP_100K)		+= omap_spi_100k.o
 obj-$(CONFIG_SPI_ORION)			+= orion_spi.o
 obj-$(CONFIG_SPI_PL022)			+= amba-pl022.o
+obj-$(CONFIG_SPI_PL022_LOOPTEST)	+= amba-pl022-looptest.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= mpc512x_psc_spi.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= mpc52xx_psc_spi.o
 obj-$(CONFIG_SPI_MPC52xx)		+= mpc52xx_spi.o
diff --git a/drivers/spi/amba-pl022-looptest.c b/drivers/spi/amba-pl022-looptest.c
index 5f55012..561886a 100644
--- a/drivers/spi/amba-pl022-looptest.c
+++ b/drivers/spi/amba-pl022-looptest.c
@@ -1,7 +1,5 @@
 /*
- * arch/arm/mach-u300/dummyspichip.c
- *
- * Copyright (C) 2007-2009 ST-Ericsson AB
+ * Copyright (C) 2007-2010 ST-Ericsson SA
  * License terms: GNU General Public License (GPL) version 2
  * This is a dummy loopback SPI "chip" used for testing SPI.
  * Author: Linus Walleij <linus.walleij@stericsson.com>
@@ -25,19 +23,93 @@
  */
 #include <linux/amba/pl022.h>
 
-struct dummy {
+struct pl022_loopback {
 	struct device *dev;
 	struct mutex lock;
 };
 
 #define DMA_TEST_SIZE 2048
 
-/* When we cat /sys/bus/spi/devices/spi0.0/looptest this will be triggered */
-static ssize_t dummy_looptest(struct device *dev,
+/*
+ * The following code self-registers the PL022 loopback
+ * chip on each PL022 SPI bus.
+ */
+
+static void pl022_select_loopback_chip(u32 chipselect)
+{
+	pr_debug("PL022 loopback chip: %s called with CS=0x%x (%s)\n",
+		 __func__,
+		 chipselect,
+		 chipselect ? "unselect chip" : "select chip");
+	/*
+	 * Here you would write the chip select value to the GPIO pins if
+	 * this was a real chip (but this is a loopback dummy).
+	 */
+}
+
+struct pl022_config_chip pl022_loopback_chip_info = {
+	/* Nominally this is LOOPBACK_DISABLED, but this is our dummy chip! */
+	.lbm = LOOPBACK_ENABLED,
+	.com_mode = INTERRUPT_TRANSFER,
+	.iface = SSP_INTERFACE_MOTOROLA_SPI,
+	.hierarchy = SSP_MASTER,
+	.slave_tx_disable = 0,
+	/* LSB first */
+	.endian_tx = SSP_TX_LSB,
+	.endian_rx = SSP_RX_LSB,
+	.data_size = SSP_DATA_BITS_8,
+	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
+	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
+	.clk_phase = SSP_CLK_SECOND_EDGE,
+	.clk_pol = SSP_CLK_POL_IDLE_LOW,
+	.ctrl_len = SSP_BITS_12,
+	.wait_state = SSP_MWIRE_WAIT_ZERO,
+	.duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
+	.cs_control = pl022_select_loopback_chip,
+};
+
+static struct spi_board_info pl022_loopback_device = {
+	/* A dummy chip used for loopback tests */
+	.modalias       = "pl022-loop",
+	/* Really dummy, pass in additional chip config here */
+	.platform_data  = NULL,
+	/* This defines how the controller shall handle the device */
+	.controller_data = &pl022_loopback_chip_info,
+	/* .irq - no external IRQ routed from this device */
+	.max_speed_hz   = 1000000,
+	.bus_num        = 0, /* Only one bus on this chip */
+	.chip_select    = 0,
+	/* Means SPI_CS_HIGH, change if e.g low CS */
+	.mode           = 0,
+};
+
+/*
+ * This is called from the PL022 driver to register a loopback
+ * on itself if this module is compiled in.
+ */
+void pl022_loopback_register(struct spi_master *master)
+{
+	struct spi_device *spidev;
+
+	spidev = spi_new_device(master, &pl022_loopback_device);
+	if (!spidev)
+		dev_err(&master->dev,
+			"could not register loopback test chip\n");
+	else
+		dev_err(&master->dev,
+			"registered loopback test chip\n");
+}
+
+/*
+ * This is where the tests begin. When we issue:
+ * cat /sys/bus/spi/devices/spi0.0/looptest
+ * this will be triggered.
+ */
+static ssize_t pl022_looptest(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	struct dummy *p_dummy = dev_get_drvdata(&spi->dev);
+	struct pl022_loopback *p_loop = dev_get_drvdata(&spi->dev);
 
 	/*
 	 * WARNING! Do not dereference the chip-specific data in any normal
@@ -55,7 +127,7 @@ static ssize_t dummy_looptest(struct device *dev,
 	u8 *bigtxbuf_virtual;
 	u8 *bigrxbuf_virtual;
 
-	if (mutex_lock_interruptible(&p_dummy->lock))
+	if (mutex_lock_interruptible(&p_loop->lock))
 		return -ERESTARTSYS;
 
 	bigtxbuf_virtual = kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
@@ -217,25 +289,25 @@ static ssize_t dummy_looptest(struct device *dev,
 	kfree(bigrxbuf_virtual);
 	kfree(bigtxbuf_virtual);
  out:
-	mutex_unlock(&p_dummy->lock);
+	mutex_unlock(&p_loop->lock);
 	return status;
 }
 
-static DEVICE_ATTR(looptest, S_IRUGO, dummy_looptest, NULL);
+static DEVICE_ATTR(looptest, S_IRUGO, pl022_looptest, NULL);
 
-static int __devinit pl022_dummy_probe(struct spi_device *spi)
+static int __devinit pl022_loopback_probe(struct spi_device *spi)
 {
-	struct dummy *p_dummy;
+	struct pl022_loopback *p_loop;
 	int status;
 
 	dev_info(&spi->dev, "probing dummy SPI device\n");
 
-	p_dummy = kzalloc(sizeof *p_dummy, GFP_KERNEL);
-	if (!p_dummy)
+	p_loop = kzalloc(sizeof *p_loop, GFP_KERNEL);
+	if (!p_loop)
 		return -ENOMEM;
 
-	dev_set_drvdata(&spi->dev, p_dummy);
-	mutex_init(&p_dummy->lock);
+	dev_set_drvdata(&spi->dev, p_loop);
+	mutex_init(&p_loop->lock);
 
 	/* sysfs hook */
 	status = device_create_file(&spi->dev, &dev_attr_looptest);
@@ -248,29 +320,29 @@ static int __devinit pl022_dummy_probe(struct spi_device *spi)
 
 out_dev_create_looptest_failed:
 	dev_set_drvdata(&spi->dev, NULL);
-	kfree(p_dummy);
+	kfree(p_loop);
 	return status;
 }
 
-static int __devexit pl022_dummy_remove(struct spi_device *spi)
+static int __devexit pl022_loopback_remove(struct spi_device *spi)
 {
-	struct dummy *p_dummy = dev_get_drvdata(&spi->dev);
+	struct pl022_loopback *p_loop = dev_get_drvdata(&spi->dev);
 
 	dev_info(&spi->dev, "removing dummy SPI device\n");
 	device_remove_file(&spi->dev, &dev_attr_looptest);
 	dev_set_drvdata(&spi->dev, NULL);
-	kfree(p_dummy);
+	kfree(p_loop);
 
 	return 0;
 }
 
 static struct spi_driver pl022_dummy_driver = {
 	.driver = {
-		.name	= "spi-dummy",
+		.name	= "pl022-loop",
 		.owner	= THIS_MODULE,
 	},
-	.probe	= pl022_dummy_probe,
-	.remove	= __devexit_p(pl022_dummy_remove),
+	.probe	= pl022_loopback_probe,
+	.remove	= __devexit_p(pl022_loopback_remove),
 };
 
 static int __init pl022_init_dummy(void)
@@ -287,5 +359,5 @@ module_init(pl022_init_dummy);
 module_exit(pl022_exit_dummy);
 
 MODULE_AUTHOR("Linus Walleij <linus.walleij@stericsson.com>");
-MODULE_DESCRIPTION("PL022 SSP/SPI DUMMY Linux driver");
+MODULE_DESCRIPTION("PL022 loopback test driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/spi/amba-pl022-looptest.h b/drivers/spi/amba-pl022-looptest.h
new file mode 100644
index 0000000..1bedcc6
--- /dev/null
+++ b/drivers/spi/amba-pl022-looptest.h
@@ -0,0 +1,11 @@
+/*
+ * Defines a single function for the master to create a loopback
+ * on itself.
+ */
+#ifdef CONFIG_SPI_PL022_LOOPTEST
+void pl022_loopback_register(struct spi_master *master);
+#else
+static void inline pl022_loopback_register(struct spi_master *master)
+{
+}
+#endif
diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index f0a1418..6e4a657 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -46,6 +46,8 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
+#include "amba-pl022-looptest.h"
+
 /*
  * This macro is used to define some register default values.
  * reg is masked with mask, the OR:ed with an (again masked)
@@ -1818,6 +1820,10 @@ pl022_probe(struct amba_device *adev, struct amba_id *id)
 		goto err_spi_register;
 	}
 	dev_dbg(dev, "probe succeded\n");
+
+	/* Register a loopback test if desired */
+	pl022_loopback_register(master);
+
 	return 0;
 
  err_spi_register:
-- 
1.7.1
