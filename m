From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 26 Jun 2017 16:55:13 +0100
Subject: [PATCH 9/9] firmware: arm_scmi: probe and initialise all the
 supported protocols
In-Reply-To: <1498492513-29771-1-git-send-email-sudeep.holla@arm.com>
References: <1498492513-29771-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1498492513-29771-10-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have basic support for all the protocols in the
specification, let's probe them individually and initialise them.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  5 +++
 drivers/firmware/arm_scmi/driver.c | 71 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 7473dfcad4ee..d7c73a8d260b 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -118,4 +118,9 @@ int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version);
 void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 				     u8 *prot_imp);
 
+typedef int (*scmi_init_fn_t)(struct scmi_handle *);
 int scmi_base_protocol_init(struct scmi_handle *h);
+int scmi_perf_protocol_init(struct scmi_handle *h);
+int scmi_sensors_protocol_init(struct scmi_handle *h);
+int scmi_power_protocol_init(struct scmi_handle *h);
+int scmi_clock_protocol_init(struct scmi_handle *h);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 45f31eaf085a..d3d289f7a174 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -157,6 +157,12 @@ struct scmi_shared_mem {
 	u8 msg_payload[0];
 };
 
+struct scmi_protocol_match {
+	u8 protocol_id;
+	scmi_init_fn_t fn;
+	char name[32];
+};
+
 static int scmi_linux_errmap[] = {
 	/* better than switch case as long as return value is continuous */
 	0,			/* SCMI_SUCCESS */
@@ -680,6 +686,41 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
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
+	const struct scmi_protocol_match *match = NULL, *loop = scmi_protocols;
+
+	for (i = 0; i < ARRAY_SIZE(scmi_protocols); i++, loop++)
+		if (loop->protocol_id == protocol_id) {
+			match = loop;
+			break;
+		}
+
+	return match;
+}
+
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret = -EINVAL;
@@ -690,7 +731,7 @@ static int scmi_probe(struct platform_device *pdev)
 	const struct scmi_desc *desc;
 	struct scmi_info *info = NULL;
 	struct device *dev = &pdev->dev;
-	struct device_node *shmem, *np = dev->of_node;
+	struct device_node *child, *shmem, *np = dev->of_node;
 
 	desc = of_match_device(scmi_of_match, dev)->data;
 
@@ -755,6 +796,34 @@ static int scmi_probe(struct platform_device *pdev)
 	list_add_tail(&info->node, &scmi_list);
 	mutex_unlock(&scmi_list_mutex);
 
+	for_each_available_child_of_node(np, child) {
+		int init_ret;
+		u32 protocol_id;
+		const struct scmi_protocol_match *match;
+
+		if (of_property_read_u32(child, "reg", &protocol_id))
+			continue;
+
+		protocol_id &= MSG_PROTOCOL_ID_MASK;
+
+		if (!scmi_is_protocol_implemented(handle, protocol_id)) {
+			dev_err(dev, "SCMI protocol %d not implemented\n",
+				protocol_id);
+			continue;
+		}
+
+		match = scmi_protocol_match_get(protocol_id);
+		if (match) {
+			init_ret = match->fn(handle);
+			if (!init_ret)
+				of_platform_device_create(child, match->name,
+							  dev);
+			else
+				dev_err(dev, "SCMI protocol %d init error %d\n",
+					protocol_id, init_ret);
+		}
+	}
+
 	return 0;
 out:
 	if (!IS_ERR(info->tx_chan))
-- 
2.7.4
