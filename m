From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri,  7 May 2010 10:40:53 +0200
Subject: [PATCH] SPI: add support for the PL023 derivate
Message-ID: <1273221653-15654-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for a further ST variant of the PL022 called
PL023. Some differences in the control registers due to being
stripped down to SPI mode only, and a new clock feedback sample
delay config setting is available.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Note: Grant this one is supposed to be applied on top of the
previous patch to fix up PL022 confusion, I can resend
these as a condensed patch series if you like, just tell me.

The stuff to be queued in Dan Williams tree for DMA support has
been tested to be applied before and after this patch and apply
cleanly so we don't have to worry about these patch sets
colliding.
---
 drivers/spi/amba-pl022.c   |   90 ++++++++++++++++++++++++++++++++++++--------
 include/linux/amba/pl022.h |   32 +++++++++++++++-
 2 files changed, 104 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 1ad617c..2309562 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -138,6 +138,8 @@
 #define SSP_CR1_MASK_MWAIT_ST	(0x1UL << 6)
 #define SSP_CR1_MASK_RXIFLSEL_ST (0x7UL << 7)
 #define SSP_CR1_MASK_TXIFLSEL_ST (0x7UL << 10)
+/* This one is only in the PL023 variant */
+#define SSP_CR1_MASK_FBCLKDEL_ST (0x7UL << 13)
 
 /*
  * SSP Status Register - SSP_SR
@@ -320,12 +322,14 @@ enum ssp_writing {
  * @unidir: supports unidirection transfers
  * @extended_cr: 32 bit wide control register 0 with extra
  * features and extra features in CR1 as found in the ST variants
+ * @pl023: supports a subset of the ST extensions called "PL023"
  */
 struct vendor_data {
 	int fifodepth;
 	int max_bpw;
 	bool unidir;
 	bool extended_cr;
+	bool pl023;
 };
 
 /**
@@ -552,11 +556,6 @@ static void restore_state(struct pl022 *pl022)
 	writew(CLEAR_ALL_INTERRUPTS, SSP_ICR(pl022->virtbase));
 }
 
-/**
- * load_ssp_default_config - Load default configuration for SSP
- * @pl022: SSP driver private data structure
- */
-
 /*
  * Default SSP Register Values
  */
@@ -579,6 +578,14 @@ static void restore_state(struct pl022 *pl022)
 	GEN_MASK_BITS(SSP_INTERFACE_MOTOROLA_SPI, SSP_CR0_MASK_FRF_ST, 21) \
 )
 
+/* The PL023 version is slightly different again */
+#define DEFAULT_SSP_REG_CR0_ST_PL023 ( \
+	GEN_MASK_BITS(SSP_DATA_BITS_12, SSP_CR0_MASK_DSS_ST, 0)	| \
+	GEN_MASK_BITS(SSP_CLK_POL_IDLE_LOW, SSP_CR0_MASK_SPO, 6) | \
+	GEN_MASK_BITS(SSP_CLK_SECOND_EDGE, SSP_CR0_MASK_SPH, 7) | \
+	GEN_MASK_BITS(SSP_DEFAULT_CLKRATE, SSP_CR0_MASK_SCR, 8) \
+)
+
 #define DEFAULT_SSP_REG_CR1 ( \
 	GEN_MASK_BITS(LOOPBACK_DISABLED, SSP_CR1_MASK_LBM, 0) | \
 	GEN_MASK_BITS(SSP_DISABLED, SSP_CR1_MASK_SSE, 1) | \
@@ -596,6 +603,20 @@ static void restore_state(struct pl022 *pl022)
 	GEN_MASK_BITS(SSP_TX_1_OR_MORE_EMPTY_LOC, SSP_CR1_MASK_TXIFLSEL_ST, 10) \
 )
 
+/*
+ * The PL023 variant has further differences: no loopback mode, no microwire
+ * support, and a new clock feedback delay setting.
+ */
+#define DEFAULT_SSP_REG_CR1_ST_PL023 ( \
+	GEN_MASK_BITS(SSP_DISABLED, SSP_CR1_MASK_SSE, 1) | \
+	GEN_MASK_BITS(SSP_MASTER, SSP_CR1_MASK_MS, 2) | \
+	GEN_MASK_BITS(DO_NOT_DRIVE_TX, SSP_CR1_MASK_SOD, 3) | \
+	GEN_MASK_BITS(SSP_RX_MSB, SSP_CR1_MASK_RENDN_ST, 4) | \
+	GEN_MASK_BITS(SSP_TX_MSB, SSP_CR1_MASK_TENDN_ST, 5) | \
+	GEN_MASK_BITS(SSP_RX_1_OR_MORE_ELEM, SSP_CR1_MASK_RXIFLSEL_ST, 7) | \
+	GEN_MASK_BITS(SSP_TX_1_OR_MORE_EMPTY_LOC, SSP_CR1_MASK_TXIFLSEL_ST, 10) | \
+	GEN_MASK_BITS(SSP_FEEDBACK_CLK_DELAY_NONE, SSP_CR1_MASK_FBCLKDEL_ST, 13) \
+)
 
 #define DEFAULT_SSP_REG_CPSR ( \
 	GEN_MASK_BITS(SSP_DEFAULT_PRESCALE, SSP_CPSR_MASK_CPSDVSR, 0) \
