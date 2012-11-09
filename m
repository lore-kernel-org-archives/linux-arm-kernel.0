From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri,  9 Nov 2012 15:00:21 +0100
Subject: [PATCH 2/6] spi/devicetree: find spi_device via device_node
In-Reply-To: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1352469625-32024-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to find a spi_device via DT device_node.
The patch is based on the way i2c does it.

This is intended for devices that depend on multiple subsystems and are therefore
not a child of the spi-master node (e.g. sound devices that are controlled via spi
and get their data via another bus). The driver instead can find the desired device
via scanning the spi bus.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/spi/spi.c       |   20 ++++++++++++++++++++
 include/linux/spi/spi.h |    3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 84c2861..e25487f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -801,6 +801,26 @@ err_init_queue:
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_OF) && !defined(CONFIG_SPARC)
+
+static int of_dev_node_match(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+/* must call spi_dev_put() when done with returned spi_device device */
+struct spi_device *of_find_spi_device_by_node(struct device_node *node)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&spi_bus_type, NULL, node, of_dev_node_match);
+
+	if (!dev)
+		return NULL;
+
+	return to_spi_device(dev);
+}
+EXPORT_SYMBOL_GPL(of_find_spi_device_by_node);
+
 /**
  * of_register_spi_devices() - Register child devices onto the SPI bus
  * @master:	Pointer to spi_master device
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fa702ae..db3a630 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -23,6 +23,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
+#include <linux/of.h>
 
 /*
  * INTERFACES between SPI master-side drivers and SPI infrastructure.
@@ -387,6 +388,8 @@ static inline void spi_master_put(struct spi_master *master)
 		put_device(&master->dev);
 }
 
+extern struct spi_device *of_find_spi_device_by_node(struct device_node *node);
+
 /* PM calls that need to be issued by the driver */
 extern int spi_master_suspend(struct spi_master *master);
 extern int spi_master_resume(struct spi_master *master);
-- 
1.7.10.4
