From: david@lechnology.com (David Lechner)
Date: Thu,  4 Jan 2018 18:38:09 -0600
Subject: [PATCH 4/7] clk: hisilicon: make use of clk_alloc_onecell_data()
In-Reply-To: <1515112695-3160-1-git-send-email-david@lechnology.com>
References: <1515112695-3160-1-git-send-email-david@lechnology.com>
Message-ID: <1515112695-3160-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper function clk_alloc_onecell_data() to allocate struct
clk_onecell_data.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/hisilicon/clk-hi3620.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 77072c7..15f8d50 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -476,21 +476,16 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 		return;
 	}
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	clk_data = clk_alloc_onecell_data(num);
 	if (WARN_ON(!clk_data))
 		return;
 
-	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
-		return;
-
 	for (i = 0; i < num; i++) {
 		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
 		clk_data->clks[mmc_clk->id] =
 			hisi_register_clk_mmc(mmc_clk, base, node);
 	}
 
-	clk_data->clk_num = num;
 	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 }
 
-- 
2.7.4
