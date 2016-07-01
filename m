From: peter.chen@nxp.com (Peter Chen)
Date: Fri, 1 Jul 2016 17:41:55 +0800
Subject: [PATCH 1/7] extcon: add missing of_node_put after calling
 of_parse_phandle
In-Reply-To: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1467366121-14120-2-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/extcon/extcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 21a123c..86ea14d 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1107,10 +1107,12 @@ struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
 	list_for_each_entry(edev, &extcon_dev_list, entry) {
 		if (edev->dev.parent && edev->dev.parent->of_node == node) {
 			mutex_unlock(&extcon_dev_list_lock);
+			of_node_put(node);
 			return edev;
 		}
 	}
 	mutex_unlock(&extcon_dev_list_lock);
+	of_node_put(node);
 
 	return ERR_PTR(-EPROBE_DEFER);
 }
-- 
1.9.1
