From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 20:34:35 +0800
Subject: [PATCH v2 1/8] mfd: sun6i-prcm: Add codec analog controls sub-device
 for Allwinner A23
In-Reply-To: <20161125123442.28410-1-wens@csie.org>
References: <20161125123442.28410-1-wens@csie.org>
Message-ID: <20161125123442.28410-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PRCM block on the A23 contains a message box like interface to
the registers for the analog path controls of the internal codec.

Add a sub-device for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/sun6i-prcm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
index 011fcc555945..2b658bed47db 100644
--- a/drivers/mfd/sun6i-prcm.c
+++ b/drivers/mfd/sun6i-prcm.c
@@ -12,6 +12,9 @@
 #include <linux/init.h>
 #include <linux/of.h>
 
+#define SUN8I_CODEC_ANALOG_BASE	0x1c0
+#define SUN8I_CODEC_ANALOG_SIZE	0x4
+
 struct prcm_data {
 	int nsubdevs;
 	const struct mfd_cell *subdevs;
@@ -57,6 +60,10 @@ static const struct resource sun6i_a31_apb0_rstc_res[] = {
 	},
 };
 
+static const struct resource sun8i_codec_analog_res[] = {
+	DEFINE_RES_MEM(SUN8I_CODEC_ANALOG_BASE, SUN8I_CODEC_ANALOG_SIZE),
+};
+
 static const struct mfd_cell sun6i_a31_prcm_subdevs[] = {
 	{
 		.name = "sun6i-a31-ar100-clk",
@@ -109,6 +116,12 @@ static const struct mfd_cell sun8i_a23_prcm_subdevs[] = {
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
