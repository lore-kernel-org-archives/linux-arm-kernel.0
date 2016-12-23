From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 23 Dec 2016 13:24:43 +0100
Subject: [PATCH 3/9] pinctrl: samsung: Remove dead code
In-Reply-To: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122524epcas1p4f0235bcdabe1e7bffa141e0b2e32de7f@epcas1p4.samsung.com>
Message-ID: <1482495889-6201-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'enable' parameter has been removed a while ago, so all code for handling
it can be simply removed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 41e62391c33c..4d9262051ff1 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -356,7 +356,7 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
 
 /* enable or disable a pinmux function */
 static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
-					unsigned group, bool enable)
+					unsigned group)
 {
 	struct samsung_pinctrl_drv_data *drvdata;
 	const struct samsung_pin_bank_type *type;
@@ -386,8 +386,7 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 
 	data = readl(reg + type->reg_offset[PINCFG_TYPE_FUNC]);
 	data &= ~(mask << shift);
-	if (enable)
-		data |= func->val << shift;
+	data |= func->val << shift;
 	writel(data, reg + type->reg_offset[PINCFG_TYPE_FUNC]);
 
 	spin_unlock_irqrestore(&bank->slock, flags);
@@ -398,7 +397,7 @@ static int samsung_pinmux_set_mux(struct pinctrl_dev *pctldev,
 				  unsigned selector,
 				  unsigned group)
 {
-	samsung_pinmux_setup(pctldev, selector, group, true);
+	samsung_pinmux_setup(pctldev, selector, group);
 	return 0;
 }
 
-- 
1.9.1
