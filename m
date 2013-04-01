From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue,  2 Apr 2013 00:22:45 +0100
Subject: [PATCH 6/6] rtc: rtc-m48t86: add devicetree bindings
In-Reply-To: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
References: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364858565-17192-7-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree bindings (and documentation) for rtc-m48t86.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 Documentation/devicetree/bindings/rtc/rtc-m48t86.txt |   17 +++++++++++++++++
 drivers/rtc/rtc-m48t86.c                             |   12 ++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-m48t86.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-m48t86.txt b/Documentation/devicetree/bindings/rtc/rtc-m48t86.txt
new file mode 100644
index 0000000..375ea56
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-m48t86.txt
@@ -0,0 +1,17 @@
+RTC support for the rtc-m48t86 driver
+
+Required properties:
+- compatible : "rtc-m48t86"
+- reg : Array of base physical addresses for the RTC control and data
+- reg-names : must have "rtc_index" and "rtc_data"
+
+Example:
+
+rtc at 808 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "rtc-m48t86";
+	reg =	<0x808 0x04>,
+		<0x80c 0x04>;
+	reg-names = "rtc_index", "rtc_data";
+};
diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index b8edf73..9395126 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -20,6 +20,7 @@
 #include <linux/bcd.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #define M48T86_REG_SEC		0x00
 #define M48T86_REG_SECALRM	0x01
@@ -335,10 +336,17 @@ static int m48t86_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id m48t86_rtc_match[] = {
+	{ .compatible = "rtc-m48t86" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, m48t86_rtc_match);
+
 static struct platform_driver m48t86_rtc_platform_driver = {
 	.driver		= {
-		.name	= "rtc-m48t86",
-		.owner	= THIS_MODULE,
+		.name		= "rtc-m48t86",
+		.owner		= THIS_MODULE,
+		.of_match_table	= m48t86_rtc_match,
 	},
 	.probe		= m48t86_rtc_probe,
 	.remove		= m48t86_rtc_remove,
-- 
1.7.10.4
