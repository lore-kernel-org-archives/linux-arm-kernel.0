From: denis@eukrea.com (Denis Carikli)
Date: Thu,  6 Mar 2014 17:04:26 +0100
Subject: [PATCH v9][ 5/8] staging: imx-drm: Use de-active and pixelclk-active
 display-timings.
In-Reply-To: <1394121869-13387-1-git-send-email-denis@eukrea.com>
References: <1394121702-13257-3-git-send-email-denis@eukrea.com>
 <1394121869-13387-1-git-send-email-denis@eukrea.com>
Message-ID: <1394121869-13387-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If de-active and/or pixelclk-active properties were set in the
display-timings DT node, they were not used.

Instead the data-enable and the pixel data clock polarity
were hardcoded.

The dts were updated to keep the former behaviour.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v8->v9:
- Removed the Cc. They are now set in git-send-email directly.
- Rebased on top of the following patch:
  "imx-drm: Match ipu_di_signal_cfg's clk_pol with its description."
- Updated the current dts that were using the ipuv3 accordingly,
  to keep the same hardware settings.
- In the display-timing.txt documentation, the pixelclk-active
  and de-active optional properties have an "ignored" state
  when the property is not set.
  In this new version, the respective bits in the
  display interface's general register are not touched if the
  dt properties are not set.

ChangeLog v7->v8:
- Changed one Cc

ChangeLog v6->v7:
- Shrinked even more the Cc list.
- Rebased the patch
- val is now initialized in imx_pd_connector_get_modes

ChangeLog v5->v6:
- Remove people not concerned by this patch from the Cc list.
- Removed wrong coments from the code.
- Corrected the code style of the "if (!!val)"

ChangeLog v3->v4:
- The old patch was named "staging: imx-drm: ipuv3-crtc: don't harcode some mode".
- Reworked the patch entierly: we now takes the mode flags from the device tree.

ChangeLog v2->v3:
- Added some interested people in the Cc list.
- Ajusted the flags to match the changes in "drm: Add the lacking
  DRM_MODE_FLAG_* for matching the DISPLAY_FLAGS_*"
---
 arch/arm/boot/dts/imx51-babbage.dts         |    2 ++
 arch/arm/boot/dts/imx53-m53evk.dts          |    2 ++
 arch/arm/boot/dts/imx53-tx53-x03x.dts       |    2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi       |    2 ++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi       |    2 ++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi   |    2 ++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi    |    2 ++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi    |    2 ++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi      |    2 ++
 drivers/staging/imx-drm/imx-drm.h           |    5 ++++
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |    4 ++++
 drivers/staging/imx-drm/ipu-v3/ipu-di.c     |   17 ++++++++++----
 drivers/staging/imx-drm/ipuv3-crtc.c        |   18 ++++++++++++--
 drivers/staging/imx-drm/parallel-display.c  |   34 +++++++++++++++++++++++++++
 14 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index ebe6c1d..fc6032e 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -39,6 +39,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 4250e74..32a6667 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -41,6 +41,8 @@
 					vfront-porch = <9>;
 					vsync-len = <3>;
 					vsync-active = <1>;
+					de-active = <1>;
+					pixelclk-active = <0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 0217dde3..4092a81 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -93,7 +93,7 @@
 					hsync-active = <0>;
 					vsync-active = <0>;
 					de-active = <1>;
