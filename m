From: jun.gao@mediatek.com (Jun Gao)
Date: Thu, 6 Sep 2018 21:15:28 +0800
Subject: [PATCH v3 1/2] i2c: mediatek: Register i2c adapter driver earlier
In-Reply-To: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
References: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
Message-ID: <1536239729-10008-2-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Gao <jun.gao@mediatek.com>

In order not to block the initializations of some i2c devices.
Register i2c adapter driver at appropriate time.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 1e57f58..806e8b90 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -888,7 +888,17 @@ static int mtk_i2c_resume(struct device *dev)
 	},
 };
 
-module_platform_driver(mtk_i2c_driver);
+static int __init mtk_i2c_adap_init(void)
+{
+	return platform_driver_register(&mtk_i2c_driver);
+}
+subsys_initcall(mtk_i2c_adap_init);
+
+static void __exit mtk_i2c_adap_exit(void)
+{
+	platform_driver_unregister(&mtk_i2c_driver);
+}
+module_exit(mtk_i2c_adap_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MediaTek I2C Bus Driver");
-- 
1.8.1.1
