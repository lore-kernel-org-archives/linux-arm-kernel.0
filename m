From: b44548@freescale.com (Chao Fu)
Date: Mon, 30 Dec 2013 15:27:54 +0800
Subject: [PATCH] spi:fsl-dspi:add support of DSPI IP in big endian
Message-ID: <1388388474-8662-1-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Fu <B44548@freescale.com>

Freescale DSPI module will have two endianess in diffrente platform,
but ARM is little endian. So when DSPI in big endian, core in little endian,
readl and writel can not adjust R/W register in this condition.
This patch will provide a new io R/W method for the device in two endianess.

R/W registers in DSPI way in stead of ARM R/W as following:
"#define DSPI_BITWISE16(d, v)   (d->big_endian ? cpu_to_be16(v) : cpu_to_le16(v))
"#define DSPI_BITWISE32(d, v)   (d->big_endian ? cpu_to_be32(v) : cpu_to_le32(v))

"#define dspi_readb(c)          readb(c)
"#define dspi_readw(c)          ({ u16 __v = (__force u16) __raw_readw(c); __iormb(); __v; })
"#define dspi_readl(c)          ({ u32 __v = (__force u32) __raw_readl(c); __iormb(); __v; })
"#define dspi_writeb(v, c)      writeb(v, c)
"#define dspi_writew(v, c)      ({ __iowmb(); __raw_writew((__force u16) v, c); })
"#define dspi_writel(v, c)      ({ __iowmb(); __raw_writel((__force u32) v, c); })

Signed-off-by: Jingchang Lu <b35083@freescale.com>
Signed-off-by: Chao Fu      <b44548@freescale.com>
---
 drivers/spi/spi-fsl-dspi.c | 66 ++++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 8641b03..14df323 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -31,6 +31,16 @@
 
 #define DRIVER_NAME "fsl-dspi"
 
+#define DSPI_BITWISE16(d, v)	(d->big_endian ? cpu_to_be16(v) : cpu_to_le16(v))
+#define DSPI_BITWISE32(d, v)	(d->big_endian ? cpu_to_be32(v) : cpu_to_le32(v))
+
+#define dspi_readb(c)		readb(c)
+#define dspi_readw(c)		({ u16 __v = (__force u16) __raw_readw(c); __iormb(); __v; })
+#define dspi_readl(c)		({ u32 __v = (__force u32) __raw_readl(c); __iormb(); __v; })
+#define dspi_writeb(v, c)	writeb(v, c)
+#define dspi_writew(v, c)	({ __iowmb(); __raw_writew((__force u16) v, c); })
+#define dspi_writel(v, c)	({ __iowmb(); __raw_writel((__force u32) v, c); })
+
 #define TRAN_STATE_RX_VOID		0x01
 #define TRAN_STATE_TX_VOID		0x02
 #define TRAN_STATE_WORD_ODD_NUM	0x04
@@ -110,9 +120,10 @@ struct fsl_dspi {
 
 	void __iomem		*base;
 	int			irq;
-	struct clk 		*clk;
+	struct clk		*clk;
 
-	struct spi_transfer 	*cur_transfer;
+	bool			big_endian;
+	struct spi_transfer	*cur_transfer;
 	struct chip_data	*cur_chip;
 	size_t			len;
 	void			*tx;
@@ -123,24 +134,26 @@ struct fsl_dspi {
 	u8			cs;
 	u16			void_write_data;
 
-	wait_queue_head_t 	waitq;
-	u32 			waitflags;
+	wait_queue_head_t	waitq;
+	u32			waitflags;
 };
 
 static inline int is_double_byte_mode(struct fsl_dspi *dspi)
 {
-	return ((readl(dspi->base + SPI_CTAR(dspi->cs)) & SPI_FRAME_BITS_MASK)
-			== SPI_FRAME_BITS(8)) ? 0 : 1;
+	return
+	((DSPI_BITWISE32(dspi, dspi_readl(dspi->base + SPI_CTAR(dspi->cs)))
+	& SPI_FRAME_BITS_MASK)
+		== SPI_FRAME_BITS(8)) ? 0 : 1;
 }
 
 static void set_bit_mode(struct fsl_dspi *dspi, unsigned char bits)
 {
-	u32 temp;
+	u32 tmp;
 
-	temp = readl(dspi->base + SPI_CTAR(dspi->cs));
-	temp &= ~SPI_FRAME_BITS_MASK;
-	temp |= SPI_FRAME_BITS(bits);
-	writel(temp, dspi->base + SPI_CTAR(dspi->cs));
+	tmp = DSPI_BITWISE32(dspi, dspi_readl(dspi->base + SPI_CTAR(dspi->cs)));
+	tmp &= ~SPI_FRAME_BITS_MASK;
+	tmp |= SPI_FRAME_BITS(bits);
+	dspi_writel(DSPI_BITWISE32(dspi, tmp), dspi->base + SPI_CTAR(dspi->cs));
 }
 
 static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
@@ -165,7 +178,7 @@ static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 			}
 		}
 
