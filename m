From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 09 May 2012 03:34:46 +0530
Subject: [PATCH 02/10] spi: s3c64xx: move controller information into driver
 data
In-Reply-To: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1336514694-22393-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform data is used to specify controller hardware specific information
such as the tx/rx fifo level mask and bit offset of rx fifo level. Such
information is not suitable to be supplied from device tree. Instead,
it can be moved into the driver data and removed from platform data.

Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/spi/spi-s3c64xx.c |  180 ++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 153 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6a3d51a..f6bc0e3 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -31,6 +31,8 @@
 #include <mach/dma.h>
 #include <plat/s3c64xx-spi.h>
 
+#define MAX_SPI_PORTS		3
+
 /* Registers and bit-fields */
 
 #define S3C64XX_SPI_CH_CFG		0x00
@@ -113,9 +115,12 @@
 
 #define S3C64XX_SPI_FBCLK_MSK		(3<<0)
 
-#define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & (1 << (i)->tx_st_done)) ? 1 : 0)
-#define TX_FIFO_LVL(v, i) (((v) >> 6) & (i)->fifo_lvl_mask)
-#define RX_FIFO_LVL(v, i) (((v) >> (i)->rx_lvl_offset) & (i)->fifo_lvl_mask)
+#define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
+#define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
+				(1 << (i)->port_conf->tx_st_done)) ? 1 : 0)
+#define TX_FIFO_LVL(v, i) (((v) >> 6) & FIFO_LVL_MASK(i))
+#define RX_FIFO_LVL(v, i) (((v) >> (i)->port_conf->rx_lvl_offset) & \
+					FIFO_LVL_MASK(i))
 
 #define S3C64XX_SPI_MAX_TRAILCNT	0x3ff
 #define S3C64XX_SPI_TRAILCNT_OFF	19
@@ -134,6 +139,28 @@ struct s3c64xx_spi_dma_data {
 };
 
 /**
+ * struct s3c64xx_spi_info - SPI Controller hardware info
+ * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
+ * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
+ * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
+ * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
+ * @clk_from_cmu: True, if the controller does not include a clock mux and
+ *	prescaler unit.
+ *
+ * The Samsung s3c64xx SPI controller are used on various Samsung SoC's but
+ * differ in some aspects such as the size of the fifo and spi bus clock
+ * setup. Such differences are specified to the driver using this structure
+ * which is provided as driver data to the driver.
+ */
+struct s3c64xx_spi_port_config {
+	int	fifo_lvl_mask[MAX_SPI_PORTS];
+	int	rx_lvl_offset;
+	int	tx_st_done;
+	bool	high_speed;
+	bool	clk_from_cmu;
+};
+
+/**
  * struct s3c64xx_spi_driver_data - Runtime info holder for SPI driver.
  * @clk: Pointer to the spi clock.
  * @src_clk: Pointer to the clock used to generate SPI signals.
@@ -171,6 +198,8 @@ struct s3c64xx_spi_driver_data {
 	struct s3c64xx_spi_dma_data	rx_dma;
 	struct s3c64xx_spi_dma_data	tx_dma;
 	struct samsung_dma_ops		*ops;
+	struct s3c64xx_spi_port_config	*port_conf;
+	unsigned			port_id;
 };
 
 static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
@@ -179,7 +208,6 @@ static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
 
 static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 {
-	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	unsigned long loops;
 	u32 val;
@@ -195,7 +223,7 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	loops = msecs_to_loops(1);
 	do {
 		val = readl(regs + S3C64XX_SPI_STATUS);
-	} while (TX_FIFO_LVL(val, sci) && loops--);
+	} while (TX_FIFO_LVL(val, sdd) && loops--);
 
 	if (loops == 0)
 		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
@@ -204,7 +232,7 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	loops = msecs_to_loops(1);
 	do {
 		val = readl(regs + S3C64XX_SPI_STATUS);
-		if (RX_FIFO_LVL(val, sci))
+		if (RX_FIFO_LVL(val, sdd))
 			readl(regs + S3C64XX_SPI_RX_DATA);
 		else
 			break;
@@ -302,7 +330,6 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 				struct spi_device *spi,
 				struct spi_transfer *xfer, int dma_mode)
 {
-	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	u32 modecfg, chcfg;
 
@@ -352,7 +379,7 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 	if (xfer->rx_buf != NULL) {
 		sdd->state |= RXBUSY;
 
-		if (sci->high_speed && sdd->cur_speed >= 30000000UL
+		if (sdd->port_conf->high_speed && sdd->cur_speed >= 30000000UL
 					&& !(sdd->cur_mode & SPI_CPHA))
 			chcfg |= S3C64XX_SPI_CH_HS_EN;
 
@@ -392,7 +419,6 @@ static inline void enable_cs(struct s3c64xx_spi_driver_data *sdd,
 static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
 				struct spi_transfer *xfer, int dma_mode)
 {
-	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	unsigned long val;
 	int ms;
@@ -409,7 +435,7 @@ static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
 		val = msecs_to_loops(ms);
 		do {
 			status = readl(regs + S3C64XX_SPI_STATUS);
-		} while (RX_FIFO_LVL(status, sci) < xfer->len && --val);
+		} while (RX_FIFO_LVL(status, sdd) < xfer->len && --val);
 	}
 
 	if (!val)
@@ -428,8 +454,8 @@ static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
 		if (xfer->rx_buf == NULL) {
 			val = msecs_to_loops(10);
 			status = readl(regs + S3C64XX_SPI_STATUS);
-			while ((TX_FIFO_LVL(status, sci)
-				|| !S3C64XX_SPI_ST_TX_DONE(status, sci))
+			while ((TX_FIFO_LVL(status, sdd)
+				|| !S3C64XX_SPI_ST_TX_DONE(status, sdd))
 					&& --val) {
 				cpu_relax();
 				status = readl(regs + S3C64XX_SPI_STATUS);
@@ -478,12 +504,11 @@ static inline void disable_cs(struct s3c64xx_spi_driver_data *sdd,
 
 static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 {
-	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	void __iomem *regs = sdd->regs;
 	u32 val;
 
 	/* Disable Clock */
