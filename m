From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Apr 2011 19:41:38 +0100
Subject: [PATCH 06/10] clk: Add support for a generic clock multiplexer
In-Reply-To: <20110418183421.GD25671@n2100.arm.linux.org.uk>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-7-git-send-email-s.hauer@pengutronix.de>
	<20110418131527.GF31131@pengutronix.de>
	<20110418133353.GL14770@pengutronix.de>
	<4DAC7AE9.9030106@codeaurora.org>
	<20110418183421.GD25671@n2100.arm.linux.org.uk>
Message-ID: <20110418184138.GE25671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 07:34:21PM +0100, Russell King - ARM Linux wrote:
> Oops, clk_get_sys() and clk_find() really should be fixed for this.  I'll
> sort a patch for it.

And here it is:

8<----
Subject: [PATCH] Fix clkdev return value for NULL clk case

clkdev may incorrectly cause a clkdev entry with a NULL clk to return
-ENOENT.  This is not the intention of this code; -ENOENT should only
be returned if the clock entry can not be found in the table.  Fix this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/clk/clkdev.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 0fc0a79..36a134f 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -32,10 +32,9 @@ static DEFINE_MUTEX(clocks_mutex);
  * Then we take the most specific entry - with the following
  * order of precedence: dev+con > dev only > con only.
  */
-static struct clk *clk_find(const char *dev_id, const char *con_id)
+static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 {
-	struct clk_lookup *p;
-	struct clk *clk = NULL;
+	struct clk_lookup *p, *cl = NULL;
 	int match, best = 0;
 
 	list_for_each_entry(p, &clocks, node) {
@@ -52,27 +51,27 @@ static struct clk *clk_find(const char *dev_id, const char *con_id)
 		}
 
 		if (match > best) {
-			clk = p->clk;
+			cl = p;
 			if (match != 3)
 				best = match;
 			else
 				break;
 		}
 	}
-	return clk;
+	return cl;
 }
 
 struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 {
-	struct clk *clk;
+	struct clk_lookup *cl;
 
 	mutex_lock(&clocks_mutex);
-	clk = clk_find(dev_id, con_id);
-	if (clk && !__clk_get(clk))
-		clk = NULL;
+	cl = clk_find(dev_id, con_id);
+	if (cl && !__clk_get(cl->clk))
+		cl = NULL;
 	mutex_unlock(&clocks_mutex);
 
-	return clk ? clk : ERR_PTR(-ENOENT);
+	return cl ? cl->clk : ERR_PTR(-ENOENT);
 }
 EXPORT_SYMBOL(clk_get_sys);
 
