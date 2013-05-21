From: list-09_linux_arm@tqsc.de (Markus Niebel)
Date: Tue, 21 May 2013 20:04:07 +0200
Subject: [PATCH v2 3/3] staging: drm/imx: revert vsync_cnt for di->id 1
In-Reply-To: <1369159448-14584-1-git-send-email-list-09_linux_arm@tqsc.de>
References: <1369159448-14584-1-git-send-email-list-09_linux_arm@tqsc.de>
Message-ID: <1369159448-14584-4-git-send-email-list-09_linux_arm@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tqs.de>

partial fix of changes from
"staging: drm/imx: Add support for VGA via TVE on i.MX53"

parallel display support / DVI needs the original setting to work

Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
V2:
  - no changes in patch
  - add Acked-by from v1 of patch

 drivers/staging/imx-drm/ipu-v3/ipu-di.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
index e7b9c98..0b6806e 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
@@ -603,7 +603,12 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 
 		vsync_cnt = 3;
 		if (di->id == 1)
-			vsync_cnt = 6;
+			/*
+			 * TODO: change only for TVEv2, parallel display
+			 * uses pin 2 / 3
+			 */
+			if (!(sig->hsync_pin == 2 && sig->vsync_pin == 3))
+				vsync_cnt = 6;
 
 		if (sig->Hsync_pol) {
 			if (sig->hsync_pin == 2)
-- 
1.7.9.5
