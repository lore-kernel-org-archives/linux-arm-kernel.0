From: johnyoun@synopsys.com (John Youn)
Date: Tue, 31 May 2016 16:55:01 -0700
Subject: [PATCH v2] reset: Return -ENOTSUPP when not configured
Message-ID: <2b8732d98087e52edec39ec83a063912fcc23962.1464738402.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prior to commit 6c96f05c8bb8 ("reset: Make [of_]reset_control_get[_foo]
functions wrappers"), the "optional" functions returned -ENOTSUPP when
CONFIG_RESET_CONTROLLER was not set.

Revert back to the old behavior by changing the new
__devm_reset_control_get() and __of_reset_control_get() functions to
return ERR_PTR(-ENOTSUPP) when compiled without CONFIG_RESET_CONTROLLER.

Otherwise they will return -EINVAL causing users to think that an error
occurred when CONFIG_RESET_CONTROLLER is not set.

Fixes: 6c96f05c8bb8 ("reset: Make [of_]reset_control_get[_foo] functions wrappers")
Signed-off-by: John Youn <johnyoun@synopsys.com>
---

Hi Philipp,

Here are the changes as discussed previously. It just returns
-ENOTSUPP directly when not configured. Tested and works with DWC2
driver with Dinh's patch that adds the reset controller, using a
configuration with no reset controller configured.

v2:
* Return ERR_PTR(-ENOTSUPP) directly.


 include/linux/reset.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index ec0306ce..067db57 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -71,14 +71,14 @@ static inline struct reset_control *__of_reset_control_get(
 					struct device_node *node,
 					const char *id, int index, int shared)
 {
-	return ERR_PTR(-EINVAL);
+	return ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct reset_control *__devm_reset_control_get(
 					struct device *dev,
 					const char *id, int index, int shared)
 {
-	return ERR_PTR(-EINVAL);
+	return ERR_PTR(-ENOTSUPP);
 }
 
 #endif /* CONFIG_RESET_CONTROLLER */
-- 
2.8.2
