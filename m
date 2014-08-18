From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 18 Aug 2014 17:30:28 +0200
Subject: [PATCH v7 2/8] clk: provide public clk_is_enabled function
In-Reply-To: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1408375833-10703-3-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

To determine if a clk has been previously enabled, provide a public
clk_is_enabled function. This is especially helpful to check the state
of clk-gate without actually changing the state of the gate.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/clk/clk.c   | 18 ++++++++++++++++++
 include/linux/clk.h | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b76fa69..bf46d27 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -953,6 +953,24 @@ int clk_enable(struct clk *clk)
 EXPORT_SYMBOL_GPL(clk_enable);
 
 /**
+ * clk_is_enabled - return the enabled state of a clk
+ * @clk: the clk whose enabled state gets returned
+ *
+ * Returns true if the clock is enabled, false otherwise.
+ */
+bool clk_is_enabled(struct clk *clk)
+{
+	bool is_en;
+
+	clk_prepare_lock();
+	is_en = __clk_is_enabled(clk);
+	clk_prepare_unlock();
+
+	return is_en;
+}
+EXPORT_SYMBOL_GPL(clk_is_enabled);
+
+/**
  * __clk_round_rate - round the given rate for a clk
  * @clk: round the rate of this clock
  * @rate: the rate which is to be rounded
diff --git a/include/linux/clk.h b/include/linux/clk.h
index fb5e097..2cd8d3c 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -218,6 +218,14 @@ int clk_enable(struct clk *clk);
 void clk_disable(struct clk *clk);
 
 /**
+ * clk_is_enabled - return the enabled state of a clk
+ * @clk: the clk whose enabled state gets returned
+ *
+ * Returns true if the clock is enabled, false otherwise.
+ */
+bool clk_is_enabled(struct clk *clk);
+
+/**
  * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
  *		  This is only valid once the clock source has been enabled.
  * @clk: clock source
@@ -330,6 +338,11 @@ static inline int clk_enable(struct clk *clk)
 
 static inline void clk_disable(struct clk *clk) {}
 
+static inline bool clk_is_enabled(struct clk *clk)
+{
+	return false;
+}
+
 static inline unsigned long clk_get_rate(struct clk *clk)
 {
 	return 0;
-- 
1.9.3
