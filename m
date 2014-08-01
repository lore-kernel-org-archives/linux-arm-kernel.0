From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 1 Aug 2014 11:58:56 +0800
Subject: [PATCH 3/3] clocksouce: sp804: use pr_fmt for logging
In-Reply-To: <1406865536-23984-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1406865536-23984-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1406865536-23984-4-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/clocksource/timer-sp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-sp.c b/drivers/clocksource/timer-sp.c
index 82b27c0..4a9bfe3 100644
--- a/drivers/clocksource/timer-sp.c
+++ b/drivers/clocksource/timer-sp.c
@@ -18,6 +18,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+
+#define pr_fmt(fmt) "sp804: " fmt
+
 #include <linux/clk.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
@@ -40,14 +43,14 @@ static long __init sp804_get_clock_rate(struct clk *clk)
 
 	err = clk_prepare(clk);
 	if (err) {
-		pr_err("sp804: clock failed to prepare: %d\n", err);
+		pr_err("clock failed to prepare: %d\n", err);
 		clk_put(clk);
 		return err;
 	}
 
 	err = clk_enable(clk);
 	if (err) {
-		pr_err("sp804: clock failed to enable: %d\n", err);
+		pr_err("clock failed to enable: %d\n", err);
 		clk_unprepare(clk);
 		clk_put(clk);
 		return err;
@@ -55,7 +58,7 @@ static long __init sp804_get_clock_rate(struct clk *clk)
 
 	rate = clk_get_rate(clk);
 	if (rate < 0) {
-		pr_err("sp804: clock failed to get rate: %ld\n", rate);
+		pr_err("clock failed to get rate: %ld\n", rate);
 		clk_disable(clk);
 		clk_unprepare(clk);
 		clk_put(clk);
@@ -81,7 +84,7 @@ void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 	if (!clk) {
 		clk = clk_get_sys("sp804", name);
 		if (IS_ERR(clk)) {
-			pr_err("sp804: clock not found: %d\n",
+			pr_err("clock not found: %d\n",
 			       (int)PTR_ERR(clk));
 			return;
 		}
@@ -188,7 +191,7 @@ void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struc
 	if (!clk)
 		clk = clk_get_sys("sp804", name);
 	if (IS_ERR(clk)) {
-		pr_err("sp804: %s clock not found: %d\n", name,
+		pr_err("%s clock not found: %d\n", name,
 			(int)PTR_ERR(clk));
 		return;
 	}
@@ -237,7 +240,7 @@ static void __init sp804_of_init(struct device_node *np)
 	if (of_count_phandle_with_args(np, "clocks", "#clock-cells") == 3) {
 		clk2 = of_clk_get(np, 1);
 		if (IS_ERR(clk2)) {
-			pr_err("sp804: %s clock not found: %d\n", np->name,
+			pr_err("%s clock not found: %d\n", np->name,
 				(int)PTR_ERR(clk2));
 			goto err;
 		}
-- 
1.7.12.4
