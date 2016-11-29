From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 29 Nov 2016 09:47:13 -0700
Subject: [PATCH 3/9] coresight: etm3x: Adding missing features of Coresight
 PTM components
In-Reply-To: <1480438039-24960-1-git-send-email-mathieu.poirier@linaro.org>
References: <1480438039-24960-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1480438039-24960-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Muhammad Abdul WAHAB <muhammadabdul.wahab@centralesupelec.fr>

In the current driver for Coresight components, two features of PTM
components are missing:

1. Branch Broadcasting (present also in ETM but called Branch Output)
2. Return Stack (only present in PTM v1.0 and PTMv1.1)

These features can be added simply to the code using `mode` field of
`etm_config` struct.

1. **Branch Broadcast** : The branch broadcast feature is present in ETM
components as well and is called Branch output. It allows to retrieve
addresses for direct branch addresses alongside the indirect branch
addresses. For example, it could be useful in cases when tracing without
source code.
2. **Return Stack** : The return stack option allows to retrieve the
return addresses of function calls. It can be useful to avoid CRA
(Code Reuse Attacks) by keeping a shadowstack.

Signed-off-by: Muhammad Abdul Wahab <muhammadabdul.wahab@centralesupelec.fr>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h         |  5 +++++
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 4a18ee499965..ad063d7444e1 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -89,11 +89,13 @@
 /* ETMCR - 0x00 */
 #define ETMCR_PWD_DWN		BIT(0)
 #define ETMCR_STALL_MODE	BIT(7)
+#define ETMCR_BRANCH_BROADCAST	BIT(8)
 #define ETMCR_ETM_PRG		BIT(10)
 #define ETMCR_ETM_EN		BIT(11)
 #define ETMCR_CYC_ACC		BIT(12)
 #define ETMCR_CTXID_SIZE	(BIT(14)|BIT(15))
 #define ETMCR_TIMESTAMP_EN	BIT(28)
+#define ETMCR_RETURN_STACK	BIT(29)
 /* ETMCCR - 0x04 */
 #define ETMCCR_FIFOFULL		BIT(23)
 /* ETMPDCR - 0x310 */
@@ -110,8 +112,11 @@
 #define ETM_MODE_STALL		BIT(2)
 #define ETM_MODE_TIMESTAMP	BIT(3)
 #define ETM_MODE_CTXID		BIT(4)
+#define ETM_MODE_BBROAD		BIT(5)
+#define ETM_MODE_RET_STACK	BIT(6)
 #define ETM_MODE_ALL		(ETM_MODE_EXCLUDE | ETM_MODE_CYCACC | \
 				 ETM_MODE_STALL | ETM_MODE_TIMESTAMP | \
+				 ETM_MODE_BBROAD | ETM_MODE_RET_STACK | \
 				 ETM_MODE_CTXID | ETM_MODE_EXCL_KERN | \
 				 ETM_MODE_EXCL_USER)
 
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 5ea090955c08..ca98ad13bb8c 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -164,6 +164,16 @@ static ssize_t mode_store(struct device *dev,
 	else
 		config->ctrl &= ~ETMCR_CTXID_SIZE;
 
+	if (config->mode & ETM_MODE_BBROAD)
+		config->ctrl |= ETMCR_BRANCH_BROADCAST;
+	else
+		config->ctrl &= ~ETMCR_BRANCH_BROADCAST;
+
+	if (config->mode & ETM_MODE_RET_STACK)
+		config->ctrl |= ETMCR_RETURN_STACK;
+	else
+		config->ctrl &= ~ETMCR_RETURN_STACK;
+
 	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
 		etm_config_trace_mode(config);
 
-- 
2.7.4
