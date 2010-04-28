From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 28 Apr 2010 17:30:25 -0500
Subject: [PATCH v5 0/2] spi: driver for Cirrus EP93xx SPI controller
In-Reply-To: <cover.1272476431.git.mika.westerberg@iki.fi>
References: <cover.1272476431.git.mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B0270842697636DB622A3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 28, 2010 10:51 AM, Mika Westerberg wrote:
> 
> Hello,
> 
> This series implements SPI master driver for Cirrus Logic EP93xx SPI
> controllers.
> 
> This is fifth iteration of the driver.
> 
> Changes to the previous version:
> 	- addressed review comments
> 	- added priming the TX FIFO when transfer is started
> 	- in case of ROR interrupt we clear it
> 	- added documentation in Documentation/spi/ep93xx_spi which provides
> 	  sample code how the driver can be hooked into platform data
> 
> I tested this on TS-7260 board with at25 and mmc_spi drivers. Now that I have
> Sim.One board, which is EP9307 based, I also tested with that (I hacked the
> board a bit to get EGPIO9 as a chip select).
> 
> Note that patch 2/2 depends on patch that is already in Russell's patch
> tracking system:
> 	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5998/1
> 

Mika,

Following is a patch to allow using built-in gpios, external gpio expanders
(spi/i2c/etc.) or really any other mechanism for the chip select.

Using your example in Documentation/spi/ep93xx_spi as a starting point, the
modified setup code would look like this:

+...
+#include <linux/gpio.h>
+#include <linux/spi/spi.h>
+
+#include <mach/ep93xx_spi.h>
+
+/* this is our GPIO line used for chip select */
+#define MMC_CHIP_SELECT_GPIO	EP93XX_GPIO_LINE_EGPIO9
+
+static int ts72xx_mmc_spi_setup(struct spi_device *spi)
+{
+	int err;
+
+	err = gpio_request(MMC_CHIP_SELECT_GPIO, spi->modalias);
+	if (err)
+		return err;
+
+	gpio_direction_output(MMC_CHIP_SELECT_GPIO, 1);
+
+	return 0;
+}
+
+static void ts72xx_mmc_spi_cleanup(struct spi_device *spi)
+{
+	gpio_set_value(MMC_CHIP_SELECT_GPIO, 1);
+	gpio_direction_input(MMC_CHIP_SELECT_GPIO);
+	gpio_free(MMC_CHIP_SELECT_GPIO);
+}
+
+static void ts72xx_mmc_spi_cs_control(struct spi_device *spi, int value)
+{
+	gpio_set_value(MMC_CHIP_SELECT_GPIO, value);
+}
+
+static struct ep93xx_spi_chip_ops ts72xx_mmc_spi_ops = {
+	.setup		= ts72xx_mmc_spi_setup,
+	.cleanup	= ts72xx_mmc_spi_cleanup,
+	.cs_control	= ts72xx_mmc_spi_cs_control,
+};
+
+static struct spi_board_info ts72xx_spi_devices[] __initconst = {
+	{
+		.modalias		= "mmc_spi",
+		.controller_data	= &ts72xx_mmc_spi_ops,
+		/*
+		 * We use 10 MHz even though the maximum is 7.4 MHz. The driver
+		 * will limit it automatically to max. frequency.
+		 */
+		.max_speed_hz	= 10 * 1000 * 1000,
+		.bus_num		= 0,
+		.chip_select	= 0,
+		.mode			= SPI_MODE_0,
+	},
+};
+
+static struct ep93xx_spi_info ts72xx_spi_info = {
+	.num_chipselect	= ARRAY_SIZE(ts72xx_spi_devices),
+};
+
+static void __init ts72xx_init_machine(void)
+{
+	...
+	ep93xx_register_spi(&ts72xx_spi_info, ts72xx_spi_devices,
+     			ARRAY_SIZE(ts72xx_spi_devices));
+}


Every spi device in struct spi_board_info would have it's own private
struct ep93xx_spi_chip_ops which is passed in the controller_data
field.

Note, this isn't a git produced patch.  I currently don't have my development
tree under git control...

