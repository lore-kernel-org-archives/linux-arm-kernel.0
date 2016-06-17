From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 17 Jun 2016 08:26:56 +0200
Subject: [PATCH v2 06/10] driver core: Avoid endless recursion if device has
 more than one link
In-Reply-To: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1466144820-6286-7-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes endless recursion, which happends when device has
more than one link.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/base/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 215cd44de761..4e778539b750 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -57,7 +57,8 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
 	device_pm_move_last(dev);
 	device_for_each_child(dev, NULL, device_reorder_to_tail);
 	list_for_each_entry(link, &dev->consumer_links, c_node)
-		device_reorder_to_tail(link->consumer, NULL);
+		if (link->consumer != dev)
+			device_reorder_to_tail(link->consumer, NULL);
 
 	return 0;
 }
-- 
1.9.1
