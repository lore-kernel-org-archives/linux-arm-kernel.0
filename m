From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 16 May 2013 11:57:11 +0200
Subject: [PATCH v2 6/6] usb: phy: samsung: Add support for USB 2.0 PHY on
 Exynos 4x12
In-Reply-To: <1368698231-24268-1-git-send-email-t.figa@samsung.com>
References: <1368698231-24268-1-git-send-email-t.figa@samsung.com>
Message-ID: <1368698231-24268-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds driver data for Exynos 4x12 USB 2.0 PHY.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/phy/phy-samsung-usb.h  |  1 +
 drivers/usb/phy/phy-samsung-usb2.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/usb/phy/phy-samsung-usb.h b/drivers/usb/phy/phy-samsung-usb.h
index 31e2ec3..585d12f 100644
--- a/drivers/usb/phy/phy-samsung-usb.h
+++ b/drivers/usb/phy/phy-samsung-usb.h
@@ -241,6 +241,7 @@
 enum samsung_cpu_type {
 	TYPE_S3C64XX,
 	TYPE_EXYNOS4210,
+	TYPE_EXYNOS4X12,
 	TYPE_EXYNOS5250,
 };
 
diff --git a/drivers/usb/phy/phy-samsung-usb2.c b/drivers/usb/phy/phy-samsung-usb2.c
index b81347b..381f8d4 100644
--- a/drivers/usb/phy/phy-samsung-usb2.c
+++ b/drivers/usb/phy/phy-samsung-usb2.c
@@ -177,6 +177,7 @@ static void samsung_usb2phy_enable(struct samsung_usbphy *sphy)
 		rstcon |= RSTCON_SWRST;
 		break;
 	case TYPE_EXYNOS4210:
+	case TYPE_EXYNOS4X12:
 		phypwr &= ~PHYPWR_NORMAL_MASK_PHY0;
 		rstcon |= RSTCON_SWRST;
 	default:
@@ -240,6 +241,7 @@ static void samsung_usb2phy_disable(struct samsung_usbphy *sphy)
 		phypwr |= PHYPWR_NORMAL_MASK;
 		break;
 	case TYPE_EXYNOS4210:
+	case TYPE_EXYNOS4X12:
 		phypwr |= PHYPWR_NORMAL_MASK_PHY0;
 	default:
 		break;
@@ -456,6 +458,16 @@ static const struct samsung_usbphy_drvdata usb2phy_exynos4 = {
 	.phy_disable		= samsung_usb2phy_disable,
 };
 
+static const struct samsung_usbphy_drvdata usb2phy_exynos4x12 = {
+	.cpu_type		= TYPE_EXYNOS4X12,
+	.devphy_en_mask		= EXYNOS_USBPHY_ENABLE,
+	.hostphy_en_mask	= EXYNOS_USBPHY_ENABLE,
+	.rate_to_clksel		= samsung_usbphy_rate_to_clksel_4x12,
+	.set_isolation		= samsung_usbphy_set_isolation_4210,
+	.phy_enable		= samsung_usb2phy_enable,
+	.phy_disable		= samsung_usb2phy_disable,
+};
+
 static struct samsung_usbphy_drvdata usb2phy_exynos5 = {
 	.cpu_type		= TYPE_EXYNOS5250,
 	.hostphy_en_mask	= EXYNOS_USBPHY_ENABLE,
@@ -475,6 +487,9 @@ static const struct of_device_id samsung_usbphy_dt_match[] = {
 		.compatible = "samsung,exynos4210-usb2phy",
 		.data = &usb2phy_exynos4,
 	}, {
+		.compatible = "samsung,exynos4x12-usb2phy",
+		.data = &usb2phy_exynos4x12,
+	}, {
 		.compatible = "samsung,exynos5250-usb2phy",
 		.data = &usb2phy_exynos5
 	},
@@ -491,6 +506,9 @@ static struct platform_device_id samsung_usbphy_driver_ids[] = {
 		.name		= "exynos4210-usb2phy",
 		.driver_data	= (unsigned long)&usb2phy_exynos4,
 	}, {
+		.name		= "exynos4x12-usb2phy",
+		.driver_data	= (unsigned long)&usb2phy_exynos4x12,
+	}, {
 		.name		= "exynos5250-usb2phy",
 		.driver_data	= (unsigned long)&usb2phy_exynos5,
 	},
-- 
1.8.2.1
