From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 17 Sep 2013 11:31:26 -0500
Subject: [PATCH 2/2] arm: socfpga: Remove check for "reg" property in
 socfpga_clk_init
In-Reply-To: <1379435486-25981-1-git-send-email-dinguyen@altera.com>
References: <1379435486-25981-1-git-send-email-dinguyen@altera.com>
Message-ID: <1379435486-25981-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The function socfpga_clk_init() can support clocks that do not have a divider
register, but a fixed-divider that can be read from DTS. Therefore, the "reg"
property is not a failing condition for socfpga_clk_init().

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/clk/socfpga/clk.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 81dd31a..c378489 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -121,9 +121,7 @@ static __init struct clk *socfpga_clk_init(struct device_node *node,
 	int rc;
 	u32 fixed_div;
 
-	rc = of_property_read_u32(node, "reg", &reg);
-	if (WARN_ON(rc))
-		return NULL;
+	of_property_read_u32(node, "reg", &reg);
 
 	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
 	if (WARN_ON(!socfpga_clk))
-- 
1.7.9.5
