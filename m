From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 17 May 2018 20:20:22 -0500
Subject: [PATCH 4/6] coresight: move shared barrier_pkt[] to coresight_priv.h
In-Reply-To: <20180518012024.22645-1-kim.phillips@arm.com>
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
Message-ID: <20180518012024.22645-4-kim.phillips@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

barrier_pkt[] is used in various coresight components.
Change barrier_pkt[] to a static definition in the coresight
private header.  Needed prior to allowing coresight to be
built as modules.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 9 ++++++++-
 drivers/hwtracing/coresight/coresight.c      | 8 --------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 83a6f5b7a683..45de8c15b687 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -57,7 +57,14 @@ static DEVICE_ATTR_RO(name)
 #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
 	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
 
-extern const u32 barrier_pkt[5];
+/*
+ * When losing synchronisation a new barrier packet needs to be inserted at the
+ * beginning of the data collected in a buffer.  That way the decoder knows that
+ * it needs to look for another sync sequence.
+ */
+static const u32 barrier_pkt[5] = {0x7fffffff, 0x7fffffff,
+				   0x7fffffff, 0x7fffffff, 0x0};
+
 
 enum etm_addr_type {
 	ETM_ADDR_TYPE_NONE,
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 29e834aab539..0cbc2948defc 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -46,14 +46,6 @@ static DEFINE_PER_CPU(struct list_head *, tracer_path);
  */
 static struct list_head *stm_path;
 
-/*
- * When losing synchronisation a new barrier packet needs to be inserted at the
- * beginning of the data collected in a buffer.  That way the decoder knows that
- * it needs to look for another sync sequence.
- */
-const u32 barrier_pkt[5] = {0x7fffffff, 0x7fffffff,
-			    0x7fffffff, 0x7fffffff, 0x0};
-
 static int coresight_id_match(struct device *dev, void *data)
 {
 	int trace_id, i_trace_id;
-- 
2.17.0
