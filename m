From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue,  2 Apr 2013 00:22:42 +0100
Subject: [PATCH 3/6] rtc: rtc-m48t86: add detect method for RTC
In-Reply-To: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
References: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364858565-17192-4-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The m48t86 has 114 bytes of user space available, so we can use this
space to detect for the presence of the RTC.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 drivers/rtc/rtc-m48t86.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 6f99e64..b8edf73 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -173,6 +173,41 @@ static const struct rtc_class_ops m48t86_rtc_ops = {
 	.proc		= m48t86_rtc_proc,
 };
 
+/*
+ * The RTC chip has 114 bytes upper bytes that can be used as user storage
+ * space which we can use to test if the chip is present; for example it is
+ * an optional feature and not all boards will have it present.
+ *
+ * I've used the method Technologic Systems use in their rtc7800.c example
+ * for the detection.
+ *
+ * TODO: track down a guinea pig without an RTC to see if we can work out a
+ *	better RTC detection routine
+ */
+static int m48t86_rtc_detect(struct device *dev)
+{
+	unsigned char tmp_rtc0, tmp_rtc1;
+
+	tmp_rtc0 = m48t86_rtc_readbyte(dev, 126);
+	tmp_rtc1 = m48t86_rtc_readbyte(dev, 127);
+
+	m48t86_rtc_writebyte(dev, 0x00, 126);
+	m48t86_rtc_writebyte(dev, 0x55, 127);
+	if (m48t86_rtc_readbyte(dev, 127) == 0x55) {
+		m48t86_rtc_writebyte(dev, 0xaa, 127);
+		if (m48t86_rtc_readbyte(dev, 127) == 0xaa
+				&& m48t86_rtc_readbyte(dev, 126) == 0x00) {
+			m48t86_rtc_writebyte(dev, tmp_rtc0, 126);
+			m48t86_rtc_writebyte(dev, tmp_rtc1, 127);
+
+			return 0;
+		}
+	}
+
+	dev_info(dev, "RTC not found\n");
+	return -ENODEV;
+}
+
 static int m48t86_rtc_probe(struct platform_device *pdev)
 {
 	unsigned char reg;
@@ -232,6 +267,14 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 	} else
 		priv->ops = pdev->dev.platform_data;
 
+	err = m48t86_rtc_detect(&pdev->dev);
+	if (err) {
+		if (!pdev->dev.platform_data)
+			goto out_io_data;
+		else
+			goto out_free;
+	}
+
 	priv->rtc = rtc_device_register("m48t86",
 				&pdev->dev, &m48t86_rtc_ops, THIS_MODULE);
 	if (IS_ERR(priv->rtc)) {
-- 
1.7.10.4
