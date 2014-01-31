From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jan 2014 11:23:10 +0100
Subject: [PATCH 1/3] spi: core: Add devm_spi_alloc_master
In-Reply-To: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391163792-21819-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using devm_spi_register_master leads to a memory leak on the spi_master
structure.

spi_alloc_master uses kzalloc to allocate the spi_master but the introduction
of devm_spi_register_master removed all the matching calls to spi_master_put,
leaking the spi_master structure.

Add a devm_spi_alloc_master to provide the intended behaviour.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/spi/spi.c       | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 63613a9..eb728ec 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1266,6 +1266,42 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 }
 EXPORT_SYMBOL_GPL(spi_alloc_master);
 
+static void devm_spi_put(struct device *dev, void *res)
+{
+	spi_master_put(*(struct spi_master **)res);
+}
+
+/**
+ * devm_spi_alloc_master - allocate SPI master controller
+ * @dev: the controller, possibly using the platform_bus
+ * @size: how much zeroed driver-private data to allocate; the pointer to this
+ *	memory is in the driver_data field of the returned device,
+ *	accessible with spi_master_get_devdata().
+ * Context: can sleep
+ *
+ * Allocates a master controller as with spi_alloc_master() which will
+ * automatically be freed
+ */
+struct spi_master *devm_spi_alloc_master(struct device *dev, unsigned size)
+{
+	struct spi_master **ptr, *master;
+
+	ptr = devres_alloc(devm_spi_put, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	master = spi_alloc_master(dev, size);
+	if (master) {
+		*ptr = master;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return master;
+}
+EXPORT_SYMBOL_GPL(devm_spi_alloc_master);
+
 #ifdef CONFIG_OF
 static int of_spi_register_master(struct spi_master *master)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a1d4ca2..6fbdb2b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -462,6 +462,8 @@ extern void spi_finalize_current_transfer(struct spi_master *master);
 /* the spi driver core manages memory for the spi_master classdev */
 extern struct spi_master *
 spi_alloc_master(struct device *host, unsigned size);
+extern struct spi_master *
+devm_spi_alloc_master(struct device *host, unsigned size);
 
 extern int spi_register_master(struct spi_master *master);
 extern int devm_spi_register_master(struct device *dev,
-- 
1.8.4.2
