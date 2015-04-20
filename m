From: colin.king@canonical.com (Colin King)
Date: Mon, 20 Apr 2015 06:15:16 -0500
Subject: [PATCH] pinctrl: mediatek: mtk-common: initialize unmask
Message-ID: <1429528516-9245-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

cppcheck detected an unitialized variable:

[drivers/pinctrl/mediatek/pinctrl-mtk-common.c:897]:
  (error) Uninitialized variable: unmask

unmask should be initialized to zero to ensure unmasking
only occurs if a previous mask occurred. The current situation
is that the unmask variable could contain any random garbage
causing random unexpected unmasking.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 493294c..3173125 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -881,7 +881,8 @@ static int mtk_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
 	if (!mtk_eint_get_mask(pctl, eint_num)) {
 		mtk_eint_mask(d);
 		unmask = 1;
-	}
+	} else
+		unmask = 0;
 
 	clr_bit = 0xff << eint_offset;
 	writel(clr_bit, pctl->eint_reg_base + clr_offset);
-- 
2.1.4
