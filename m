From: cedric@precidata.com (Cedric Berger)
Date: Wed, 17 Apr 2013 22:42:55 +0200 (CEST)
Subject: [PATCH 7/10] LPC32XX: 007-pl022.1: Add start_control board hook
Message-ID: <mailman.17.1366231445.1198.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Cedric Berger <cedric@precidata.com>
---
For our platform, we must delay the start of SPI frames at a specific later
time, controlled by a FIQ interrupt. To implement this mechanism without
messing too much with the pl022 driver, we need a board hook on the SSP start
signal.

Index: include/linux/amba/pl022.h
===================================================================
--- include/linux/amba/pl022.h	(revision 1703)
+++ include/linux/amba/pl022.h	(revision 1704)
@@ -276,6 +276,8 @@
  * before sampling the incoming line
  * @cs_control: function pointer to board-specific function to
  * assert/deassert I/O port to control HW generation of devices chip-select.
+ * @start_control: function pointer to board-specific function to
+ * start the SPI controller.
  */
 struct pl022_config_chip {
 	enum ssp_interface iface;
@@ -290,6 +292,7 @@
 	enum ssp_duplex duplex;
 	enum ssp_clkdelay clkdelay;
 	void (*cs_control) (u32 control);
+	void (*start_control) (void);
 };
 
 #endif /* _SSP_PL022_H */
Index: drivers/spi/spi-pl022.c
===================================================================
--- drivers/spi/spi-pl022.c	(revision 1703)
+++ drivers/spi/spi-pl022.c	(revision 1704)
@@ -430,6 +430,7 @@
 	enum ssp_reading read;
 	enum ssp_writing write;
 	void (*cs_control) (u32 command);
+	void (*start_control) (void);
 	int xfer_type;
 };
 
@@ -1417,8 +1418,11 @@
 	}
 err_config_dma:
 	/* Enable SSP, turn on interrupts */
-	writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK_SSE),
-	       SSP_CR1(pl022->virtbase));
+	if (pl022->cur_chip->start_control)
+		pl022->cur_chip->start_control();
+	else
+		writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK_SSE),
+		       SSP_CR1(pl022->virtbase));
 	writew(irqflags, SSP_IMSC(pl022->virtbase));
 }
 
@@ -1888,6 +1892,7 @@
 				 "invalid chip select\n");
 	} else
 		chip->cs_control = chip_info->cs_control;
+	chip->start_control = chip_info->start_control;
 
 	/* Check bits per word with vendor specific range */
 	if ((bits <= 3) || (bits > pl022->vendor->max_bpw)) {
@@ -1934,7 +1939,7 @@
 		SSP_WRITE_BITS(chip->dmacr, SSP_DMA_DISABLED,
 			       SSP_DMACR_MASK_TXDMAE, 1);
 	}
-
+	chip->start_control = chip_info->start_control;
 	chip->cpsr = clk_freq.cpsdvsr;
 
 	/* Special setup for the ST micro extended control registers */
