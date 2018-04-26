From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 26 Apr 2018 16:44:31 +0800
Subject: [PATCH v7 1/7] clk: meson: migrate to devm_of_clk_add_hw_provider API
In-Reply-To: <20180426084437.192394-1-yixun.lan@amlogic.com>
References: <20180426084437.192394-1-yixun.lan@amlogic.com>
Message-ID: <20180426084437.192394-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a protential memory leak, as of_clk_del_provider is
never called if of_clk_add_hw_provider has been executed.
Fix this by using devm variant API.

Fixes: f8c11f79912d ("clk: meson: Add GXBB AO Clock and Reset controller driver")
Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/gxbb-aoclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 9ec23ae9a219..eebb580b9e0f 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -191,7 +191,7 @@ static int gxbb_aoclkc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
 			&gxbb_aoclk_onecell_data);
 }
 
-- 
2.17.0
