From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed,  5 May 2010 11:28:15 +0200
Subject: [PATCH] SPI: fix up some PL022 confusion
Message-ID: <1273051695-32251-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL022 SPI driver did not cleanly separate between the
original unmodified ARM version and the ST Microelectronics
versions. Split this more cleanly and fix some whitespace
moaning from checkpatch at the same time.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: STEricsson_nomadik_linux at list.st.com
Cc: Alessandro Rubini <rubini@unipv.it>
---
 drivers/spi/amba-pl022.c   |  178 ++++++++++++++++++++++++++++++--------------
 include/linux/amba/pl022.h |    4 +-
 2 files changed, 125 insertions(+), 57 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 53f0acd..c97c5bb 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -105,13 +105,21 @@
 /*
  * SSP Control Register 0  - SSP_CR0
  */
-#define SSP_CR0_MASK_DSS	(0x1FUL << 0)
-#define SSP_CR0_MASK_HALFDUP	(0x1UL << 5)
+#define SSP_CR0_MASK_DSS	(0x0FUL << 0)
+#define SSP_CR0_MASK_FRF	(0x3UL << 4)
 #define SSP_CR0_MASK_SPO	(0x1UL << 6)
 #define SSP_CR0_MASK_SPH	(0x1UL << 7)
 #define SSP_CR0_MASK_SCR	(0xFFUL << 8)
-#define SSP_CR0_MASK_CSS	(0x1FUL << 16)
-#define SSP_CR0_MASK_FRF	(0x3UL << 21)
+
+/*
+ * The ST version of this block moves som bits
+ * in SSP_CR0 and extends it to 32 bits
+ */
+#define SSP_CR0_MASK_DSS_ST	(0x1FUL << 0)
+#define SSP_CR0_MASK_HALFDUP_ST	(0x1UL << 5)
+#define SSP_CR0_MASK_CSS_ST	(0x1FUL << 16)
+#define SSP_CR0_MASK_FRF_ST	(0x3UL << 21)
+
 
 /*
  * SSP Control Register 0  - SSP_CR1
@@ -120,16 +128,16 @@
 #define SSP_CR1_MASK_SSE	(0x1UL << 1)
 #define SSP_CR1_MASK_MS		(0x1UL << 2)
 #define SSP_CR1_MASK_SOD	(0x1UL << 3)
-#define SSP_CR1_MASK_RENDN	(0x1UL << 4)
-#define SSP_CR1_MASK_TENDN	(0x1UL << 5)
-#define SSP_CR1_MASK_MWAIT	(0x1UL << 6)
-#define SSP_CR1_MASK_RXIFLSEL	(0x7UL << 7)
-#define SSP_CR1_MASK_TXIFLSEL	(0x7UL << 10)
 
 /*
- * SSP Data Register - SSP_DR
+ * The ST version of this block adds some bits
+ * in SSP_CR1
  */
-#define SSP_DR_MASK_DATA	0xFFFFFFFF
+#define SSP_CR1_MASK_RENDN_ST	(0x1UL << 4)
+#define SSP_CR1_MASK_TENDN_ST	(0x1UL << 5)
+#define SSP_CR1_MASK_MWAIT_ST	(0x1UL << 6)
+#define SSP_CR1_MASK_RXIFLSEL_ST (0x7UL << 7)
+#define SSP_CR1_MASK_TXIFLSEL_ST (0x7UL << 10)
 
 /*
  * SSP Status Register - SSP_SR
@@ -137,7 +145,7 @@
 #define SSP_SR_MASK_TFE		(0x1UL << 0) /* Transmit FIFO empty */
 #define SSP_SR_MASK_TNF		(0x1UL << 1) /* Transmit FIFO not full */
 #define SSP_SR_MASK_RNE		(0x1UL << 2) /* Receive FIFO not empty */
-#define SSP_SR_MASK_RFF 	(0x1UL << 3) /* Receive FIFO full */
+#define SSP_SR_MASK_RFF		(0x1UL << 3) /* Receive FIFO full */
 #define SSP_SR_MASK_BSY		(0x1UL << 4) /* Busy Flag */
 
 /*
@@ -230,7 +238,7 @@
 /*
  * SSP Test Data Register - SSP_TDR
  */
-#define TDR_MASK_TESTDATA 		(0xFFFFFFFF)
+#define TDR_MASK_TESTDATA		(0xFFFFFFFF)
 
 /*
  * Message State
@@ -238,33 +246,33 @@
  * hold a single state value, that's why all this
  * (void *) casting is done here.
  */
