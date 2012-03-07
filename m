From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Mar 2012 13:23:07 +0100
Subject: [PATCH 2/4 v4] spi/atmel: add DT support
In-Reply-To: <1331122989-14451-1-git-send-email-plagnioj@jcrosoft.com>
References: <1331122989-14451-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1331122989-14451-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atmel_spi use only gpio for chip select.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: spi-devel-general at lists.sourceforge.net
---
 .../devicetree/bindings/spi/spi_atmel.txt          |    6 +++++
 drivers/spi/spi-atmel.c                            |   21 ++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt

diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
new file mode 100644
index 0000000..7ec3d8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
@@ -0,0 +1,6 @@
+Atmel SPI device
+
+Required properties:
+- compatible : should be "atmel,at91rm9200-spi".
+- reg: Address and length of the register set for the device
+- interrupts: Should contain macb interrupt
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 16d6a83..efbc5f8 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <asm/io.h>
 #include <mach/board.h>
@@ -695,7 +696,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 	u32			scbr, csr;
 	unsigned int		bits = spi->bits_per_word;
 	unsigned long		bus_hz;
-	unsigned int		npcs_pin;
+	int			npcs_pin;
 	int			ret;
 
 	as = spi_master_get_devdata(spi->master);
@@ -767,7 +768,9 @@ static int atmel_spi_setup(struct spi_device *spi)
 	csr |= SPI_BF(DLYBCT, 0);
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
-	npcs_pin = (unsigned int)spi->controller_data;
+	if (!gpio_is_valid(spi->cs_gpio))
+		spi->cs_gpio = (int)spi->controller_data;
+	npcs_pin = spi->cs_gpio;
 	asd = spi->controller_state;
 	if (!asd) {
 		asd = kzalloc(sizeof(struct atmel_spi_device), GFP_KERNEL);
@@ -887,7 +890,7 @@ static void atmel_spi_cleanup(struct spi_device *spi)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(spi->master);
 	struct atmel_spi_device	*asd = spi->controller_state;
-	unsigned		gpio = (unsigned) spi->controller_data;
+	unsigned		gpio = spi->cs_gpio;
 	unsigned long		flags;
 
 	if (!asd)
@@ -938,7 +941,8 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
 	master->bus_num = pdev->id;
-	master->num_chipselect = 4;
+	master->dev.of_node = pdev->dev.of_node;
+	master->num_chipselect = master->dev.of_node ? 0 : 4;
 	master->setup = atmel_spi_setup;
 	master->transfer = atmel_spi_transfer;
 	master->cleanup = atmel_spi_cleanup;
@@ -1064,11 +1068,20 @@ static int atmel_spi_resume(struct platform_device *pdev)
 #define	atmel_spi_resume	NULL
 #endif
 
+#if defined(CONFIG_OF)
+static const struct of_device_id atmel_spi_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-spi" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, atmel_spi_dt_ids);
+#endif
 
 static struct platform_driver atmel_spi_driver = {
 	.driver		= {
 		.name	= "atmel_spi",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(atmel_spi_dt_ids),
 	},
 	.suspend	= atmel_spi_suspend,
 	.resume		= atmel_spi_resume,
-- 
1.7.7
