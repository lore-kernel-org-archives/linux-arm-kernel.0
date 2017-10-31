From: tpiepho@impinj.com (Trent Piepho)
Date: Tue, 31 Oct 2017 12:49:05 -0700
Subject: [PATCH v3 2/4] spi: imx: Fix failure path leak on GPIO request error
In-Reply-To: <20171031194907.29108-1-tpiepho@impinj.com>
References: <20171031194907.29108-1-tpiepho@impinj.com>
Message-ID: <20171031194907.29108-3-tpiepho@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the code that requests any chip select GPIOs fails, the cleanup of
spi_bitbang_start() by calling spi_bitbang_stop() is not done.  Add this
to the failure path.

Note that spi_bitbang_start() has to be called before requesting GPIOs
because the GPIO data in the spi master is populated when the master is
registed, and that doesn't happen until spi_bitbang_start() is called.

CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <kernel@pengutronix.de>
CC: Fabio Estevam <fabio.estevam@nxp.com>
CC: Mark Brown <broonie@kernel.org>
CC: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/spi/spi-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 76bf0e4fc2c7..ad54f8258513 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1638,7 +1638,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 			if (ret) {
 				dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
 					master->cs_gpios[i]);
-				goto out_clk_put;
+				goto out_spi_bitbang;
 			}
 		}
 	}
@@ -1649,6 +1649,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	clk_disable(spi_imx->clk_per);
 	return ret;
 
+out_spi_bitbang:
+	spi_bitbang_stop(&spi_imx->bitbang);
 out_clk_put:
 	clk_disable_unprepare(spi_imx->clk_ipg);
 out_put_per:
-- 
2.14.3
