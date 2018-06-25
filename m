From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 25 Jun 2018 18:04:40 +0200
Subject: [RESEND (again) PATCH] clkdev: don't call __of_clk_get_by_name()
 unnecessarily from clk_get()
Message-ID: <20180625160440.10537-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The way this function is implemented caused some confusion when
converting the TI DaVinci platform to using the common clock framework.

Current kernel supports booting DaVinci boards both in device tree as
well as legacy, board-file mode. In the latter, we always end up
calling clk_get_sys() as of_node is NULL and __of_clk_get_by_name()
returns -ENOENT.

It was not obvious at first glance how clk_get(dev, NULL) will work in
board-file mode since we always call __of_clk_get_by_name(). Let's make
it clearer by checking if of_node is NULL and skipping right to
clk_get_sys().

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/clkdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 7513411140b6..f394e8964909 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -199,7 +199,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct clk *clk;
 
-	if (dev) {
+	if (dev && dev->of_node) {
 		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
 		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
-- 
2.17.1
