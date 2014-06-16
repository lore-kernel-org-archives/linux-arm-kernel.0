From: elder@linaro.org (Alex Elder)
Date: Mon, 16 Jun 2014 08:40:03 -0500
Subject: [PATCH v6 3/7] clk: bcm281xx: add an initialized flag
In-Reply-To: <1402926007-4436-1-git-send-email-elder@linaro.org>
References: <1402926007-4436-1-git-send-email-elder@linaro.org>
Message-ID: <1402926007-4436-4-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a flag that tracks whether a clock has already been initialized.
Use it to avoid initializing a clock more than once.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/clk/bcm/clk-kona.c | 12 ++++++++++++
 drivers/clk/bcm/clk-kona.h |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index cacbfd6..2e27924 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -27,6 +27,9 @@
 #define CCU_ACCESS_PASSWORD      0xA5A500
 #define CLK_GATE_DELAY_LOOP      2000
 
+#define clk_is_initialized(_clk)	FLAG_TEST((_clk), KONA, INITIALIZED)
+#define clk_set_initialized(_clk)	FLAG_SET((_clk), KONA, INITIALIZED)
+
 /* Bitfield operations */
 
 /* Produces a mask of set bits covering a range of a 32-bit value */
@@ -1041,6 +1044,9 @@ static int kona_clk_prepare(struct clk_hw *hw)
 	unsigned long flags;
 	int ret = 0;
 
+	if (clk_is_initialized(bcm_clk))
+		return 0;
+
 	ccu = bcm_clk->ccu;
 	flags = ccu_lock(ccu);
 	__ccu_write_enable(ccu);
@@ -1057,11 +1063,17 @@ static int kona_clk_prepare(struct clk_hw *hw)
 	__ccu_write_disable(ccu);
 	ccu_unlock(ccu, flags);
 
+	if (!ret)
+		clk_set_initialized(bcm_clk);
+
 	return ret;
 }
 
 static void kona_clk_unprepare(struct clk_hw *hw)
 {
+	struct kona_clk *bcm_clk = to_kona_clk(hw);
+
+	WARN_ON(!clk_is_initialized(bcm_clk));
 	/* Nothing to do. */
 }
 
diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
index 4c7e796..ea77ec1 100644
--- a/drivers/clk/bcm/clk-kona.h
+++ b/drivers/clk/bcm/clk-kona.h
@@ -406,6 +406,7 @@ struct kona_clk {
 	struct clk_init_data init_data;	/* includes name of this clock */
 	struct ccu_data *ccu;	/* ccu this clock is associated with */
 	enum bcm_clk_type type;
+	u32 flags;		/* BCM_CLK_KONA_FLAGS_* below */
 	union {
 		void *data;
 		struct peri_clk_data *peri;
@@ -414,6 +415,12 @@ struct kona_clk {
 #define to_kona_clk(_hw) \
 	container_of(_hw, struct kona_clk, hw)
 
+/*
+ * Kona clock flags:
+ *   INITIALIZED	clock has been initialized already
+ */
+#define BCM_CLK_KONA_FLAGS_INITIALIZED	((u32)1 << 0)	/* Clock initialized */
+
 /* Initialization macro for an entry in a CCU's kona_clks[] array. */
 #define KONA_CLK(_ccu_name, _clk_name, _type)				\
 	{								\
-- 
1.9.1
