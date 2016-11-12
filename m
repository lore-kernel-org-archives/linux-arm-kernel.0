From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 12 Nov 2016 14:46:41 +0800
Subject: [PATCH 03/10] mfd: sun6i-prcm: Add codec analog controls sub-device
 for Allwinner A23
In-Reply-To: <20161112064648.26779-1-wens@csie.org>
References: <20161112064648.26779-1-wens@csie.org>
Message-ID: <20161112064648.26779-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PRCM block on the A23 contains a message box like interface to
the registers for the analog path controls of the internal codec.

Add a sub-device for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/sun6i-prcm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
index 011fcc555945..4abbf2ede944 100644
--- a/drivers/mfd/sun6i-prcm.c
+++ b/drivers/mfd/sun6i-prcm.c
@@ -12,6 +12,9 @@
 #include <linux/init.h>
 #include <linux/of.h>
 
+#define SUN8I_CODEC_ANALOG_BASE	0x1c0
+#define SUN8I_CODEC_ANALOG_END	(SUN8I_CODEC_ANALOG_BASE + 0x4 - 1)
+
 struct prcm_data {
 	int nsubdevs;
 	const struct mfd_cell *subdevs;
@@ -57,6 +60,14 @@ static const struct resource sun6i_a31_apb0_rstc_res[] = {
 	},
 };
 
+static const struct resource sun8i_codec_analog_res[] = {
+	{
+		.start	= SUN8I_CODEC_ANALOG_BASE,
+		.end	= SUN8I_CODEC_ANALOG_END,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 static const struct mfd_cell sun6i_a31_prcm_subdevs[] = {
 	{
 		.name = "sun6i-a31-ar100-clk",
@@ -109,6 +120,12 @@ static const struct mfd_cell sun8i_a23_prcm_subdevs[] = {
 		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_rstc_res),
 		.resources = sun6i_a31_apb0_rstc_res,
 	},
+	{
+		.name		= "sun8i-codec-analog",
+		.of_compatible	= "allwinner,sun8i-a23-codec-analog",
+		.num_resources	= ARRAY_SIZE(sun8i_codec_analog_res),
+		.resources	= sun8i_codec_analog_res,
+	},
 };
 
 static const struct prcm_data sun6i_a31_prcm_data = {
-- 
2.10.2
