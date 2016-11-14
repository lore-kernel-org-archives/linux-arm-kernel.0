From: ben.whitten@gmail.com (Ben Whitten)
Date: Mon, 14 Nov 2016 15:13:20 +0000
Subject: [PATCH RESEND] spi: atmel: Fix scheduling while atomic
Message-ID: <1479136400-10285-1-git-send-email-ben.whitten@lairdtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A call to clk_get_rate appears to be called in the context of an interrupt,
cache the bus clock for the frequency calculations in transmission.

This fixes a 'BUG: scheduling while atomic' and
'WARNING: CPU: 0 PID: 777 at kernel/sched/core.c:2960 atmel_spi_unlock'

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
Signed-off-by: Steve deRosier <steve.derosier@lairdtech.com>
---

Resending due to missing off the subsystem maintainer in initial submission,
pointed out by Alexandre Belloni, thanks.

---
 drivers/spi/spi-atmel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 8feac59..c281d1a 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -295,6 +295,7 @@ struct atmel_spi {
 	int			irq;
 	struct clk		*clk;
 	struct platform_device	*pdev;
+	unsigned long		spi_clk;
 
 	struct spi_transfer	*current_transfer;
 	int			current_remaining_bytes;
@@ -864,7 +865,7 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
 	unsigned long		bus_hz;
 
 	/* v1 chips start out at half the peripheral bus speed. */
-	bus_hz = clk_get_rate(as->clk);
+	bus_hz = as->spi_clk;
 	if (!atmel_spi_is_v2(as))
 		bus_hz /= 2;
 
@@ -1606,6 +1607,9 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(clk);
 	if (ret)
 		goto out_free_irq;
+
+	as->spi_clk = clk_get_rate(clk);
+
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	if (as->caps.has_wdrbt) {
-- 
2.7.4
