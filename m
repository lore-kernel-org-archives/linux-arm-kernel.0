From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 17:15:59 +0000
Subject: [PATCH 06/15] clk: export __clk_get_name
In-Reply-To: <1358788568-11137-1-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
Message-ID: <1358788568-11137-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __clk_get_name is used by drivers that provide their
own clocks, which have traditionally all been built-in.
The new imx drm driver however provides clocks but can
be built as a module, so we need to export __clk_get_name.

While this is only a staging driver, it's likely that
there will be others like it in the future.

Without this patch, building ARM allmodconfig results in:

ERROR: "__clk_get_name" [drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.ko] undefined!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/clk.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 251e45d..13b793e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -263,6 +263,7 @@ inline const char *__clk_get_name(struct clk *clk)
 {
 	return !clk ? NULL : clk->name;
 }
+EXPORT_SYMBOL_GPL(__clk_get_name);
 
 inline struct clk_hw *__clk_get_hw(struct clk *clk)
 {
-- 
1.7.10.4
