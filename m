From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  7 Sep 2018 17:52:15 +0100
Subject: [PATCH] firmware: arm_scmi: use strlcpy to ensure NULL-terminated
 strings
Message-ID: <1536339135-5431-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace all the memcpy() for copying name strings from the firmware with
strlcpy() to make sure we are bounded by the source buffer size and we
also always have NULL-terminated strings.

This is needed to avoid out of bounds accesses if the firmware returns
a non-terminated string.

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/base.c    | 2 +-
 drivers/firmware/arm_scmi/clock.c   | 2 +-
 drivers/firmware/arm_scmi/perf.c    | 2 +-
 drivers/firmware/arm_scmi/power.c   | 2 +-
 drivers/firmware/arm_scmi/sensors.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

Hi Olof,

Let me know if this is rc/fix material or need to wait for v4.20 ?

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 9dff33ea6416..204390297f4b 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -208,7 +208,7 @@ static int scmi_base_discover_agent_get(const struct scmi_handle *handle,

 	ret = scmi_do_xfer(handle, t);
 	if (!ret)
-		memcpy(name, t->rx.buf, SCMI_MAX_STR_SIZE);
+		strlcpy(name, t->rx.buf, SCMI_MAX_STR_SIZE);

 	scmi_xfer_put(handle, t);

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index e4119eb34986..30fc04e28431 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -111,7 +111,7 @@ static int scmi_clock_attributes_get(const struct scmi_handle *handle,

 	ret = scmi_do_xfer(handle, t);
 	if (!ret)
-		memcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
+		strlcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
 	else
 		clk->name[0] = '\0';

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 721e6c57beae..c3b0041defee 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -168,7 +168,7 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 					le32_to_cpu(attr->sustained_perf_level);
 		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
 					dom_info->sustained_perf_level;
-		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
+		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}

 	scmi_xfer_put(handle, t);
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index cfa033b05aed..62f3401a1f01 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -106,7 +106,7 @@ scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 		dom_info->state_set_notify = SUPPORTS_STATE_SET_NOTIFY(flags);
 		dom_info->state_set_async = SUPPORTS_STATE_SET_ASYNC(flags);
 		dom_info->state_set_sync = SUPPORTS_STATE_SET_SYNC(flags);
-		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
+		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}

 	scmi_xfer_put(handle, t);
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 27f2092b9882..b53d5cc9c9f6 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -140,7 +140,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 			s = &si->sensors[desc_index + cnt];
 			s->id = le32_to_cpu(buf->desc[cnt].id);
 			s->type = SENSOR_TYPE(attrh);
-			memcpy(s->name, buf->desc[cnt].name, SCMI_MAX_STR_SIZE);
+			strlcpy(s->name, buf->desc[cnt].name, SCMI_MAX_STR_SIZE);
 		}

 		desc_index += num_returned;
--
2.7.4
