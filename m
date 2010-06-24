From: roman.tereshonkov@nokia.com (roman.tereshonkov at nokia.com)
Date: Thu, 24 Jun 2010 16:32:14 +0200
Subject: [PATCH] spi/omap2_mcspi: disable and enable chan between each
	SPI transfer
In-Reply-To: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <E1C7579D1379824DAE67858071C810382DD83846FB@NOK-EUMSG-02.mgdnok.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

>-----Original Message-----
>From: ext Jason Wang [mailto:jason77.wang at gmail.com] 
>Sent: 24 June, 2010 15:13
>To: grant.likely at secretlab.ca; Tereshonkov Roman 
>(Nokia-D/Helsinki); david-b at pacbell.net
>Cc: spi-devel-general at lists.sourceforge.net; 
>linux-arm-kernel at lists.infradead.org
>Subject: [PATCH] spi/omap2_mcspi: disable and enable chan 
>between each SPI transfer
>
>In current design, the SPI channel is always enable during the period
>of handling a SPI message, it is risky when more than one SPI transfer
>are included in a message. Current working route like that:
>[
>  SPI channel enable
>  configure channel
>  handle transfer #1
>  configure channel
>  handle transfer #2
>  ...
>  SPI channel disable
>]
>If we can disable channel before configure it and reenable
>channel after it is configured, it will be more safe.
>
>The commit a330ce2 "omap2_mcspi: Flush posted writes" make this risk
>to a real problem for ads7846 driver on omap3530evm. The
>ads7846 driver will send a SPI messge which includes,
>[
>  TX_ONLY transfer (1 byte)
>  RX_ONLY transfer (2 bytes)
>  TX_ONLY transfer (1 byte)
>  RX_ONLY transfer (2 bytes)
>]
>If we don't add disable/reenable channel between TX and RX transfers,
>the RX transfer will get wrong datas sent from slave.
>
>Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>---
> drivers/spi/omap2_mcspi.c |   16 ++++++----------
> 1 files changed, 6 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>index b3a94ca..1e3cb7b 100644
>--- a/drivers/spi/omap2_mcspi.c
>+++ b/drivers/spi/omap2_mcspi.c
>@@ -408,7 +408,6 @@ omap2_mcspi_txrx_dma(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 				count -= (word_len <= 8)  ? 2 :
> 					(word_len <= 16) ? 4 :
> 					/* word_len <= 32 */ 8;
>-				omap2_mcspi_set_enable(spi, 1);
> 				return count;
> 			}
> 		}
>@@ -430,8 +429,10 @@ omap2_mcspi_txrx_dma(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 				 (word_len <= 16) ? 2 :
> 			       /* word_len <= 32 */ 4;
> 		}
>-		omap2_mcspi_set_enable(spi, 1);
> 	}
>+
>+	omap2_mcspi_set_enable(spi, 0);
>+
> 	return count;
> }
> 
>@@ -517,8 +518,6 @@ omap2_mcspi_txrx_pio(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 						goto out;
> 					}
> 					c = 0;
>-				} else if (c == 0 && tx == NULL) {
>-					omap2_mcspi_set_enable(spi, 0);
> 				}
> 
> 				*rx++ = __raw_readl(rx_reg);
>@@ -570,8 +569,6 @@ omap2_mcspi_txrx_pio(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 						goto out;
> 					}
> 					c = 0;
>-				} else if (c == 0 && tx == NULL) {
>-					omap2_mcspi_set_enable(spi, 0);
> 				}
> 
> 				*rx++ = __raw_readl(rx_reg);
>@@ -623,8 +620,6 @@ omap2_mcspi_txrx_pio(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 						goto out;
> 					}
> 					c = 0;
>-				} else if (c == 0 && tx == NULL) {
>-					omap2_mcspi_set_enable(spi, 0);
> 				}
> 
> 				*rx++ = __raw_readl(rx_reg);

Why do you do this?
Reading the last word from the shift register buffer leads to 
the receiving new data to the buffer.
The channel needs to be disabled before the last word reading.



>@@ -646,7 +641,7 @@ omap2_mcspi_txrx_pio(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 			dev_err(&spi->dev, "EOT timed out\n");
> 	}
> out:
>-	omap2_mcspi_set_enable(spi, 1);
>+	omap2_mcspi_set_enable(spi, 0);
> 	return count - c;
> }
> 
>@@ -894,7 +889,6 @@ static void omap2_mcspi_work(struct 
>work_struct *work)
> 		cs = spi->controller_state;
> 		cd = spi->controller_data;
> 
>-		omap2_mcspi_set_enable(spi, 1);
> 		list_for_each_entry(t, &m->transfers, transfer_list) {
> 			if (t->tx_buf == NULL && t->rx_buf == 
>NULL && t->len) {
> 				status = -EINVAL;
>@@ -931,6 +925,8 @@ static void omap2_mcspi_work(struct 
>work_struct *work)
> 
> 			mcspi_write_chconf0(spi, chconf);
> 
>+			omap2_mcspi_set_enable(spi, 1);
>+
> 			if (t->len) {
> 				unsigned	count;
> 
>-- 
>1.5.6.5
>
>
