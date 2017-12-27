From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Dec 2017 14:59:52 -0800
Subject: [PATCH 16/20] nvmem: rockchip-efuse: Make use of
 of_device_get_match_data()
In-Reply-To: <20171227225956.14442-1-andrew.smirnov@gmail.com>
References: <20171227225956.14442-1-andrew.smirnov@gmail.com>
Message-ID: <20171227225956.14442-17-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify code a bit by using of_device_get_match_data() instead of
of_match_device().

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Joachim Eastwood <manabian@gmail.com>
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
index d6dc1330f895..979ba0a376a0 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -193,11 +193,11 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct rockchip_efuse_chip *efuse;
-	const struct of_device_id *match;
+	const void *data;
 	struct device *dev = &pdev->dev;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data) {
+	data = of_device_get_match_data(dev);
+	if (!data) {
 		dev_err(dev, "failed to get match data\n");
 		return -EINVAL;
 	}
@@ -218,7 +218,7 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 
 	efuse->dev = &pdev->dev;
 	econfig.size = resource_size(res);
-	econfig.reg_read = match->data;
+	econfig.reg_read = data;
 	econfig.priv = efuse;
 	econfig.dev = efuse->dev;
 	nvmem = devm_nvmem_register(dev, &econfig);
-- 
2.14.3
