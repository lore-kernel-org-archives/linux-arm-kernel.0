From: bilhuang@nvidia.com (Bill Huang)
Date: Thu, 14 Mar 2013 02:31:04 -0700
Subject: [RFC v2 1/1] clk: Add notifier support in clk_prepare/clk_unprepare
Message-ID: <1363253464-3200-1-git-send-email-bilhuang@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the below two notifier events so drivers which are interested in
knowing the clock status can act accordingly. This is extremely useful
in some of the DVFS (Dynamic Voltage Frequency Scaling) design.

CLK_PREPARED
CLK_UNPREPARED

Signed-off-by: Bill Huang <bilhuang@nvidia.com>
---
 drivers/clk/clk.c   |    3 +++
 include/linux/clk.h |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ed87b24..3292cec 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -550,6 +550,7 @@ void clk_unprepare(struct clk *clk)
 {
 	mutex_lock(&prepare_lock);
 	__clk_unprepare(clk);
+	__clk_notify(clk, CLK_UNPREPARED, clk->rate, clk->rate);
 	mutex_unlock(&prepare_lock);
 }
 EXPORT_SYMBOL_GPL(clk_unprepare);
@@ -598,6 +599,8 @@ int clk_prepare(struct clk *clk)
 
 	mutex_lock(&prepare_lock);
 	ret = __clk_prepare(clk);
+	if (!ret)
+		__clk_notify(clk, CLK_PREPARED, clk->rate, clk->rate);
 	mutex_unlock(&prepare_lock);
 
 	return ret;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index b3ac22d..16c1d92 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -43,6 +43,8 @@ struct clk;
 #define PRE_RATE_CHANGE			BIT(0)
 #define POST_RATE_CHANGE		BIT(1)
 #define ABORT_RATE_CHANGE		BIT(2)
+#define CLK_PREPARED			BIT(3)
+#define CLK_UNPREPARED			BIT(4)
 
 /**
  * struct clk_notifier - associate a clk with a notifier
-- 
1.7.9.5
