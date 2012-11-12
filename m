From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 12 Nov 2012 16:52:31 +0800
Subject: [PATCH 11/17] spi/atmel_spi: add DT support
In-Reply-To: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
References: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1352710357-3265-12-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

The atmel_spi use only gpio for chip select.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: spi-devel-general at lists.sourceforge.net
Cc: grant.likely at secretlab.ca
Cc: rob.herring at calxeda.com
Cc: rob at landley.net
Cc: linux-doc at vger.kernel.org
Cc: richard.genoud at gmail.com
---
Hi, Richard,

This patches is based on the original patch from Jean-Christophe
	[PATCH] spi/atmel: add DT support
and merged the patch from Richard Genoud
	[PATCH] spi-atmel OF: complete documentation

Could you sign your signature in this patch?

Best Regards,
Wenyou Yang

 .../devicetree/bindings/spi/spi_atmel.txt          |   23 ++++++++++++++++++++
 drivers/spi/spi-atmel.c                            |   21 ++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt

diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
new file mode 100644
index 0000000..20cdc91
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
@@ -0,0 +1,23 @@
+Atmel SPI device
+
+Required properties:
+- compatible : should be "atmel,at91rm9200-spi".
+- reg: Address and length of the register set for the device
+- interrupts: Should contain macb interrupt
+- cs-gpio: Should contain the GPIOs used for chipselect.
+- dma-mask: device coherent dma mask.
+
+spi0: spi at f0000000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "atmel,at91rm9200-spi";
+	reg = <0xf0000000 0x100>;
+	interrupts = <13 4>;
+	cs-gpios = <&pioA 14 0
+		    &pioA 7 0 /* conflicts with TXD2 */
+		    &pioA 1 0 /* conflicts with RXD0 */
+		    &pioB 3 0 /* conflicts with ERXDV */
+		   >;
+	dma-mask = <0xffffffff>;
+	status = "disabled";
+};
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 7a3613d..0cc347c 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <asm/io.h>
 #include <mach/board.h>
@@ -1242,7 +1243,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 	u32			scbr, csr;
 	unsigned int		bits = spi->bits_per_word;
 	unsigned long		bus_hz;
-	unsigned int		npcs_pin;
+	int			npcs_pin;
 	int			ret;
 
 	as = spi_master_get_devdata(spi->master);
@@ -1314,7 +1315,9 @@ static int atmel_spi_setup(struct spi_device *spi)
 	csr |= SPI_BF(DLYBCT, 0);
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
-	npcs_pin = (unsigned int)spi->controller_data;
+	if (!gpio_is_valid(spi->cs_gpio))
+		spi->cs_gpio = (int)spi->controller_data;
+	npcs_pin = spi->cs_gpio;
 	asd = spi->controller_state;
 	if (!asd) {
 		asd = kzalloc(sizeof(struct atmel_spi_device), GFP_KERNEL);
@@ -1435,7 +1438,7 @@ static void atmel_spi_cleanup(struct spi_device *spi)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(spi->master);
 	struct atmel_spi_device	*asd = spi->controller_state;
-	unsigned		gpio = (unsigned) spi->controller_data;
+	unsigned		gpio = spi->cs_gpio;
 
 	if (!asd)
 		return;
@@ -1485,7 +1488,8 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
 	master->bus_num = pdev->id;
-	master->num_chipselect = 4;
+	master->dev.of_node = pdev->dev.of_node;
+	master->num_chipselect = master->dev.of_node ? 0 : 4;
 	master->setup = atmel_spi_setup;
 	master->transfer = atmel_spi_transfer;
 	master->cleanup = atmel_spi_cleanup;
@@ -1637,11 +1641,20 @@ static int atmel_spi_resume(struct platform_device *pdev)
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
1.7.9.5
