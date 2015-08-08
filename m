From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:03:35 +0100
Subject: [PATCH 03/12] gpu: imx: simplify sync polarity setting
In-Reply-To: <20150808160251.GM7557@n2100.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6at-0002qb-2m@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a function to convert the sync pin to a bit mask for the DI_GENERAL
register, and move this out of the interlace/non-interlace path to the
common path.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/ipu-v3/ipu-di.c | 50 +++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
index 2970c6bb668c..a96991c5c15f 100644
--- a/drivers/gpu/ipu-v3/ipu-di.c
+++ b/drivers/gpu/ipu-v3/ipu-di.c
@@ -543,6 +543,29 @@ int ipu_di_adjust_videomode(struct ipu_di *di, struct videomode *mode)
 }
 EXPORT_SYMBOL_GPL(ipu_di_adjust_videomode);
 
+static u32 ipu_di_gen_polarity(int pin)
+{
+	switch (pin) {
+	case 1:
+		return DI_GEN_POLARITY_1;
+	case 2:
+		return DI_GEN_POLARITY_2;
+	case 3:
+		return DI_GEN_POLARITY_3;
+	case 4:
+		return DI_GEN_POLARITY_4;
+	case 5:
+		return DI_GEN_POLARITY_5;
+	case 6:
+		return DI_GEN_POLARITY_6;
+	case 7:
+		return DI_GEN_POLARITY_7;
+	case 8:
+		return DI_GEN_POLARITY_8;
+	}
+	return 0;
+}
+
 int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 {
 	u32 reg;
@@ -586,11 +609,6 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 		di_gen |= DI_GEN_POLARITY_8;
 
 		vsync_cnt = 7;
-
-		if (sig->mode.flags & DISPLAY_FLAGS_HSYNC_HIGH)
-			di_gen |= DI_GEN_POLARITY_3;
-		if (sig->mode.flags & DISPLAY_FLAGS_VSYNC_HIGH)
-			di_gen |= DI_GEN_POLARITY_2;
 	} else {
 		ipu_di_sync_config_noninterlaced(di, sig, div);
 
@@ -602,25 +620,13 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 			 */
 			if (!(sig->hsync_pin == 2 && sig->vsync_pin == 3))
 				vsync_cnt = 6;
-
-		if (sig->mode.flags & DISPLAY_FLAGS_HSYNC_HIGH) {
-			if (sig->hsync_pin == 2)
-				di_gen |= DI_GEN_POLARITY_2;
-			else if (sig->hsync_pin == 4)
-				di_gen |= DI_GEN_POLARITY_4;
-			else if (sig->hsync_pin == 7)
-				di_gen |= DI_GEN_POLARITY_7;
-		}
-		if (sig->mode.flags & DISPLAY_FLAGS_VSYNC_HIGH) {
-			if (sig->vsync_pin == 3)
-				di_gen |= DI_GEN_POLARITY_3;
-			else if (sig->vsync_pin == 6)
-				di_gen |= DI_GEN_POLARITY_6;
-			else if (sig->vsync_pin == 8)
-				di_gen |= DI_GEN_POLARITY_8;
-		}
 	}
 
+	if (sig->mode.flags & DISPLAY_FLAGS_HSYNC_HIGH)
+		di_gen |= ipu_di_gen_polarity(sig->hsync_pin);
+	if (sig->mode.flags & DISPLAY_FLAGS_VSYNC_HIGH)
+		di_gen |= ipu_di_gen_polarity(sig->vsync_pin);
+
 	if (sig->clk_pol)
 		di_gen |= DI_GEN_POLARITY_DISP_CLK;
 
-- 
2.1.0
