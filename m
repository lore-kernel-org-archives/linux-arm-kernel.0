From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 25 Jan 2011 21:44:22 -0700
Subject: [RFC PATCH 4/5] arm/clkdev: lookup clocks from OF clock providers
In-Reply-To: <20110126043338.16410.75019.stgit@localhost6.localdomain6>
References: <20110126043338.16410.75019.stgit@localhost6.localdomain6>
Message-ID: <20110126044422.16410.78703.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jeremy.kerr@canonical.com>

Hook the OF clock provider infrastructure to clk_get.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/clk/clkdev.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 0fc0a79..a546763 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -19,6 +19,8 @@
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/of.h>
+#include <linux/of_clk.h>
 
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
@@ -79,6 +81,11 @@ EXPORT_SYMBOL(clk_get_sys);
 struct clk *clk_get(struct device *dev, const char *con_id)
 {
 	const char *dev_id = dev ? dev_name(dev) : NULL;
+	struct clk *clk;
+
+	clk = of_clk_get(dev, con_id);
+	if (clk && __clk_get(clk))
+		return clk;
 
 	return clk_get_sys(dev_id, con_id);
 }
