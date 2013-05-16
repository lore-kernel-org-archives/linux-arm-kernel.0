From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 16 May 2013 11:57:10 +0200
Subject: [PATCH v2 5/6] usb: phy: samsung: Pass enable/disable callbacks
 through driver data
In-Reply-To: <1368698231-24268-1-git-send-email-t.figa@samsung.com>
References: <1368698231-24268-1-git-send-email-t.figa@samsung.com>
Message-ID: <1368698231-24268-6-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To remove unnecessary if statements, this patch introduces phy_enable
and phy_disable callbacks in driver data structure that implement
SoC-specific PHY initialization and deinitialization.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/phy/phy-samsung-usb.h  |  2 ++
 drivers/usb/phy/phy-samsung-usb2.c | 16 ++++++++--------
 drivers/usb/phy/phy-samsung-usb3.c | 10 +++++-----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/phy/phy-samsung-usb.h b/drivers/usb/phy/phy-samsung-usb.h
index 5203784..31e2ec3 100644
--- a/drivers/usb/phy/phy-samsung-usb.h
+++ b/drivers/usb/phy/phy-samsung-usb.h
@@ -272,6 +272,8 @@ struct samsung_usbphy_drvdata {
 	u32 hostphy_reg_offset;
 	int (*rate_to_clksel)(struct samsung_usbphy *, unsigned long);
 	void (*set_isolation)(struct samsung_usbphy *, bool);
+	void (*phy_enable)(struct samsung_usbphy *);
+	void (*phy_disable)(struct samsung_usbphy *);
 };
 
 /*
diff --git a/drivers/usb/phy/phy-samsung-usb2.c b/drivers/usb/phy/phy-samsung-usb2.c
index ae6da68..b81347b 100644
--- a/drivers/usb/phy/phy-samsung-usb2.c
+++ b/drivers/usb/phy/phy-samsung-usb2.c
@@ -291,10 +291,7 @@ static int samsung_usb2phy_init(struct usb_phy *phy)
 	samsung_usbphy_cfg_sel(sphy);
 
 	/* Initialize usb phy registers */
-	if (sphy->drv_data->cpu_type == TYPE_EXYNOS5250)
-		samsung_exynos5_usb2phy_enable(sphy);
-	else
-		samsung_usb2phy_enable(sphy);
+	sphy->drv_data->phy_enable(sphy);
 
 	spin_unlock_irqrestore(&sphy->lock, flags);
 
@@ -334,10 +331,7 @@ static void samsung_usb2phy_shutdown(struct usb_phy *phy)
 	}
 
 	/* De-initialize usb phy registers */
-	if (sphy->drv_data->cpu_type == TYPE_EXYNOS5250)
-		samsung_exynos5_usb2phy_disable(sphy);
-	else
-		samsung_usb2phy_disable(sphy);
+	sphy->drv_data->phy_disable(sphy);
 
 	/* Enable phy isolation */
 	if (sphy->plat && sphy->plat->pmu_isolation)
@@ -448,6 +442,8 @@ static const struct samsung_usbphy_drvdata usb2phy_s3c64xx = {
 	.devphy_en_mask		= S3C64XX_USBPHY_ENABLE,
 	.rate_to_clksel		= samsung_usbphy_rate_to_clksel_64xx,
 	.set_isolation		= NULL, /* TODO */
+	.phy_enable		= samsung_usb2phy_enable,
+	.phy_disable		= samsung_usb2phy_disable,
 };
 
 static const struct samsung_usbphy_drvdata usb2phy_exynos4 = {
@@ -456,6 +452,8 @@ static const struct samsung_usbphy_drvdata usb2phy_exynos4 = {
 	.hostphy_en_mask	= EXYNOS_USBPHY_ENABLE,
 	.rate_to_clksel		= samsung_usbphy_rate_to_clksel_64xx,
 	.set_isolation		= samsung_usbphy_set_isolation_4210,
+	.phy_enable		= samsung_usb2phy_enable,
+	.phy_disable		= samsung_usb2phy_disable,
 };
 
 static struct samsung_usbphy_drvdata usb2phy_exynos5 = {
@@ -464,6 +462,8 @@ static struct samsung_usbphy_drvdata usb2phy_exynos5 = {
 	.hostphy_reg_offset	= EXYNOS_USBHOST_PHY_CTRL_OFFSET,
 	.rate_to_clksel		= samsung_usbphy_rate_to_clksel_4x12,
 	.set_isolation		= samsung_usbphy_set_isolation_4210,
+	.phy_enable		= samsung_exynos5_usb2phy_enable,
+	.phy_disable		= samsung_exynos5_usb2phy_disable,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/usb/phy/phy-samsung-usb3.c b/drivers/usb/phy/phy-samsung-usb3.c
index ae232ad..b663353 100644
--- a/drivers/usb/phy/phy-samsung-usb3.c
+++ b/drivers/usb/phy/phy-samsung-usb3.c
@@ -65,7 +65,7 @@ static u32 samsung_usb3phy_set_refclk(struct samsung_usbphy *sphy)
 	return reg;
 }
 
-static int samsung_exynos5_usb3phy_enable(struct samsung_usbphy *sphy)
+static void samsung_exynos5_usb3phy_enable(struct samsung_usbphy *sphy)
 {
 	void __iomem *regs = sphy->regs;
 	u32 phyparam0;
@@ -133,8 +133,6 @@ static int samsung_exynos5_usb3phy_enable(struct samsung_usbphy *sphy)
 
 	phyclkrst &= ~(PHYCLKRST_PORTRESET);
 	writel(phyclkrst, regs + EXYNOS5_DRD_PHYCLKRST);
-
-	return 0;
 }
 
 static void samsung_exynos5_usb3phy_disable(struct samsung_usbphy *sphy)
@@ -188,7 +186,7 @@ static int samsung_usb3phy_init(struct usb_phy *phy)
 		sphy->drv_data->set_isolation(sphy, false);
 
 	/* Initialize usb phy registers */
-	samsung_exynos5_usb3phy_enable(sphy);
+	sphy->drv_data->phy_enable(sphy);
 
 	spin_unlock_irqrestore(&sphy->lock, flags);
 
@@ -219,7 +217,7 @@ static void samsung_usb3phy_shutdown(struct usb_phy *phy)
 	samsung_usbphy_set_type(&sphy->phy, USB_PHY_TYPE_DEVICE);
 
 	/* De-initialize usb phy registers */
-	samsung_exynos5_usb3phy_disable(sphy);
+	sphy->drv_data->phy_disable(sphy);
 
 	/* Enable phy isolation */
 	if (sphy->drv_data->set_isolation)
@@ -312,6 +310,8 @@ static struct samsung_usbphy_drvdata usb3phy_exynos5 = {
 	.devphy_en_mask		= EXYNOS_USBPHY_ENABLE,
 	.rate_to_clksel		= samsung_usbphy_rate_to_clksel_4x12,
 	.set_isolation		= samsung_usbphy_set_isolation_4210,
+	.phy_enable		= samsung_exynos5_usb3phy_enable,
+	.phy_disable		= samsung_exynos5_usb3phy_disable,
 };
 
 #ifdef CONFIG_OF
-- 
1.8.2.1
