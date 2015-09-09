From: eric@anholt.net (Eric Anholt)
Date: Tue, 08 Sep 2015 19:20:15 -0700
Subject: [PATCH v5 4/6] spi: bcm2835: new driver implementing auxiliar
 spi1/spi2 on the bcm2835 soc
In-Reply-To: <1441359711-2800-5-git-send-email-kernel@martin.sperl.org>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
 <1441359711-2800-5-git-send-email-kernel@martin.sperl.org>
Message-ID: <87fv2o1ggw.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Implements spi master driver for the 2 auxiliar spi devices
> supported by the bcm2835 SOC.
>
> The driver does not implement native chip-selects but uses
> framework provided aribtrary GPIO-chip-selects.
>
> Requires soc-bcm2835-aux enable api to enable/disable HW blocks.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/spi/Kconfig          |   12 +
>  drivers/spi/Makefile         |    1 +
>  drivers/spi/spi-bcm2835aux.c |  514 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 527 insertions(+)
>  create mode 100644 drivers/spi/spi-bcm2835aux.c
>
> Changelog:
> 	v4->v5: added error-handling and deferred probing support
> 		moved change to default-config to a separate patch
> 		fixed Kconfig to add the correct dependency

Review comments as a diff, so you can git-am and squash them in if you
like.  If you take them all, you can add "Acked-by: Eric Anholt
<eric@anholt.net>".

I didn't know anything about SPI before tonight, but I've looked through
what you did and it looks solid when compared to the hardware docs I've
got.  The only functional comment I had that's not in my diff is that
you could probably reduce the transfer overhead by knowing that there
are 4 dwords in the transfer and receive FIFOs, so I think you could
write more before checking if you had to stop.

>From e082c3b5ea32d3eb1a40b7f9b5a822ba307cf886 Mon Sep 17 00:00:00 2001
From: Eric Anholt <eric@anholt.net>
Date: Tue, 8 Sep 2015 17:51:08 -0700
Subject: [PATCH] spi: Changes for Martin's aux spi driver.

The intention is for these to be review fixes squashed into his commit of the driver.

- Reset has to happen before the clock gate is disabled, since
  register writes wouldn't take effect.

- Typo fixes.

- Dropped unnecessary regs/defines.

- Dropped custom clock enable/disable, assuming we use the aux clock
  driver instead.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/spi/Kconfig          |  5 ++---
 drivers/spi/spi-bcm2835aux.c | 45 ++++++--------------------------------------
 2 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cdb3dba..20854d4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -89,16 +89,15 @@ config SPI_BCM2835
 	  not supported.
 
 config SPI_BCM2835AUX
-	tristate "BCM2835 SPI auxiliar controller"
+	tristate "BCM2835 SPI auxiliary controller"
 	depends on ARCH_BCM2835 || COMPILE_TEST
 	depends on GPIOLIB
-	select SOC_BCM2835_AUX
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI aux master.
 
 	  The BCM2835 contains two types of SPI master controller; the
 	  "universal SPI master", and the regular SPI controller.
-	  This driver is for the universal/auxiliar SPI controller.
+	  This driver is for the universal/auxiliary SPI controller.
 
 config SPI_BFIN5XX
 	tristate "SPI controller driver for ADI Blackfin5xx"
diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index d968647..3451ecb 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -1,5 +1,5 @@
 /*
- * Driver for Broadcom BCM2835 SPI Controllers
+ * Driver for Broadcom BCM2835 auxiliary SPI Controllers
  *
  * the driver does not rely on the native chipselects at all
  * but only uses the gpio type chipselects
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/soc/bcm/bcm2835-aux.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -38,27 +37,10 @@
 #include <linux/spinlock.h>
 
 /*
- * shared aux registers between spi1/spi2 and uart1
- *
- * these defines could go to a separate module if needed
- * so that it can also get used with the uart1 implementation
- * when it materializes.
- */
-
-/* the AUX register offsets */
-#define BCM2835_AUX_IRQ		0x00
-#define BCM2835_AUX_ENABLE	0x04
-
-/* the AUX Bitfield identical for both register */
-#define BCM2835_AUX_BIT_UART	0x00000001
-#define BCM2835_AUX_BIT_SPI1	0x00000002
-#define BCM2835_AUX_BIT_SPI2	0x00000004
-
-/*
  * spi register defines
  *
  * note there is garbage in the "official" documentation,
- * so somedata taken from the file:
+ * so some data is taken from the file:
  *   brcm_usrlib/dag/vmcsx/vcinclude/bcm2708_chip/aux_io.h
  * inside of:
  *   http://www.broadcom.com/docs/support/videocore/Brcm_Android_ICS_Graphics_Stack.tar.gz
@@ -113,9 +95,6 @@
 #define BCM2835_AUX_SPI_MODE_BITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				  | SPI_NO_CS)
 
-#define DRV_NAME	"spi-bcm2835aux"
-#define ENABLE_PROPERTY "brcm,aux-enable"
-
 struct bcm2835aux_spi {
 	void __iomem *regs;
 	struct clk *clk;
@@ -450,26 +429,17 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
-	/* enable HW block */
-	err = bcm2835aux_enable(&pdev->dev, ENABLE_PROPERTY);
-	if (err) {
-		dev_err(&pdev->dev, "could not enable aux: %d\n", err);
-		goto out_clk_disable;
-	}
-
 	/* reset SPI-HW block */
 	bcm2835aux_spi_reset_hw(bs);
 
 	err = devm_spi_register_master(&pdev->dev, master);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
-		goto out_hw_disable;
+		goto out_clk_disable;
 	}
 
 	return 0;
 
-out_hw_disable:
-	bcm2835aux_disable(&pdev->dev, ENABLE_PROPERTY);
 out_clk_disable:
 	clk_disable_unprepare(bs->clk);
 out_master_put:
@@ -482,13 +452,10 @@ static int bcm2835aux_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 
-	/* Clear FIFOs, and disable the HW block */
-	clk_disable_unprepare(bs->clk);
-
 	bcm2835aux_spi_reset_hw(bs);
 
-	/* disable HW block */
-	bcm2835aux_disable(&pdev->dev, ENABLE_PROPERTY);
+	/* Clear FIFOs, and disable the HW block */
+	clk_disable_unprepare(bs->clk);
 
 	return 0;
 }
@@ -501,7 +468,7 @@ MODULE_DEVICE_TABLE(of, bcm2835aux_spi_match);
 
 static struct platform_driver bcm2835aux_spi_driver = {
 	.driver		= {
-		.name		= DRV_NAME,
+		.name		= "spi-bcm2835aux",
 		.of_match_table	= bcm2835aux_spi_match,
 	},
 	.probe		= bcm2835aux_spi_probe,
-- 
2.1.4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150908/b100af71/attachment.sig>
