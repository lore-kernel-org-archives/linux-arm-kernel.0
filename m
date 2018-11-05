From: broonie@kernel.org (Mark Brown)
Date: Mon,  5 Nov 2018 12:06:21 +0000 (GMT)
Subject: Applied "spi: rockchip: set min/max speed" to the spi tree
In-Reply-To: <20181031105711.19575-11-esmil@mailme.dk>
Message-ID: <20181105120621.755631124D98@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: set min/max speed

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 420b82f842941a32adf309ca1b193adfc77616b0 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:07 +0100
Subject: [PATCH] spi: rockchip: set min/max speed

The driver previously checked each transfer if the
requested speed was higher than possible with the
current spi clock rate and raised the clock rate
accordingly.

However, there is no check to see if the spi clock
was actually set that high and no way to dynamically
lower the spi clock rate again.

So it seems any potiential users of this functionality
are better off just setting the spi clock rate at init
using the assigned-clock-rates devicetree property.

Removing this dynamic spi clock rate raising allows
us let the spi framework handle min/max speeds
for us.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 52 +++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index ba60cbcd45c2..d1b3ba2b1532 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -115,6 +115,10 @@
 /* Bit fields in SER, 2bit */
 #define SER_MASK					0x3
 
+/* Bit fields in BAUDR */
+#define BAUDR_SCKDV_MIN				2
+#define BAUDR_SCKDV_MAX				65534
+
 /* Bit fields in SR, 5bit */
 #define SR_MASK						0x1f
 #define SR_BUSY						(1 << 0)
@@ -147,7 +151,7 @@
 #define TXDMA					(1 << 1)
 
 /* sclk_out: spi master internal logic in rk3x can support 50Mhz */
-#define MAX_SCLK_OUT		50000000
+#define MAX_SCLK_OUT				50000000U
 
 /*
  * SPI_CTRLR1 is 16-bits, so we should support lengths of 0xffff + 1. However,
@@ -171,12 +175,11 @@ struct rockchip_spi {
 
 	/*depth of the FIFO buffer */
 	u32 fifo_len;
-	/* max bus freq supported */
-	u32 max_freq;
+	/* frequency of spiclk */
+	u32 freq;
 
 	u8 n_bytes;
 	u32 rsd_nsecs;
-	u32 speed;
 
 	const void *tx;
 	const void *tx_end;
@@ -191,11 +194,6 @@ static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
 	writel_relaxed((enable ? 1U : 0U), rs->regs + ROCKCHIP_SPI_SSIENR);
 }
 
-static inline void spi_set_clk(struct rockchip_spi *rs, u16 div)
-{
-	writel_relaxed(div, rs->regs + ROCKCHIP_SPI_BAUDR);
-}
-
 static inline void wait_for_idle(struct rockchip_spi *rs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5);
@@ -451,7 +449,6 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		struct spi_device *spi, struct spi_transfer *xfer,
 		bool use_dma)
 {
-	u32 div = 0;
 	u32 dmacr = 0;
 	int rsd = 0;
 
@@ -477,30 +474,17 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 			dmacr |= RF_DMA_EN;
 	}
 
-	if (WARN_ON(rs->speed > MAX_SCLK_OUT))
-		rs->speed = MAX_SCLK_OUT;
-
-	/* the minimum divisor is 2 */
-	if (rs->max_freq < 2 * rs->speed) {
-		clk_set_rate(rs->spiclk, 2 * rs->speed);
-		rs->max_freq = clk_get_rate(rs->spiclk);
-	}
-
-	/* div doesn't support odd number */
-	div = DIV_ROUND_UP(rs->max_freq, rs->speed);
-	div = (div + 1) & 0xfffe;
-
 	/* Rx sample delay is expressed in parent clock cycles (max 3) */
-	rsd = DIV_ROUND_CLOSEST(rs->rsd_nsecs * (rs->max_freq >> 8),
+	rsd = DIV_ROUND_CLOSEST(rs->rsd_nsecs * (rs->freq >> 8),
 				1000000000 >> 8);
 	if (!rsd && rs->rsd_nsecs) {
 		pr_warn_once("rockchip-spi: %u Hz are too slow to express %u ns delay\n",
-			     rs->max_freq, rs->rsd_nsecs);
+			     rs->freq, rs->rsd_nsecs);
 	} else if (rsd > 3) {
 		rsd = 3;
 		pr_warn_once("rockchip-spi: %u Hz are too fast to express %u ns delay, clamping at %u ns\n",
-			     rs->max_freq, rs->rsd_nsecs,
-			     rsd * 1000000000U / rs->max_freq);
+			     rs->freq, rs->rsd_nsecs,
+			     rsd * 1000000000U / rs->freq);
 	}
 	cr0 |= rsd << CR0_RSD_OFFSET;
 
@@ -520,9 +504,12 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_DMARDLR);
 	writel_relaxed(dmacr, rs->regs + ROCKCHIP_SPI_DMACR);
 
-	spi_set_clk(rs, div);
-
-	dev_dbg(rs->dev, "cr0 0x%x, div %d\n", cr0, div);
+	/* the hardware only supports an even clock divisor, so
+	 * round divisor = spiclk / speed up to nearest even number
+	 * so that the resulting speed is <= the requested speed
+	 */
+	writel_relaxed(2 * DIV_ROUND_UP(rs->freq, 2 * xfer->speed_hz),
+			rs->regs + ROCKCHIP_SPI_BAUDR);
 }
 
 static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
@@ -551,7 +538,6 @@ static int rockchip_spi_transfer_one(
 		return -EINVAL;
 	}
 
-	rs->speed = xfer->speed_hz;
 	rs->n_bytes = xfer->bits_per_word >> 3;
 
 	rs->tx = xfer->tx_buf;
@@ -631,7 +617,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	spi_enable_chip(rs, false);
 
 	rs->dev = &pdev->dev;
-	rs->max_freq = clk_get_rate(rs->spiclk);
+	rs->freq = clk_get_rate(rs->spiclk);
 
 	if (!of_property_read_u32(pdev->dev.of_node, "rx-sample-delay-ns",
 				  &rsd_nsecs))
@@ -653,6 +639,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	master->min_speed_hz = rs->freq / BAUDR_SCKDV_MAX;
+	master->max_speed_hz = min(rs->freq / BAUDR_SCKDV_MIN, MAX_SCLK_OUT);
 
 	master->set_cs = rockchip_spi_set_cs;
 	master->transfer_one = rockchip_spi_transfer_one;
-- 
2.19.0.rc2
