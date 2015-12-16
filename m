From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 Dec 2015 12:00:56 +0100
Subject: [PATCH v2] soc: mediatek: SCPSYS: use module_platform_driver
Message-ID: <1450263656-12513-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With regulator support to the scpsys driver needs to be able to defer
probe. Probe deferral is incompatible with module_platform_driver_probe,
so use module_platform_driver. module_platform_driver_probe sets the
suppress_bind_attrs. To prevent unbinding the device with
module_platform_driver we have to set the flag explicitly in the driver
now.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Changes since v1:
- Add suppress_bind_attrs attribute

 drivers/soc/mediatek/mtk-scpsys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index e425619..ae2d177 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -542,11 +542,13 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 };
 
 static struct platform_driver scpsys_drv = {
+	.probe = scpsys_probe,
 	.driver = {
 		.name = "mtk-scpsys",
+		.suppress_bind_attrs = true,
 		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(of_scpsys_match_tbl),
 	},
 };
 
-module_platform_driver_probe(scpsys_drv, scpsys_probe);
+module_platform_driver(scpsys_drv);
-- 
2.6.2
