From: johnyoun@synopsys.com (John Youn)
Date: Wed, 25 May 2016 18:15:45 -0700
Subject: [PATCH] reset: Put back *_optional variants
Message-ID: <ca359e013c30f27c825a9580164b01da5ca6476d.1464224883.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prior to commit 6c96f05c8bb8 ("reset: Make [of_]reset_control_get[_foo]
functions wrappers"), the optional variants returned -ENOTSUPP when
CONFIG_RESET_CONTROLLER was not set. This patch reverts to this
behavior. Otherwise those calls will return -EINVAL causing users to
think that an error occurred when CONFIG_RESET_CONTROLLER is not set.

Fixes: 6c96f05c8bb8 ("reset: Make [of_]reset_control_get[_foo] functions wrappers")
Signed-off-by: John Youn <johnyoun@synopsys.com>
---

Hi Philipp, Hans,

The commit referenced above breaks an upcoming patch for the dwc2
driver that adds an optional reset control.

https://marc.info/?l=linux-usb&m=146161328211584&w=2

I've attempted to add the optional variants back the way they were
working before. Let me know if I need to do anything else to fix it or
if it should be done another way.

Regards,
John


 include/linux/reset.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index ec0306ce..739d33d 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -14,10 +14,24 @@ int reset_control_status(struct reset_control *rstc);
 
 struct reset_control *__of_reset_control_get(struct device_node *node,
 				     const char *id, int index, int shared);
+
+struct reset_control *__of_reset_control_get_optional(struct device_node *node,
+				     const char *id, int index, int shared)
+{
+	return __of_reset_control_get(node, id, index, shared);
+}
+
 void reset_control_put(struct reset_control *rstc);
 struct reset_control *__devm_reset_control_get(struct device *dev,
 				     const char *id, int index, int shared);
 
+static inline struct reset_control *__devm_reset_control_get_optional(
+					struct device *dev,
+					const char *id, int index, int shared)
+{
+	return __devm_reset_control_get(dev, id, index, shared);
+}
+
 int __must_check device_reset(struct device *dev);
 
 static inline int device_reset_optional(struct device *dev)
@@ -74,6 +88,13 @@ static inline struct reset_control *__of_reset_control_get(
 	return ERR_PTR(-EINVAL);
 }
 
+static inline struct reset_control *__of_reset_control_get_optional(
+					struct device_node *node,
+					const char *id, int index, int shared)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct reset_control *__devm_reset_control_get(
 					struct device *dev,
 					const char *id, int index, int shared)
@@ -81,6 +102,13 @@ static inline struct reset_control *__devm_reset_control_get(
 	return ERR_PTR(-EINVAL);
 }
 
+static inline struct reset_control *__devm_reset_control_get_optional(
+					struct device *dev,
+					const char *id, int index, int shared)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 #endif /* CONFIG_RESET_CONTROLLER */
 
 /**
@@ -110,7 +138,8 @@ static inline struct reset_control *__must_check reset_control_get(
 static inline struct reset_control *reset_control_get_optional(
 					struct device *dev, const char *id)
 {
-	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, 0);
+	return __of_reset_control_get_optional(dev ? dev->of_node : NULL,
+					       id, 0, 0);
 }
 
 /**
@@ -194,7 +223,7 @@ static inline struct reset_control *__must_check devm_reset_control_get(
 static inline struct reset_control *devm_reset_control_get_optional(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, 0);
+	return __devm_reset_control_get_optional(dev, id, 0, 0);
 }
 
 /**
-- 
2.8.2
