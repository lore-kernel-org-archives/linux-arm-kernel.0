From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 19 Dec 2015 22:19:33 +0100
Subject: [PATCH] nvmem: delete unneeded IS_ERR test
Message-ID: <1450559973-9067-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_kzalloc returns NULL rather than an ERR_PTR value.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,e;
@@

* x = devm_kzalloc(...)
... when != x = e
* IS_ERR(x)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/nvmem/rockchip-efuse.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index f552134..811c73c 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -136,8 +136,8 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 
 	context = devm_kzalloc(dev, sizeof(struct rockchip_efuse_context),
 			       GFP_KERNEL);
-	if (IS_ERR(context))
-		return PTR_ERR(context);
+	if (!context)
+		return -ENOMEM;
 
 	clk = devm_clk_get(dev, "pclk_efuse");
 	if (IS_ERR(clk))