-#define STATE_START                     ((void *) 0)
-#define STATE_RUNNING                   ((void *) 1)
-#define STATE_DONE                      ((void *) 2)
-#define STATE_ERROR                     ((void *) -1)
+#define STATE_START			((void *) 0)
+#define STATE_RUNNING			((void *) 1)
+#define STATE_DONE			((void *) 2)
+#define STATE_ERROR			((void *) -1)
 
 /*
  * Queue State
  */
-#define QUEUE_RUNNING                   (0)
-#define QUEUE_STOPPED                   (1)
+#define QUEUE_RUNNING			(0)
+#define QUEUE_STOPPED			(1)
 /*
  * SSP State - Whether Enabled or Disabled
  */
-#define SSP_DISABLED 			(0)
-#define SSP_ENABLED 			(1)
+#define SSP_DISABLED			(0)
+#define SSP_ENABLED			(1)
 
 /*
  * SSP DMA State - Whether DMA Enabled or Disabled
  */
-#define SSP_DMA_DISABLED 		(0)
-#define SSP_DMA_ENABLED 		(1)
+#define SSP_DMA_DISABLED		(0)
+#define SSP_DMA_ENABLED			(1)
 
 /*
  * SSP Clock Defaults
  */
-#define NMDK_SSP_DEFAULT_CLKRATE 0x2
-#define NMDK_SSP_DEFAULT_PRESCALE 0x40
+#define SSP_DEFAULT_CLKRATE 0x2
+#define SSP_DEFAULT_PRESCALE 0x40
 
 /*
  * SSP Clock Parameter ranges
@@ -310,16 +318,20 @@ enum ssp_writing {
  * @fifodepth: depth of FIFOs (both)
  * @max_bpw: maximum number of bits per word
  * @unidir: supports unidirection transfers
+ * @extended_cr: 32 bit wide control register 0 with extra
+ * features and extra features in CR1 as found in the ST variants
  */
 struct vendor_data {
 	int fifodepth;
 	int max_bpw;
 	bool unidir;
+	bool extended_cr;
 };
 
 /**
  * struct pl022 - This is the private SSP driver data structure
  * @adev: AMBA device model hookup
+ * @vendor: Vendor data for the IP block
  * @phybase: The physical memory where the SSP device resides
  * @virtbase: The virtual memory where the SSP is mapped
  * @master: SPI framework hookup
@@ -380,7 +392,8 @@ struct pl022 {
 
 /**
  * struct chip_data - To maintain runtime state of SSP for each client chip
- * @cr0: Value of control register CR0 of SSP
+ * @cr0: Value of control register CR0 of SSP - on later ST variants this
+ *       register is 32 bits wide rather than just 16
  * @cr1: Value of control register CR1 of SSP
  * @dmacr: Value of DMA control Register of SSP
  * @cpsr: Value of Clock prescale register
@@ -395,7 +408,7 @@ struct pl022 {
  * This would be set according to the current message that would be served
  */
 struct chip_data {
-	u16 cr0;
+	u32 cr0;
 	u16 cr1;
 	u16 dmacr;
 	u16 cpsr;
@@ -528,7 +541,10 @@ static void restore_state(struct pl022 *pl022)
 {
 	struct chip_data *chip = pl022->cur_chip;
 
-	writew(chip->cr0, SSP_CR0(pl022->virtbase));
+	if (pl022->vendor->extended_cr)
+		writel(chip->cr0, SSP_CR0(pl022->virtbase));
+	else
+		writew(chip->cr0, SSP_CR0(pl022->virtbase));
 	writew(chip->cr1, SSP_CR1(pl022->virtbase));
 	writew(chip->dmacr, SSP_DMACR(pl022->virtbase));
 	writew(chip->cpsr, SSP_CPSR(pl022->virtbase));
@@ -546,28 +562,43 @@ static void restore_state(struct pl022 *pl022)
  */
 #define DEFAULT_SSP_REG_CR0 ( \
 	GEN_MASK_BITS(SSP_DATA_BITS_12, SSP_CR0_MASK_DSS, 0)	| \
-	GEN_MASK_BITS(SSP_MICROWIRE_CHANNEL_FULL_DUPLEX, SSP_CR0_MASK_HALFDUP, 5) | \
+	GEN_MASK_BITS(SSP_INTERFACE_MOTOROLA_SPI, SSP_CR0_MASK_FRF, 4) | \
+	GEN_MASK_BITS(SSP_CLK_POL_IDLE_LOW, SSP_CR0_MASK_SPO, 6) | \
+	GEN_MASK_BITS(SSP_CLK_SECOND_EDGE, SSP_CR0_MASK_SPH, 7) | \
+	GEN_MASK_BITS(SSP_DEFAULT_CLKRATE, SSP_CR0_MASK_SCR, 8) \
+)
+
+/* ST versions have slightly different bit layout */
+#define DEFAULT_SSP_REG_CR0_ST ( \
+	GEN_MASK_BITS(SSP_DATA_BITS_12, SSP_CR0_MASK_DSS_ST, 0)	| \
+	GEN_MASK_BITS(SSP_MICROWIRE_CHANNEL_FULL_DUPLEX, SSP_CR0_MASK_HALFDUP_ST, 5) | \
 	GEN_MASK_BITS(SSP_CLK_POL_IDLE_LOW, SSP_CR0_MASK_SPO, 6) | \
 	GEN_MASK_BITS(SSP_CLK_SECOND_EDGE, SSP_CR0_MASK_SPH, 7) | \
-	GEN_MASK_BITS(NMDK_SSP_DEFAULT_CLKRATE, SSP_CR0_MASK_SCR, 8) | \
-	GEN_MASK_BITS(SSP_BITS_8, SSP_CR0_MASK_CSS, 16)	| \
-	GEN_MASK_BITS(SSP_INTERFACE_MOTOROLA_SPI, SSP_CR0_MASK_FRF, 21) \
+	GEN_MASK_BITS(SSP_DEFAULT_CLKRATE, SSP_CR0_MASK_SCR, 8) | \
+	GEN_MASK_BITS(SSP_BITS_8, SSP_CR0_MASK_CSS_ST, 16)	| \
+	GEN_MASK_BITS(SSP_INTERFACE_MOTOROLA_SPI, SSP_CR0_MASK_FRF_ST, 21) \
 )
 
 #define DEFAULT_SSP_REG_CR1 ( \
 	GEN_MASK_BITS(LOOPBACK_DISABLED, SSP_CR1_MASK_LBM, 0) | \
 	GEN_MASK_BITS(SSP_DISABLED, SSP_CR1_MASK_SSE, 1) | \
 	GEN_MASK_BITS(SSP_MASTER, SSP_CR1_MASK_MS, 2) | \
