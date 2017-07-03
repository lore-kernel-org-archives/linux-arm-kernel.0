From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Mon, 3 Jul 2017 14:24:56 +0800
Subject: [PATCH] mmc: mediatek: add ops->get_cd() support
Message-ID: <1499063096-10604-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if user plug out sd card slowly, finally card is plugged out but
cat /proc/partitions can find that card is still exist in kernel.
that's because alougth get card detect interrupt but CMD13 still
can get correct response(all other pins are connected expect card
detect pin).
add ops->get_cd() can avoid this issue.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5c1e178..975c765 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1585,6 +1585,7 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	.request = msdc_ops_request,
 	.set_ios = msdc_ops_set_ios,
 	.get_ro = mmc_gpio_get_ro,
+	.get_cd = mmc_gpio_get_cd,
 	.start_signal_voltage_switch = msdc_ops_switch_volt,
 	.card_busy = msdc_card_busy,
 	.execute_tuning = msdc_execute_tuning,
-- 
1.8.1.1.dirty
