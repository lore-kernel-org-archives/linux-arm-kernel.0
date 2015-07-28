From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:48 +0200
Subject: [PATCH v2 17/22] clk: Probe clk providers on demand
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-18-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a clock through its firmware node, probe it if it hasn't
already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7bb975747a2c..3cc951989a12 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2979,6 +2979,9 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
 
+	if (clkspec->np)
+		fwnode_ensure_device(&clkspec->np->fwnode);
+
 	/* Check if we have such a provider in our array */
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(provider, &of_clk_providers, link) {
-- 
2.4.3
