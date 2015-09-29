From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 29 Sep 2015 11:10:52 +0200
Subject: [PATCH v7 14/20] clk: Probe clk providers on demand
In-Reply-To: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1443517859-30376-15-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a clock through its OF node, probe it if it hasn't
already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---


 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 43e2c3ad6c31..e5fe02a11c36 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -19,6 +19,7 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/sched.h>
@@ -3004,6 +3005,8 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
 
+	of_device_probe(clkspec->np);
+
 	/* Check if we have such a provider in our array */
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(provider, &of_clk_providers, link) {
-- 
2.4.3
