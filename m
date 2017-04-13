From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Thu, 13 Apr 2017 05:14:00 -0700
Subject: [PATCH RFC 1/5] spi: core: add support to work in Slave mode
In-Reply-To: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <1492085644-4195-2-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

Add support for SPI bus controller to work in slave mode using
the existing SPI master framework.
- SPI device on SPI bus controller with 'spi-slave' property
  declared in DT node represents SPI controller itself to work
  as a slave device and listening to external SPI master devices
- when SPI bus controller works in slave mode, 'chip_select' and
  'max_speed_hz' are not required.
- SPI slave mode continue to use 'struct spi_master'

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 27 ++++++++++++++---------
 Documentation/spi/spi-summary                     | 19 +++++++++++-----
 drivers/spi/Kconfig                               | 14 +++++++++++-
 drivers/spi/spi.c                                 | 23 ++++++++++++++++++-
 include/linux/spi/spi.h                           | 15 +++++++++++++
 5 files changed, 80 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 4b1d6e7..96e93ba 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -1,17 +1,20 @@
 SPI (Serial Peripheral Interface) busses
 
-SPI busses can be described with a node for the SPI master device
-and a set of child nodes for each SPI slave on the bus.  For this
-discussion, it is assumed that the system's SPI controller is in
-SPI master mode.  This binding does not describe SPI controllers
-in slave mode.
+SPI busses can be described with a node for the SPI controller device
+and a set of child nodes for each SPI slave on the bus.  The system's SPI
+controller can work either in master mode or in slave mode, based on the
+child node on it.
 
-The SPI master node requires the following properties:
+The SPI controller node requires the following properties:
+- compatible      - name of SPI bus controller following generic names
+		recommended practice.
+
+In master mode, the SPI controller node requires the following additional
+properties:
 - #address-cells  - number of cells required to define a chip select
 		address on the SPI bus.
 - #size-cells     - should be zero.
-- compatible      - name of SPI bus controller following generic names
-		recommended practice.
+
 No other properties are required in the SPI bus node.  It is assumed
 that a driver for an SPI bus device will understand that it is an SPI bus.
 However, the binding does not attempt to define the specific method for
@@ -43,10 +46,11 @@ cs3 : &gpio1 2 0
 
 SPI slave nodes must be children of the SPI master node and can
 contain the following properties.
-- reg             - (required) chip select address of device.
+- reg             - (required, master mode only) chip select address of device.
 - compatible      - (required) name of SPI device following generic names
 		recommended practice.
-- spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz.
+- spi-max-frequency - (required, master mode only) Maximum SPI clocking speed of
+		device in Hz.
 - spi-cpol        - (optional) Empty property indicating device requires
 		inverse clock polarity (CPOL) mode.
 - spi-cpha        - (optional) Empty property indicating device requires
@@ -63,6 +67,9 @@ contain the following properties.
                       used for MISO. Defaults to 1 if not present.
 - spi-rx-delay-us  - (optional) Microsecond delay after a read transfer.
 - spi-tx-delay-us  - (optional) Microsecond delay after a write transfer.
+- spi-slave        - (optional) Empty property indicating SPI bus controller
+		itself works in slave mode to interface with external master
+		devices.
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index d1824b3..4c2ceaa 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -62,9 +62,8 @@ chips described as using "three wire" signaling: SCK, data, nCSx.
 (That data line is sometimes called MOMI or SISO.)
 
 Microcontrollers often support both master and slave sides of the SPI
-protocol.  This document (and Linux) currently only supports the master
-side of SPI interactions.
-
+protocol.  This document (and Linux) supports both the master and slave
+sides of SPI interactions.
 
 Who uses it?  On what kinds of systems?
 ---------------------------------------
@@ -154,9 +153,8 @@ control audio interfaces, present touchscreen sensors as input interfaces,
 or monitor temperature and voltage levels during industrial processing.
 And those might all be sharing the same controller driver.
 
-A "struct spi_device" encapsulates the master-side interface between
-those two types of driver.  At this writing, Linux has no slave side
-programming interface.
+A "struct spi_device" encapsulates the controller-side interface between
+those two types of drivers.
 
 There is a minimal core of SPI programming interfaces, focussing on
 using the driver model to connect controller and protocol drivers using
@@ -168,12 +166,21 @@ shows up in sysfs in several locations:
    /sys/devices/.../CTLR/spiB.C ... spi_device on bus "B",
 	chipselect C, accessed through CTLR.
 
+   /sys/devices/.../CTLR/spiB-slv ... SPI bus "B" controller itself as a
+	spi_device works in slave mode, accessed through CTRL.
+
    /sys/bus/spi/devices/spiB.C ... symlink to that physical
    	.../CTLR/spiB.C device
 
+   /sys/bus/spi/devices/spiB-slv ... symlink to that physical
+	.../CTLR/spiB-slv device
+
    /sys/devices/.../CTLR/spiB.C/modalias ... identifies the driver
 	that should be used with this device (for hotplug/coldplug)
 
