From: jianwei.wang@freescale.com (Jianwei Wang)
Date: Mon, 13 Jul 2015 14:00:09 +0800
Subject: [PATCH v8 2/4] drm/panel: simple: Add support for NEC NL4827HC19-05B
 480x272 panel
In-Reply-To: <1436767211-38571-1-git-send-email-jianwei.wang@freescale.com>
References: <1436767211-38571-1-git-send-email-jianwei.wang@freescale.com>
Message-ID: <1436767211-38571-2-git-send-email-jianwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the NEC NL4827HC19-05B 480x272 panel to the DRM
simple panel driver.

Signed-off-by: Jianwei Wang <jianwei.wang@freescale.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 .../bindings/panel/nec,nl4827hc19_05b.txt          |  7 ++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 MAINTAINERS                                        |  1 +
 drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
 4 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt

diff --git a/Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt b/Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
new file mode 100644
index 0000000..20e9473
--- /dev/null
+++ b/Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
@@ -0,0 +1,7 @@
+NEC LCD Technologies,Ltd. WQVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "nec,nl4827hc19_05b"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8033919..9f22b3e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -131,6 +131,7 @@ mundoreader	Mundo Reader S.L.
 murata	Murata Manufacturing Co., Ltd.
 mxicy	Macronix International Co., Ltd.
 national	National Semiconductor
+nec	NEC LCD Technologies, Ltd.
 neonode		Neonode Inc.
 netgear	NETGEAR
 netlogic	Broadcom Corporation (formerly NetLogic Microsystems)
diff --git a/MAINTAINERS b/MAINTAINERS
index b25b948..e191ded 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3410,6 +3410,7 @@ M:	Alison Wang <alison.wang@freescale.com>
 L:	dri-devel at lists.freedesktop.org
 S:	Supported
 F:	drivers/gpu/drm/fsl-dcu/
+F:      Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
 
 DRM DRIVERS FOR NVIDIA TEGRA
 M:	Thierry Reding <thierry.reding@gmail.com>
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index f94201b..eb12fe4 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1036,6 +1036,29 @@ static const struct panel_desc shelly_sca07010_bfn_lnn = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct drm_display_mode nec_nl4827hc19_05b_mode = {
+	.clock = 10870,
+	.hdisplay = 480,
+	.hsync_start = 480 + 2,
+	.hsync_end = 480 + 2 + 41,
+	.htotal = 480 + 2 + 41 + 2,
+	.vdisplay = 272,
+	.vsync_start = 272 + 2,
+	.vsync_end = 272 + 2 + 4,
+	.vtotal = 272 + 2 + 4 + 2,
+	.vrefresh = 74,
+};
+
+static const struct panel_desc nec_nl4827hc19_05b = {
+	.modes = &nec_nl4827hc19_05b_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 95,
+		.height = 54,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24
+};
+
 static const struct of_device_id platform_of_match[] = {
 	{
 		.compatible = "ampire,am800480r3tmqwa1h",
@@ -1125,6 +1148,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "shelly,sca07010-bfn-lnn",
 		.data = &shelly_sca07010_bfn_lnn,
 	}, {
+		.compatible = "nec,nl4827hc19_05b",
+		.data = &nec_nl4827hc19_05b,
+	}, {
 		/* sentinel */
 	}
 };
-- 
2.1.0.27.g96db324