-	pr_warn("Can not find valid baud rate,speed_hz is %d,clkrate is %ld\
+	pr_warn("Can not find valid baud rate,speed_hz is %d,clkrate is %ld
 		,we use the max prescaler value.\n", speed_hz, clkrate);
 	*pbr = ARRAY_SIZE(pbr_tbl) - 1;
 	*br =  ARRAY_SIZE(brs) - 1;
@@ -212,7 +225,6 @@ static int dspi_transfer_write(struct fsl_dspi *dspi)
 			dspi->len -= 2;
 		} else {
 			if (!(dspi->dataflags & TRAN_STATE_TX_VOID)) {
-
 				d8 = *(u8 *)dspi->tx;
 				dspi->tx++;
 			} else {
@@ -238,7 +250,8 @@ static int dspi_transfer_write(struct fsl_dspi *dspi)
 			dspi_pushr |= SPI_PUSHR_CTCNT; /* clear counter */
 		}
 
-		writel(dspi_pushr, dspi->base + SPI_PUSHR);
+		dspi_writel(DSPI_BITWISE32(dspi, dspi_pushr),
+				dspi->base + SPI_PUSHR);
 		tx_count++;
 	}
 
@@ -256,14 +269,15 @@ static int dspi_transfer_read(struct fsl_dspi *dspi)
 			if ((dspi->rx_end - dspi->rx) == 1)
 				break;
 
-			d = SPI_POPR_RXDATA(readl(dspi->base + SPI_POPR));
+			d = DSPI_BITWISE16(dspi,
+					dspi_readl(dspi->base + SPI_POPR));
 
 			if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
 				*(u16 *)dspi->rx = d;
 			dspi->rx += 2;
 
 		} else {
-			d = SPI_POPR_RXDATA(readl(dspi->base + SPI_POPR));
+			d = dspi_readb(dspi->base + SPI_POPR);
 			if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
 				*(u8 *)dspi->rx = d;
 			dspi->rx++;
@@ -295,12 +309,15 @@ static int dspi_txrx_transfer(struct spi_device *spi, struct spi_transfer *t)
 	if (!dspi->tx)
 		dspi->dataflags |= TRAN_STATE_TX_VOID;
 
-	writel(dspi->cur_chip->mcr_val, dspi->base + SPI_MCR);
-	writel(dspi->cur_chip->ctar_val, dspi->base + SPI_CTAR(dspi->cs));
-	writel(SPI_RSER_EOQFE, dspi->base + SPI_RSER);
+	dspi_writel(DSPI_BITWISE32(dspi, dspi->cur_chip->mcr_val),
+			dspi->base + SPI_MCR);
+	dspi_writel(DSPI_BITWISE32(dspi, dspi->cur_chip->ctar_val),
+			dspi->base + SPI_CTAR(dspi->cs));
+	dspi_writel(DSPI_BITWISE32(dspi, SPI_RSER_EOQFE),
+			dspi->base + SPI_RSER);
 
 	if (t->speed_hz)
-		writel(dspi->cur_chip->ctar_val,
+		dspi_writel(DSPI_BITWISE32(dspi, dspi->cur_chip->ctar_val),
 				dspi->base + SPI_CTAR(dspi->cs));
 
 	dspi_transfer_write(dspi);
@@ -315,7 +332,7 @@ static int dspi_txrx_transfer(struct spi_device *spi, struct spi_transfer *t)
 static void dspi_chipselect(struct spi_device *spi, int value)
 {
 	struct fsl_dspi *dspi = spi_master_get_devdata(spi->master);
-	u32 pushr = readl(dspi->base + SPI_PUSHR);
+	u32 pushr = DSPI_BITWISE32(dspi, dspi_readl(dspi->base + SPI_PUSHR));
 
 	switch (value) {
 	case BITBANG_CS_ACTIVE:
@@ -324,7 +341,7 @@ static void dspi_chipselect(struct spi_device *spi, int value)
 		pushr &= ~SPI_PUSHR_CONT;
 	}
 
-	writel(pushr, dspi->base + SPI_PUSHR);
+	dspi_writel(DSPI_BITWISE32(dspi, pushr), dspi->base + SPI_PUSHR);
 }
 
 static int dspi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
@@ -383,13 +400,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
 
-	writel(SPI_SR_EOQF, dspi->base + SPI_SR);
+	dspi_writel(DSPI_BITWISE32(dspi, SPI_SR_EOQF), dspi->base + SPI_SR);
 
 	dspi_transfer_read(dspi);
 
 	if (!dspi->len) {
 		if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM)
 			set_bit_mode(dspi, 16);
+
 		dspi->waitflags = 1;
 		wake_up_interruptible(&dspi->waitq);
 	} else {
@@ -507,6 +525,8 @@ static int dspi_probe(struct platform_device *pdev)
 	init_waitqueue_head(&dspi->waitq);
 	platform_set_drvdata(pdev, dspi);
 
+	dspi->big_endian = of_property_read_bool(np, "big-endian");
+
 	ret = spi_bitbang_start(&dspi->bitbang);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Problem registering DSPI master\n");
-- 
1.8.4
