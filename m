From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  1 Jun 2016 13:42:50 +0200
Subject: [PATCH] drm: atmel-hlcdc: actually disable scaling when no scaling is
 required
Message-ID: <1464781370-19277-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is only enabling scaling, but never disabling it, thus, if you
enable the scaling feature once it stays enabled forever.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Alex Vazquez <avazquez.dev@gmail.com>
Fixes: 1a396789f65a ("drm: add Atmel HLCDC Display Controller support")
Cc: <stable@vger.kernel.org>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index aef3ca8..016c191 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -339,6 +339,8 @@ atmel_hlcdc_plane_update_pos_and_size(struct atmel_hlcdc_plane *plane,
 
 		atmel_hlcdc_layer_update_cfg(&plane->layer, 13, 0xffffffff,
 					     factor_reg);
+	} else {
+		atmel_hlcdc_layer_update_cfg(&plane->layer, 13, 0xffffffff, 0);
 	}
 }
 
-- 
2.7.4