@@ -606,10 +627,16 @@ static void restore_state(struct pl022 *pl022)
 	GEN_MASK_BITS(SSP_DMA_DISABLED, SSP_DMACR_MASK_TXDMAE, 1) \
 )
 
-
+/**
+ * load_ssp_default_config - Load default configuration for SSP
+ * @pl022: SSP driver private data structure
+ */
 static void load_ssp_default_config(struct pl022 *pl022)
 {
-	if (pl022->vendor->extended_cr) {
+	if (pl022->vendor->pl023) {
+		writel(DEFAULT_SSP_REG_CR0_ST_PL023, SSP_CR0(pl022->virtbase));
+		writew(DEFAULT_SSP_REG_CR1_ST_PL023, SSP_CR1(pl022->virtbase));
+	} else if (pl022->vendor->extended_cr) {
 		writel(DEFAULT_SSP_REG_CR0_ST, SSP_CR0(pl022->virtbase));
 		writew(DEFAULT_SSP_REG_CR1_ST, SSP_CR1(pl022->virtbase));
 	} else {
@@ -1954,20 +1981,27 @@ static int pl022_setup(struct spi_device *spi)
 
 	/* Special setup for the ST micro extended control registers */
 	if (pl022->vendor->extended_cr) {
+		if (pl022->vendor->pl023) {
+			/* These bits are only in the PL023 */
+			SSP_WRITE_BITS(chip->cr1, chip_info->clkdelay,
+				       SSP_CR1_MASK_FBCLKDEL_ST, 13);
+		} else {
+			/* These bits are in the PL022 but not PL023 */
+			SSP_WRITE_BITS(chip->cr0, chip_info->duplex,
+				       SSP_CR0_MASK_HALFDUP_ST, 5);
+			SSP_WRITE_BITS(chip->cr0, chip_info->ctrl_len,
+				       SSP_CR0_MASK_CSS_ST, 16);
+			SSP_WRITE_BITS(chip->cr0, chip_info->iface,
+				       SSP_CR0_MASK_FRF_ST, 21);
+			SSP_WRITE_BITS(chip->cr1, chip_info->wait_state,
+				       SSP_CR1_MASK_MWAIT_ST, 6);
+		}
 		SSP_WRITE_BITS(chip->cr0, chip_info->data_size,
 			       SSP_CR0_MASK_DSS_ST, 0);
-		SSP_WRITE_BITS(chip->cr0, chip_info->duplex,
-			       SSP_CR0_MASK_HALFDUP_ST, 5);
-		SSP_WRITE_BITS(chip->cr0, chip_info->ctrl_len,
-			       SSP_CR0_MASK_CSS_ST, 16);
-		SSP_WRITE_BITS(chip->cr0, chip_info->iface,
-			       SSP_CR0_MASK_FRF_ST, 21);
 		SSP_WRITE_BITS(chip->cr1, chip_info->endian_rx,
 			       SSP_CR1_MASK_RENDN_ST, 4);
 		SSP_WRITE_BITS(chip->cr1, chip_info->endian_tx,
 			       SSP_CR1_MASK_TENDN_ST, 5);
-		SSP_WRITE_BITS(chip->cr1, chip_info->wait_state,
-			       SSP_CR1_MASK_MWAIT_ST, 6);
 		SSP_WRITE_BITS(chip->cr1, chip_info->rx_lev_trig,
 			       SSP_CR1_MASK_RXIFLSEL_ST, 7);
 		SSP_WRITE_BITS(chip->cr1, chip_info->tx_lev_trig,
@@ -1982,7 +2016,9 @@ static int pl022_setup(struct spi_device *spi)
 	SSP_WRITE_BITS(chip->cr0, chip_info->clk_pol, SSP_CR0_MASK_SPO, 6);
 	SSP_WRITE_BITS(chip->cr0, chip_info->clk_phase, SSP_CR0_MASK_SPH, 7);
 	SSP_WRITE_BITS(chip->cr0, chip_info->clk_freq.scr, SSP_CR0_MASK_SCR, 8);
-	SSP_WRITE_BITS(chip->cr1, chip_info->lbm, SSP_CR1_MASK_LBM, 0);
+	/* Loopback is available on all versions except PL023 */
+	if (!pl022->vendor->pl023)
+		SSP_WRITE_BITS(chip->cr1, chip_info->lbm, SSP_CR1_MASK_LBM, 0);
 	SSP_WRITE_BITS(chip->cr1, SSP_DISABLED, SSP_CR1_MASK_SSE, 1);
 	SSP_WRITE_BITS(chip->cr1, chip_info->hierarchy, SSP_CR1_MASK_MS, 2);
 	SSP_WRITE_BITS(chip->cr1, chip_info->slave_tx_disable, SSP_CR1_MASK_SOD, 3);
@@ -2211,6 +2247,7 @@ static struct vendor_data vendor_arm = {
 	.max_bpw = 16,
 	.unidir = false,
 	.extended_cr = false,
+	.pl023 = false,
 };
 
 
@@ -2219,6 +2256,15 @@ static struct vendor_data vendor_st = {
 	.max_bpw = 32,
 	.unidir = false,
 	.extended_cr = true,
+	.pl023 = false,
+};
+
+static struct vendor_data vendor_st_pl023 = {
+	.fifodepth = 32,
+	.max_bpw = 32,
+	.unidir = false,
+	.extended_cr = true,
+	.pl023 = true,
 };
 
 static struct amba_id pl022_ids[] = {
@@ -2240,6 +2286,18 @@ static struct amba_id pl022_ids[] = {
 		.mask	= 0xffffffff,
 		.data	= &vendor_st,
 	},
+	{
+		/*
+		 * ST-Ericsson derivative "PL023" (this is not
+		 * an official ARM number), this is a PL022 SSP block
+		 * stripped to SPI mode only, it has 32bit wide
+		 * and 32 locations deep TX/RX FIFO but no extended
+		 * CR0/CR1 register
+		 */
+		.id     = 0x00080023,
+		.mask   = 0xffffffff,
+		.data   = &vendor_st_pl023,
+	},
 	{ 0, 0 },
 };
 
diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index 1a83b61..db6a191 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -182,8 +182,8 @@ enum ssp_microwire_wait_state {
 };
 
 /**
- * enum Microwire - whether Full/Half Duplex, only available
- * in the ST Micro variant.
+ * enum ssp_duplex - whether Full/Half Duplex on microwire, only
+ * available in the ST Micro variant.
  * @SSP_MICROWIRE_CHANNEL_FULL_DUPLEX: SSPTXD becomes bi-directional,
  *     SSPRXD not used
  * @SSP_MICROWIRE_CHANNEL_HALF_DUPLEX: SSPTXD is an output, SSPRXD is
@@ -195,6 +195,31 @@ enum ssp_duplex {
 };
 
 /**
+ * enum ssp_clkdelay - an optional clock delay on the feedback clock
+ * only available in the ST Micro PL023 variant.
+ * @SSP_FEEDBACK_CLK_DELAY_NONE: no delay, the data coming in from the
+ * slave is sampled directly
+ * @SSP_FEEDBACK_CLK_DELAY_1T: the incoming slave data is sampled with
+ * a delay of T-dt
+ * @SSP_FEEDBACK_CLK_DELAY_2T: dito with a delay if 2T-dt
+ * @SSP_FEEDBACK_CLK_DELAY_3T: dito with a delay if 3T-dt
+ * @SSP_FEEDBACK_CLK_DELAY_4T: dito with a delay if 4T-dt
+ * @SSP_FEEDBACK_CLK_DELAY_5T: dito with a delay if 5T-dt
+ * @SSP_FEEDBACK_CLK_DELAY_6T: dito with a delay if 6T-dt
+ * @SSP_FEEDBACK_CLK_DELAY_7T: dito with a delay if 7T-dt
+ */
+enum ssp_clkdelay {
+	SSP_FEEDBACK_CLK_DELAY_NONE,
+	SSP_FEEDBACK_CLK_DELAY_1T,
+	SSP_FEEDBACK_CLK_DELAY_2T,
+	SSP_FEEDBACK_CLK_DELAY_3T,
+	SSP_FEEDBACK_CLK_DELAY_4T,
+	SSP_FEEDBACK_CLK_DELAY_5T,
+	SSP_FEEDBACK_CLK_DELAY_6T,
+	SSP_FEEDBACK_CLK_DELAY_7T
+};
+
+/**
  * CHIP select/deselect commands
  */
 enum ssp_chip_select {
@@ -243,6 +268,8 @@ struct pl022_ssp_controller {
  * @ctrl_len: Microwire interface: Control length
  * @wait_state: Microwire interface: Wait state
  * @duplex: Microwire interface: Full/Half duplex
+ * @clkdelay: on the PL023 variant, the delay in feeback clock cycles
+ * before sampling the incoming line
  * @cs_control: function pointer to board-specific function to
  * assert/deassert I/O port to control HW generation of devices chip-select.
  * @dma_xfer_type: Type of DMA xfer (Mem-to-periph or Periph-to-Periph)
@@ -266,6 +293,7 @@ struct pl022_config_chip {
 	enum ssp_microwire_ctrl_len ctrl_len;
 	enum ssp_microwire_wait_state wait_state;
 	enum ssp_duplex duplex;
+	enum ssp_clkdelay clkdelay;
 	void (*cs_control) (u32 control);
 };
 
-- 
1.6.3.3
