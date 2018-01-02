From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue,  2 Jan 2018 14:42:32 +0000
Subject: [PATCH v5 10/20] firmware: arm_scmi: probe and initialise all the
 supported protocols
In-Reply-To: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1514904162-11201-11-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have basic support for all the protocols in the
specification, let's probe them individually and initialise them.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 51 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 20d083be474c..11c18ac9816f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -494,6 +494,21 @@ void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 	info->protocols_imp = prot_imp;
 }
 
+static bool
+scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
+{
+	int i;
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	if (!info->protocols_imp)
+		return false;
+
+	for (i = 0; i < MAX_PROTOCOLS_IMP; i++)
+		if (info->protocols_imp[i] == prot_id)
+			return true;
+	return false;
+}
+
 /**
  * scmi_handle_get() - Get the  SCMI handle for a device
  *
@@ -691,6 +706,23 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
 	return 0;
 }
 
+static inline void
+scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
+			    int prot_id)
+{
+	struct scmi_device *sdev;
+
+	sdev = scmi_device_create(np, info->dev, prot_id);
+	if (!sdev) {
+		dev_err(info->dev, "failed to create %d protocol device\n",
+			prot_id);
+		return;
+	}
+
+	/* setup handle now as the transport is ready */
+	scmi_set_handle(sdev);
+}
+
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -698,7 +730,7 @@ static int scmi_probe(struct platform_device *pdev)
 	const struct scmi_desc *desc;
 	struct scmi_info *info;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
+	struct device_node *child, *np = dev->of_node;
 
 	/* Only mailbox method supported, check for the presence of one */
 	if (scmi_mailbox_check(np)) {
@@ -741,6 +773,23 @@ static int scmi_probe(struct platform_device *pdev)
 	list_add_tail(&info->node, &scmi_list);
 	mutex_unlock(&scmi_list_mutex);
 
+	for_each_available_child_of_node(np, child) {
+		u32 prot_id;
+
+		if (of_property_read_u32(child, "reg", &prot_id))
+			continue;
+
+		prot_id &= MSG_PROTOCOL_ID_MASK;
+
+		if (!scmi_is_protocol_implemented(handle, prot_id)) {
+			dev_err(dev, "SCMI protocol %d not implemented\n",
+				prot_id);
+			continue;
+		}
+
+		scmi_create_protocol_device(child, info, prot_id);
+	}
+
 	return 0;
 }
 
-- 
2.7.4
