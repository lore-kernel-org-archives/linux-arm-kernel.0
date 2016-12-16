From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Dec 2016 15:26:45 +0800
Subject: [PATCH v2 1/3] clk: zx296718: do not panic on failure
In-Reply-To: <1481873207-22929-1-git-send-email-shawnguo@kernel.org>
References: <1481873207-22929-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1481873207-22929-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Instead of using panic, we should give an error message and return error
code when of_clk_add_hw_provider() call fails.

Since we have error prompt for failures, the "init over" pr_info output
isn't really necessary but becomes a debug noise.  So let's clean it up
along the way.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/zte/clk-zx296718.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/zte/clk-zx296718.c b/drivers/clk/zte/clk-zx296718.c
index 707d62956e9b..026310708aea 100644
--- a/drivers/clk/zte/clk-zx296718.c
+++ b/drivers/clk/zte/clk-zx296718.c
@@ -610,9 +610,12 @@ static int __init top_clocks_init(struct device_node *np)
 		}
 	}
 
-	if (of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &top_hw_onecell_data))
-		panic("could not register clk provider\n");
-	pr_info("top clk init over, nr:%d\n", TOP_NR_CLKS);
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
+				     &top_hw_onecell_data);
+	if (ret) {
+		pr_err("failed to register top clk provider: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
@@ -776,9 +779,12 @@ static int __init lsp0_clocks_init(struct device_node *np)
 		}
 	}
 
-	if (of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &lsp0_hw_onecell_data))
-		panic("could not register clk provider\n");
-	pr_info("lsp0-clk init over:%d\n", LSP0_NR_CLKS);
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
+				     &lsp0_hw_onecell_data);
+	if (ret) {
+		pr_err("failed to register lsp0 clk provider: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
@@ -881,9 +887,12 @@ static int __init lsp1_clocks_init(struct device_node *np)
 		}
 	}
 
-	if (of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &lsp1_hw_onecell_data))
-		panic("could not register clk provider\n");
-	pr_info("lsp1-clk init over, nr:%d\n", LSP1_NR_CLKS);
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
+				     &lsp1_hw_onecell_data);
+	if (ret) {
+		pr_err("failed to register lsp1 clk provider: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
-- 
1.9.1
