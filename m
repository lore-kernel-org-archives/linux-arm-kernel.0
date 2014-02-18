From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 18 Feb 2014 20:09:46 +0000
Subject: [PATCH 02/34] imx-drm: imx-hdmi: clean up setting CSC registers
In-Reply-To: <20140218200900.GM21483@n2100.arm.linux.org.uk>
References: <20140218200900.GM21483@n2100.arm.linux.org.uk>
Message-ID: <E1WFqzC-0007hy-I6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than manually writing each register sequentially, we can use a
loop to reduce the amount of code.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c | 40 +++++++++++++-------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index cb316bf3ec56..18de310e50e0 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -480,6 +480,7 @@ static int is_color_space_interpolation(struct imx_hdmi *hdmi)
 static void imx_hdmi_update_csc_coeffs(struct imx_hdmi *hdmi)
 {
 	const u16 (*csc_coeff)[3][4] = &csc_coeff_default;
+	unsigned i;
 	u32 csc_scale = 1;
 	u8 val;
 
@@ -498,32 +499,19 @@ static void imx_hdmi_update_csc_coeffs(struct imx_hdmi *hdmi)
 		}
 	}
 
-	hdmi_writeb(hdmi, ((*csc_coeff)[0][0] & 0xff), HDMI_CSC_COEF_A1_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[0][0] >> 8), HDMI_CSC_COEF_A1_MSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[0][1] & 0xff), HDMI_CSC_COEF_A2_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[0][1] >> 8), HDMI_CSC_COEF_A2_MSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[0][2] & 0xff), HDMI_CSC_COEF_A3_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[0][2] >> 8), HDMI_CSC_COEF_A3_MSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[0][3] & 0xff), HDMI_CSC_COEF_A4_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[0][3] >> 8), HDMI_CSC_COEF_A4_MSB);
-
-	hdmi_writeb(hdmi, ((*csc_coeff)[1][0] & 0xff), HDMI_CSC_COEF_B1_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[1][0] >> 8), HDMI_CSC_COEF_B1_MSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[1][1] & 0xff), HDMI_CSC_COEF_B2_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[1][1] >> 8), HDMI_CSC_COEF_B2_MSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[1][2] & 0xff), HDMI_CSC_COEF_B3_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[1][2] >> 8), HDMI_CSC_COEF_B3_MSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[1][3] & 0xff), HDMI_CSC_COEF_B4_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[1][3] >> 8), HDMI_CSC_COEF_B4_MSB);
-
-	hdmi_writeb(hdmi, ((*csc_coeff)[2][0] & 0xff), HDMI_CSC_COEF_C1_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[2][0] >> 8), HDMI_CSC_COEF_C1_MSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[2][1] & 0xff), HDMI_CSC_COEF_C2_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[2][1] >> 8), HDMI_CSC_COEF_C2_MSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[2][2] & 0xff), HDMI_CSC_COEF_C3_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[2][2] >> 8), HDMI_CSC_COEF_C3_MSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[2][3] & 0xff), HDMI_CSC_COEF_C4_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[2][3] >> 8), HDMI_CSC_COEF_C4_MSB);
+	/* The CSC registers are sequential, alternating MSB then LSB */
+	for (i = 0; i < ARRAY_SIZE(csc_coeff_default[0]); i++) {
+		u16 coeff_a = (*csc_coeff)[0][i];
+		u16 coeff_b = (*csc_coeff)[1][i];
+		u16 coeff_c = (*csc_coeff)[2][i];
+
+		hdmi_writeb(hdmi, coeff_a & 0xff, HDMI_CSC_COEF_A1_LSB + i * 2);
+		hdmi_writeb(hdmi, coeff_a >> 8, HDMI_CSC_COEF_A1_MSB + i * 2);
+		hdmi_writeb(hdmi, coeff_b & 0xff, HDMI_CSC_COEF_B1_LSB + i * 2);
+		hdmi_writeb(hdmi, coeff_b >> 8, HDMI_CSC_COEF_B1_MSB + i * 2);
+		hdmi_writeb(hdmi, coeff_c & 0xff, HDMI_CSC_COEF_C1_LSB + i * 2);
+		hdmi_writeb(hdmi, coeff_c >> 8, HDMI_CSC_COEF_C1_MSB + i * 2);
+	}
 
 	val = hdmi_readb(hdmi, HDMI_CSC_SCALE);
 	val &= ~HDMI_CSC_SCALE_CSCSCALE_MASK;
-- 
1.8.3.1
