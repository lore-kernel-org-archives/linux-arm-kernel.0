From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 21 Mar 2015 17:26:24 +0100
Subject: [PATCH] extcon: Fix missing locking when [un]registering notifiers
Message-ID: <1426955184-3727-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since extcon-class.c is using raw_notifiers it must protect the notifier
list itself when [un]registering notifiers to avoid the list changing while
extcon_update_state is walking the list (through raw_notifier_call_chain).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-class.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-class.c b/drivers/extcon/extcon-class.c
index 8319f25..b079c41 100644
--- a/drivers/extcon/extcon-class.c
+++ b/drivers/extcon/extcon-class.c
@@ -444,6 +444,9 @@ int extcon_register_interest(struct extcon_specific_cable_nb *obj,
 			     const char *extcon_name, const char *cable_name,
 			     struct notifier_block *nb)
 {
+	unsigned long flags;
+	int ret;
+
 	if (!obj || !cable_name || !nb)
 		return -EINVAL;
 
@@ -461,8 +464,11 @@ int extcon_register_interest(struct extcon_specific_cable_nb *obj,
 
 		obj->internal_nb.notifier_call = _call_per_cable;
 
-		return raw_notifier_chain_register(&obj->edev->nh,
+		spin_lock_irqsave(&obj->edev->lock, flags);
+		ret = raw_notifier_chain_register(&obj->edev->nh,
 						  &obj->internal_nb);
+		spin_unlock_irqrestore(&obj->edev->lock, flags);
+		return ret;
 	} else {
 		struct class_dev_iter iter;
 		struct extcon_dev *extd;
@@ -495,10 +501,17 @@ EXPORT_SYMBOL_GPL(extcon_register_interest);
  */
 int extcon_unregister_interest(struct extcon_specific_cable_nb *obj)
 {
+	unsigned long flags;
+	int ret;
+
 	if (!obj)
 		return -EINVAL;
 
-	return raw_notifier_chain_unregister(&obj->edev->nh, &obj->internal_nb);
+	spin_lock_irqsave(&obj->edev->lock, flags);
+	ret = raw_notifier_chain_unregister(&obj->edev->nh, &obj->internal_nb);
+	spin_unlock_irqrestore(&obj->edev->lock, flags);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(extcon_unregister_interest);
 
@@ -515,7 +528,14 @@ EXPORT_SYMBOL_GPL(extcon_unregister_interest);
 int extcon_register_notifier(struct extcon_dev *edev,
 			struct notifier_block *nb)
 {
-	return raw_notifier_chain_register(&edev->nh, nb);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&edev->lock, flags);
+	ret = raw_notifier_chain_register(&edev->nh, nb);
+	spin_unlock_irqrestore(&edev->lock, flags);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(extcon_register_notifier);
 
@@ -527,7 +547,14 @@ EXPORT_SYMBOL_GPL(extcon_register_notifier);
 int extcon_unregister_notifier(struct extcon_dev *edev,
 			struct notifier_block *nb)
 {
-	return raw_notifier_chain_unregister(&edev->nh, nb);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&edev->lock, flags);
+	ret = raw_notifier_chain_unregister(&edev->nh, nb);
+	spin_unlock_irqrestore(&edev->lock, flags);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(extcon_unregister_notifier);
 
-- 
2.3.3
