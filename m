From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu,  8 Mar 2018 11:12:03 -0800
Subject: [PATCH v5 19/21] nvmem: rockchip-efuse: Do not use "&pdev->dev"
 explicitly
In-Reply-To: <20180308191205.26943-1-andrew.smirnov@gmail.com>
References: <20180308191205.26943-1-andrew.smirnov@gmail.com>
Message-ID: <20180308191205.26943-20-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's "dev" variable for this already. Use it.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy at gmail.com
Cc: linux-kernel at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: linux-amlogic at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/rockchip-efuse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index ade8848adf82..b3b0b648be62 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -268,21 +268,21 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	efuse = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_efuse_chip),
+	efuse = devm_kzalloc(dev, sizeof(struct rockchip_efuse_chip),
 			     GFP_KERNEL);
 	if (!efuse)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	efuse->base = devm_ioremap_resource(&pdev->dev, res);
+	efuse->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
 
-	efuse->clk = devm_clk_get(&pdev->dev, "pclk_efuse");
+	efuse->clk = devm_clk_get(dev, "pclk_efuse");
 	if (IS_ERR(efuse->clk))
 		return PTR_ERR(efuse->clk);
 
-	efuse->dev = &pdev->dev;
+	efuse->dev = dev;
 	if (of_property_read_u32(dev->of_node, "rockchip,efuse-size",
 				 &econfig.size))
 		econfig.size = resource_size(res);
-- 
2.14.3
