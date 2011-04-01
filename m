From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  1 Apr 2011 10:39:20 +0800
Subject: [PATCH 1/9] ARM: pxa: add clk_set_rate()
In-Reply-To: <040101>
References: <040101>
Message-ID: <1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there're mulitple clock rates in some device controllers, enable
clk_set_rate() for this usage.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/clock.c |   15 +++++++++++++++
 arch/arm/mach-mmp/clock.h |    1 +
 arch/arm/mach-pxa/clock.c |   15 +++++++++++++++
 arch/arm/mach-pxa/clock.h |    1 +
 4 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
index 886e056..7c6f95f 100644
--- a/arch/arm/mach-mmp/clock.c
+++ b/arch/arm/mach-mmp/clock.c
@@ -88,3 +88,18 @@ unsigned long clk_get_rate(struct clk *clk)
 	return rate;
 }
 EXPORT_SYMBOL(clk_get_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	if (clk->ops->setrate) {
+		spin_lock_irqsave(&clocks_lock, flags);
+		ret = clk->ops->setrate(clk, rate);
+		spin_unlock_irqrestore(&clocks_lock, flags);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_rate);
diff --git a/arch/arm/mach-mmp/clock.h b/arch/arm/mach-mmp/clock.h
index 9b027d7..3143e99 100644
--- a/arch/arm/mach-mmp/clock.h
+++ b/arch/arm/mach-mmp/clock.h
@@ -12,6 +12,7 @@ struct clkops {
 	void			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
 	unsigned long		(*getrate)(struct clk *);
+	int			(*setrate)(struct clk *, unsigned long);
 };
 
 struct clk {
diff --git a/arch/arm/mach-pxa/clock.c b/arch/arm/mach-pxa/clock.c
index d515222..4d46610 100644
--- a/arch/arm/mach-pxa/clock.c
+++ b/arch/arm/mach-pxa/clock.c
@@ -53,6 +53,21 @@ unsigned long clk_get_rate(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_rate);
 
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	if (clk->ops->setrate) {
+		spin_lock_irqsave(&clocks_lock, flags);
+		ret = clk->ops->setrate(clk, rate);
+		spin_unlock_irqrestore(&clocks_lock, flags);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
 void clk_dummy_enable(struct clk *clk)
 {
 }
diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
index f9f349a..7373853 100644
--- a/arch/arm/mach-pxa/clock.h
+++ b/arch/arm/mach-pxa/clock.h
@@ -5,6 +5,7 @@ struct clkops {
 	void			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
 	unsigned long		(*getrate)(struct clk *);
+	int			(*setrate)(struct clk *, unsigned long);
 };
 
 struct clk {
-- 
1.5.6.5
