From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Sep 2017 14:11:36 +0100
Subject: [PATCH v3 12/22] firmware: arm_scmi: add option for polling based
 performance domain operations
In-Reply-To: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1506604306-20739-13-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to implement fast CPU DVFS switching, we need to perform all
DVFS operations atomically. Since SCMI transfer already provide option
to choose between pooling vs interrupt driven(default), we can opt for
polling based transfers for set,get performance domain operations.

This patch adds option to choose between polling vs interrupt driven
SCMI transfers for set,get performance level operations.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 19 +++++++++++--------
 include/linux/scmi_protocol.h    |  8 ++++----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 13d84d829201..334e8ec321ed 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -305,8 +305,8 @@ static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
-static int
-scmi_perf_level_set(const struct scmi_handle *handle, u32 domain, u32 level)
+static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
+			       u32 level, bool poll)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -317,6 +317,7 @@ scmi_perf_level_set(const struct scmi_handle *handle, u32 domain, u32 level)
 	if (ret)
 		return ret;
 
+	t->hdr.poll_completion = poll;
 	lvl = t->tx.buf;
 	lvl->domain = cpu_to_le32(domain);
 	lvl->level = cpu_to_le32(level);
@@ -327,8 +328,8 @@ scmi_perf_level_set(const struct scmi_handle *handle, u32 domain, u32 level)
 	return ret;
 }
 
-static int
-scmi_perf_level_get(const struct scmi_handle *handle, u32 domain, u32 *level)
+static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
+			       u32 *level, bool poll)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -338,6 +339,7 @@ scmi_perf_level_get(const struct scmi_handle *handle, u32 domain, u32 *level)
 	if (ret)
 		return ret;
 
+	t->hdr.poll_completion = poll;
 	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
 
 	ret = scmi_do_xfer(handle, t);
@@ -445,21 +447,22 @@ static int scmi_dvfs_get_transition_latency(struct device *dev)
 }
 
 static int scmi_dvfs_freq_set(const struct scmi_handle *handle, u32 domain,
-			      unsigned long freq)
+			      unsigned long freq, bool poll)
 {
 	struct perf_dom_info *dom = perf_info.dom_info + domain;
 
-	return scmi_perf_level_set(handle, domain, freq / dom->mult_factor);
+	return scmi_perf_level_set(handle, domain, freq / dom->mult_factor,
+				   poll);
 }
 
 static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
-			      unsigned long *freq)
+			      unsigned long *freq, bool poll)
 {
 	int ret;
 	u32 level;
 	struct perf_dom_info *dom = perf_info.dom_info + domain;
 
-	ret = scmi_perf_level_get(handle, domain, &level);
+	ret = scmi_perf_level_get(handle, domain, &level, poll);
 	if (!ret)
 		*freq = level * dom->mult_factor;
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 5e29394b5cc9..ac1a4a096314 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -99,15 +99,15 @@ struct scmi_clk_ops {
 struct scmi_perf_ops {
 	int (*limits_set)(const struct scmi_handle *, u32, u32, u32);
 	int (*limits_get)(const struct scmi_handle *, u32, u32 *, u32 *);
-	int (*level_set)(const struct scmi_handle *, u32, u32);
-	int (*level_get)(const struct scmi_handle *, u32, u32 *);
+	int (*level_set)(const struct scmi_handle *, u32, u32, bool);
+	int (*level_get)(const struct scmi_handle *, u32, u32 *, bool);
 	int (*limits_notify_enable)(const struct scmi_handle *, u32, bool);
 	int (*level_notify_enable)(const struct scmi_handle *, u32, bool);
 	int (*device_domain_id)(struct device *);
 	int (*get_transition_latency)(struct device *);
 	int (*add_opps_to_device)(struct device *);
-	int (*freq_set)(const struct scmi_handle *, u32, unsigned long);
-	int (*freq_get)(const struct scmi_handle *, u32, unsigned long *);
+	int (*freq_set)(const struct scmi_handle *, u32, unsigned long, bool);
+	int (*freq_get)(const struct scmi_handle *, u32, unsigned long *, bool);
 };
 
 /**
-- 
2.7.4
