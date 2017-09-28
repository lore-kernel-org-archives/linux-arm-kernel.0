From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Sep 2017 14:11:34 +0100
Subject: [PATCH v3 10/22] firmware: arm_scmi: probe and initialise all the
 supported protocols
In-Reply-To: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1506604306-20739-11-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have basic support for all the protocols in the
specification, let's probe them individually and initialise them.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  5 +++
 drivers/firmware/arm_scmi/driver.c | 82 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 0df52905ba48..07acddf5c060 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -119,4 +119,9 @@ int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version);
 void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 				     u8 *prot_imp);
 
+typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
 int scmi_base_protocol_init(struct scmi_handle *h);
+int scmi_perf_protocol_init(struct scmi_handle *h);
+int scmi_sensors_protocol_init(struct scmi_handle *h);
+int scmi_power_protocol_init(struct scmi_handle *h);
+int scmi_clock_protocol_init(struct scmi_handle *h);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 5df76512a291..a1abcf2049ca 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -154,6 +154,12 @@ struct scmi_shared_mem {
 	u8 msg_payload[0];
 };
 
+struct scmi_protocol_match {
+	u8 protocol_id;
+	scmi_prot_init_fn_t fn;
+	char name[32];
+};
+
 static int scmi_linux_errmap[] = {
 	/* better than switch case as long as return value is continuous */
 	0,			/* SCMI_SUCCESS */
@@ -686,6 +692,39 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
 	return 0;
 }
 
+static const struct scmi_protocol_match scmi_protocols[] = {
+	{
+		.protocol_id = SCMI_PROTOCOL_PERF,
+		.fn = scmi_perf_protocol_init,
+		.name = "scmi-cpufreq",
+	}, {
+		.protocol_id = SCMI_PROTOCOL_CLOCK,
+		.fn = scmi_clock_protocol_init,
+		.name = "scmi-clocks",
+	}, {
+		.protocol_id = SCMI_PROTOCOL_POWER,
+		.fn = scmi_power_protocol_init,
+		.name = "scmi-power-domain",
+	}, {
+		.protocol_id = SCMI_PROTOCOL_SENSOR,
+		.fn = scmi_sensors_protocol_init,
+		.name = "scmi-hwmon",
+	},
+	{}
+};
+
+static const struct scmi_protocol_match *scmi_protocol_match_get(u8 protocol_id)
+{
+	int i;
+	const struct scmi_protocol_match *loop = scmi_protocols;
+
+	for (i = 0; i < ARRAY_SIZE(scmi_protocols); i++, loop++)
+		if (loop->protocol_id == protocol_id)
+			return loop;
+
+	return NULL;
+}
+
 static int scmi_mailbox_check(struct device_node *np)
 {
 	struct of_phandle_args arg;
@@ -767,6 +806,27 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
 	return 0;
 }
 
+static inline void
+scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
+			    const struct scmi_protocol_match *match)
+{
+	int init_ret;
+	struct platform_device *cdev;
+
+	cdev = of_platform_device_create(np, match->name, info->dev);
+	if (!cdev) {
+		dev_err(info->dev, "failed to create %s device\n", match->name);
+		return;
+	}
+
+	init_ret = match->fn(&info->handle);
+	if (init_ret) {
+		dev_err(info->dev, "SCMI protocol %d init error %d\n",
+			match->protocol_id, init_ret);
+		of_platform_device_destroy(&cdev->dev, NULL);
+	}
+}
+
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -774,7 +834,7 @@ static int scmi_probe(struct platform_device *pdev)
 	const struct scmi_desc *desc;
 	struct scmi_info *info;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
+	struct device_node *child, *np = dev->of_node;
 
 	/* Only mailbox method supported, check for the presence of one */
 	if (scmi_mailbox_check(np)) {
@@ -813,6 +873,26 @@ static int scmi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	for_each_available_child_of_node(np, child) {
+		u32 prot_id;
+		const struct scmi_protocol_match *match;
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
+		match = scmi_protocol_match_get(prot_id);
+		if (match)
+			scmi_create_protocol_device(child, info, match);
+	}
+
 	mutex_lock(&scmi_list_mutex);
 	list_add_tail(&info->node, &scmi_list);
 	mutex_unlock(&scmi_list_mutex);
-- 
2.7.4