-	if (sci->clk_from_cmu) {
+	if (sdd->port_conf->clk_from_cmu) {
 		clk_disable(sdd->src_clk);
 	} else {
 		val = readl(regs + S3C64XX_SPI_CLK_CFG);
@@ -527,7 +552,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
-	if (sci->clk_from_cmu) {
+	if (sdd->port_conf->clk_from_cmu) {
 		/* Configure Clock */
 		/* There is half-multiplier before the SPI */
 		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
@@ -553,7 +578,6 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
 						struct spi_message *msg)
 {
-	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	struct device *dev = &sdd->pdev->dev;
 	struct spi_transfer *xfer;
 
@@ -569,7 +593,7 @@ static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
 	/* Map until end or first fail */
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 
-		if (xfer->len <= ((sci->fifo_lvl_mask >> 1) + 1))
+		if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
 			continue;
 
 		if (xfer->tx_buf != NULL) {
@@ -603,7 +627,6 @@ static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
 static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
 						struct spi_message *msg)
 {
-	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	struct device *dev = &sdd->pdev->dev;
 	struct spi_transfer *xfer;
 
@@ -612,7 +635,7 @@ static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 
-		if (xfer->len <= ((sci->fifo_lvl_mask >> 1) + 1))
+		if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
 			continue;
 
 		if (xfer->rx_buf != NULL
@@ -631,7 +654,6 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
 					    struct spi_message *msg)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
-	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	struct spi_device *spi = msg->spi;
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 	struct spi_transfer *xfer;
@@ -686,7 +708,7 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
 		}
 
 		/* Polling method for xfers not bigger than FIFO capacity */
-		if (xfer->len <= ((sci->fifo_lvl_mask >> 1) + 1))
+		if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
 			use_dma = 0;
 		else
 			use_dma = 1;
@@ -840,7 +862,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	pm_runtime_get_sync(&sdd->pdev->dev);
 
 	/* Check if we can provide the requested rate */
-	if (!sci->clk_from_cmu) {
+	if (!sdd->port_conf->clk_from_cmu) {
 		u32 psr, speed;
 
 		/* Max possible */
@@ -921,7 +943,7 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 	/* Disable Interrupts - we use Polling if not DMA mode */
 	writel(0, regs + S3C64XX_SPI_INT_EN);
 
-	if (!sci->clk_from_cmu)
+	if (!sdd->port_conf->clk_from_cmu)
 		writel(sci->src_clk_nr << S3C64XX_SPI_CLKSEL_SRCSHFT,
 				regs + S3C64XX_SPI_CLK_CFG);
 	writel(0, regs + S3C64XX_SPI_MODE_CFG);
@@ -942,6 +964,13 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 	flush_fifo(sdd);
 }
 
+static inline struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
+						struct platform_device *pdev)
+{
+	return (struct s3c64xx_spi_port_config *)
+			 platform_get_device_id(pdev)->driver_data;
+}
+
 static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 {
 	struct resource	*mem_res, *dmatx_res, *dmarx_res;
@@ -1000,6 +1029,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	sdd = spi_master_get_devdata(master);
+	sdd->port_conf = s3c64xx_spi_get_port_config(pdev);
 	sdd->master = master;
 	sdd->cntrlr_info = sci;
 	sdd->pdev = pdev;
@@ -1008,10 +1038,11 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
 	sdd->rx_dma.dmach = dmarx_res->start;
 	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
+	sdd->port_id = pdev->id;
 
 	sdd->cur_bpw = 8;
 
-	master->bus_num = pdev->id;
+	master->bus_num = sdd->port_id;
 	master->setup = s3c64xx_spi_setup;
 	master->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
 	master->transfer_one_message = s3c64xx_spi_transfer_one_message;
@@ -1071,7 +1102,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	}
 
 	/* Setup Deufult Mode */
-	s3c64xx_spi_hwinit(sdd, pdev->id);
+	s3c64xx_spi_hwinit(sdd, sdd->port_id);
 
 	spin_lock_init(&sdd->lock);
 	init_completion(&sdd->xfer_completion);
@@ -1096,7 +1127,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d "
 					"with %d Slaves attached\n",
-					pdev->id, master->num_chipselect);
+					sdd->port_id, master->num_chipselect);
 	dev_dbg(&pdev->dev, "\tIOmem=[0x%x-0x%x]\tDMA=[Rx-%d, Tx-%d]\n",
 					mem_res->end, mem_res->start,
 					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
@@ -1189,7 +1220,7 @@ static int s3c64xx_spi_resume(struct device *dev)
 	clk_enable(sdd->src_clk);
 	clk_enable(sdd->clk);
 
-	s3c64xx_spi_hwinit(sdd, pdev->id);
+	s3c64xx_spi_hwinit(sdd, sdd->port_id);
 
 	spi_master_resume(master);
 
@@ -1227,6 +1258,100 @@ static const struct dev_pm_ops s3c64xx_spi_pm = {
 			   s3c64xx_spi_runtime_resume, NULL)
 };
 
+#if defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2443)
+struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
+	.fifo_lvl_mask	= { 0x7f },
+	.rx_lvl_offset	= 13,
+	.tx_st_done	= 21,
+	.high_speed	= true,
+};
+#define S3C2443_SPI_PORT_CONFIG ((kernel_ulong_t)&s3c2443_spi_port_config)
+#else
+#define S3C2443_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
+#endif
+
+#ifdef CONFIG_ARCH_S3C64XX
+struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
+	.fifo_lvl_mask	= { 0x7f, 0x7F },
+	.rx_lvl_offset	= 13,
+	.tx_st_done	= 21,
+};
+#define S3C6410_SPI_PORT_CONFIG ((kernel_ulong_t)&s3c6410_spi_port_config)
+#else
+#define S3C6410_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
+#endif /* CONFIG_ARCH_S3C64XX */
+
+#ifdef CONFIG_ARCH_S5P64X0
+struct s3c64xx_spi_port_config s5p64x0_spi_port_config = {
+	.fifo_lvl_mask	= { 0x1ff, 0x7F },
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+};
+#define S5P64X0_SPI_PORT_CONFIG ((kernel_ulong_t)&s5p64x0_spi_port_config)
+#else
+#define S5P64X0_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
+#endif /* CONFIG_ARCH_S5P64X0 */
+
+#ifdef CONFIG_ARCH_S5PC100
+struct s3c64xx_spi_port_config s5pc100_spi_port_config = {
+	.fifo_lvl_mask	= { 0x7f, 0x7F },
+	.rx_lvl_offset	= 13,
+	.tx_st_done	= 21,
+	.high_speed	= true,
+};
+#define S5PC100_SPI_PORT_CONFIG ((kernel_ulong_t)&s5pc100_spi_port_config)
+#else
+#define S5PC100_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
+#endif /* CONFIG_ARCH_S5PC100 */
+
+#ifdef CONFIG_ARCH_S5PV210
+struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
+	.fifo_lvl_mask	= { 0x1ff, 0x7F },
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.high_speed	= 1,
+};
+#define S5PV210_SPI_PORT_CONFIG ((kernel_ulong_t)&s5pv210_spi_port_config)
+#else
+#define S5PV210_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
+#endif /* CONFIG_ARCH_S5PV210 */
+
+#ifdef CONFIG_ARCH_EXYNOS4
+struct s3c64xx_spi_port_config exynos4_spi_port_config = {
+	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F },
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.high_speed	= 1,
+	.clk_from_cmu	= true,
+};
+#define EXYNOS4_SPI_PORT_CONFIG ((kernel_ulong_t)&exynos4_spi_port_config)
+#else
+#define EXYNOS4_SPI_PORT_CONFIG ((kernel_ulong_t)NULL)
+#endif /* CONFIG_ARCH_EXYNOS4 */
+
+static struct platform_device_id s3c64xx_spi_driver_ids[] = {
+	{
+		.name		= "s3c2443-spi",
+		.driver_data	= S3C2443_SPI_PORT_CONFIG,
+	}, {
+		.name		= "s3c6410-spi",
+		.driver_data	= S3C6410_SPI_PORT_CONFIG,
+	}, {
+		.name		= "s5p64x0-spi",
+		.driver_data	= S5P64X0_SPI_PORT_CONFIG,
+	}, {
+		.name		= "s5pc100-spi",
+		.driver_data	= S5PC100_SPI_PORT_CONFIG,
+	}, {
+		.name		= "s5pv210-spi",
+		.driver_data	= S5PV210_SPI_PORT_CONFIG,
+	}, {
+		.name		= "exynos4210-spi",
+		.driver_data	= EXYNOS4_SPI_PORT_CONFIG,
+	},
+	{ },
+};
+
 static struct platform_driver s3c64xx_spi_driver = {
 	.driver = {
 		.name	= "s3c64xx-spi",
@@ -1234,6 +1359,7 @@ static struct platform_driver s3c64xx_spi_driver = {
 		.pm = &s3c64xx_spi_pm,
 	},
 	.remove = s3c64xx_spi_remove,
+	.id_table = s3c64xx_spi_driver_ids,
 };
 MODULE_ALIAS("platform:s3c64xx-spi");
 
-- 
1.6.6.rc2
