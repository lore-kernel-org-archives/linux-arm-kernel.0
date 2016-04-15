From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 15 Apr 2016 15:32:49 +0900
Subject: [PATCH v2 2/8] PM / devfreq: event: Find the instance of devfreq-event
 device by using phandle
In-Reply-To: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1460701975-24178-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch use the phandle to find the instance of devfreq-event device in
Device Tree when calling the devfreq_event_get_edev_by_phandle() because there
is two type devfreq-event devices as following:

First case, exynos-ppmu.c driver provides the maximum four event of each PPMU.
So, when getting the instance of devfreq-event device, using the unique name of
struct devfreq_event_desc.

Second case, exynos-nocp.c driver provide the only one event of each NoC Probe
device. So, when getting the instance of devfreq-event device, using the
phandle of each NoC probe device.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq-event.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 38bf144ca147..39b048eda2ce 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -235,6 +235,11 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
 
 	mutex_lock(&devfreq_event_list_lock);
 	list_for_each_entry(edev, &devfreq_event_list, node) {
+		if (edev->dev.parent && edev->dev.parent->of_node == node)
+			goto out;
+	}
+
+	list_for_each_entry(edev, &devfreq_event_list, node) {
 		if (!strcmp(edev->desc->name, node->name))
 			goto out;
 	}
-- 
1.9.1
