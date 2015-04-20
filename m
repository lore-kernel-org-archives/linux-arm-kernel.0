From: colin.king@canonical.com (Colin King)
Date: Mon, 20 Apr 2015 10:59:17 -0500
Subject: [PATCH][V2] pinctrl: mediatek: mtk-common: initialize unmask
Message-ID: <1429545557-3404-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

cppcheck detected an uninitialized variable:

[drivers/pinctrl/mediatek/pinctrl-mtk-common.c:897]:
  (error) Uninitialized variable: unmask

unmask should be initialized to zero to ensure unmasking
only occurs if a previous mask occurred. The current situation
is that the unmask variable could contain any random garbage
causing random unexpected unmasking.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 493294c..474812e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -881,6 +881,8 @@ static int mtk_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
 	if (!mtk_eint_get_mask(pctl, eint_num)) {
 		mtk_eint_mask(d);
 		unmask = 1;
+	} else {
+		unmask = 0;
 	}
 
 	clr_bit = 0xff << eint_offset;
-- 
2.1.4
