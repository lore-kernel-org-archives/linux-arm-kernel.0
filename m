From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 31 Oct 2013 13:23:53 -0700
Subject: [PATCH v4] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <1383181127-12013-1-git-send-email-festevam@gmail.com>
References: <1383181127-12013-1-git-send-email-festevam@gmail.com>
Message-ID: <5272BC59.1080109@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


+/* Workaround to clear the overflow condition */
+static void imx_hdmi_clear_overflow(struct imx_hdmi *hdmi)
+{
+	int count;
+	u8 val;
+
+	/* TMDS software reset */
+	hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ, HDMI_MC_SWRSTZ);
+
+	val = hdmi_readb(hdmi, HDMI_FC_INVIDCONF);
+	if (hdmi->dev_type == IMX6DL_HDMI) {
+		hdmi_writeb(hdmi, val, HDMI_FC_INVIDCONF);
+		return;
+	}
+
+	for (count = 0; count < 5; count++)
+		hdmi_writeb(hdmi, val, HDMI_FC_INVIDCONF);
+}
+

Hi Fabio,

I get a magenta line down the left side of the screen unless I replace 
the 5 with a 6.
ie.

+	for (count = 0; count < 6; count++)
+		hdmi_writeb(hdmi, val, HDMI_FC_INVIDCONF);


This is with a imx6q processor. With the 6, the picture looks great!

Troy
