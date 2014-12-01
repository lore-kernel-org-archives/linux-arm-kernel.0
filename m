From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  2 Dec 2014 02:47:24 +0300
Subject: [PATCH v2 2/4] ARM: sa1100: implement clk_get_rate
In-Reply-To: <1417477646-14278-1-git-send-email-dbaryshkov@gmail.com>
References: <1417477646-14278-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1417477646-14278-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide actual implementation of clk_get_rate function for StrongARM
sa-11x0 SoC family.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/clock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index 9fa6a99..9434766 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -19,6 +19,7 @@
 struct clkops {
 	void			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
+	unsigned long		(*get_rate)(struct clk *);
 };
 
 struct clk {
@@ -33,9 +34,11 @@ struct clk clk_##_name = {				\
 
 static DEFINE_SPINLOCK(clocks_lock);
 
-/* Dummy clk routine to build generic kernel parts that may be using them */
 unsigned long clk_get_rate(struct clk *clk)
 {
+	if (clk && clk->ops && clk->ops->get_rate)
+		return clk->ops->get_rate(clk);
+
 	return 0;
 }
 EXPORT_SYMBOL(clk_get_rate);
-- 
2.1.3
