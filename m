From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 8 Mar 2010 19:39:02 +0100
Subject: [PATCH 6/7] ARM: SAMSUNG: Add broken_card_detection field to HSMMC
	platform data
Message-ID: <b2e8f9f71003081039w75a32a02m51d8e17ea0e34264@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is useful when your board uses multiple HSMMC controllers and
only some of them have broken card detection.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/plat-samsung/dev-hsmmc.c          |    1 +
 arch/arm/plat-samsung/dev-hsmmc1.c         |    1 +
 arch/arm/plat-samsung/dev-hsmmc2.c         |    1 +
 arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
 drivers/mmc/host/sdhci-s3c.c               |    3 +++
 5 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-hsmmc.c
b/arch/arm/plat-samsung/dev-hsmmc.c
index 4c05b39..09c1af9 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -60,6 +60,7 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc0_def_platdata;

 	set->max_width = pd->max_width;
+	set->broken_card_detection = pd->broken_card_detection;

 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c
b/arch/arm/plat-samsung/dev-hsmmc1.c
index e49bc4c..11421a6 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -60,6 +60,7 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc1_def_platdata;

 	set->max_width = pd->max_width;
+	set->broken_card_detection = pd->broken_card_detection;

 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c
b/arch/arm/plat-samsung/dev-hsmmc2.c
index 824580b..dccc581 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -61,6 +61,7 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 	struct s3c_sdhci_platdata *set = &s3c_hsmmc2_def_platdata;

 	set->max_width = pd->max_width;
+	set->broken_card_detection = pd->broken_card_detection;

 	if (pd->cfg_gpio)
 		set->cfg_gpio = pd->cfg_gpio;
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h
b/arch/arm/plat-samsung/include/plat/sdhci.h
index 7d07cd7..6763af7 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -24,6 +24,7 @@ struct mmc_ios;
  * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
  * @max_width: The maximum number of data bits supported.
  * @host_caps: Standard MMC host capabilities bit field.
+ * @broken_card_detection: Quirk for broken card detection.
  * @cfg_gpio: Configure the GPIO for a specific card bit-width
  * @cfg_card: Configure the interface for a specific card and speed. This
  *            is necessary the controllers and/or GPIO blocks require the
@@ -37,6 +38,7 @@ struct mmc_ios;
 struct s3c_sdhci_platdata {
 	unsigned int	max_width;
 	unsigned int	host_caps;
+	bool		broken_card_detection;

 	char		**clocks;	/* set of clock sources */

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 50997d2..08cf90a 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -342,6 +342,9 @@ static int __devinit sdhci_s3c_probe(struct
platform_device *pdev)
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);

+	if (pdata->broken_card_detection)
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(dev, "sdhci_add_host() failed\n");
-- 
1.7.0.1
