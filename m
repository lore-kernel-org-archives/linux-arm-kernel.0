From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 23 Apr 2018 14:41:49 +0200
Subject: [PATCH v2 3/3] nvmem: meson-efuse: add write support
In-Reply-To: <20180423124149.3077-1-jbrunet@baylibre.com>
References: <20180423124149.3077-1-jbrunet@baylibre.com>
Message-ID: <20180423124149.3077-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add write support to the meson-gx efuse driver.
Beware, this efuse is one time programmable !

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvmem/meson-efuse.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 4623249dfd87..d769840d1e18 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -28,6 +28,13 @@ static int meson_efuse_read(void *context, unsigned int offset,
 				  bytes, 0, 0, 0);
 }
 
+static int meson_efuse_write(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	return meson_sm_call_write((u8 *)val, bytes, SM_EFUSE_WRITE, offset,
+				   bytes, 0, 0, 0);
+}
+
 static const struct of_device_id meson_efuse_match[] = {
 	{ .compatible = "amlogic,meson-gxbb-efuse", },
 	{ /* sentinel */ },
@@ -52,8 +59,8 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	econfig->name = dev_name(dev);
 	econfig->stride = 1;
 	econfig->word_size = 1;
-	econfig->read_only = true;
 	econfig->reg_read = meson_efuse_read;
+	econfig->reg_write = meson_efuse_write;
 	econfig->size = size;
 
 	nvmem = devm_nvmem_register(&pdev->dev, econfig);
-- 
2.14.3
