From: stigge@antcom.de (Roland Stigge)
Date: Mon, 17 Sep 2012 18:59:19 +0200
Subject: [PATCH] spi/pl022: Devicetree support w/o platform data
Message-ID: <1347901159-3665-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even with devicetree support, we needed platform data to provide some data like
bus_id and enable_dma, leading to mixed device tree and platform data. This
patch makes it possible to provide all that information via device tree. Now,
the data must be provided via platform data _or_ device tree completely.

Only in case of callback specification (dma_filter()), platform data is
necessary.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 Documentation/devicetree/bindings/spi/spi_pl022.txt |    9 ++++
 drivers/spi/spi-pl022.c                             |   41 +++++++++++++++++---
 2 files changed, 45 insertions(+), 5 deletions(-)

--- linux-2.6.orig/Documentation/devicetree/bindings/spi/spi_pl022.txt
+++ linux-2.6/Documentation/devicetree/bindings/spi/spi_pl022.txt
@@ -10,6 +10,15 @@ Optional properties:
 - cs-gpios : should specify GPIOs used for chipselects.
   The gpios will be referred to as reg = <index> in the SPI child nodes.
   If unspecified, a single SPI device without a chip select can be used.
+- pl022,bus-id : Bus ID (0, 1, ...)
+- pl022,enable-dma : enables DMA driven transfers (boolean)
+- pl022,autosuspend-delay : delay in ms following transfer completion before
+			    the runtime power management system suspends the
+			    device. A setting of 0 indicates no delay and the
+                            device will be suspended immediately
+- pl022,rt : indicates the controller should run the message pump with realtime
+             priority to minimise the transfer latency on the bus (boolean)
+
 
 SPI slave nodes must be children of the SPI master node and can
 contain the following properties.
--- linux-2.6.orig/drivers/spi/spi-pl022.c
+++ linux-2.6/drivers/spi/spi-pl022.c
@@ -2024,6 +2024,36 @@ static void pl022_cleanup(struct spi_dev
 	kfree(chip);
 }
 
+static struct pl022_ssp_controller *
+pl022_platform_data_dt_get(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct pl022_ssp_controller *pd;
+	u32 tmp;
+
+	if (!np) {
+		dev_err(dev, "no dt node defined\n");
+		return NULL;
+	}
+
+	pd = devm_kzalloc(dev, sizeof(struct pl022_ssp_controller), GFP_KERNEL);
+	if (!pd) {
+		dev_err(dev, "cannot allocate platform data memory\n");
+		return NULL;
+	}
+
+	of_property_read_u32(np, "pl022,bus-id", &tmp);
+	pd->bus_id = tmp;
+	of_property_read_u32(np, "num-cs", &tmp);
+	pd->num_chipselect = tmp;
+	pd->enable_dma = of_property_read_bool(np, "pl022,enable-dma") ? 1 : 0;
+	of_property_read_u32(np, "pl022,autosuspend-delay",
+			     &pd->autosuspend_delay);
+	pd->rt = of_property_read_bool(np, "pl022,rt");
+
+	return pd;
+}
+
 static int __devinit
 pl022_probe(struct amba_device *adev, const struct amba_id *id)
 {
@@ -2036,18 +2066,19 @@ pl022_probe(struct amba_device *adev, co
 
 	dev_info(&adev->dev,
 		 "ARM PL022 driver, device ID: 0x%08x\n", adev->periphid);
-	if (platform_info == NULL) {
-		dev_err(&adev->dev, "probe - no platform data supplied\n");
+	if (!platform_info && IS_ENABLED(CONFIG_OF))
+		platform_info = pl022_platform_data_dt_get(dev);
+
+	if (!platform_info) {
+		dev_err(dev, "probe: no platform data defined\n");
 		status = -ENODEV;
 		goto err_no_pdata;
 	}
 
 	if (platform_info->num_chipselect) {
 		num_cs = platform_info->num_chipselect;
-	} else if (IS_ENABLED(CONFIG_OF)) {
-		of_property_read_u32(np, "num-cs", &num_cs);
 	} else {
-		dev_err(&adev->dev, "probe: no chip select defined\n");
+		dev_err(dev, "probe: no chip select defined\n");
 		status = -ENODEV;
 		goto err_no_pdata;
 	}
