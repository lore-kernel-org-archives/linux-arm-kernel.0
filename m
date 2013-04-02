From: tpiepho@gmail.com (Trent Piepho)
Date: Tue,  2 Apr 2013 05:19:50 -0700
Subject: [PATCH V2 07/12] spi/mxs: Remove bogus setting of ssp clk rate field
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <1364905195-24286-7-git-send-email-tpiepho@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ssp struct has a clock rate field, to provide the actual value, in Hz,
of the SSP output clock (the rate of SSP_SCK) after mxs_ssp_set_clk_rate()
is called.  It should be read-only, except for mxs_ssp_set_clk_rate().

For some reason the spi-mxs driver decides to write to this field on init,
and sets it to the value of the SSP input clock (clk_sspN, from the MXS
clocking block) in kHz.  It shouldn't be setting the value, and certainly
shouldn't be setting it with the wrong clock in the wrong units.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 208de97..103c478 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -591,7 +591,6 @@ static int mxs_spi_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(ssp->clk);
 	clk_set_rate(ssp->clk, clk_freq);
-	ssp->clk_rate = clk_get_rate(ssp->clk) / 1000;
 
 	stmp_reset_block(ssp->base);
 
-- 
1.7.10.4
