From: quentin.perret@arm.com (Quentin Perret)
Date: Mon, 10 Sep 2018 17:28:10 +0100
Subject: [PATCH v3] firmware: arm_scmi: add a getter for power of performance
 states
In-Reply-To: <20180910161530.izm4l22clxqktetn@queper01-lin>
References: <20180910161530.izm4l22clxqktetn@queper01-lin>
Message-ID: <20180910162810.7307-1-quentin.perret@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SCMI protocol can be used to get power estimates from firmware
corresponding to each performance state of a device. Although these power
costs are already managed by the SCMI firmware driver, they are not
exposed to any external subsystem yet.

Fix this by adding a new get_power() interface to the exisiting perf_ops
defined for the SCMI protocol.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
v3: Changed the accessor name to "scmi_dvfs_est_power_get"
v2: rebased on 4.19-rc2
---
 drivers/firmware/arm_scmi/perf.c | 28 ++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h    |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 721e6c57beae..3e6453b4ea1d 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -421,6 +421,33 @@ static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
+static int scmi_dvfs_est_power_get(const struct scmi_handle *handle, u32 domain,
+			       unsigned long *freq, unsigned long *power)
+{
+	struct scmi_perf_info *pi = handle->perf_priv;
+	struct perf_dom_info *dom;
+	unsigned long opp_freq;
+	int idx, ret = -EINVAL;
+	struct scmi_opp *opp;
+
+	dom = pi->dom_info + domain;
+	if (!dom)
+		return -EIO;
+
+	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
+		opp_freq = opp->perf * dom->mult_factor;
+		if (opp_freq < *freq)
+			continue;
+
+		*freq = opp_freq;
+		*power = opp->power;
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
 static struct scmi_perf_ops perf_ops = {
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
@@ -431,6 +458,7 @@ static struct scmi_perf_ops perf_ops = {
 	.device_opps_add = scmi_dvfs_device_opps_add,
 	.freq_set = scmi_dvfs_freq_set,
 	.freq_get = scmi_dvfs_freq_get,
+	.est_power_get = scmi_dvfs_est_power_get,
 };
 
 static int scmi_perf_protocol_init(struct scmi_handle *handle)
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f4c9fc0fc755..e4db899c1cfb 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -91,6 +91,8 @@ struct scmi_clk_ops {
  *	to sustained performance level mapping
  * @freq_get: gets the frequency for a given device using sustained frequency
  *	to sustained performance level mapping
+ * @est_power_get: gets the estimated power cost for a given performance domain
+ *	at a given frequency
  */
 struct scmi_perf_ops {
 	int (*limits_set)(const struct scmi_handle *handle, u32 domain,
@@ -110,6 +112,8 @@ struct scmi_perf_ops {
 			unsigned long rate, bool poll);
 	int (*freq_get)(const struct scmi_handle *handle, u32 domain,
 			unsigned long *rate, bool poll);
+	int (*est_power_get)(const struct scmi_handle *handle, u32 domain,
+			 unsigned long *rate, unsigned long *power);
 };
 
 /**
-- 
2.17.1
