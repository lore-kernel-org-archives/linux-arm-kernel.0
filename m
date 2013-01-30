From: stigge@antcom.de (Roland Stigge)
Date: Wed, 30 Jan 2013 18:05:08 +0100
Subject: [PATCH] mmc: mmc_spi: Fix return value evaluation of
 irq_of_parse_and_map()
Message-ID: <1359565508-13362-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When irq_of_parse_and_map() returns an error, it does as zero. But in
mmc_spi_get_pdata(), the error return case is compared against NO_IRQ. This
might work where NO_IRQ is zero (defaults to zero when undefined, as on MIPS)
but not where NO_IRQ is sth. different, e.g. on ARM, where it is -1.

This patch changes to comparison with 0 which is the error return value of
irq_of_parse_and_map(). 

Tested on ARM that mmc_spi is working now.

Signed-off-by: Roland Stigge <stigge@antcom.de>

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 1534b58..d720b5e 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -146,7 +146,7 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 		oms->pdata.get_ro = of_mmc_spi_get_ro;
 
 	oms->detect_irq = irq_of_parse_and_map(np, 0);
-	if (oms->detect_irq != NO_IRQ) {
+	if (oms->detect_irq != 0) {
 		oms->pdata.init = of_mmc_spi_init;
 		oms->pdata.exit = of_mmc_spi_exit;
 	} else {
