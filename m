From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 May 2014 19:29:49 -0500
Subject: [PATCH 3/7] clk: sunxi: avoid double DT matching
In-Reply-To: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
References: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
Message-ID: <1399940993-1773-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Use for_each_matching_node_and_match instead of for_each_matching_node plus
of_match_node to avoid searching the DT twice for each node.

The sunxi DT scanning code should really be re-worked rather than have
its own private matching infrastructure. It is working around needing a
function pointer and a data pointer for each compatible match.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: "Emilio L?pez" <emilio@elopez.com.ar>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index bd7dc73..7977106 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1278,8 +1278,7 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
 	const struct of_device_id *match;
 	void (*setup_function)(struct device_node *, const void *) = function;
 
-	for_each_matching_node(np, clk_match) {
-		match = of_match_node(clk_match, np);
+	for_each_matching_node_and_match(np, clk_match, match) {
 		data = match->data;
 		setup_function(np, data);
 	}
-- 
1.9.1
