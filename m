From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 16 May 2013 11:57:09 +0200
Subject: [PATCH v2 4/6] usb: phy: samsung: Pass set_isolation callback through
 driver data
In-Reply-To: <1368698231-24268-1-git-send-email-t.figa@samsung.com>
References: <1368698231-24268-1-git-send-email-t.figa@samsung.com>
Message-ID: <1368698231-24268-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends driver data structure with set_isolation callback,
which allows to remove the need for checking for SoC type in a switch
statement.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/phy/phy-samsung-usb.c  | 36 ++++++++----------------------------
 drivers/usb/phy/phy-samsung-usb.h  |  4 +++-
 drivers/usb/phy/phy-samsung-usb2.c | 11 +++++++----
 drivers/usb/phy/phy-samsung-usb3.c |  7 +++++--
 4 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/phy/phy-samsung-usb.c b/drivers/usb/phy/phy-samsung-usb.c
index c40ea32..7a1ed90 100644
--- a/drivers/usb/phy/phy-samsung-usb.c
+++ b/drivers/usb/phy/phy-samsung-usb.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL_GPL(samsung_usbphy_parse_dt);
  * Here 'on = true' would mean USB PHY block is isolated, hence
  * de-activated and vice-versa.
  */
-void samsung_usbphy_set_isolation(struct samsung_usbphy *sphy, bool on)
+void samsung_usbphy_set_isolation_4210(struct samsung_usbphy *sphy, bool on)
 {
 	void __iomem *reg = NULL;
 	u32 reg_val;
@@ -84,32 +84,12 @@ void samsung_usbphy_set_isolation(struct samsung_usbphy *sphy, bool on)
 		return;
 	}
 
-	switch (sphy->drv_data->cpu_type) {
-	case TYPE_S3C64XX:
-		/*
-		 * Do nothing: We will add here once S3C64xx goes for DT support
-		 */
-		break;
-	case TYPE_EXYNOS4210:
-		/*
-		 * Fall through since exynos4210 and exynos5250 have similar
-		 * register architecture: two separate registers for host and
-		 * device phy control with enable bit at position 0.
-		 */
-	case TYPE_EXYNOS5250:
-		if (sphy->phy_type == USB_PHY_TYPE_DEVICE) {
-			reg = sphy->pmuregs +
-				sphy->drv_data->devphy_reg_offset;
-			en_mask = sphy->drv_data->devphy_en_mask;
-		} else if (sphy->phy_type == USB_PHY_TYPE_HOST) {
-			reg = sphy->pmuregs +
-				sphy->drv_data->hostphy_reg_offset;
-			en_mask = sphy->drv_data->hostphy_en_mask;
-		}
-		break;
-	default:
-		dev_err(sphy->dev, "Invalid SoC type\n");
-		return;
+	if (sphy->phy_type == USB_PHY_TYPE_DEVICE) {
+		reg = sphy->pmuregs + sphy->drv_data->devphy_reg_offset;
+		en_mask = sphy->drv_data->devphy_en_mask;
+	} else if (sphy->phy_type == USB_PHY_TYPE_HOST) {
+		reg = sphy->pmuregs + sphy->drv_data->hostphy_reg_offset;
+		en_mask = sphy->drv_data->hostphy_en_mask;
 	}
 
 	reg_val = readl(reg);
@@ -121,7 +101,7 @@ void samsung_usbphy_set_isolation(struct samsung_usbphy *sphy, bool on)
 
 	writel(reg_val, reg);
 }
-EXPORT_SYMBOL_GPL(samsung_usbphy_set_isolation);
+EXPORT_SYMBOL_GPL(samsung_usbphy_set_isolation_4210);
 
 /*
  * Configure the mode of working of usb-phy here: HOST/DEVICE.
diff --git a/drivers/usb/phy/phy-samsung-usb.h b/drivers/usb/phy/phy-samsung-usb.h
index 0336f6b..5203784 100644
--- a/drivers/usb/phy/phy-samsung-usb.h
+++ b/drivers/usb/phy/phy-samsung-usb.h
@@ -271,6 +271,7 @@ struct samsung_usbphy_drvdata {
 	u32 devphy_reg_offset;
 	u32 hostphy_reg_offset;
 	int (*rate_to_clksel)(struct samsung_usbphy *, unsigned long);
+	void (*set_isolation)(struct samsung_usbphy *, bool);
 };
 
 /*
@@ -323,7 +324,8 @@ static inline const struct samsung_usbphy_drvdata
 }
 
 extern int samsung_usbphy_parse_dt(struct samsung_usbphy *sphy);
-extern void samsung_usbphy_set_isolation(struct samsung_usbphy *sphy, bool on);
+extern void samsung_usbphy_set_isolation_4210(struct samsung_usbphy *sphy,
+								bool on);
 extern void samsung_usbphy_cfg_sel(struct samsung_usbphy *sphy);
 extern int samsung_usbphy_set_type(struct usb_phy *phy,
 					enum samsung_usb_phy_type phy_type);
diff --git a/drivers/usb/phy/phy-samsung-usb2.c b/drivers/usb/phy/phy-samsung-usb2.c
index 802e738..ae6da68 100644
--- a/drivers/usb/phy/phy-samsung-usb2.c
+++ b/drivers/usb/phy/phy-samsung-usb2.c
@@ -284,8 +284,8 @@ static int samsung_usb2phy_init(struct usb_phy *phy)
 	/* Disable phy isolation */
 	if (sphy->plat && sphy->plat->pmu_isolation)
 		sphy->plat->pmu_isolation(false);
