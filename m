From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri,  5 Apr 2013 07:22:12 +0200
Subject: [PATCH] clk: add helper to set flags for clk-provider
Message-ID: <1365139332-17775-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock providers are not allowed to mess with struct clk internals directly
but using helpers provided by clk-provider.h. This patch adds a helper to
allow to set flags of a clock after registration. This is useful, if clock
flags change during runtime, e.g. ability to set parent clock after mux
switch.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/clk.c            |    8 ++++++++
 include/linux/clk-provider.h |    1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ed87b24..780a0c0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -451,6 +451,14 @@ unsigned long __clk_get_flags(struct clk *clk)
 	return !clk ? 0 : clk->flags;
 }
 
+void __clk_set_flags(struct clk *clk, unsigned long flags)
+{
+	if (!clk)
+		return;
+
+	clk->flags = flags;
+}
+
 bool __clk_is_enabled(struct clk *clk)
 {
 	int ret;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7f197d7..e862d9c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -351,6 +351,7 @@ unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned int __clk_get_prepare_count(struct clk *clk);
 unsigned long __clk_get_rate(struct clk *clk);
 unsigned long __clk_get_flags(struct clk *clk);
+void __clk_set_flags(struct clk *clk, unsigned long flags);
 bool __clk_is_enabled(struct clk *clk);
 struct clk *__clk_lookup(const char *name);
 
-- 
1.7.10.4
