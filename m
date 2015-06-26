From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 26 Jun 2015 12:59:15 +0200
Subject: [PATCH v3 2/4] mfd: axp20x: Add missing registers,
 and mark more registers volatile
In-Reply-To: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1435316357-26606-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bruno Pr?mont <bonbons@linux-vserver.org>

Add an extra set of registers which is necessary tu support the PMICs
battery charger function, and mark registers which contain status bits,
gpio status, and adc readings as volatile.

Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
Signed-off-by: Bruno Pr?mont <bonbons@linux-vserver.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add a AXP20X_OCV_MAX define
Changes in v3:
-Add Bruno's S-o-b
---
 drivers/mfd/axp20x.c       | 8 +++++++-
 include/linux/mfd/axp20x.h | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 6df9155..f9a3c2d 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -39,10 +39,16 @@ static const char * const axp20x_model_names[] = {
 static const struct regmap_range axp20x_writeable_ranges[] = {
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
+	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(15)),
 };
 
 static const struct regmap_range axp20x_volatile_ranges[] = {
+	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_USB_OTG_STATUS),
+	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
+	regmap_reg_range(AXP20X_ACIN_V_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
+	regmap_reg_range(AXP20X_GPIO20_SS, AXP20X_GPIO3_CTRL),
+	regmap_reg_range(AXP20X_FG_RES, AXP20X_RDC_L),
 };
 
 static const struct regmap_access_table axp20x_writeable_table = {
@@ -159,7 +165,7 @@ static const struct regmap_config axp20x_regmap_config = {
 	.val_bits	= 8,
 	.wr_table	= &axp20x_writeable_table,
 	.volatile_table	= &axp20x_volatile_table,
-	.max_register	= AXP20X_FG_RES,
+	.max_register	= AXP20X_OCV(AXP20X_OCV_MAX),
 	.cache_type	= REGCACHE_RBTREE,
 };
 
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 5275423..6d8b39a 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -151,6 +151,12 @@ enum {
 #define AXP20X_CC_CTRL			0xb8
 #define AXP20X_FG_RES			0xb9
 
+/* OCV */
+#define AXP20X_RDC_H			0xba
+#define AXP20X_RDC_L			0xbb
+#define AXP20X_OCV(m)			(0xc0 + (m))
+#define AXP20X_OCV_MAX			0xf
+
 /* AXP22X specific registers */
 #define AXP22X_BATLOW_THRES1		0xe6
 
-- 
2.4.3