-	GEN_MASK_BITS(DO_NOT_DRIVE_TX, SSP_CR1_MASK_SOD, 3) | \
-	GEN_MASK_BITS(SSP_RX_MSB, SSP_CR1_MASK_RENDN, 4) | \
-	GEN_MASK_BITS(SSP_TX_MSB, SSP_CR1_MASK_TENDN, 5) | \
-	GEN_MASK_BITS(SSP_MWIRE_WAIT_ZERO, SSP_CR1_MASK_MWAIT, 6) |\
-	GEN_MASK_BITS(SSP_RX_1_OR_MORE_ELEM, SSP_CR1_MASK_RXIFLSEL, 7) | \
-	GEN_MASK_BITS(SSP_TX_1_OR_MORE_EMPTY_LOC, SSP_CR1_MASK_TXIFLSEL, 10) \
+	GEN_MASK_BITS(DO_NOT_DRIVE_TX, SSP_CR1_MASK_SOD, 3) \
 )
 
+/* ST versions extend this register to use all 16 bits */
+#define DEFAULT_SSP_REG_CR1_ST ( \
+	DEFAULT_SSP_REG_CR1 | \
+	GEN_MASK_BITS(SSP_RX_MSB, SSP_CR1_MASK_RENDN_ST, 4) | \
+	GEN_MASK_BITS(SSP_TX_MSB, SSP_CR1_MASK_TENDN_ST, 5) | \
+	GEN_MASK_BITS(SSP_MWIRE_WAIT_ZERO, SSP_CR1_MASK_MWAIT_ST, 6) |\
+	GEN_MASK_BITS(SSP_RX_1_OR_MORE_ELEM, SSP_CR1_MASK_RXIFLSEL_ST, 7) | \
+	GEN_MASK_BITS(SSP_TX_1_OR_MORE_EMPTY_LOC, SSP_CR1_MASK_TXIFLSEL_ST, 10) \
+)
+
+
 #define DEFAULT_SSP_REG_CPSR ( \