---

Expand the chip select options for the ep93xx_spi driver to allow using
spi/i2c/etc. gpio expanders to provide the chip selects.

This introduces a per-chip structure to provide setup/cleanup callbacks
for the chip select mechanism and a cs_control callback that is used to
actually select/deselect the device.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

--- arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h.orig	2010-04-28 14:36:14.000000000 -0700
+++ arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h	2010-04-28 15:27:39.000000000 -0700
@@ -7,25 +7,20 @@ struct spi_device;
  * struct ep93xx_spi_info - EP93xx specific SPI descriptor
  * @num_chipselect: number of chip selects on this board, must be
  *                  at least one
- * @cs_control: chip select control function. Can be %NULL if not needed.
- *
- * This structure is passed from board support files to EP93xx SPI controller
- * driver. It provides callback hook to control chip select lines that are
- * allocated in board support files during the board initialization.
  */
 struct ep93xx_spi_info {
 	int	num_chipselect;
-	/*
-	 * cs_control() - control board chipselect GPIO lines
-	 * @spi: SPI device whose chipselect is controlled
-	 * @value: value to set the chip select line to
-	 *
-	 * This function is used to control board specific chip select lines.
-	 * @value is either %0 or %1.
-	 *
-	 * This function is called from thread context and can sleep if
-	 * necessary.
-	 */
+};
+
+/**
+ * struct ep93xx_spi_chip_ops  - operation callbacks for SPI slave device
+ * @setup: setup the chip select mechanism
+ * @cleanup: cleanup the chip select mechanism
+ * @cs_control: control the device chip select
+ */
+struct ep93xx_spi_chip_ops {
+	int	(*setup)(struct spi_device *spi);
+	void	(*cleanup)(struct spi_device *spi);
 	void	(*cs_control)(struct spi_device *spi, int value);
 };
 
--- drivers/spi/ep93xx_spi.c.orig	2010-04-28 13:06:07.000000000 -0700
+++ drivers/spi/ep93xx_spi.c	2010-04-28 15:24:47.000000000 -0700
@@ -84,7 +84,6 @@
  * @rx: current byte in transfer to receive
  * @fifo_level: how full is FIFO (%0..%SPI_FIFO_SIZE - %1). Receiving one
  *              frame decreases this level and sending one frame increases it.
- * @cs_control: chip select control function
  *
  * This structure holds EP93xx SPI controller specific information. When
  * @running is %true, driver accepts transfer requests from protocol drivers.
@@ -113,7 +112,6 @@ struct ep93xx_spi {
 	size_t				tx;
 	size_t				rx;
 	size_t				fifo_level;
-	void				(*cs_control)(struct spi_device *, int);
 };
 
 /**
@@ -123,6 +121,7 @@ struct ep93xx_spi {
  * @div_cpsr: cpsr (pre-scaler) divider
  * @div_scr: scr divider
  * @dss: bits per word (4 - 16 bits)
+ * @ops: private chip operations
  *
  * This structure is used to store hardware register specific settings for each
  * SPI device. Settings are written to hardware by function
@@ -134,6 +133,7 @@ struct ep93xx_spi_chip {
 	u8			div_cpsr;
 	u8			div_scr;
 	u8			dss;
+	struct ep93xx_spi_chip_ops *ops;
 };
 
 /* converts bits per word to CR0.DSS value */
