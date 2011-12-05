From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 5 Dec 2011 18:35:56 +0100
Subject: [PATCH 10/14] mmc: mmci: Cache MMCICLOCK and MMCIPOWER register
In-Reply-To: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1323106560-5218-11-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of reading a register value everytime we need to
apply a new value for it, maintain a cached copy for it.
This also means we are able to skip writes that are not
needed.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   41 +++++++++++++++++++++++++++++------------
 drivers/mmc/host/mmci.h |    3 ++-
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 4560b20..45e794a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -121,6 +121,28 @@ static struct variant_data variant_ux500v2 = {
 /*
  * This must be called with host->lock held
  */
+static void mmci_write_clkreg(struct mmci_host *host, u32 clk)
+{
+	if (host->clk_reg != clk) {
+		host->clk_reg = clk;
+		writel(clk, host->base + MMCICLOCK);
+	}
+}
+
+/*
+ * This must be called with host->lock held
+ */
+static void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
+{
+	if (host->pwr_reg != pwr) {
+		host->pwr_reg = pwr;
+		writel(pwr, host->base + MMCIPOWER);
+	}
+}
+
+/*
+ * This must be called with host->lock held
+ */
 static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 {
 	struct variant_data *variant = host->variant;
@@ -165,7 +187,7 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
 		clk |= MCI_ST_8BIT_BUS;
 
-	writel(clk, host->base + MMCICLOCK);
+	mmci_write_clkreg(host, clk);
 }
 
 static void
@@ -824,14 +846,13 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
 		 */
 		if (variant->sdio &&
 		    mmc_card_sdio(host->mmc->card)) {
+			u32 clk;
 			if (count < 8)
-				writel(readl(host->base + MMCICLOCK) &
-					~variant->clkreg_enable,
-					host->base + MMCICLOCK);
+				clk = host->clk_reg & ~variant->clkreg_enable;
 			else
-				writel(readl(host->base + MMCICLOCK) |
-					variant->clkreg_enable,
-					host->base + MMCICLOCK);
+				clk = host->clk_reg | variant->clkreg_enable;
+
+			mmci_write_clkreg(host, clk);
 		}
 
 		/*
@@ -1090,11 +1111,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	spin_lock_irqsave(&host->lock, flags);
 
 	mmci_set_clkreg(host, ios->clock);
-
-	if (host->pwr != pwr) {
-		host->pwr = pwr;
-		writel(pwr, host->base + MMCIPOWER);
-	}
+	mmci_write_pwrreg(host, pwr);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 89eb2e3..d437ccf 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -179,7 +179,8 @@ struct mmci_host {
 
 	unsigned int		mclk;
 	unsigned int		cclk;
-	u32			pwr;
+	u32			pwr_reg;
+	u32			clk_reg;
 	struct mmci_platform_data *plat;
 	struct variant_data	*variant;
 
-- 
1.7.5.4
