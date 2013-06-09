From: Baohua.Song@csr.com (Barry Song)
Date: Sun, 9 Jun 2013 13:30:46 +0800
Subject: [PATCH] reset: provide dummy API entries to avoid link errors
Message-ID: <1370755846-27011-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch provides dummy reset API entries like other subsystem e.g.
gpiolib to avoid link errors when RESET_CONTROLLER is not enabled.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 include/linux/reset.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index 6082247..92bd6fa 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -4,6 +4,7 @@
 struct device;
 struct reset_control;
 
+#ifdef CONFIG_RESET_CONTROLLER
 int reset_control_reset(struct reset_control *rstc);
 int reset_control_assert(struct reset_control *rstc);
 int reset_control_deassert(struct reset_control *rstc);
@@ -14,4 +15,47 @@ struct reset_control *devm_reset_control_get(struct device *dev, const char *id)
 
 int device_reset(struct device *dev);
 
+#else /* ! CONFIG_RESET_CONTROLLER */
+
+static inline int reset_control_reset(struct reset_control *rstc)
+{
+	return -ENOSYS;
+}
+
+static inline int reset_control_assert(struct reset_control *rstc);
+{
+	return -ENOSYS;
+}
+
+static inline int reset_control_deassert(struct reset_control *rstc)
+{
+	return -ENOSYS;
+}
+
+static inline struct reset_control *reset_control_get(struct device *dev, const char *id)
+{
+	return -ENOSYS;
+}
+
+static inline void reset_control_put(struct reset_control *rstc)
+{
+	/* reset_control_get never succeed */
+	WARN_ON(1);
+}
+
+static inline struct reset_control *devm_reset_control_get(struct device *dev, const char *id);
+{
+	return -ENOSYS;
+}
+
+static inline int device_reset(struct device *dev)
+{
+	/* device_reset will never really be done */
+	WARN_ON(1);
+
+	return -ENOSYS;
+}
+
+#endif
+
 #endif
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