@@ -283,7 +283,6 @@ static int ep93xx_spi_calc_divisors(cons
 
 /**
  * ep93xx_spi_cs_control() - controls chipselect for given device
- * @espi: ep93xx SPI controller struct
  * @spi: SPI device to select/deselect
  * @control: select (%true) / deselect (%false)
  *
@@ -291,14 +290,13 @@ static int ep93xx_spi_calc_divisors(cons
  *
  * Note that this function is called from a thread context and can sleep.
  */
-static inline void ep93xx_spi_cs_control(const struct ep93xx_spi *espi,
-					 struct spi_device *spi,
-					 bool control)
+static void ep93xx_spi_cs_control(struct spi_device *spi, bool control)
 {
+	struct ep93xx_spi_chip *chip = spi_get_ctldata(spi);
 	int value = (spi->mode & SPI_CS_HIGH) ? control : !control;
 
-	if (espi->cs_control)
-		espi->cs_control(spi, value);
+	if (chip->ops && chip->ops->cs_control)
+		chip->ops->cs_control(spi, value);
 }
 
 /**
@@ -323,12 +321,25 @@ static int ep93xx_spi_setup(struct spi_d
 
 	chip = spi_get_ctldata(spi);
 	if (!chip) {
+		dev_dbg(&espi->pdev->dev, "initial setup for %s\n",
+			spi->modalias);
+
 		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 		if (!chip)
 			return -ENOMEM;
 
-		spi_set_ctldata(spi, chip);
 		chip->spi = spi;
+		chip->ops = spi->controller_data;
+
+		if (chip->ops && chip->ops->setup) {
+			ret = chip->ops->setup(spi);
+			if (ret) {
+				kfree(chip);
+				return ret;
+			}
+		}
+
+		spi_set_ctldata(spi, chip);
 	}
 
 	if (spi->max_speed_hz != chip->rate) {
@@ -345,7 +356,7 @@ static int ep93xx_spi_setup(struct spi_d
 
 	chip->dss = bits_per_word_to_dss(spi->bits_per_word);
 
-	ep93xx_spi_cs_control(espi, spi, false);
+	ep93xx_spi_cs_control(spi, false);
 	return 0;
 }
 
@@ -414,6 +425,8 @@ static void ep93xx_spi_cleanup(struct sp
 
 	chip = spi_get_ctldata(spi);
 	if (chip) {
+		if (chip->ops && chip->ops->cleanup)
+			chip->ops->cleanup(spi);
 		spi_set_ctldata(spi, NULL);
 		kfree(chip);
 	}
@@ -610,9 +623,9 @@ static void ep93xx_spi_process_transfer(
 			 * chipselect briefly, we let the scheduler to handle
 			 * any "delay" here.
 			 */
-			ep93xx_spi_cs_control(espi, msg->spi, false);
+			ep93xx_spi_cs_control(msg->spi, false);
 			cond_resched();
-			ep93xx_spi_cs_control(espi, msg->spi, true);
+			ep93xx_spi_cs_control(msg->spi, true);
 		}
 	}
 
@@ -674,7 +687,7 @@ static void ep93xx_spi_process_message(s
 	 * the chipselect.
 	 */
 	ep93xx_spi_chip_setup(espi, spi_get_ctldata(msg->spi));
-	ep93xx_spi_cs_control(espi, msg->spi, true);
+	ep93xx_spi_cs_control(msg->spi, true);
 
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
 		ep93xx_spi_process_transfer(espi, msg, t);
@@ -686,7 +699,7 @@ static void ep93xx_spi_process_message(s
 	 * Now the whole message is transferred (or failed for some reason). We
 	 * deselect the device and disable the SPI controller.
 	 */
-	ep93xx_spi_cs_control(espi, msg->spi, false);
+	ep93xx_spi_cs_control(msg->spi, false);
 	ep93xx_spi_disable(espi);
 }
 
@@ -811,7 +824,6 @@ static int __init ep93xx_spi_probe(struc
 	platform_set_drvdata(pdev, master);
 
 	espi = spi_master_get_devdata(master);
-	espi->cs_control = info->cs_control;
 
 	espi->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(espi->clk)) {
@@ -860,7 +872,7 @@ static int __init ep93xx_spi_probe(struc
 	}
 
 	error = request_irq(espi->irq, ep93xx_spi_interrupt, 0,
-			    "ep93xx-spi", espi);
+				"ep93xx-spi", espi);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request irq\n");
 		goto fail_unmap_regs;
@@ -878,7 +890,7 @@ static int __init ep93xx_spi_probe(struc
 	/* make sure that the hardware is disabled */
 	ep93xx_spi_write_u8(espi, SSPCR1, 0);
 
-	error =	spi_register_master(master);
+	error = spi_register_master(master);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register SPI master\n");
 		goto fail_free_queue;