-	GEN_MASK_BITS(NMDK_SSP_DEFAULT_PRESCALE, SSP_CPSR_MASK_CPSDVSR, 0) \
+	GEN_MASK_BITS(SSP_DEFAULT_PRESCALE, SSP_CPSR_MASK_CPSDVSR, 0) \
 )
 
 #define DEFAULT_SSP_REG_DMACR (\
@@ -578,8 +609,13 @@ static void restore_state(struct pl022 *pl022)
 
 static void load_ssp_default_config(struct pl022 *pl022)
 {
-	writew(DEFAULT_SSP_REG_CR0, SSP_CR0(pl022->virtbase));
-	writew(DEFAULT_SSP_REG_CR1, SSP_CR1(pl022->virtbase));
+	if (pl022->vendor->extended_cr) {
+		writel(DEFAULT_SSP_REG_CR0_ST, SSP_CR0(pl022->virtbase));
+		writew(DEFAULT_SSP_REG_CR1_ST, SSP_CR1(pl022->virtbase));
+	} else {
+		writew(DEFAULT_SSP_REG_CR0, SSP_CR0(pl022->virtbase));
+		writew(DEFAULT_SSP_REG_CR1, SSP_CR1(pl022->virtbase));
+	}
 	writew(DEFAULT_SSP_REG_DMACR, SSP_DMACR(pl022->virtbase));
 	writew(DEFAULT_SSP_REG_CPSR, SSP_CPSR(pl022->virtbase));
 	writew(DISABLE_ALL_INTERRUPTS, SSP_IMSC(pl022->virtbase));
@@ -1352,7 +1388,7 @@ static void do_polling_transfer(struct pl022 *pl022)
 		writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK_SSE),
 		       SSP_CR1(pl022->virtbase));
 
-		dev_dbg(&pl022->adev->dev, "POLLING TRANSFER ONGOING ... \n");
+		dev_dbg(&pl022->adev->dev, "polling transfer ongoing ...\n");
 		/* FIXME: insert a timeout so we don't hang here indefinately */
 		while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end)
 			readwriter(pl022);
@@ -1622,11 +1658,21 @@ static int verify_controller_parameters(struct pl022 *pl022,
 				"Wait State is configured incorrectly\n");
 			return -EINVAL;
 		}
-		if ((chip_info->duplex != SSP_MICROWIRE_CHANNEL_FULL_DUPLEX)
-		    && (chip_info->duplex !=
-			SSP_MICROWIRE_CHANNEL_HALF_DUPLEX)) {
-			dev_err(chip_info->dev,
-				"DUPLEX is configured incorrectly\n");
+		/* Half duplex is only available in the ST Micro version */
+		if (pl022->vendor->extended_cr) {
+			if ((chip_info->duplex !=
+			     SSP_MICROWIRE_CHANNEL_FULL_DUPLEX)
+			    && (chip_info->duplex !=
+				SSP_MICROWIRE_CHANNEL_HALF_DUPLEX))
+				dev_err(chip_info->dev,
+					"Microwire duplex mode is configured incorrectly\n");
+				return -EINVAL;
+		} else {
+			if (chip_info->duplex != SSP_MICROWIRE_CHANNEL_FULL_DUPLEX)
+				dev_err(chip_info->dev,
+					"Microwire half duplex mode requested,"
+					" but this is only available in the"
+					" ST version of PL022\n");
 			return -EINVAL;
 		}
 	}
@@ -1906,22 +1952,40 @@ static int pl022_setup(struct spi_device *spi)
 
 	chip->cpsr = chip_info->clk_freq.cpsdvsr;
 
