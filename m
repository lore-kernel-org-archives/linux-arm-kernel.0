From: marex@denx.de (Marek Vasut)
Date: Sat, 23 Jun 2012 20:43:52 +0200
Subject: [PATCH 6/7] ARM: mxs: Pull out the SSP clock configuration function
In-Reply-To: <1340477033-2761-1-git-send-email-marex@denx.de>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
Message-ID: <1340477033-2761-6-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pull out the MMC clock configuration function and make it
into SSP clock configuration function, so it can be used by
the SPI driver too.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <rob.herring@calxeda.com>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
---
 drivers/clk/mxs/Makefile    |    2 +-
 drivers/clk/mxs/clk-ssp.c   |   61 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mxs-mmc.c  |   39 +--------------------------
 include/linux/spi/mxs-spi.h |    2 ++
 4 files changed, 65 insertions(+), 39 deletions(-)
 create mode 100644 drivers/clk/mxs/clk-ssp.c

diff --git a/drivers/clk/mxs/Makefile b/drivers/clk/mxs/Makefile
index 7bedeec..a6a2223 100644
--- a/drivers/clk/mxs/Makefile
+++ b/drivers/clk/mxs/Makefile
@@ -2,7 +2,7 @@
 # Makefile for mxs specific clk
 #
 
-obj-y += clk.o clk-pll.o clk-ref.o clk-div.o clk-frac.o
+obj-y += clk.o clk-pll.o clk-ref.o clk-div.o clk-frac.o clk-ssp.o
 
 obj-$(CONFIG_SOC_IMX23) += clk-imx23.o
 obj-$(CONFIG_SOC_IMX28) += clk-imx28.o
diff --git a/drivers/clk/mxs/clk-ssp.c b/drivers/clk/mxs/clk-ssp.c
new file mode 100644
index 0000000..b3c1e16
--- /dev/null
+++ b/drivers/clk/mxs/clk-ssp.c
@@ -0,0 +1,61 @@
+/*
+ * Copyright 2012 DENX Software Engineering, GmbH
+ *
+ * Pulled from code:
+ * Portions copyright (C) 2003 Russell King, PXA MMCI Driver
+ * Portions copyright (C) 2004-2005 Pierre Ossman, W83L51xD SD/MMC driver
+ *
+ * Copyright 2008 Embedded Alley Solutions, Inc.
+ * Copyright 2009-2011 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/spi/mxs-spi.h>
+
+void mxs_ssp_set_clk_rate(struct mxs_ssp *ssp, unsigned int rate)
+{
+	unsigned int ssp_clk, ssp_sck;
+	u32 clock_divide, clock_rate;
+	u32 val;
+
+	ssp_clk = clk_get_rate(ssp->clk);
+
+	for (clock_divide = 2; clock_divide <= 254; clock_divide += 2) {
+		clock_rate = DIV_ROUND_UP(ssp_clk, rate * clock_divide);
+		clock_rate = (clock_rate > 0) ? clock_rate - 1 : 0;
+		if (clock_rate <= 255)
+			break;
+	}
+
+	if (clock_divide > 254) {
+		dev_err(ssp->dev,
+			"%s: cannot set clock to %d\n", __func__, rate);
+		return;
+	}
+
+	ssp_sck = ssp_clk / clock_divide / (1 + clock_rate);
+
+	val = readl(ssp->base + HW_SSP_TIMING(ssp));
+	val &= ~(BM_SSP_TIMING_CLOCK_DIVIDE | BM_SSP_TIMING_CLOCK_RATE);
+	val |= BF_SSP(clock_divide, TIMING_CLOCK_DIVIDE);
+	val |= BF_SSP(clock_rate, TIMING_CLOCK_RATE);
+	writel(val, ssp->base + HW_SSP_TIMING(ssp));
+
+	ssp->clk_rate = ssp_sck;
+
+	dev_dbg(ssp->dev,
+		"%s: clock_divide %d, clock_rate %d, ssp_clk %d, rate_actual %d, rate_requested %d\n",
+		__func__, clock_divide, clock_rate, ssp_clk, ssp_sck, rate);
+}
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index d5f2421..7701e08 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -501,43 +501,6 @@ static void mxs_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	mxs_mmc_start_cmd(host, mrq->cmd);
 }
 
-static void mxs_mmc_set_clk_rate(struct mxs_mmc_host *host, unsigned int rate)
-{
-	struct mxs_ssp *ssp = &host->ssp;
-	unsigned int ssp_clk, ssp_sck;
-	u32 clock_divide, clock_rate;
-	u32 val;
-
-	ssp_clk = clk_get_rate(ssp->clk);
-
-	for (clock_divide = 2; clock_divide <= 254; clock_divide += 2) {
-		clock_rate = DIV_ROUND_UP(ssp_clk, rate * clock_divide);
-		clock_rate = (clock_rate > 0) ? clock_rate - 1 : 0;
-		if (clock_rate <= 255)
-			break;
-	}
-
-	if (clock_divide > 254) {
-		dev_err(mmc_dev(host->mmc),
-			"%s: cannot set clock to %d\n", __func__, rate);
-		return;
-	}
-
-	ssp_sck = ssp_clk / clock_divide / (1 + clock_rate);
-
-	val = readl(ssp->base + HW_SSP_TIMING(ssp));
-	val &= ~(BM_SSP_TIMING_CLOCK_DIVIDE | BM_SSP_TIMING_CLOCK_RATE);
-	val |= BF_SSP(clock_divide, TIMING_CLOCK_DIVIDE);
-	val |= BF_SSP(clock_rate, TIMING_CLOCK_RATE);
-	writel(val, ssp->base + HW_SSP_TIMING(ssp));
-
-	ssp->clk_rate = ssp_sck;
-
-	dev_dbg(mmc_dev(host->mmc),
-		"%s: clock_divide %d, clock_rate %d, ssp_clk %d, rate_actual %d, rate_requested %d\n",
-		__func__, clock_divide, clock_rate, ssp_clk, ssp_sck, rate);
-}
-
 static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mxs_mmc_host *host = mmc_priv(mmc);
@@ -550,7 +513,7 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->bus_width = 0;
 
 	if (ios->clock)
-		mxs_mmc_set_clk_rate(host, ios->clock);
+		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
 }
 
 static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
diff --git a/include/linux/spi/mxs-spi.h b/include/linux/spi/mxs-spi.h
index 0cb2767..2bc8abb 100644
--- a/include/linux/spi/mxs-spi.h
+++ b/include/linux/spi/mxs-spi.h
@@ -136,4 +136,6 @@ struct mxs_ssp {
 	enum mxs_ssp_id			devid;
 };
 
+void mxs_ssp_set_clk_rate(struct mxs_ssp *ssp, unsigned int rate);
+
 #endif	/* __LINUX_SPI_MXS_SPI_H__ */
-- 
1.7.10
