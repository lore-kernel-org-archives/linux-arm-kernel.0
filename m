From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  6 Feb 2015 16:33:09 +0100
Subject: [PATCH] drm: atmel-hlcdc: reset layer A2Q and UPDATE bits when
 disabling it
Message-ID: <1423236789-6859-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A2Q (Add To Queue) and UPDATE bits are left in their previous state
when resetting the layer.
This lead to weird behavior when enabling the plane again: the framebuffer
previously queued is dequeued and we end up with access to an old memory
region.

Reset those bits when resetting the channel.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
index 063d2a7..e79bd9b 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
@@ -311,7 +311,8 @@ int atmel_hlcdc_layer_disable(struct atmel_hlcdc_layer *layer)
 
 	/* Disable the layer */
 	regmap_write(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_CHDR,
-		     ATMEL_HLCDC_LAYER_RST);
+		     ATMEL_HLCDC_LAYER_RST | ATMEL_HLCDC_LAYER_A2Q |
+		     ATMEL_HLCDC_LAYER_UPDATE);
 
 	/* Clear all pending interrupts */
 	regmap_read(regmap, desc->regs_offset + ATMEL_HLCDC_LAYER_ISR, &isr);
-- 
1.9.1
