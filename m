From: kim.phillips@arm.com (Kim Phillips)
Date: Tue,  5 Jun 2018 16:06:59 -0500
Subject: [PATCH v4 03/14] coresight: move shared barrier_pkt[] to
 coresight_priv.h
In-Reply-To: <20180605210710.22227-1-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
Message-ID: <20180605210710.22227-4-kim.phillips@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

barrier_pkt[] is used in the etb and tmc-etf coresight
components.  Change barrier_pkt[] to a static definition,
so as to allow them to be built as modules.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 8 +++++++-
 drivers/hwtracing/coresight/coresight.c      | 7 -------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 158c720119dd..e76f19ca9e04 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -57,7 +57,13 @@ static DEVICE_ATTR_RO(name)
 #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
 	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
 
-extern const u32 barrier_pkt[4];
+/*
+ * When losing synchronisation a new barrier packet needs to be inserted at the
+ * beginning of the data collected in a buffer.  That way the decoder knows that
+ * it needs to look for another sync sequence.
+ */
+static const u32 barrier_pkt[4] = { 0x7fffffff, 0x7fffffff,
+				    0x7fffffff, 0x7fffffff };
 #define CORESIGHT_BARRIER_PKT_SIZE (sizeof(barrier_pkt))
 
 enum etm_addr_type {
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 4969b329511c..0cbc2948defc 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -46,13 +46,6 @@ static DEFINE_PER_CPU(struct list_head *, tracer_path);
  */
 static struct list_head *stm_path;
 
-/*
- * When losing synchronisation a new barrier packet needs to be inserted at the
- * beginning of the data collected in a buffer.  That way the decoder knows that
- * it needs to look for another sync sequence.
- */
-const u32 barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
-
 static int coresight_id_match(struct device *dev, void *data)
 {
 	int trace_id, i_trace_id;
-- 
2.17.0
