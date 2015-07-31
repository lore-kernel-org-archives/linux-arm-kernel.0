From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 31 Jul 2015 15:36:32 +0200
Subject: [PATCH 3/3] drm: atmel-hlcdc: add support for sama5d4 SoCs
In-Reply-To: <1438349792-6398-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1438349792-6398-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1438349792-6398-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe capabilities of the HLCDC IP found on sama5d4 SoCs and add a
new entry to the atmel_hlcdc_of_match table.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 86 ++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 266a893..af1bbff 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -241,6 +241,88 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sama5d3 = {
 	.layers = atmel_hlcdc_sama5d3_layers,
 };
 
+static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d4_layers[] = {
+	{
+		.name = "base",
+		.formats = &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset = 0x40,
+		.id = 0,
+		.type = ATMEL_HLCDC_BASE_LAYER,
+		.nconfigs = 7,
+		.layout = {
+			.xstride = { 2 },
+			.default_color = 3,
+			.general_config = 4,
+			.disc_pos = 5,
+			.disc_size = 6,
+		},
+	},
+	{
+		.name = "overlay1",
+		.formats = &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset = 0x140,
+		.id = 1,
+		.type = ATMEL_HLCDC_OVERLAY_LAYER,
+		.nconfigs = 10,
+		.layout = {
+			.pos = 2,
+			.size = 3,
+			.xstride = { 4 },
+			.pstride = { 5 },
+			.default_color = 6,
+			.chroma_key = 7,
+			.chroma_key_mask = 8,
+			.general_config = 9,
+		},
+	},
+	{
+		.name = "overlay2",
+		.formats = &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset = 0x240,
+		.id = 2,
+		.type = ATMEL_HLCDC_OVERLAY_LAYER,
+		.nconfigs = 10,
+		.layout = {
+			.pos = 2,
+			.size = 3,
+			.xstride = { 4 },
+			.pstride = { 5 },
+			.default_color = 6,
+			.chroma_key = 7,
+			.chroma_key_mask = 8,
+			.general_config = 9,
+		},
+	},
+	{
+		.name = "high-end-overlay",
+		.formats = &atmel_hlcdc_plane_rgb_and_yuv_formats,
+		.regs_offset = 0x340,
+		.id = 3,
+		.type = ATMEL_HLCDC_OVERLAY_LAYER,
+		.nconfigs = 42,
+		.layout = {
+			.pos = 2,
+			.size = 3,
+			.memsize = 4,
+			.xstride = { 5, 7 },
+			.pstride = { 6, 8 },
+			.default_color = 9,
+			.chroma_key = 10,
+			.chroma_key_mask = 11,
+			.general_config = 12,
+			.csc = 14,
+		},
+	},
+};
+
+static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sama5d4 = {
+	.min_width = 0,
+	.min_height = 0,
+	.max_width = 2048,
+	.max_height = 2048,
+	.nlayers = ARRAY_SIZE(atmel_hlcdc_sama5d4_layers),
+	.layers = atmel_hlcdc_sama5d4_layers,
+};
 static const struct of_device_id atmel_hlcdc_of_match[] = {
 	{
 		.compatible = "atmel,at91sam9n12-hlcdc",
@@ -254,6 +336,10 @@ static const struct of_device_id atmel_hlcdc_of_match[] = {
 		.compatible = "atmel,sama5d3-hlcdc",
 		.data = &atmel_hlcdc_dc_sama5d3,
 	},
+	{
+		.compatible = "atmel,sama5d4-hlcdc",
+		.data = &atmel_hlcdc_dc_sama5d4,
+	},
 	{ /* sentinel */ },
 };
 
-- 
1.9.1
