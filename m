From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 23 Apr 2018 14:41:47 +0200
Subject: [PATCH v2 1/3] nvmem: meson-efuse: remove econfig global
In-Reply-To: <20180423124149.3077-1-jbrunet@baylibre.com>
References: <20180423124149.3077-1-jbrunet@baylibre.com>
Message-ID: <20180423124149.3077-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having a global structure holding a reference to the device
structure is not very nice. Allocate the econfig instead and fill
the nvmem information as before

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvmem/meson-efuse.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 71823d1403c5..2df9b0094f45 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -35,13 +35,6 @@ static int meson_efuse_read(void *context, unsigned int offset,
 	return 0;
 }
 
-static struct nvmem_config econfig = {
-	.name = "meson-efuse",
-	.stride = 1,
-	.word_size = 1,
-	.read_only = true,
-};
-
 static const struct of_device_id meson_efuse_match[] = {
 	{ .compatible = "amlogic,meson-gxbb-efuse", },
 	{ /* sentinel */ },
@@ -50,17 +43,27 @@ MODULE_DEVICE_TABLE(of, meson_efuse_match);
 
 static int meson_efuse_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct nvmem_device *nvmem;
+	struct nvmem_config *econfig;
 	unsigned int size;
 
 	if (meson_sm_call(SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0)
 		return -EINVAL;
 
-	econfig.dev = &pdev->dev;
-	econfig.reg_read = meson_efuse_read;
-	econfig.size = size;
+	econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
+	if (!econfig)
+		return -ENOMEM;
+
+	econfig->dev = dev;
+	econfig->name = dev_name(dev);
+	econfig->stride = 1;
+	econfig->word_size = 1;
+	econfig->read_only = true;
+	econfig->reg_read = meson_efuse_read;
+	econfig->size = size;
 
-	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
+	nvmem = devm_nvmem_register(&pdev->dev, econfig);
 
 	return PTR_ERR_OR_ZERO(nvmem);
 }
-- 
2.14.3
