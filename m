From: hongkun.cao@mediatek.com (hongkun.cao at mediatek.com)
Date: Sat, 21 May 2016 15:23:39 +0800
Subject: [PATCH] pinctrl: mediatek: fix dual-edge code defect
Message-ID: <1463815419-11719-1-git-send-email-hongkun.cao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "hongkun.cao" <hongkun.cao@mediatek.com>

When a dual-edge irq is triggered, an incorrect irq will be reported on
condition that the external signal is not stable and this incorrect irq
has been registered.
Correct the register offset.

Signed-off-by: hongkun.cao <hongkun.cao@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 2bbe6f7..92ae49f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1255,9 +1255,10 @@ static void mtk_eint_irq_handler(struct irq_desc *desc)
 	const struct mtk_desc_pin *pin;
 
 	chained_irq_enter(chip, desc);
-	for (eint_num = 0; eint_num < pctl->devdata->ap_num; eint_num += 32) {
+	for (eint_num = 0;
+	     eint_num < pctl->devdata->ap_num;
+	     eint_num += 32, reg += 4) {
 		status = readl(reg);
-		reg += 4;
 		while (status) {
 			offset = __ffs(status);
 			index = eint_num + offset;
-- 
1.7.9.5