-					pixelclk-active = <1>;
+					pixelclk-active = <0>;
 				};
 
 				ET0500 {
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index c8e5ae0..43f48f2 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -494,6 +494,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 2795dfc..59ecfd1 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -516,6 +516,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 99be301..e9419a2 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -349,6 +349,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 009abd6..230bbc6 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -405,6 +405,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 3bec128..ed4c72f 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -349,6 +349,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 04487cb..c89d64b 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -450,6 +450,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/drivers/staging/imx-drm/imx-drm.h b/drivers/staging/imx-drm/imx-drm.h
index 035ab62..a479738 100644
--- a/drivers/staging/imx-drm/imx-drm.h
+++ b/drivers/staging/imx-drm/imx-drm.h
@@ -1,6 +1,11 @@
 #ifndef _IMX_DRM_H_
 #define _IMX_DRM_H_
 
+#define IMXDRM_MODE_FLAG_DE_HIGH		(1 << 0)
+#define IMXDRM_MODE_FLAG_DE_LOW			(1 << 1)
+#define IMXDRM_MODE_FLAG_PIXDATA_POSEDGE	(1 << 2)
+#define IMXDRM_MODE_FLAG_PIXDATA_NEGEDGE	(1 << 3)
+
 struct device_node;
 struct drm_crtc;
 struct drm_connector;
diff --git a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
index c4d14ea..fc863e4 100644
--- a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
+++ b/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
@@ -27,6 +27,9 @@ enum ipuv3_type {
 
 #define IPU_PIX_FMT_GBR24	v4l2_fourcc('G', 'B', 'R', '3')
 
+#define SET_CLK_POL	(1 << 0)
+#define SET_DE_POL	(1 << 1)
+
 /*
  * Bitfield of Display Interface signal polarities.
  */
@@ -41,6 +44,7 @@ struct ipu_di_signal_cfg {
 	unsigned enable_pol:1;
 	unsigned Hsync_pol:1;	/* true = active high */
 	unsigned Vsync_pol:1;
+	unsigned set_mask:2;
 
 	u16 width;
 	u16 height;
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
index 849b3e1..5d273c1 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
@@ -595,8 +595,12 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 		}
 	}
 
-	if (sig->clk_pol)
-		di_gen |= DI_GEN_POLARITY_DISP_CLK;
+	if (sig->set_mask & SET_CLK_POL) {
+		if (sig->clk_pol)
+			di_gen |= DI_GEN_POLARITY_DISP_CLK;
+		else
+			di_gen &= ~DI_GEN_POLARITY_DISP_CLK;
+	}
 
 	ipu_di_write(di, di_gen, DI_GENERAL);
 
@@ -606,8 +610,13 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 	reg = ipu_di_read(di, DI_POL);
 	reg &= ~(DI_POL_DRDY_DATA_POLARITY | DI_POL_DRDY_POLARITY_15);
 
-	if (sig->enable_pol)
-		reg |= DI_POL_DRDY_POLARITY_15;
+	if (sig->set_mask & SET_DE_POL) {
+		if (sig->enable_pol)
+			reg |= DI_POL_DRDY_POLARITY_15;
+		else
+			reg &= ~DI_POL_DRDY_POLARITY_15;
+	}
+
 	if (sig->data_pol)
 		reg |= DI_POL_DRDY_DATA_POLARITY;
 
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index f506075..71f757f 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -157,8 +157,22 @@ static int ipu_crtc_mode_set(struct drm_crtc *crtc,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		sig_cfg.Vsync_pol = 1;
 
-	sig_cfg.enable_pol = 1;
-	sig_cfg.clk_pol = 0;
+	if (mode->private_flags & IMXDRM_MODE_FLAG_DE_HIGH) {
+		sig_cfg.enable_pol = 1;
+		sig_cfg.set_mask |= SET_DE_POL;
+	} else if (mode->private_flags & IMXDRM_MODE_FLAG_DE_LOW) {
+		sig_cfg.enable_pol = 0;
+		sig_cfg.set_mask |= SET_DE_POL;
+	}
+
+	if (mode->private_flags & IMXDRM_MODE_FLAG_PIXDATA_POSEDGE) {
+		sig_cfg.clk_pol = 1;
+		sig_cfg.set_mask |= SET_CLK_POL;
+	} else if (mode->private_flags & IMXDRM_MODE_FLAG_PIXDATA_NEGEDGE) {
+		sig_cfg.clk_pol = 0;
+		sig_cfg.set_mask |= SET_CLK_POL;
+	}
+
 	sig_cfg.width = mode->hdisplay;
 	sig_cfg.height = mode->vdisplay;
 	sig_cfg.pixel_fmt = out_pixel_fmt;
diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 01b7ce5..084500b 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -80,9 +80,43 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 
 	if (np) {
 		struct drm_display_mode *mode = drm_mode_create(connector->dev);
+		struct device_node *timings_np;
+		struct device_node *mode_np;
+		u32 val;
+
 		if (!mode)
 			return -EINVAL;
 		of_get_drm_display_mode(np, &imxpd->mode, OF_USE_NATIVE_MODE);
+
+		timings_np = of_get_child_by_name(np, "display-timings");
+		if (timings_np) {
+			/* get the display mode node */
+			mode_np = of_parse_phandle(timings_np,
+						   "native-mode", 0);
+			if (!mode_np)
+				mode_np = of_get_next_child(timings_np, NULL);
+
+			if (!of_property_read_u32(mode_np, "de-active", &val)) {
+				if (val) {
+					imxpd->mode.private_flags |=
+						IMXDRM_MODE_FLAG_DE_HIGH;
+				} else {
+					imxpd->mode.private_flags |=
+						IMXDRM_MODE_FLAG_DE_LOW;
+				}
+			}
+
+			if (!of_property_read_u32(mode_np, "pixelclk-active",
+						  &val)) {
+				if (val) {
+					imxpd->mode.private_flags |=
+						IMXDRM_MODE_FLAG_PIXDATA_POSEDGE;
+				} else {
+					imxpd->mode.private_flags |=
+						IMXDRM_MODE_FLAG_PIXDATA_NEGEDGE;
+				}
+			}
+		}
 		drm_mode_copy(mode, &imxpd->mode);
 		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
 		drm_mode_probed_add(connector, mode);
-- 
1.7.9.5
