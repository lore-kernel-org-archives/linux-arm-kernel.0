From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Jul 2012 11:52:23 +0800
Subject: [PATCH v2 2/2] clk: fix compile for OF && !COMMON_CLK
In-Reply-To: <1342583543-20404-1-git-send-email-shawn.guo@linaro.org>
References: <1342583543-20404-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1342583543-20404-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With commit 766e6a4ec602d0c107 (clk: add DT clock binding support),
compiling with OF && !COMMON_CLK is broken.

Reported-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Reported-by: Prashant Gaikwad <pgaikwad@nvidia.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/clk/clkdev.c |    2 +-
 include/linux/clk.h  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 69085e0..d423c9b 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -24,7 +24,7 @@
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
 
-#ifdef CONFIG_OF
+#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index)
 {
 	struct of_phandle_args clkspec;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 6283e2e..f80ebad 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -364,7 +364,7 @@ int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
 struct device_node;
 struct of_phandle_args;
 
-#ifdef CONFIG_OF
+#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
-- 
1.7.4.1
