From: blogic@openwrt.org (John Crispin)
Date: Sun,  7 Feb 2016 11:42:51 +0100
Subject: [PATCH V5 04/11] soc: mediatek: PMIC wrap: split SoC specific init
 into callback
In-Reply-To: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
References: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
Message-ID: <1454841778-35529-5-git-send-email-blogic@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the SoC specific wrapper init code into separate callback
to avoid pwrap_init() getting too large.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
Changes in V5
* only check the return code of init_special() if the function is
  actually called

 drivers/soc/mediatek/mtk-pmic-wrap.c |   67 +++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index b22b664..e3bbee5 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -372,6 +372,7 @@ struct pmic_wrapper_type {
 	enum pwrap_type type;
 	u32 arb_en_all;
 	int (*init_reg_clock)(struct pmic_wrapper *wrp);
+	int (*init_special)(struct pmic_wrapper *wrp);
 };
 
 static inline int pwrap_is_mt8135(struct pmic_wrapper *wrp)
@@ -665,6 +666,41 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	return 0;
 }
 
+static int pwrap_mt8135_init_special(struct pmic_wrapper *wrp)
+{
+	/* enable pwrap events and pwrap bridge in AP side */
+	pwrap_writel(wrp, 0x1, PWRAP_EVENT_IN_EN);
+	pwrap_writel(wrp, 0xffff, PWRAP_EVENT_DST_EN);
+	writel(0x7f, wrp->bridge_base + PWRAP_MT8135_BRIDGE_IORD_ARB_EN);
+	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WACS3_EN);
+	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WACS4_EN);
+	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WDT_UNIT);
+	writel(0xffff, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WDT_SRC_EN);
+	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_TIMER_EN);
+	writel(0x7ff, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INT_EN);
+
+	/* enable PMIC event out and sources */
+	if (pwrap_write(wrp, PWRAP_DEW_EVENT_OUT_EN, 0x1) ||
+		pwrap_write(wrp, PWRAP_DEW_EVENT_SRC_EN, 0xffff)) {
+		dev_err(wrp->dev, "enable dewrap fail\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int pwrap_mt8173_init_special(struct pmic_wrapper *wrp)
+{
+	/* PMIC_DEWRAP enables */
+	if (pwrap_write(wrp, PWRAP_DEW_EVENT_OUT_EN, 0x1) ||
+		pwrap_write(wrp, PWRAP_DEW_EVENT_SRC_EN, 0xffff)) {
+		dev_err(wrp->dev, "enable dewrap fail\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int pwrap_init(struct pmic_wrapper *wrp)
 {
 	int ret;
@@ -743,31 +779,10 @@ static int pwrap_init(struct pmic_wrapper *wrp)
 	pwrap_writel(wrp, 0x5, PWRAP_STAUPD_PRD);
 	pwrap_writel(wrp, 0xff, PWRAP_STAUPD_GRPEN);
 
-	if (pwrap_is_mt8135(wrp)) {
-		/* enable pwrap events and pwrap bridge in AP side */
-		pwrap_writel(wrp, 0x1, PWRAP_EVENT_IN_EN);
-		pwrap_writel(wrp, 0xffff, PWRAP_EVENT_DST_EN);
-		writel(0x7f, wrp->bridge_base + PWRAP_MT8135_BRIDGE_IORD_ARB_EN);
-		writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WACS3_EN);
-		writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WACS4_EN);
-		writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WDT_UNIT);
-		writel(0xffff, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WDT_SRC_EN);
-		writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_TIMER_EN);
-		writel(0x7ff, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INT_EN);
-
-		/* enable PMIC event out and sources */
-		if (pwrap_write(wrp, PWRAP_DEW_EVENT_OUT_EN, 0x1) ||
-				pwrap_write(wrp, PWRAP_DEW_EVENT_SRC_EN, 0xffff)) {
-			dev_err(wrp->dev, "enable dewrap fail\n");
-			return -EFAULT;
-		}
-	} else {
-		/* PMIC_DEWRAP enables */
-		if (pwrap_write(wrp, PWRAP_DEW_EVENT_OUT_EN, 0x1) ||
-				pwrap_write(wrp, PWRAP_DEW_EVENT_SRC_EN, 0xffff)) {
-			dev_err(wrp->dev, "enable dewrap fail\n");
-			return -EFAULT;
-		}
+	if (wrp->master->init_special) {
+		ret = wrp->master->init_special(wrp);
+		if (ret)
+			return ret;
 	}
 
 	/* Setup the init done registers */
@@ -811,6 +826,7 @@ static struct pmic_wrapper_type pwrap_mt8135 = {
 	.type = PWRAP_MT8135,
 	.arb_en_all = 0x1ff,
 	.init_reg_clock = pwrap_mt8135_init_reg_clock,
+	.init_special = pwrap_mt8135_init_special,
 };
 
 static struct pmic_wrapper_type pwrap_mt8173 = {
@@ -818,6 +834,7 @@ static struct pmic_wrapper_type pwrap_mt8173 = {
 	.type = PWRAP_MT8173,
 	.arb_en_all = 0x3f,
 	.init_reg_clock = pwrap_mt8173_init_reg_clock,
+	.init_special = pwrap_mt8173_init_special,
 };
 
 static struct of_device_id of_pwrap_match_tbl[] = {
-- 
1.7.10.4
