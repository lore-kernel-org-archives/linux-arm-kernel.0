From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  4 Oct 2016 11:46:18 +0200
Subject: [PATCH 05/14] mfd: sun6i-prcm: Add sun8i analog codec as subnode
In-Reply-To: <cover.1475569400.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
Message-ID: <c74aea452bd1831f439dd67884cb2879e0849f03.1475571575.git.mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun8i audio codec is using PRCM registers to configure all the
analog part of the audio codec. It is added as a subnode of the PRCM
with his resource (offset of 0x1c0).

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/mfd/sun6i-prcm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
index 011fcc5..e0c6bf5 100644
--- a/drivers/mfd/sun6i-prcm.c
+++ b/drivers/mfd/sun6i-prcm.c
@@ -12,6 +12,8 @@
 #include <linux/init.h>
 #include <linux/of.h>
 
+#define SUN6I_AUDIO_CODEC_ANALOG	0x1c0
+
 struct prcm_data {
 	int nsubdevs;
 	const struct mfd_cell *subdevs;
@@ -57,6 +59,14 @@ static const struct resource sun6i_a31_apb0_rstc_res[] = {
 	},
 };
 
+static const struct resource sun8i_adda_res[] = {
+	{
+		.start = SUN6I_AUDIO_CODEC_ANALOG,
+		.end = 0x1c3,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
 static const struct mfd_cell sun6i_a31_prcm_subdevs[] = {
 	{
 		.name = "sun6i-a31-ar100-clk",
@@ -109,6 +119,12 @@ static const struct mfd_cell sun8i_a23_prcm_subdevs[] = {
 		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_rstc_res),
 		.resources = sun6i_a31_apb0_rstc_res,
 	},
+	{
+		.name = "sun8i-codec-analog",
+		.of_compatible = "allwinner,sun8i-codec-analog",
+		.num_resources = ARRAY_SIZE(sun8i_adda_res),
+		.resources = sun8i_adda_res,
+	},
 };
 
 static const struct prcm_data sun6i_a31_prcm_data = {
-- 
2.9.3
