From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 30 Jul 2013 12:37:37 +0200
Subject: [PATCH v2 13/13] mmc: tmio-mmc: Remove .set_pwr() callback from
 platform data
In-Reply-To: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1375180657-23641-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The .set_pwr() callback isn't used anymore as all platforms register
GPIO-controlled regulators. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     | 1 -
 drivers/mmc/host/tmio_mmc_pio.c | 7 -------
 include/linux/mfd/tmio.h        | 1 -
 3 files changed, 9 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 86fd21e..39c2f45 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -68,7 +68,6 @@ struct tmio_mmc_host {
 	enum tmio_mmc_power	power;
 
 	/* Callbacks for clock / power control */
-	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 
 	/* pio related stuff */
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 2a7eb5a..4675513 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -777,9 +777,6 @@ static void tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned short vdd)
 
 	/* .set_ios() is returning void, so, no chance to report an error */
 
-	if (host->set_pwr)
-		host->set_pwr(host->pdev, 1);
-
 	if (!IS_ERR(mmc->supply.vmmc)) {
 		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 		/*
@@ -809,9 +806,6 @@ static void tmio_mmc_power_off(struct tmio_mmc_host *host)
 
 	if (!IS_ERR(mmc->supply.vmmc))
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
-
-	if (host->set_pwr)
-		host->set_pwr(host->pdev, 0);
 }
 
 /* Set MMC clock / power.
@@ -998,7 +992,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	_host->pdev = pdev;
 	platform_set_drvdata(pdev, mmc);
 
-	_host->set_pwr = pdata->set_pwr;
 	_host->set_clk_div = pdata->set_clk_div;
 
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index b22883d..baa2346 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -106,7 +106,6 @@ struct tmio_mmc_data {
 	struct tmio_mmc_dma		*dma;
 	struct device			*dev;
 	unsigned int			cd_gpio;
-	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	/* clock management callbacks */
-- 
1.8.1.5
