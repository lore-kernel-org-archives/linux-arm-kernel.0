From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Wed, 14 Mar 2018 13:44:30 +0530
Subject: [PATCH v10 1/5] driver core: Delete the link between two given devices
In-Reply-To: <20180314081434.30875-1-vivek.gautam@codeaurora.org>
References: <20180314081434.30875-1-vivek.gautam@codeaurora.org>
Message-ID: <20180314081434.30875-2-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given the consumer and supplier devices, add an API to
delete the link between them.

Suggested-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 - This patch replaces an earlier patch [1] that was adding
   device_link_find() API.
   [1] https://patchwork.kernel.org/patch/10277975/

 drivers/base/core.c    | 31 +++++++++++++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5847364f25d9..e13d904e1e12 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -336,6 +336,37 @@ void device_link_del(struct device_link *link)
 }
 EXPORT_SYMBOL_GPL(device_link_del);
 
+/**
+ * device_link_del_dev - Delete a link between two given devices
+ * @consumer: Consumer end of the link.
+ * @supplier: Supplier end of the link.
+ *
+ * The caller must ensure proper synchronization of this function with runtime
+ * PM.
+ */
+void device_link_del_dev(struct device *consumer, struct device *supplier)
+{
+	struct device_link *link;
+
+	if (!consumer || !supplier)
+		return;
+
+	device_links_write_lock();
+	device_pm_lock();
+
+	list_for_each_entry(link, &supplier->links.consumers, s_node) {
+		if (link->consumer == consumer) {
+			__device_link_del(link);
+			/* just one link between the devices */
+			break;
+		}
+	}
+
+	device_pm_unlock();
+	device_links_write_unlock();
+}
+EXPORT_SYMBOL_GPL(device_link_del_dev);
+
 static void device_links_missing_supplier(struct device *dev)
 {
 	struct device_link *link;
diff --git a/include/linux/device.h b/include/linux/device.h
index b093405ed525..14508d843f67 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1278,6 +1278,7 @@ extern const char *dev_driver_string(const struct device *dev);
 struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
+void device_link_del_dev(struct device *consumer, struct device *supplier);
 
 #ifdef CONFIG_PRINTK
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
