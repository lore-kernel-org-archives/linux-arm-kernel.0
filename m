From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 29 Oct 2013 16:20:19 +0530
Subject: [PATCH] clk: Zero-initialize memory for new clock in devm_clk_register
Message-ID: <1383043819-9123-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Earlier to commit 64c862a839a8 ("devres: add kernel standard devm_k.alloc
functions") devres_alloc API used to zero-initialize the devres
allocated object, but now only the devres header is zero-initialized.

Since clk_register zero-initializes the memory while allocating for
a new clock, passing explicit flag __GFP_ZERO to devres_alloc in
devm_clk_register to match the behaviour.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/clk/clk.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2cf2ea6..ea3f2b9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1932,7 +1932,8 @@ struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw)
 	struct clk *clk;
 	int ret;
 
-	clk = devres_alloc(devm_clk_release, sizeof(*clk), GFP_KERNEL);
+	clk = devres_alloc(devm_clk_release, sizeof(*clk),
+			GFP_KERNEL|__GFP_ZERO);
 	if (!clk)
 		return ERR_PTR(-ENOMEM);
 
-- 
1.7.9.5
