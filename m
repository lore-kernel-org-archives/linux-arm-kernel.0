From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 26 Jun 2017 11:10:06 +0800
Subject: [PATCH] spi: rockchip: Keep master alive when CS asserted
Message-ID: <1498446606-5529-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cros_ec requires CS line to be active after last message. But the CS
would be toggled when powering off/on rockchip spi, which breaks ec xfer.

Keep spi alive after CS asserted to prevent that.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

 drivers/spi/spi-rockchip.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index acf31f3..df016a1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -264,7 +264,7 @@ static inline u32 rx_max(struct rockchip_spi *rs)
 
 static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	u32 ser;
+	u32 ser, new_ser;
 	struct spi_master *master = spi->master;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
@@ -288,13 +288,25 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 	 * Note: enable(rockchip_spi_set_cs) = !enable(spi_set_cs)
 	 */
 	if (!enable)
-		ser |= 1 << spi->chip_select;
+		new_ser = ser | BIT(spi->chip_select);
 	else
-		ser &= ~(1 << spi->chip_select);
+		new_ser = ser & ~BIT(spi->chip_select);
 
-	writel_relaxed(ser, rs->regs + ROCKCHIP_SPI_SER);
+	if (new_ser == ser)
+		goto out;
 
-	pm_runtime_put_sync(rs->dev);
+	writel_relaxed(new_ser, rs->regs + ROCKCHIP_SPI_SER);
+
+	/*
+	 * The rockchip spi would stop driving CS when power down.
+	 * So we need to keep it alive after CS asserted
+	 */
+	if (!enable)
+		return;
+	pm_runtime_put(rs->dev);
+
+out:
+	pm_runtime_put(rs->dev);
 }
 
 static int rockchip_spi_prepare_message(struct spi_master *master,
-- 
2.1.4
