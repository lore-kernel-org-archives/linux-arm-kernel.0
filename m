From: vincent.stehle@laposte.net (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Mon, 30 Jan 2017 15:06:43 +0100
Subject: [PATCH] net: thunderx: avoid dereferencing xcv when NULL
Message-ID: <20170130140643.24182-1-vincent.stehle@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following smatch and coccinelle warnings:

  drivers/net/ethernet/cavium/thunder/thunder_xcv.c:119 xcv_setup_link() error: we previously assumed 'xcv' could be null (see line 118) [smatch]
  drivers/net/ethernet/cavium/thunder/thunder_xcv.c:119:16-20: ERROR: xcv is NULL but dereferenced. [coccinelle]

Fixes: 6465859aba1e66a5 ("net: thunderx: Add RGMII interface type support")
Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
Cc: Sunil Goutham <sgoutham@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_xcv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_xcv.c b/drivers/net/ethernet/cavium/thunder/thunder_xcv.c
index 67befedef709..578c7f8f11bf 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_xcv.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_xcv.c
@@ -116,8 +116,7 @@ void xcv_setup_link(bool link_up, int link_speed)
 	int speed = 2;
 
 	if (!xcv) {
-		dev_err(&xcv->pdev->dev,
-			"XCV init not done, probe may have failed\n");
+		pr_err("XCV init not done, probe may have failed\n");
 		return;
 	}
 
-- 
2.11.0
