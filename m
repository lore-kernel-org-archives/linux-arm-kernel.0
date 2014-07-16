From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 16 Jul 2014 17:19:07 +0200
Subject: [PATCH 1/4] Revert "spi: s3c64xx: Added provision for dedicated cs
 pin"
In-Reply-To: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1405523950-2231-2-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 3146beec21b64f4551fcf0ac148381d54dc41b1b.

This commit resulted in a DT backward compatibility breakage.

Some devices use the native chip select (CS) instead of a GPIO
pin to drive the CS line. But the SPI driver made it mandatory
to specify a GPIO pin in the SPI device node controller-data.
So, using the built-in CS was not possible with the driver.

Commit 3146bee tried to fix that by adding a "cs-gpio" property
which could be defined in the SPI device node to make the driver
request the GPIO from the controller-data node.

Unfortunately that changed the old DT binding semantics since
now it's mandatory to have the "cs-gpio" property defined in
the SPI device node in order to use a GPIO pin to drive the CS.

As an example, a SPI device was defined before the commit with:

spi at 12d20000 {
    slave-node at 0 {
        controller-data {
             cs-gpio = <&gpb1 2 0>;
        }
   }
}

and after the commit, the following DTS snippet must be used:

spi at 12d20000 {
    cs-gpio;
    slave-node at 0 {
        controller-data {
             cs-gpio = <&gpb1 2 0>;
        }
   }
}

So, after commit 3146bee the driver does not look for the GPIO
by default and it only looks for it if the top level "cs-gpio"
property is defined while the default used to be the opposite.
To always request the GPIO defined in the controller-data node.

This means that old FDT that of course didn't have this added
"cs-gpio" DT property in the SPI node broke after this change.

The offending commit can't be reverted cleanly since more than
a year have passed and other changes were made in the meantime
but this patch partially reverts the driver to it's original
state so old FDT can work again.

This patch will break Device Trees that were relying on the new
behavior of course but the patch should be reverted because:

a) There aren't DTS in mainline that use this new property.
b) They were relying on a behavior that broke DT compatibility.
c) The new binding is awkard, needing two properties with the
   same name (cs-gpio) on different nodes is confusing at least.
d) The new property was not added to the DT binding doc:
   Documentation/devicetree/bindings/spi/spi-samsung.txt

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index a771a3a..e48c6fa 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -197,7 +197,6 @@ struct s3c64xx_spi_driver_data {
 	struct s3c64xx_spi_dma_data	tx_dma;
 	struct s3c64xx_spi_port_config	*port_conf;
 	unsigned int			port_id;
-	bool				cs_gpio;
 };
 
 static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
@@ -754,10 +753,8 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 {
 	struct s3c64xx_spi_csinfo *cs;
 	struct device_node *slave_np, *data_np = NULL;
-	struct s3c64xx_spi_driver_data *sdd;
 	u32 fb_delay = 0;
 
-	sdd = spi_master_get_devdata(spi->master);
 	slave_np = spi->dev.of_node;
 	if (!slave_np) {
 		dev_err(&spi->dev, "device node not found\n");
@@ -776,10 +773,7 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* The CS line is asserted/deasserted by the gpio pin */
-	if (sdd->cs_gpio)
-		cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
-
+	cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
 	if (!gpio_is_valid(cs->line)) {
 		dev_err(&spi->dev, "chip select gpio is not specified or invalid\n");
 		kfree(cs);
@@ -818,20 +812,17 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	}
 
 	if (!spi_get_ctldata(spi)) {
-		/* Request gpio only if cs line is asserted by gpio pins */
-		if (sdd->cs_gpio) {
-			err = gpio_request_one(cs->line, GPIOF_OUT_INIT_HIGH,
-					dev_name(&spi->dev));
-			if (err) {
-				dev_err(&spi->dev,
-					"Failed to get /CS gpio [%d]: %d\n",
-					cs->line, err);
-				goto err_gpio_req;
-			}
-
-			spi->cs_gpio = cs->line;
+		err = gpio_request_one(cs->line, GPIOF_OUT_INIT_HIGH,
+				       dev_name(&spi->dev));
+		if (err) {
+			dev_err(&spi->dev,
+				"Failed to get /CS gpio [%d]: %d\n",
+				cs->line, err);
+			goto err_gpio_req;
 		}
 
+		spi->cs_gpio = cs->line;
+
 		spi_set_ctldata(spi, cs);
 	}
 
@@ -897,10 +888,8 @@ err_gpio_req:
 static void s3c64xx_spi_cleanup(struct spi_device *spi)
 {
 	struct s3c64xx_spi_csinfo *cs = spi_get_ctldata(spi);
-	struct s3c64xx_spi_driver_data *sdd;
 
-	sdd = spi_master_get_devdata(spi->master);
-	if (spi->cs_gpio) {
+	if (cs) {
 		gpio_free(spi->cs_gpio);
 		if (spi->dev.of_node)
 			kfree(cs);
@@ -1075,11 +1064,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->cntrlr_info = sci;
 	sdd->pdev = pdev;
 	sdd->sfr_start = mem_res->start;
-	sdd->cs_gpio = true;
 	if (pdev->dev.of_node) {
-		if (!of_find_property(pdev->dev.of_node, "cs-gpio", NULL))
-			sdd->cs_gpio = false;
-
 		ret = of_alias_get_id(pdev->dev.of_node, "spi");
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to get alias id, errno %d\n",
-- 
2.0.0.rc2
