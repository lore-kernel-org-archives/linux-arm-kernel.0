From: andrew-ct.chen@mediatek.com (Andrew-CT Chen)
Date: Fri, 25 Dec 2015 11:41:15 +0800
Subject: [PATCH] nvmem: mediatek: Fix later provider initialization
Message-ID: <1451014875-11625-1-git-send-email-andrew-ct.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Possibly, provider driver initialization is later than
consumer driver. Use function subsys_initcall to initialize
NVMEM provider early to ensure NVMEM consumer doesn't need
to -EPROBE_DEFER.

Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
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
