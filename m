From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 08 Feb 2014 13:25:25 -0000
Subject: [PATCH RESEND v3] clk: return probe defer when DT clock not yet ready
Message-ID: <20140208132446.2A26694003E@smtp1-g21.free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At probe time, a clock device may not be ready when some other device
wants to use it.

This patch lets the functions clk_get/devm_clk_get return a probe defer
when the clock is defined in the DT but not yet available.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
resend v3:
	- base kernel 3.14.0-rc1
	- __clk_get() failure is fixed
resend v2: remove ASoc from subject (thank you, Mark)
resend: - patch subject change from
   [PATCH v3 1/2] ASoC: kirkwood: clk: probe defer when clock not yet ready
	- base kernel 3.13.0-rc1
v2: fix __clk_get() failure (from Russell King)
---
 drivers/clk/clk.c    | 2 +-
 drivers/clk/clkdev.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5517944..32d84e9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2472,7 +2472,7 @@ EXPORT_SYMBOL_GPL(of_clk_del_provider);
 struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
 	struct of_clk_provider *provider;
-	struct clk *clk = ERR_PTR(-ENOENT);
+	struct clk *clk = ERR_PTR(-EPROBE_DEFER);
 
 	/* Check if we have such a provider in our array */
 	list_for_each_entry(provider, &of_clk_providers, link) {
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 48f6721..a360b2e 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -167,6 +167,8 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 		clk = of_clk_get_by_name(dev->of_node, con_id);
 		if (!IS_ERR(clk))
 			return clk;
+		if (PTR_ERR(clk) == -EPROBE_DEFER)
+			return clk;
 	}
 
 	return clk_get_sys(dev_id, con_id);
-- 
1.9.0.rc3
