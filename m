From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 31 Jul 2015 15:36:31 +0200
Subject: [PATCH 2/3] drm: atmel-hlcdc: add support for at91sam9n12 SoC
In-Reply-To: <1438349792-6398-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1438349792-6398-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1438349792-6398-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe capabilities of the HLCDC IP found on at91sam9n12 SoC and add a
new entry to the atmel_hlcdc_of_match table.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index d99d3fe..266a893 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -29,6 +29,31 @@
 
 #define ATMEL_HLCDC_LAYER_IRQS_OFFSET		8
 
+static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9n12_layers[] = {
+	{
+		.name = "base",
+		.formats = &atmel_hlcdc_plane_rgb_formats,
+		.regs_offset = 0x40,
+		.id = 0,
+		.type = ATMEL_HLCDC_BASE_LAYER,
+		.nconfigs = 5,
+		.layout = {
+			.xstride = { 2 },
+			.default_color = 3,
+			.general_config = 4,
+		},
+	},
+};
+
+static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_at91sam9n12 = {
+	.min_width = 0,
+	.min_height = 0,
+	.max_width = 1280,
+	.max_height = 860,
+	.nlayers = ARRAY_SIZE(atmel_hlcdc_at91sam9n12_layers),
+	.layers = atmel_hlcdc_at91sam9n12_layers,
+};
+
 static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9x5_layers[] = {
 	{
 		.name = "base",
@@ -218,6 +243,10 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sama5d3 = {
 
 static const struct of_device_id atmel_hlcdc_of_match[] = {
 	{
+		.compatible = "atmel,at91sam9n12-hlcdc",
+		.data = &atmel_hlcdc_dc_at91sam9n12,
+	},
+	{
 		.compatible = "atmel,at91sam9x5-hlcdc",
 		.data = &atmel_hlcdc_dc_at91sam9x5,
 	},
-- 
1.9.1