-	else
-		samsung_usbphy_set_isolation(sphy, false);
+	else if (sphy->drv_data->set_isolation)
+		sphy->drv_data->set_isolation(sphy, false);
 
 	/* Selecting Host/OTG mode; After reset USB2.0PHY_CFG: HOST */
 	samsung_usbphy_cfg_sel(sphy);
@@ -342,8 +342,8 @@ static void samsung_usb2phy_shutdown(struct usb_phy *phy)
 	/* Enable phy isolation */
 	if (sphy->plat && sphy->plat->pmu_isolation)
 		sphy->plat->pmu_isolation(true);
-	else
-		samsung_usbphy_set_isolation(sphy, true);
+	else if (sphy->drv_data->set_isolation)
+		sphy->drv_data->set_isolation(sphy, true);
 
 	spin_unlock_irqrestore(&sphy->lock, flags);
 
@@ -447,6 +447,7 @@ static const struct samsung_usbphy_drvdata usb2phy_s3c64xx = {
 	.cpu_type		= TYPE_S3C64XX,
 	.devphy_en_mask		= S3C64XX_USBPHY_ENABLE,
 	.rate_to_clksel		= samsung_usbphy_rate_to_clksel_64xx,
+	.set_isolation		= NULL, /* TODO */
 };
 
 static const struct samsung_usbphy_drvdata usb2phy_exynos4 = {
@@ -454,6 +455,7 @@ static const struct samsung_usbphy_drvdata usb2phy_exynos4 = {
 	.devphy_en_mask		= EXYNOS_USBPHY_ENABLE,
 	.hostphy_en_mask	= EXYNOS_USBPHY_ENABLE,
 	.rate_to_clksel		= samsung_usbphy_rate_to_clksel_64xx,
+	.set_isolation		= samsung_usbphy_set_isolation_4210,
 };
 
 static struct samsung_usbphy_drvdata usb2phy_exynos5 = {
@@ -461,6 +463,7 @@ static struct samsung_usbphy_drvdata usb2phy_exynos5 = {
 	.hostphy_en_mask	= EXYNOS_USBPHY_ENABLE,
 	.hostphy_reg_offset	= EXYNOS_USBHOST_PHY_CTRL_OFFSET,
 	.rate_to_clksel		= samsung_usbphy_rate_to_clksel_4x12,
+	.set_isolation		= samsung_usbphy_set_isolation_4210,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/usb/phy/phy-samsung-usb3.c b/drivers/usb/phy/phy-samsung-usb3.c
index c07bc32..ae232ad 100644
--- a/drivers/usb/phy/phy-samsung-usb3.c
+++ b/drivers/usb/phy/phy-samsung-usb3.c
@@ -184,7 +184,8 @@ static int samsung_usb3phy_init(struct usb_phy *phy)
 	samsung_usbphy_set_type(&sphy->phy, USB_PHY_TYPE_DEVICE);
 
 	/* Disable phy isolation */
-	samsung_usbphy_set_isolation(sphy, false);
+	if (sphy->drv_data->set_isolation)
+		sphy->drv_data->set_isolation(sphy, false);
 
 	/* Initialize usb phy registers */
 	samsung_exynos5_usb3phy_enable(sphy);
@@ -221,7 +222,8 @@ static void samsung_usb3phy_shutdown(struct usb_phy *phy)
 	samsung_exynos5_usb3phy_disable(sphy);
 
 	/* Enable phy isolation */
-	samsung_usbphy_set_isolation(sphy, true);
+	if (sphy->drv_data->set_isolation)
+		sphy->drv_data->set_isolation(sphy, true);
 
 	spin_unlock_irqrestore(&sphy->lock, flags);
 
@@ -309,6 +311,7 @@ static struct samsung_usbphy_drvdata usb3phy_exynos5 = {
 	.cpu_type		= TYPE_EXYNOS5250,
 	.devphy_en_mask		= EXYNOS_USBPHY_ENABLE,
 	.rate_to_clksel		= samsung_usbphy_rate_to_clksel_4x12,
+	.set_isolation		= samsung_usbphy_set_isolation_4210,
 };
 
 #ifdef CONFIG_OF
-- 
1.8.2.1
