From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  1 May 2016 19:36:57 +0900
Subject: [PATCH 1/7] reset: add devm_reset_controller_register API
In-Reply-To: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462099023-11819-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device managed API for reset_controller_register().

This helps in reducing code in .remove callbacks and sometimes
dropping .remove callbacks entirely.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/driver-model/devres.txt |  4 ++++
 drivers/reset/core.c                  | 37 +++++++++++++++++++++++++++++++++++
 include/linux/reset-controller.h      |  4 ++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 108d455..5270435 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -340,6 +340,10 @@ REGULATOR
   devm_regulator_put()
   devm_regulator_register()
 
+RESET
+  devm_reset_control_get()
+  devm_reset_controller_register()
+
 SLAVE DMA ENGINE
   devm_acpi_dma_controller_register()
 
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index f15f150..181b05d 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -82,6 +82,43 @@ void reset_controller_unregister(struct reset_controller_dev *rcdev)
 }
 EXPORT_SYMBOL_GPL(reset_controller_unregister);
 
+static void devm_reset_controller_release(struct device *dev, void *res)
+{
+	reset_controller_unregister(*(struct reset_controller_dev **)res);
+}
+
+/**
+ * devm_reset_controller_register - resource managed reset_controller_register()
+ * @dev: device that is registering this reset controller
+ * @rcdev: a pointer to the initialized reset controller device
+ *
+ * Managed reset_controller_register(). For reset controllers registered by
+ * this function, reset_controller_unregister() is automatically called on
+ * driver detach. See reset_controller_register() for more information.
+ */
+int devm_reset_controller_register(struct device *dev,
+				   struct reset_controller_dev *rcdev)
+{
+	struct reset_controller_dev **rcdevp;
+	int ret;
+
+	rcdevp = devres_alloc(devm_reset_controller_release, sizeof(*rcdevp),
+			      GFP_KERNEL);
+	if (!rcdevp)
+		return -ENOMEM;
+
+	ret = reset_controller_register(rcdev);
+	if (!ret) {
+		*rcdevp = rcdev;
+		devres_add(dev, rcdevp);
+	} else {
+		devres_free(rcdevp);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_reset_controller_register);
+
 /**
  * reset_control_reset - reset the controlled device
  * @rstc: reset controller
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index a3a5bcd..a4eaf1c 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -51,4 +51,8 @@ struct reset_controller_dev {
 int reset_controller_register(struct reset_controller_dev *rcdev);
 void reset_controller_unregister(struct reset_controller_dev *rcdev);
 
+struct device;
+int devm_reset_controller_register(struct device *dev,
+				   struct reset_controller_dev *rcdev);
+
 #endif
-- 
1.9.1
