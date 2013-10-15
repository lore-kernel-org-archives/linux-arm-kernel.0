From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Oct 2013 14:10:39 +0100
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131003202751.GZ6192@mwanda>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
Message-ID: <20131015131038.GB25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another point on patch 1.  Sorry, I don't have patch 1 to reply to, it
seems it was deleted from linux-arm-kernel's moderation queue.

drm_mode_connector_attach_encoder() is called too early, before the
base.id field in the encoder has been initialised.  This causes the
connectors encoder array to be empty, and userspace KMS to fail.

There's also bugs in the CSC setting too - it runs off the end of the
array and gcc warns about this.  The code was clearly wrong.

You may wish to combine this patch with patch 1 to sort all that out.
For the patch below:

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index e227eb1..ca0450b 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -507,7 +507,7 @@ static void imx_hdmi_update_csc_coeffs(struct imx_hdmi *hdmi)
 	hdmi_writeb(hdmi, ((*csc_coeff)[0][2] & 0xff), HDMI_CSC_COEF_A3_LSB);
 	hdmi_writeb(hdmi, ((*csc_coeff)[0][2] >> 8), HDMI_CSC_COEF_A3_MSB);
 	hdmi_writeb(hdmi, ((*csc_coeff)[0][3] & 0xff), HDMI_CSC_COEF_A4_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[0][4] >> 8), HDMI_CSC_COEF_A4_MSB);
+	hdmi_writeb(hdmi, ((*csc_coeff)[0][3] >> 8), HDMI_CSC_COEF_A4_MSB);
 
 	hdmi_writeb(hdmi, ((*csc_coeff)[1][0] & 0xff), HDMI_CSC_COEF_B1_LSB);
 	hdmi_writeb(hdmi, ((*csc_coeff)[1][0] >> 8), HDMI_CSC_COEF_B1_MSB);
@@ -516,7 +516,7 @@ static void imx_hdmi_update_csc_coeffs(struct imx_hdmi *hdmi)
 	hdmi_writeb(hdmi, ((*csc_coeff)[1][2] & 0xff), HDMI_CSC_COEF_B3_LSB);
 	hdmi_writeb(hdmi, ((*csc_coeff)[1][2] >> 8), HDMI_CSC_COEF_B3_MSB);
 	hdmi_writeb(hdmi, ((*csc_coeff)[1][3] & 0xff), HDMI_CSC_COEF_B4_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[1][4] >> 8), HDMI_CSC_COEF_B4_MSB);
+	hdmi_writeb(hdmi, ((*csc_coeff)[1][3] >> 8), HDMI_CSC_COEF_B4_MSB);
 
 	hdmi_writeb(hdmi, ((*csc_coeff)[2][0] & 0xff), HDMI_CSC_COEF_C1_LSB);
 	hdmi_writeb(hdmi, ((*csc_coeff)[2][0] >> 8), HDMI_CSC_COEF_C1_MSB);
@@ -525,7 +525,7 @@ static void imx_hdmi_update_csc_coeffs(struct imx_hdmi *hdmi)
 	hdmi_writeb(hdmi, ((*csc_coeff)[2][2] & 0xff), HDMI_CSC_COEF_C3_LSB);
 	hdmi_writeb(hdmi, ((*csc_coeff)[2][2] >> 8), HDMI_CSC_COEF_C3_MSB);
 	hdmi_writeb(hdmi, ((*csc_coeff)[2][3] & 0xff), HDMI_CSC_COEF_C4_LSB);
-	hdmi_writeb(hdmi, ((*csc_coeff)[2][4] >> 8), HDMI_CSC_COEF_C4_MSB);
+	hdmi_writeb(hdmi, ((*csc_coeff)[2][3] >> 8), HDMI_CSC_COEF_C4_MSB);
 
 	val = hdmi_readb(hdmi, HDMI_CSC_SCALE);
 	val &= ~HDMI_CSC_SCALE_CSCSCALE_MASK;
@@ -1774,8 +1774,6 @@ static int imx_hdmi_register(struct imx_hdmi *hdmi)
 {
 	int ret;
 
-	drm_mode_connector_attach_encoder(&hdmi->connector, &hdmi->encoder);
-
 	hdmi->connector.funcs = &imx_hdmi_connector_funcs;
 	hdmi->encoder.funcs = &imx_hdmi_encoder_funcs;
 
@@ -1803,6 +1801,8 @@ static int imx_hdmi_register(struct imx_hdmi *hdmi)
 
 	hdmi->connector.encoder = &hdmi->encoder;
 
+	drm_mode_connector_attach_encoder(&hdmi->connector, &hdmi->encoder);
+
 	return 0;
 }
 
