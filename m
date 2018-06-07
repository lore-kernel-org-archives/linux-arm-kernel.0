From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  7 Jun 2018 14:24:34 +0200
Subject: [PATCH] pinctrl: pinctrl-single: Avoid divisions in context
 save/restore
Message-ID: <1528374274-26385-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The divisions (and multiplications) can be avoided by changing the loops
to use increments of mux_bytes instead of 1.
While at it, remove the unneeded casts when assigning void pointers.

This saves +100 bytes of kernel size on arm32/arm64.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

As the loops are now identical, the code could be made even smaller by
moving the switch() inside the loop, at the expense of readability.
---
 drivers/pinctrl/pinctrl-single.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 9c3c00515aa0fe20..5de5dedb804928eb 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1593,19 +1593,19 @@ static int pcs_save_context(struct pcs_device *pcs)
 
 	switch (pcs->width) {
 	case 64:
-		regsl = (u64 *)pcs->saved_vals;
-		for (i = 0; i < pcs->size / mux_bytes; i++)
-			regsl[i] = pcs->read(pcs->base + i * mux_bytes);
+		regsl = pcs->saved_vals;
+		for (i = 0; i < pcs->size; i += mux_bytes)
+			*regsl++ = pcs->read(pcs->base + i);
 		break;
 	case 32:
-		regsw = (u32 *)pcs->saved_vals;
-		for (i = 0; i < pcs->size / mux_bytes; i++)
-			regsw[i] = pcs->read(pcs->base + i * mux_bytes);
+		regsw = pcs->saved_vals;
+		for (i = 0; i < pcs->size; i += mux_bytes)
+			*regsw++ = pcs->read(pcs->base + i);
 		break;
 	case 16:
-		regshw = (u16 *)pcs->saved_vals;
-		for (i = 0; i < pcs->size / mux_bytes; i++)
-			regshw[i] = pcs->read(pcs->base + i * mux_bytes);
+		regshw = pcs->saved_vals;
+		for (i = 0; i < pcs->size; i += mux_bytes)
+			*regshw++ = pcs->read(pcs->base + i);
 		break;
 	}
 
@@ -1623,19 +1623,19 @@ static void pcs_restore_context(struct pcs_device *pcs)
 
 	switch (pcs->width) {
 	case 64:
-		regsl = (u64 *)pcs->saved_vals;
-		for (i = 0; i < pcs->size / mux_bytes; i++)
-			pcs->write(regsl[i], pcs->base + i * mux_bytes);
+		regsl = pcs->saved_vals;
+		for (i = 0; i < pcs->size; i += mux_bytes)
+			pcs->write(*regsl++, pcs->base + i);
 		break;
 	case 32:
-		regsw = (u32 *)pcs->saved_vals;
-		for (i = 0; i < pcs->size / mux_bytes; i++)
-			pcs->write(regsw[i], pcs->base + i * mux_bytes);
+		regsw = pcs->saved_vals;
+		for (i = 0; i < pcs->size; i += mux_bytes)
+			pcs->write(*regsw++, pcs->base + i);
 		break;
 	case 16:
-		regshw = (u16 *)pcs->saved_vals;
-		for (i = 0; i < pcs->size / mux_bytes; i++)
-			pcs->write(regshw[i], pcs->base + i * mux_bytes);
+		regshw = pcs->saved_vals;
+		for (i = 0; i < pcs->size; i += mux_bytes)
+			pcs->write(*regshw++, pcs->base + i);
 		break;
 	}
 }
-- 
2.7.4
