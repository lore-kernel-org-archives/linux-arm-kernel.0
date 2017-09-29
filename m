From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 16:23:01 +0800
Subject: [PATCH v3 09/14] regmap: add iopoll-like polling macro for
 regmap_field
In-Reply-To: <20170929082306.16193-1-wens@csie.org>
References: <20170929082306.16193-1-wens@csie.org>
Message-ID: <20170929082306.16193-10-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a macro regmap_field_read_poll_timeout that works
similar to the readx_poll_timeout defined in linux/iopoll.h, except
that this can also return the error value returned by a failed
regmap_field_read.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 include/linux/regmap.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 978abfbac617..93a4663d7acb 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -139,6 +139,45 @@ struct reg_sequence {
 	pollret ?: ((cond) ? 0 : -ETIMEDOUT); \
 })
 
+/**
+ * regmap_field_read_poll_timeout - Poll until a condition is met or timeout
+ *
+ * @field: Regmap field to read from
+ * @val: Unsigned integer variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @sleep_us: Maximum time to sleep between reads in us (0
+ *            tight-loops).  Should be less than ~20ms since usleep_range
+ *            is used (see Documentation/timers/timers-howto.txt).
+ * @timeout_us: Timeout in us, 0 means never timeout
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_field_read
+ * error return value in case of a error read. In the two former cases,
+ * the last read value at @addr is stored in @val. Must not be called
+ * from atomic context if sleep_us or timeout_us are used.
+ *
+ * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
+ */
+#define regmap_field_read_poll_timeout(field, val, cond, sleep_us, timeout_us) \
+({ \
+	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
+	int pollret; \
+	might_sleep_if(sleep_us); \
+	for (;;) { \
+		pollret = regmap_field_read((field), &(val)); \
+		if (pollret) \
+			break; \
+		if (cond) \
+			break; \
+		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
+			pollret = regmap_field_read((field), &(val)); \
+			break; \
+		} \
+		if (sleep_us) \
+			usleep_range((sleep_us >> 2) + 1, sleep_us); \
+	} \
+	pollret ?: ((cond) ? 0 : -ETIMEDOUT); \
+})
+
 #ifdef CONFIG_REGMAP
 
 enum regmap_endian {
-- 
2.14.2