-	SSP_WRITE_BITS(chip->cr0, chip_info->data_size, SSP_CR0_MASK_DSS, 0);
-	SSP_WRITE_BITS(chip->cr0, chip_info->duplex, SSP_CR0_MASK_HALFDUP, 5);
+	/* Special setup for the ST micro extended control registers */
+	if (pl022->vendor->extended_cr) {
+		SSP_WRITE_BITS(chip->cr0, chip_info->data_size,
+			       SSP_CR0_MASK_DSS_ST, 0);
+		SSP_WRITE_BITS(chip->cr0, chip_info->duplex,
+			       SSP_CR0_MASK_HALFDUP_ST, 5);
+		SSP_WRITE_BITS(chip->cr0, chip_info->ctrl_len,
+			       SSP_CR0_MASK_CSS_ST, 16);
+		SSP_WRITE_BITS(chip->cr0, chip_info->iface,
+			       SSP_CR0_MASK_FRF_ST, 21);
+		SSP_WRITE_BITS(chip->cr1, chip_info->endian_rx,
+			       SSP_CR1_MASK_RENDN_ST, 4);
+		SSP_WRITE_BITS(chip->cr1, chip_info->endian_tx,
+			       SSP_CR1_MASK_TENDN_ST, 5);
+		SSP_WRITE_BITS(chip->cr1, chip_info->wait_state,
+			       SSP_CR1_MASK_MWAIT_ST, 6);
+		SSP_WRITE_BITS(chip->cr1, chip_info->rx_lev_trig,
+			       SSP_CR1_MASK_RXIFLSEL_ST, 7);
+		SSP_WRITE_BITS(chip->cr1, chip_info->tx_lev_trig,
+			       SSP_CR1_MASK_TXIFLSEL_ST, 10);
+	} else {
+		SSP_WRITE_BITS(chip->cr0, chip_info->data_size,
+			       SSP_CR0_MASK_DSS, 0);
+		SSP_WRITE_BITS(chip->cr0, chip_info->iface,
+			       SSP_CR0_MASK_FRF, 4);
+	}
+	/* Stuff that is common for all versions */
 	SSP_WRITE_BITS(chip->cr0, chip_info->clk_pol, SSP_CR0_MASK_SPO, 6);
 	SSP_WRITE_BITS(chip->cr0, chip_info->clk_phase, SSP_CR0_MASK_SPH, 7);
 	SSP_WRITE_BITS(chip->cr0, chip_info->clk_freq.scr, SSP_CR0_MASK_SCR, 8);
-	SSP_WRITE_BITS(chip->cr0, chip_info->ctrl_len, SSP_CR0_MASK_CSS, 16);
-	SSP_WRITE_BITS(chip->cr0, chip_info->iface, SSP_CR0_MASK_FRF, 21);
 	SSP_WRITE_BITS(chip->cr1, chip_info->lbm, SSP_CR1_MASK_LBM, 0);
 	SSP_WRITE_BITS(chip->cr1, SSP_DISABLED, SSP_CR1_MASK_SSE, 1);
 	SSP_WRITE_BITS(chip->cr1, chip_info->hierarchy, SSP_CR1_MASK_MS, 2);
 	SSP_WRITE_BITS(chip->cr1, chip_info->slave_tx_disable, SSP_CR1_MASK_SOD, 3);
-	SSP_WRITE_BITS(chip->cr1, chip_info->endian_rx, SSP_CR1_MASK_RENDN, 4);
-	SSP_WRITE_BITS(chip->cr1, chip_info->endian_tx, SSP_CR1_MASK_TENDN, 5);
-	SSP_WRITE_BITS(chip->cr1, chip_info->wait_state, SSP_CR1_MASK_MWAIT, 6);
-	SSP_WRITE_BITS(chip->cr1, chip_info->rx_lev_trig, SSP_CR1_MASK_RXIFLSEL, 7);
-	SSP_WRITE_BITS(chip->cr1, chip_info->tx_lev_trig, SSP_CR1_MASK_TXIFLSEL, 10);
 
 	/* Save controller_state */
 	spi_set_ctldata(spi, chip);
@@ -2146,6 +2210,7 @@ static struct vendor_data vendor_arm = {
 	.fifodepth = 8,
 	.max_bpw = 16,
 	.unidir = false,
+	.extended_cr = false,
 };
 
 
@@ -2153,6 +2218,7 @@ static struct vendor_data vendor_st = {
 	.fifodepth = 32,
 	.max_bpw = 32,
 	.unidir = false,
+	.extended_cr = true,
 };
 
 static struct amba_id pl022_ids[] = {
diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index 95f8d17..1a83b61 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -71,6 +71,7 @@ struct ssp_clock_params {
 
 /**
  * enum ssp_rx_endian - endianess of Rx FIFO Data
+ * this feature is only available in ST versionf of PL022
  */
 enum ssp_rx_endian {
 	SSP_RX_MSB,
@@ -181,7 +182,8 @@ enum ssp_microwire_wait_state {
 };
 
 /**
- * enum Microwire - whether Full/Half Duplex
+ * enum Microwire - whether Full/Half Duplex, only available
+ * in the ST Micro variant.
  * @SSP_MICROWIRE_CHANNEL_FULL_DUPLEX: SSPTXD becomes bi-directional,
  *     SSPRXD not used
  * @SSP_MICROWIRE_CHANNEL_HALF_DUPLEX: SSPTXD is an output, SSPRXD is
-- 
1.6.3.3
