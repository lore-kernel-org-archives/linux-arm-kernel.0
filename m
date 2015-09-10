From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 10 Sep 2015 15:06:20 -0700
Subject: [PATCH] spmi: Auto-populate driver.owner in spmi_driver_register()
Message-ID: <1441922780-14467-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate the owner field of the spmi driver when
spmi_driver_register() is called in a similar fashion to how
other *_driver_register() functions do it. This saves driver
writers from having to do this themselves.

Cc: Andy Gross <agross@codeaurora.org>
Cc: Gilad Avidov <gavidov@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/spmi/spmi.c  | 5 +++--
 include/linux/spmi.h | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 11467e17bdd8..6b3da1bb0d63 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -560,12 +560,13 @@ EXPORT_SYMBOL_GPL(spmi_controller_remove);
  * This API will register the client driver with the SPMI framework.
  * It is typically called from the driver's module-init function.
  */
-int spmi_driver_register(struct spmi_driver *sdrv)
+int __spmi_driver_register(struct spmi_driver *sdrv, struct module *owner)
 {
 	sdrv->driver.bus = &spmi_bus_type;
+	sdrv->driver.owner = owner;
 	return driver_register(&sdrv->driver);
 }
-EXPORT_SYMBOL_GPL(spmi_driver_register);
+EXPORT_SYMBOL_GPL(__spmi_driver_register);
 
 static void __exit spmi_exit(void)
 {
diff --git a/include/linux/spmi.h b/include/linux/spmi.h
index f84212cd3b7d..1396a255d2a2 100644
--- a/include/linux/spmi.h
+++ b/include/linux/spmi.h
@@ -153,7 +153,9 @@ static inline struct spmi_driver *to_spmi_driver(struct device_driver *d)
 	return container_of(d, struct spmi_driver, driver);
 }
 
-int spmi_driver_register(struct spmi_driver *sdrv);
+#define spmi_driver_register(sdrv) \
+	__spmi_driver_register(sdrv, THIS_MODULE)
+int __spmi_driver_register(struct spmi_driver *sdrv, struct module *owner);
 
 /**
  * spmi_driver_unregister() - unregister an SPMI client driver
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
