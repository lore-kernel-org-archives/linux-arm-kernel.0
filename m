From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun,  6 Mar 2016 03:21:35 +0200
Subject: [PATCH] clk: bcm2835: fix check of error code returned by
 devm_ioremap_resource()
Message-ID: <1457227295-3093-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change fixes potential oops while accessing iomem on invalid
address, if devm_ioremap_resource() fails due to some reason.

The devm_ioremap_resource() function returns ERR_PTR() and never
returns NULL, which makes useless a following check for NULL.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Fixes: 5e63dcc74b30 ("clk: bcm2835: Add a driver for the auxiliary peripheral clock gates")
---
 drivers/clk/bcm/clk-bcm2835-aux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835-aux.c b/drivers/clk/bcm/clk-bcm2835-aux.c
index e4f89e2..3a177ad 100644
--- a/drivers/clk/bcm/clk-bcm2835-aux.c
+++ b/drivers/clk/bcm/clk-bcm2835-aux.c
@@ -38,8 +38,8 @@ static int bcm2835_aux_clk_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(dev, res);
-	if (!reg)
-		return -ENODEV;
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	onecell = devm_kmalloc(dev, sizeof(*onecell), GFP_KERNEL);
 	if (!onecell)
-- 
2.1.4
