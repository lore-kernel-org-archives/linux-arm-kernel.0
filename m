From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 08 Aug 2015 17:03:40 +0100
Subject: [PATCH 04/12] gpu: imx: fix support for interlaced modes
In-Reply-To: <20150808160251.GM7557@n2100.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZO6ay-0002qh-6E@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The support for interlaced video modes seems to be broken; we don't use
anything other than the vtotal/htotal from the timing information to
define the various sync counters.

Freescale patches for interlaced video support contain an alternative
sync counter setup, which we include here.  This setup produces the
hsync and vsync via the normal counter 2 and 3, but moves the display
enable signal from counter 5 to counter 6.  Therefore, we need to
change the display controller setup as well.

The corresponding Freescale patches for this change are:
  iMX6-HDMI-support-interlaced-display-mode.patch
  IPU-fine-tuning-the-interlace-display-timing-for-CEA.patch

This produces a working interlace format output from the IPU.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/ipu-v3/ipu-dc.c | 18 ++++++++---
 drivers/gpu/ipu-v3/ipu-di.c | 79 +++++++++++++++++++++------------------------
 2 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-dc.c b/drivers/gpu/ipu-v3/ipu-dc.c
index 9ef2e1f54ca4..aa560855c1dc 100644
--- a/drivers/gpu/ipu-v3/ipu-dc.c
+++ b/drivers/gpu/ipu-v3/ipu-dc.c
@@ -183,12 +183,22 @@ int ipu_dc_init_sync(struct ipu_dc *dc, struct ipu_di *di, bool interlaced,
 	}
 
 	if (interlaced) {
-		dc_link_event(dc, DC_EVT_NL, 0, 3);
-		dc_link_event(dc, DC_EVT_EOL, 0, 2);
-		dc_link_event(dc, DC_EVT_NEW_DATA, 0, 1);
+		int word, addr;
+
+		if (dc->di) {
+			addr = 1;
+			word = 1;
+		} else {
+			addr = 0;
+			word = 0;
+		}
+
+		dc_link_event(dc, DC_EVT_NL, addr, 3);
+		dc_link_event(dc, DC_EVT_EOL, addr, 2);
+		dc_link_event(dc, DC_EVT_NEW_DATA, addr, 1);
 
 		/* Init template microcode */
-		dc_write_tmpl(dc, 0, WROD(0), 0, map, SYNC_WAVE, 0, 8, 1);
+		dc_write_tmpl(dc, word, WROD(0), 0, map, SYNC_WAVE, 0, 6, 1);
 	} else {
 		if (dc->di) {
 			dc_link_event(dc, DC_EVT_NL, 2, 3);
diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
index a96991c5c15f..359268e3a166 100644
--- a/drivers/gpu/ipu-v3/ipu-di.c
+++ b/drivers/gpu/ipu-v3/ipu-di.c
@@ -71,6 +71,10 @@ enum di_sync_wave {
 	DI_SYNC_HSYNC = 3,
 	DI_SYNC_VSYNC = 4,
 	DI_SYNC_DE = 6,
+
+	DI_SYNC_CNT1 = 2,	/* counter >= 2 only */
+	DI_SYNC_CNT4 = 5,	/* counter >= 5 only */
+	DI_SYNC_CNT5 = 6,	/* counter >= 6 only */
 };
 
 #define SYNC_WAVE 0
@@ -211,66 +215,59 @@ static void ipu_di_sync_config_interlaced(struct ipu_di *di,
 		sig->mode.hback_porch + sig->mode.hfront_porch;
 	u32 v_total = sig->mode.vactive + sig->mode.vsync_len +
 		sig->mode.vback_porch + sig->mode.vfront_porch;
-	u32 reg;
 	struct di_sync_config cfg[] = {
 		{
-			.run_count = h_total / 2 - 1,
-			.run_src = DI_SYNC_CLK,
+			/* 1: internal VSYNC for each frame */
+			.run_count = v_total * 2 - 1,
+			.run_src = 3,			/* == counter 7 */
 		}, {
-			.run_count = h_total - 11,
+			/* PIN2: HSYNC waveform */
+			.run_count = h_total - 1,
 			.run_src = DI_SYNC_CLK,
-			.cnt_down = 4,
+			.cnt_polarity_gen_en = 1,
+			.cnt_polarity_trigger_src = DI_SYNC_CLK,
+			.cnt_down = sig->mode.hsync_len * 2,
 		}, {
-			.run_count = v_total * 2 - 1,
-			.run_src = DI_SYNC_INT_HSYNC,
-			.offset_count = 1,
-			.offset_src = DI_SYNC_INT_HSYNC,
-			.cnt_down = 4,
+			/* PIN3: VSYNC waveform */
+			.run_count = v_total - 1,
+			.run_src = 4,			/* == counter 7 */
+			.cnt_polarity_gen_en = 1,
+			.cnt_polarity_trigger_src = 4,	/* == counter 7 */
+			.cnt_down = sig->mode.vsync_len * 2,
+			.cnt_clr_src = DI_SYNC_CNT1,
 		}, {
-			.run_count = v_total / 2 - 1,
+			/* 4: Field */
+			.run_count = v_total / 2,
 			.run_src = DI_SYNC_HSYNC,
-			.offset_count = sig->mode.vback_porch,
-			.offset_src = DI_SYNC_HSYNC,
+			.offset_count = h_total / 2,
+			.offset_src = DI_SYNC_CLK,
 			.repeat_count = 2,
-			.cnt_clr_src = DI_SYNC_VSYNC,
+			.cnt_clr_src = DI_SYNC_CNT1,
 		}, {
+			/* 5: Active lines */
 			.run_src = DI_SYNC_HSYNC,
-			.repeat_count = sig->mode.vactive / 2,
-			.cnt_clr_src = 4,
-		}, {
-			.run_count = v_total - 1,
-			.run_src = DI_SYNC_HSYNC,
-		}, {
-			.run_count = v_total / 2 - 1,
-			.run_src = DI_SYNC_HSYNC,
-			.offset_count = 9,
+			.offset_count = (sig->mode.vsync_len +
+					 sig->mode.vback_porch) / 2,
 			.offset_src = DI_SYNC_HSYNC,
-			.repeat_count = 2,
-			.cnt_clr_src = DI_SYNC_VSYNC,
+			.repeat_count = sig->mode.vactive / 2,
+			.cnt_clr_src = DI_SYNC_CNT4,
 		}, {
+			/* 6: Active pixel, referenced by DC */
 			.run_src = DI_SYNC_CLK,
-			.offset_count = sig->mode.hback_porch,
+			.offset_count = sig->mode.hsync_len +
+					sig->mode.hback_porch,
 			.offset_src = DI_SYNC_CLK,
 			.repeat_count = sig->mode.hactive,
-			.cnt_clr_src = 5,
+			.cnt_clr_src = DI_SYNC_CNT5,
 		}, {
-			.run_count = v_total - 1,
-			.run_src = DI_SYNC_INT_HSYNC,
-			.offset_count = v_total / 2,
-			.offset_src = DI_SYNC_INT_HSYNC,
-			.cnt_clr_src = DI_SYNC_HSYNC,
-			.cnt_down = 4,
+			/* 7: Half line HSYNC */
+			.run_count = h_total / 2 - 1,
+			.run_src = DI_SYNC_CLK,
 		}
 	};
 
 	ipu_di_sync_config(di, cfg, 0, ARRAY_SIZE(cfg));
 
-	/* set gentime select and tag sel */
-	reg = ipu_di_read(di, DI_SW_GEN1(9));
-	reg &= 0x1FFFFFFF;
-	reg |= (3 - 1) << 29 | 0x00008000;
-	ipu_di_write(di, reg, DI_SW_GEN1(9));
-
 	ipu_di_write(di, v_total / 2 - 1, DI_SCR_CONF);
 }
 
@@ -605,10 +602,8 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 
 		/* set y_sel = 1 */
 		di_gen |= 0x10000000;
-		di_gen |= DI_GEN_POLARITY_5;
-		di_gen |= DI_GEN_POLARITY_8;
 
-		vsync_cnt = 7;
+		vsync_cnt = 3;
 	} else {
 		ipu_di_sync_config_noninterlaced(di, sig, div);
 
-- 
2.1.0
