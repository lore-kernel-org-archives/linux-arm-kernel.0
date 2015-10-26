From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 26 Oct 2015 17:46:37 +0800
Subject: [PATCH] soc: mediatek: Init MT8173 scpsys driver earlier
Message-ID: <1445852797-15549-1-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some power domain comsumers may init before module_init.
So the power domain provider (scpsys) need to be initialized
earlier too.

This patch modify scpsys driver init level from module_init to
subsys_initcall.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---

This patch is based on v4.3-rc7.

 drivers/soc/mediatek/mtk-scpsys.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 164a7d8..7d5d55d 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -485,4 +485,15 @@ static struct platform_driver scpsys_drv = {
 	},
 };
 
-module_platform_driver_probe(scpsys_drv, scpsys_probe);
+static int __init scpsys_drv_init(void)
+{
+	return platform_driver_probe(&scpsys_drv, scpsys_probe);
+}
+
+static void __exit scpsys_drv_exit(void)
+{
+	platform_driver_unregister(&scpsys_drv);
+}
+
+subsys_initcall(scpsys_drv_init);
+module_exit(scpsys_drv_exit);
-- 
1.9.1
