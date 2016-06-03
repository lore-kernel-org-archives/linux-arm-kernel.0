From: hongkun.cao@mediatek.com (hongkun.cao at mediatek.com)
Date: Fri, 3 Jun 2016 11:28:14 +0800
Subject: [PATCH] pinctrl: mediatek: fix suspend/resume timing issue
Message-ID: <1464924495-20375-1-git-send-email-hongkun.cao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "hongkun.cao" <hongkun.cao@mediatek.com>

An irq which is a wake up source maybe masked unexpectedly if the wake
up source irq was triggered after pinctrl irqchip suspend and before
suspend_device_irqs finished.
Use *_noirq callbacks to guarantee pinctrl irqchip suspend would be
called after suspend_devices_irqs.

Signed-off-by: hongkun.cao <hongkun.cao@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index a607655..ce554e0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1183,8 +1183,8 @@ static int mtk_eint_resume(struct device *device)
 }
 
 const struct dev_pm_ops mtk_eint_pm_ops = {
-	.suspend = mtk_eint_suspend,
-	.resume = mtk_eint_resume,
+	.suspend_noirq = mtk_eint_suspend,
+	.resume_noirq = mtk_eint_resume,
 };
 
 static void mtk_eint_ack(struct irq_data *d)
-- 
1.9.1