+   /sys/devices/.../CTLR/spiB-slv/modalias ... identifies the driver
+	that should be used with this device (for hotplug/coldplug)
+
    /sys/bus/spi/drivers/D ... driver for one or more spi*.* devices
 
    /sys/class/spi_master/spiB ... symlink (or actual device node) to
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 25ae7f2e..1096c7d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -784,6 +784,18 @@ config SPI_TLE62X0
 
 endif # SPI_MASTER
 
-# (slave support would go here)
+#
+# SLAVE side ... listening to other SPI masters
+#
+
+config SPI_SLAVE
+	bool "SPI slave protocol handlers"
+	help
+	  If your system has a slave-capable SPI controller, you can enable
+	  slave protocol handlers.
+
+if SPI_SLAVE
+
+endif # SPI_SLAVE
 
 endif # SPI
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 90b5b2e..3af26e2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -475,6 +475,12 @@ static void spi_dev_set_name(struct spi_device *spi)
 		return;
 	}
 
+	if (spi->slave_mode) {
+		dev_set_name(&spi->dev, "%s-slv",
+			     dev_name(&spi->master->dev));
+		return;
+	}
+
 	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->dev),
 		     spi->chip_select);
 }
@@ -484,6 +490,9 @@ static int spi_dev_check(struct device *dev, void *data)
 	struct spi_device *spi = to_spi_device(dev);
 	struct spi_device *new_spi = data;
 
+	if (spi->slave_mode)
+		return 0;
+
 	if (spi->master == new_spi->master &&
 	    spi->chip_select == new_spi->chip_select)
 		return -EBUSY;
@@ -523,6 +532,9 @@ int spi_add_device(struct spi_device *spi)
 	 */
 	mutex_lock(&spi_add_lock);
 
+	if (spi->slave_mode)
+		goto setup_spi;
+
 	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
 	if (status) {
 		dev_err(dev, "chipselect %d already in use\n",
@@ -533,6 +545,7 @@ int spi_add_device(struct spi_device *spi)
 	if (master->cs_gpios)
 		spi->cs_gpio = master->cs_gpios[spi->chip_select];
 
+setup_spi:
 	/* Drivers may modify this initial i/o setup, but will
 	 * normally rely on the device being setup.  Devices
 	 * using SPI_CS_HIGH can't coexist well otherwise...
@@ -1511,6 +1524,14 @@ static int of_spi_parse_dt(struct spi_master *master, struct spi_device *spi,
 	u32 value;
 	int rc;
 
+	if (of_find_property(nc, "spi-slave", NULL)) {
+		if (!spi_controller_has_slavemode(master))
+			return -EINVAL;
+
+		spi->slave_mode = 1;
+		return 0;
+	}
+
 	/* Device address */
 	rc = of_property_read_u32(nc, "reg", &value);
 	if (rc) {
@@ -1961,7 +1982,7 @@ int spi_register_master(struct spi_master *master)
 	status = device_add(&master->dev);
 	if (status < 0)
 		goto done;
-	dev_dbg(dev, "registered master %s%s\n", dev_name(&master->dev),
+	dev_dbg(dev, "registered controller %s%s\n", dev_name(&master->dev),
 			dynamic ? " (dynamic)" : "");
 
 	/* If we're using a queued driver, start the queue */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 75c6bd0..bb81425 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -115,6 +115,8 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	This may be changed by the device's driver, or left at the
  *	default (0) indicating protocol words are eight bit bytes.
  *	The spi_transfer.bits_per_word can override this for each transfer.
+ * @slave_mode: indicates whether SPI controller works in master mode
+ *	or slave mode to transfer data with external spi devices.
  * @irq: Negative, or the number passed to request_irq() to receive
  *	interrupts from this device.
  * @controller_state: Controller's runtime state
@@ -144,6 +146,7 @@ struct spi_device {
 	u8			chip_select;
 	u8			bits_per_word;
 	u16			mode;
+	u8			slave_mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
 #define	SPI_MODE_0	(0|0)			/* (original MicroWire) */
@@ -372,6 +375,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *                    transfer_one callback.
  * @handle_err: the subsystem calls the driver to handle an error that occurs
  *		in the generic implementation of transfer_one_message().
+ * @has_slavemode: checks whether SPI Controller supports slave mode or not.
  * @unprepare_message: undo any work done by prepare_message().
  * @spi_flash_read: to support spi-controller hardwares that provide
  *                  accelerated interface to read from flash devices.
@@ -549,6 +553,7 @@ struct spi_master {
 			    struct spi_transfer *transfer);
 	void (*handle_err)(struct spi_master *master,
 			   struct spi_message *message);
+	bool (*has_slavemode)(struct spi_master *master);
 
 	/* gpio chip select */
 	int			*cs_gpios;
@@ -590,6 +595,16 @@ static inline void spi_master_put(struct spi_master *master)
 		put_device(&master->dev);
 }
 
+
+static inline bool spi_controller_has_slavemode(struct spi_master *master)
+{
+#ifdef CONFIG_SPI_SLAVE
+	if (master->has_slavemode)
+		return master->has_slavemode(master);
+#endif
+	return false;
+}
+
 /* PM calls that need to be issued by the driver */
 extern int spi_master_suspend(struct spi_master *master);
 extern int spi_master_resume(struct spi_master *master);
-- 
2.7.4
