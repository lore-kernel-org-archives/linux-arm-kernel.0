From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:17 +0100
Subject: [PATCH 20/20] mmc: mmci: Enforce max frequency configuration through
 DT
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-21-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the option to provide a maximum frequency as platform data,
enforce it through DT.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c   |    5 +----
 include/linux/amba/mmci.h |    4 ----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 181445e..cbbb87e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1475,13 +1475,10 @@ static int mmci_probe(struct amba_device *dev,
 	 * If no maximum operating frequency is supplied, fall back to use
 	 * the module parameter, which has a (low) default value in case it
 	 * is not specified. Either value must not exceed the clock rate into
-	 * the block, of course. Also note that DT takes precedence over
-	 * platform data.
+	 * the block, of course.
 	 */
 	if (mmc->f_max)
 		mmc->f_max = min(host->mclk, mmc->f_max);
-	else if (plat->f_max)
-		mmc->f_max = min(host->mclk, plat->f_max);
 	else
 		mmc->f_max = min(host->mclk, fmax);
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index bf339ff..8c98113 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -9,9 +9,6 @@
 /**
  * struct mmci_platform_data - platform configuration for the MMCI
  * (also known as PL180) block.
- * @f_max: the maximum operational frequency for this host in this
- * platform configuration. When this is specified it takes precedence
- * over the module parameter for the same frequency.
  * @ocr_mask: available voltages on the 4 pins from the block, this
  * is ignored if a regulator is used, see the MMC_VDD_* masks in
  * mmc/host.h
@@ -28,7 +25,6 @@
  * @cd_invert: true if the gpio_cd pin value is active low
  */
 struct mmci_platform_data {
-	unsigned int f_max;
 	unsigned int ocr_mask;
 	int (*ios_handler)(struct device *, struct mmc_ios *);
 	unsigned int (*status)(struct device *);
-- 
1.7.9.5
