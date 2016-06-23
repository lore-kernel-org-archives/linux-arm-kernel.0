From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 23 Jun 2016 00:53:24 -0700
Subject: [PATCH] extcon: Check for incorrect connection type in notifier
 register
Message-ID: <20160623075324.21935-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we call extcon_register_notifier() with the wrong cable type,
it blows up with an oops instead of returning an error code.
Let's be nice and fail gracefully given that the consumer might
not know if the cable is supported by the extcon provider.

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/extcon/extcon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 21a123cadf78..161acb826334 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -586,6 +586,8 @@ int extcon_register_notifier(struct extcon_dev *edev, unsigned int id,
 		return -EINVAL;
 
 	idx = find_cable_index_by_id(edev, id);
+	if (idx < 0)
+		return idx;
 
 	spin_lock_irqsave(&edev->lock, flags);
 	ret = raw_notifier_chain_register(&edev->nh[idx], nb);
@@ -611,6 +613,8 @@ int extcon_unregister_notifier(struct extcon_dev *edev, unsigned int id,
 		return -EINVAL;
 
 	idx = find_cable_index_by_id(edev, id);
+	if (idx < 0)
+		return idx;
 
 	spin_lock_irqsave(&edev->lock, flags);
 	ret = raw_notifier_chain_unregister(&edev->nh[idx], nb);
-- 
2.9.0.rc2.8.ga28705d
