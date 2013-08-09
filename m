From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 09 Aug 2013 18:34:06 +0200
Subject: [PATCH RFC 2/2] clkdev: Fix race condition in clock lookup from device
 tree
In-Reply-To: <1376066046-16037-1-git-send-email-s.nawrocki@samsung.com>
References: <1376066046-16037-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1376066046-16037-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is currently a race condition in the device tree part of clk_get()
function, since the pointer returned from of_clk_get_by_name() may become
invalid before __clk_get() call. For example, due to the clock provider
driver remove() callback being called in between of_clk_get_by_name()
and __clk_get().

Fix this by doing both the look up and __clk_get() operations with the
clock providers list mutex held. This ensures that the clock pointer
returned from __of_clk_get_from_provider() call and passed to __clk_get()
is valid, as long as the clock supplier module first removes its clock
provider instance and then does clk_unregister() on the corresponding
clocks.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/clkdev.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 442a313..4f5c4ef 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -39,7 +39,13 @@ struct clk *of_clk_get(struct device_node *np, int index)
 	if (rc)
 		return ERR_PTR(rc);

-	clk = of_clk_get_from_provider(&clkspec);
+	of_clk_lock();
+	clk = __of_clk_get_from_provider(&clkspec);
+
+	if (!IS_ERR(clk) && !__clk_get(clk))
+		clk = ERR_PTR(-ENOENT);
+
+	of_clk_unlock();
 	of_node_put(clkspec.np);
 	return clk;
 }
@@ -157,7 +163,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)

 	if (dev) {
 		clk = of_clk_get_by_name(dev->of_node, con_id);
-		if (!IS_ERR(clk) && __clk_get(clk))
+		if (!IS_ERR(clk))
 			return clk;
 	}

--
1.7.9.5
