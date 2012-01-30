From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 30 Jan 2012 16:27:50 +0100
Subject: [PATCH 2/3] spi/atmel: add DT support
In-Reply-To: <1327937271-23668-1-git-send-email-plagnioj@jcrosoft.com>
References: <1327937271-23668-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1327937271-23668-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the atmel_spi use only gpio for chip select

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: spi-devel-general at lists.sourceforge.net
---
 .../devicetree/bindings/spi/spi_atmel.txt          |    6 ++++++
 drivers/spi/spi-atmel.c                            |   13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletions(-)
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
index 16d6a83..beeaa26 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <asm/io.h>
 #include <mach/board.h>
@@ -937,8 +938,9 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
+	master->dev.of_node = pdev->dev.of_node;
 	master->bus_num = pdev->id;
-	master->num_chipselect = 4;
+	master->num_chipselect = master->dev.of_node ? 0 : 4;
 	master->setup = atmel_spi_setup;
 	master->transfer = atmel_spi_transfer;
 	master->cleanup = atmel_spi_cleanup;
@@ -1064,11 +1066,20 @@ static int atmel_spi_resume(struct platform_device *pdev)
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
