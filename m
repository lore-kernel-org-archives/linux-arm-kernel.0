From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:25:59 +0100
Subject: Applied "spi: rockchip: Disable Runtime PM when chip select is
 asserted" to the spi tree
In-Reply-To: <1498624723-17332-2-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <E1dQIb9-0004iH-1G@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: Disable Runtime PM when chip select is asserted

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From aa099382ac0cda27e10fa8f45bf91edea0d1d35e Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Wed, 28 Jun 2017 12:38:43 +0800
Subject: [PATCH] spi: rockchip: Disable Runtime PM when chip select is
 asserted

The rockchip spi would stop driving pins when runtime suspended, which
might break slave's xfer(for example cros_ec).

Since we have pullups on those pins, we only need to care about this
when the CS asserted.

So let's keep the spi alive when chip select is asserted.

Also use pm_runtime_put instead of pm_runtime_put_sync.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 51 +++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 52ea1605d4c6..0b4a52b3e1dc 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -25,6 +25,11 @@
 
 #define DRIVER_NAME "rockchip-spi"
 
+#define ROCKCHIP_SPI_CLR_BITS(reg, bits) \
+		writel_relaxed(readl_relaxed(reg) & ~(bits), reg)
+#define ROCKCHIP_SPI_SET_BITS(reg, bits) \
+		writel_relaxed(readl_relaxed(reg) | (bits), reg)
+
 /* SPI register offsets */
 #define ROCKCHIP_SPI_CTRLR0			0x0000
 #define ROCKCHIP_SPI_CTRLR1			0x0004
@@ -149,6 +154,8 @@
  */
 #define ROCKCHIP_SPI_MAX_TRANLEN		0xffff
 
+#define ROCKCHIP_SPI_MAX_CS_NUM			2
+
 enum rockchip_ssi_type {
 	SSI_MOTO_SPI = 0,
 	SSI_TI_SSP,
@@ -193,6 +200,8 @@ struct rockchip_spi {
 	/* protect state */
 	spinlock_t lock;
 
+	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
+
 	u32 use_dma;
 	struct sg_table tx_sg;
 	struct sg_table rx_sg;
@@ -264,37 +273,29 @@ static inline u32 rx_max(struct rockchip_spi *rs)
 
 static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	u32 ser;
 	struct spi_master *master = spi->master;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
+	bool cs_asserted = !enable;
 
-	pm_runtime_get_sync(rs->dev);
+	/* Return immediately for no-op */
+	if (cs_asserted == rs->cs_asserted[spi->chip_select])
+		return;
 
-	ser = readl_relaxed(rs->regs + ROCKCHIP_SPI_SER) & SER_MASK;
+	if (cs_asserted) {
+		/* Keep things powered as long as CS is asserted */
+		pm_runtime_get_sync(rs->dev);
 
-	/*
-	 * drivers/spi/spi.c:
-	 * static void spi_set_cs(struct spi_device *spi, bool enable)
-	 * {
-	 *		if (spi->mode & SPI_CS_HIGH)
-	 *			enable = !enable;
-	 *
-	 *		if (spi->cs_gpio >= 0)
-	 *			gpio_set_value(spi->cs_gpio, !enable);
-	 *		else if (spi->master->set_cs)
-	 *		spi->master->set_cs(spi, !enable);
-	 * }
-	 *
-	 * Note: enable(rockchip_spi_set_cs) = !enable(spi_set_cs)
-	 */
-	if (!enable)
-		ser |= 1 << spi->chip_select;
-	else
-		ser &= ~(1 << spi->chip_select);
+		ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER,
+				      BIT(spi->chip_select));
+	} else {
+		ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER,
+				      BIT(spi->chip_select));
 
-	writel_relaxed(ser, rs->regs + ROCKCHIP_SPI_SER);
+		/* Drop reference from when we first asserted CS */
+		pm_runtime_put(rs->dev);
+	}
 
-	pm_runtime_put_sync(rs->dev);
+	rs->cs_asserted[spi->chip_select] = cs_asserted;
 }
 
 static int rockchip_spi_prepare_message(struct spi_master *master,
@@ -739,7 +740,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->auto_runtime_pm = true;
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
-	master->num_chipselect = 2;
+	master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
 
-- 
2.13.2
