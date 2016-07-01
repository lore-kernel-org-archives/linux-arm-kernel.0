From: peter.chen@nxp.com (Peter Chen)
Date: Fri, 1 Jul 2016 17:42:00 +0800
Subject: [PATCH 6/7] devfreq: add missing of_node_put after calling
 of_parse_phandle
In-Reply-To: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1467366121-14120-7-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/devfreq/devfreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1d6c803..3f2142f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -706,10 +706,12 @@ struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index)
 		if (devfreq->dev.parent
 			&& devfreq->dev.parent->of_node == node) {
 			mutex_unlock(&devfreq_list_lock);
+			of_node_put(node);
 			return devfreq;
 		}
 	}
 	mutex_unlock(&devfreq_list_lock);
+	of_node_put(node);
 
 	return ERR_PTR(-EPROBE_DEFER);
 }
-- 
1.9.1
