From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 1 Oct 2010 11:47:32 +0200
Subject: [PATCH] spi/pl022: get rid of chipinfo dev pointer
Message-ID: <1285926452-8636-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What is the dev pointer doing inside the platform data anyway.
We have another pointer to the actual device at hand, use that.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Note: this is based off Kevin Wells patch for using the proper
modebits since I expect that to go in first. If you want this to
go before that patch, tell me and we both have to rebase.
---
 drivers/spi/amba-pl022.c   |   27 ++++++++++++---------------
 include/linux/amba/pl022.h |    1 -
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 610c274..b01ee5b 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1597,58 +1597,58 @@ static int verify_controller_parameters(struct pl022 *pl022,
 {
 	if ((chip_info->iface < SSP_INTERFACE_MOTOROLA_SPI)
 	    || (chip_info->iface > SSP_INTERFACE_UNIDIRECTIONAL)) {
-		dev_err(chip_info->dev,
+		dev_err(&pl022->adev->dev,
 			"interface is configured incorrectly\n");
 		return -EINVAL;
 	}
 	if ((chip_info->iface == SSP_INTERFACE_UNIDIRECTIONAL) &&
 	    (!pl022->vendor->unidir)) {
-		dev_err(chip_info->dev,
+		dev_err(&pl022->adev->dev,
 			"unidirectional mode not supported in this "
 			"hardware version\n");
 		return -EINVAL;
 	}
 	if ((chip_info->hierarchy != SSP_MASTER)
 	    && (chip_info->hierarchy != SSP_SLAVE)) {
-		dev_err(chip_info->dev,
+		dev_err(&pl022->adev->dev,
 			"hierarchy is configured incorrectly\n");
 		return -EINVAL;
 	}
 	if (((chip_info->clk_freq).cpsdvsr < CPSDVR_MIN)
 	    || ((chip_info->clk_freq).cpsdvsr > CPSDVR_MAX)) {
-		dev_err(chip_info->dev,
+		dev_err(&pl022->adev->dev,
 			"cpsdvsr is configured incorrectly\n");
 		return -EINVAL;
 	}
 	if ((chip_info->com_mode != INTERRUPT_TRANSFER)
 	    && (chip_info->com_mode != DMA_TRANSFER)
 	    && (chip_info->com_mode != POLLING_TRANSFER)) {
-		dev_err(chip_info->dev,
+		dev_err(&pl022->adev->dev,
 			"Communication mode is configured incorrectly\n");
 		return -EINVAL;
 	}
 	if ((chip_info->rx_lev_trig < SSP_RX_1_OR_MORE_ELEM)
 	    || (chip_info->rx_lev_trig > SSP_RX_32_OR_MORE_ELEM)) {
-		dev_err(chip_info->dev,
+		dev_err(&pl022->adev->dev,
 			"RX FIFO Trigger Level is configured incorrectly\n");
 		return -EINVAL;
 	}
 	if ((chip_info->tx_lev_trig < SSP_TX_1_OR_MORE_EMPTY_LOC)
 	    || (chip_info->tx_lev_trig > SSP_TX_32_OR_MORE_EMPTY_LOC)) {
-		dev_err(chip_info->dev,
+		dev_err(&pl022->adev->dev,
 			"TX FIFO Trigger Level is configured incorrectly\n");
 		return -EINVAL;
 	}
 	if (chip_info->iface == SSP_INTERFACE_NATIONAL_MICROWIRE) {
 		if ((chip_info->ctrl_len < SSP_BITS_4)
 		    || (chip_info->ctrl_len > SSP_BITS_32)) {
-			dev_err(chip_info->dev,
+			dev_err(&pl022->adev->dev,
 				"CTRL LEN is configured incorrectly\n");
 			return -EINVAL;
 		}
 		if ((chip_info->wait_state != SSP_MWIRE_WAIT_ZERO)
 		    && (chip_info->wait_state != SSP_MWIRE_WAIT_ONE)) {
-			dev_err(chip_info->dev,
+			dev_err(&pl022->adev->dev,
 				"Wait State is configured incorrectly\n");
 			return -EINVAL;
 		}
@@ -1658,12 +1658,12 @@ static int verify_controller_parameters(struct pl022 *pl022,
 			     SSP_MICROWIRE_CHANNEL_FULL_DUPLEX)
 			    && (chip_info->duplex !=
 				SSP_MICROWIRE_CHANNEL_HALF_DUPLEX))
-				dev_err(chip_info->dev,
+				dev_err(&pl022->adev->dev,
 					"Microwire duplex mode is configured incorrectly\n");
 				return -EINVAL;
 		} else {
 			if (chip_info->duplex != SSP_MICROWIRE_CHANNEL_FULL_DUPLEX)
-				dev_err(chip_info->dev,
+				dev_err(&pl022->adev->dev,
 					"Microwire half duplex mode requested,"
 					" but this is only available in the"
 					" ST version of PL022\n");
@@ -1671,7 +1671,7 @@ static int verify_controller_parameters(struct pl022 *pl022,
 		}
 	}
 	if (chip_info->cs_control == NULL) {
-		dev_warn(chip_info->dev,
+		dev_warn(&pl022->adev->dev,
 			"Chip Select Function is NULL for this chip\n");
 		chip_info->cs_control = null_cs_control;
 	}
@@ -1851,9 +1851,6 @@ static int pl022_setup(struct spi_device *spi)
 			"using user supplied controller_data settings\n");
 	}
 
-	/* Pointer back to the SPI device */
-	chip_info->dev = &spi->dev;
-
 	/*
 	 * We can override with custom divisors, else we use the board
 	 * frequency setting
diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index bf14366..4ce98f5 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -276,7 +276,6 @@ struct pl022_ssp_controller {
  * @dma_config: DMA configuration for SSP controller and peripheral
  */
 struct pl022_config_chip {
-	struct device *dev;
 	enum ssp_interface iface;
 	enum ssp_hierarchy hierarchy;
 	bool slave_tx_disable;
-- 
1.6.3.3
