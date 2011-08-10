From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 10 Aug 2011 14:20:54 +0530
Subject: [PATCH V2 1/6] spi/spi-pl022: Resolve formatting issues
In-Reply-To: <cover.1312965741.git.viresh.kumar@st.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
Message-ID: <a72e7189be95278b97614fe9ab7d307d422d54e4.1312965741.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There were few formatting related issues in code. This patch fixes them.
Fixes include:
- Remove extra blank lines
- align code to 80 cols
- combine several lines to one line
- Replace multiple spaces with tabs
- Remove spaces before labels

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c |   54 +++++++++++++++++-----------------------------
 1 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 730b4a3..f600d00 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -113,7 +113,6 @@
 #define SSP_CR0_MASK_CSS_ST	(0x1FUL << 16)
 #define SSP_CR0_MASK_FRF_ST	(0x3UL << 21)
 
-
 /*
  * SSP Control Register 0  - SSP_CR1
  */
@@ -283,7 +282,6 @@
 
 #define SPI_POLLING_TIMEOUT 1000
 
-
 /*
  * The type of reading going on on this chip
  */
@@ -752,7 +750,6 @@ static void readwriter(struct pl022 *pl022)
 	 */
 }
 
-
 /**
  * next_transfer - Move to the Next transfer in the current spi message
  * @pl022: SSP driver private data structure
@@ -1534,8 +1531,7 @@ static void pump_messages(struct work_struct *work)
 	/* Initial message state */
 	pl022->cur_msg->state = STATE_START;
 	pl022->cur_transfer = list_entry(pl022->cur_msg->transfers.next,
-					    struct spi_transfer,
-					    transfer_list);
+					    struct spi_transfer, transfer_list);
 
 	/* Setup the SPI using the per chip configuration */
 	pl022->cur_chip = spi_get_ctldata(pl022->cur_msg->spi);
@@ -1557,7 +1553,6 @@ static void pump_messages(struct work_struct *work)
 		do_interrupt_dma_transfer(pl022);
 }
 
-
 static int __init init_queue(struct pl022 *pl022)
 {
 	INIT_LIST_HEAD(&pl022->queue);
@@ -1566,8 +1561,8 @@ static int __init init_queue(struct pl022 *pl022)
 	pl022->running = false;
 	pl022->busy = false;
 
-	tasklet_init(&pl022->pump_transfers,
-			pump_transfers,	(unsigned long)pl022);
+	tasklet_init(&pl022->pump_transfers, pump_transfers,
+			(unsigned long)pl022);
 
 	INIT_WORK(&pl022->pump_messages, pump_messages);
 	pl022->workqueue = create_singlethread_workqueue(
@@ -1578,7 +1573,6 @@ static int __init init_queue(struct pl022 *pl022)
 	return 0;
 }
 
-
 static int start_queue(struct pl022 *pl022)
 {
 	unsigned long flags;
@@ -1601,7 +1595,6 @@ static int start_queue(struct pl022 *pl022)
 	return 0;
 }
 
-
 static int stop_queue(struct pl022 *pl022)
 {
 	unsigned long flags;
@@ -1861,7 +1854,6 @@ static int calculate_effective_freq(struct pl022 *pl022,
 	return 0;
 }
 
-
 /*
  * A piece of default chip info unless the platform
  * supplies it.
@@ -1879,7 +1871,6 @@ static const struct pl022_config_chip pl022_default_chip_info = {
 	.cs_control = null_cs_control,
 };
 
-
 /**
  * pl022_setup - setup function registered to SPI master framework
  * @spi: spi device which is requesting setup
@@ -1956,7 +1947,6 @@ static int pl022_setup(struct spi_device *spi)
 		goto err_config_params;
 	}
 
-
 	status = verify_controller_parameters(pl022, chip_info);
 	if (status) {
 		dev_err(&spi->dev, "controller data is incorrect");
@@ -2096,12 +2086,13 @@ static int pl022_setup(struct spi_device *spi)
 	}
 	SSP_WRITE_BITS(chip->cr1, SSP_DISABLED, SSP_CR1_MASK_SSE, 1);
 	SSP_WRITE_BITS(chip->cr1, chip_info->hierarchy, SSP_CR1_MASK_MS, 2);
-	SSP_WRITE_BITS(chip->cr1, chip_info->slave_tx_disable, SSP_CR1_MASK_SOD, 3);
+	SSP_WRITE_BITS(chip->cr1, chip_info->slave_tx_disable, SSP_CR1_MASK_SOD,
+		3);
 
 	/* Save controller_state */
 	spi_set_ctldata(spi, chip);
 	return status;
- err_config_params:
+err_config_params:
 	spi_set_ctldata(spi, NULL);
 	kfree(chip);
 	return status;
@@ -2122,7 +2113,6 @@ static void pl022_cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-
 static int __devinit
 pl022_probe(struct amba_device *adev, const struct amba_id *id)
 {
@@ -2243,23 +2233,23 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	amba_vcore_disable(adev);
 	return 0;
 
- err_spi_register:
- err_start_queue:
- err_init_queue:
+err_spi_register:
+err_start_queue:
+err_init_queue:
 	destroy_queue(pl022);
 	pl022_dma_remove(pl022);
 	free_irq(adev->irq[0], pl022);
 	pm_runtime_disable(&adev->dev);
- err_no_irq:
+err_no_irq:
 	clk_put(pl022->clk);
- err_no_clk:
+err_no_clk:
 	iounmap(pl022->virtbase);
- err_no_ioremap:
+err_no_ioremap:
 	amba_release_regions(adev);
- err_no_ioregion:
+err_no_ioregion:
 	spi_master_put(master);
- err_no_master:
- err_no_pdata:
+err_no_master:
+err_no_pdata:
 	return status;
 }
 
@@ -2337,7 +2327,6 @@ static struct vendor_data vendor_arm = {
 	.loopback = true,
 };
 
-
 static struct vendor_data vendor_st = {
 	.fifodepth = 32,
 	.max_bpw = 32,
@@ -2392,9 +2381,9 @@ static struct amba_id pl022_ids[] = {
 		 * and 32 locations deep TX/RX FIFO but no extended
 		 * CR0/CR1 register
 		 */
-		.id     = 0x00080023,
-		.mask   = 0xffffffff,
-		.data   = &vendor_st_pl023,
+		.id	= 0x00080023,
+		.mask	= 0xffffffff,
+		.data	= &vendor_st_pl023,
 	},
 	{
 		.id	= 0x10080023,
@@ -2411,23 +2400,20 @@ static struct amba_driver pl022_driver = {
 	.id_table	= pl022_ids,
 	.probe		= pl022_probe,
 	.remove		= __devexit_p(pl022_remove),
-	.suspend        = pl022_suspend,
-	.resume         = pl022_resume,
+	.suspend	= pl022_suspend,
+	.resume		= pl022_resume,
 };
 
-
 static int __init pl022_init(void)
 {
 	return amba_driver_register(&pl022_driver);
 }
-
 subsys_initcall(pl022_init);
 
 static void __exit pl022_exit(void)
 {
 	amba_driver_unregister(&pl022_driver);
 }
-
 module_exit(pl022_exit);
 
 MODULE_AUTHOR("Linus Walleij <linus.walleij@stericsson.com>");
-- 
1.7.2.2
