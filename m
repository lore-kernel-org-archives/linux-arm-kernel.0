From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 22 Feb 2016 11:24:05 +0000
Subject: [PATCH 3/3] nvmem: mediatek: Fix later provider initialization
In-Reply-To: <1456140161-6851-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456140161-6851-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456140245-6982-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew-CT Chen <andrew-ct.chen@mediatek.com>

Possibly, provider driver initialization is later than
consumer driver. Use function subsys_initcall to initialize
NVMEM provider early to ensure NVMEM consumer doesn't need
to -EPROBE_DEFER.

Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mtk-efuse.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 7b35f5b..9c49369 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -83,7 +83,28 @@ static struct platform_driver mtk_efuse_driver = {
 		.of_match_table = mtk_efuse_of_match,
 	},
 };
-module_platform_driver(mtk_efuse_driver);
+
+static int __init mtk_efuse_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&mtk_efuse_driver);
+	if (ret) {
+		pr_err("Failed to register efuse driver\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit mtk_efuse_exit(void)
+{
+	return platform_driver_unregister(&mtk_efuse_driver);
+}
+
+subsys_initcall(mtk_efuse_init);
+module_exit(mtk_efuse_exit);
+
 MODULE_AUTHOR("Andrew-CT Chen <andrew-ct.chen@mediatek.com>");
 MODULE_DESCRIPTION("Mediatek EFUSE driver");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1
