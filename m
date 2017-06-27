From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 27 Jun 2017 10:20:35 +0800
Subject: [PATCH v2] spi: rockchip: Disable Runtime PM when chip select is
 asserted
Message-ID: <1498530035-22070-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rockchip spi would stop driving pins when runtime suspended, which
might break slave's xfer(for example cros_ec).

Since we have pullups on those pins, we only need to care about the CS
asserted case.

So let's keep the spi alive when chip select is asserted for that.

Also change use pm_runtime_put instead of pm_runtime_put_sync.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

Changes in v2:
Improve commit message and comments and coding style.

 drivers/spi/spi-rockchip.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index acf31f3..ea0edd7 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -264,7 +264,7 @@ static inline u32 rx_max(struct rockchip_spi *rs)
 
 static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	u32 ser;
+	u32 ser, new_ser;
 	struct spi_master *master = spi->master;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
@@ -288,13 +288,26 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 	 * Note: enable(rockchip_spi_set_cs) = !enable(spi_set_cs)
 	 */
 	if (!enable)
-		ser |= 1 << spi->chip_select;
+		new_ser = ser | BIT(spi->chip_select);
 	else
-		ser &= ~(1 << spi->chip_select);
+		new_ser = ser & ~BIT(spi->chip_select);
 
-	writel_relaxed(ser, rs->regs + ROCKCHIP_SPI_SER);
+	if (new_ser != ser) {
+		writel_relaxed(new_ser, rs->regs + ROCKCHIP_SPI_SER);
 
-	pm_runtime_put_sync(rs->dev);
+		/*
+		 * The rockchip spi would stop driving all pins when powered
+		 * down.
+		 * So hold a runtime PM reference as long as CS is asserted.
+		 */
+		if (!enable)
+			return;
+
+		/* Drop reference from when we first asserted CS */
+		pm_runtime_put(rs->dev);
+	}
+
+	pm_runtime_put(rs->dev);
 }
 
 static int rockchip_spi_prepare_message(struct spi_master *master,
-- 
2.1.4
