From: drinkcat@chromium.org (Nicolas Boichat)
Date: Tue,  4 Aug 2015 14:09:57 +0800
Subject: [PATCH 2/3] spi: ppc44x: Remove chipselect from setupxfer
In-Reply-To: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
References: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
Message-ID: <1438668598-6678-2-git-send-email-drinkcat@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chipselect operation is already done in spi_bitbang_transfer_one,
or in spi_bitbang_setup, so there is no need to do it in setupxfer
as well.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/spi/spi-ppc4xx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 54fb984..55947f6 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -210,13 +210,6 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	if (in_8(&hw->regs->cdm) != cdm)
 		out_8(&hw->regs->cdm, cdm);
 
-	spin_lock(&hw->bitbang.lock);
-	if (!hw->bitbang.busy) {
-		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
-		/* Need to ndelay here? */
-	}
-	spin_unlock(&hw->bitbang.lock);
-
 	return 0;
 }
 
-- 
2.5.0.rc2.392.g76e840b
