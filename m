From: henryc.chen@mediatek.com (Henry Chen)
Date: Wed, 23 Dec 2015 16:57:29 +0800
Subject: [PATCH] soc: mediatek: PMIC wrap: convert to arch_initcall
Message-ID: <1450861049-12726-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move pmic wrap initialization earlier in boot so that real devices
can use pmic without probe deferring.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index ccd5337..a8cde17 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -945,7 +945,11 @@ static struct platform_driver pwrap_drv = {
 	.probe = pwrap_probe,
 };
 
-module_platform_driver(pwrap_drv);
+static int __init mtk_pmic_wrap_init(void)
+{
+	return platform_driver_register(&pwrap_drv);
+}
+arch_initcall(mtk_pmic_wrap_init);
 
 MODULE_AUTHOR("Flora Fu, MediaTek");
 MODULE_DESCRIPTION("MediaTek MT8135 PMIC Wrapper Driver");
-- 
1.9.1
