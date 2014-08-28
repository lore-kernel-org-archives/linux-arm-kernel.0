From: dianders@chromium.org (Doug Anderson)
Date: Thu, 28 Aug 2014 16:43:48 -0700
Subject: [PATCH] spi/rockchip: Avoid accidentally turning off the clock
Message-ID: <1409269428-24680-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If our client is requesting a clock that is above the maximum clock
then the following division will result in 0:
  rs->max_freq / rs->speed

We'll then program 0 into the SPI_BAUDR register.  The Rockchip TRM
says: "If the value is 0, the serial output clock (sclk_out) is
disabled."

It's much better to end up with the fastest possible clock rather than
a clock that is off, so enforce a minimum value.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 6321326..cd0e08b0 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -499,7 +499,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	}
 
 	/* div doesn't support odd number */
-	div = rs->max_freq / rs->speed;
+	div = max_t(u32, rs->max_freq / rs->speed, 1);
 	div = (div + 1) & 0xfffe;
 
 	spi_enable_chip(rs, 0);
-- 
2.1.0.rc2.206.gedb03e5
