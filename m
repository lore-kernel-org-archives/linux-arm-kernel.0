From: addy.ke@rock-chips.com (Addy Ke)
Date: Wed, 15 Oct 2014 19:25:49 +0800
Subject: [PATCH 1/2] spi/rockchip: fix bug that case spi can't go as fast as
 slave request
In-Reply-To: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1413372349-4254-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the minimum divisor in rk3x's spi controller is 2,
if spi_clk is less than 2 * sclk_out, we can't get the right divisor.
So we must set spi_clk again to match slave request.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/spi/spi-rockchip.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index f96ea8a..3044c6c 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -145,6 +145,9 @@
 #define RXBUSY						(1 << 0)
 #define TXBUSY						(1 << 1)
 
+/* sclk_out: spi master internal logic in rk3x can support 50Mhz */
+#define MAX_SCLK_OUT		50000000
+
 enum rockchip_ssi_type {
 	SSI_MOTO_SPI = 0,
 	SSI_TI_SSP,
@@ -496,6 +499,15 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 			dmacr |= RF_DMA_EN;
 	}
 
+	if (WARN_ON(rs->speed > MAX_SCLK_OUT))
+		rs->speed = MAX_SCLK_OUT;
+
+	/* the minimum divsor is 2 */
+	if (rs->max_freq < 2 * rs->speed) {
+		clk_set_rate(rs->spiclk, 2 * rs->speed);
+		rs->max_freq = clk_get_rate(rs->spiclk);
+	}
+
 	/* div doesn't support odd number */
 	div = max_t(u32, rs->max_freq / rs->speed, 1);
 	div = (div + 1) & 0xfffe;
-- 
1.8.3.2
