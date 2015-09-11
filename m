From: yvo@apm.com (Y Vo)
Date: Fri, 11 Sep 2015 16:22:12 +0700
Subject: [PATCH 2/2] Documentation: gpio: Update description for X-Gene
 standby GPIO controller DTS binding
In-Reply-To: <1441963332-13329-1-git-send-email-yvo@apm.com>
References: <1441963332-13329-1-git-send-email-yvo@apm.com>
Message-ID: <1441963332-13329-3-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Y Vo <yvo@apm.com>
---
 .../devicetree/bindings/gpio/gpio-xgene-sb.txt     |   26 ++++++++++++++-----
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
index dae1300..bee1347 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
@@ -3,8 +3,11 @@ APM X-Gene Standby GPIO controller bindings
 This is a gpio controller in the standby domain.
 
 There are 20 GPIO pins from 0..21. There is no GPIO_DS14 or GPIO_DS15,
-only GPIO_DS8..GPIO_DS13 support interrupts. The IRQ mapping
+only GPIO_DS8..GPIO_DS13 support external interrupts. The IRQ mapping
 is currently 1-to-1 on interrupts 0x28 thru 0x2d.
+GPIO pins from GPIO_DS8 to GPIO_DS13 are configured as external interrupt
+by default. If one wish not to use any of these pins as external interrupts,
+the corresponding interrupt resource for those pins should be removed.
 
 Required properties:
 - compatible: "apm,xgene-gpio-sb" for the X-Gene Standby GPIO controller
@@ -23,10 +26,19 @@ Example:
 		reg = <0x0 0x17001000 0x0 0x400>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		interrupts = 	<0x0 0x28 0x1>,
-				<0x0 0x29 0x1>,
-				<0x0 0x2a 0x1>,
-				<0x0 0x2b 0x1>,
-				<0x0 0x2c 0x1>,
-				<0x0 0x2d 0x1>;
+		interrupts = 	<0x0 0x28 0x1>,		/* GPIO_DS8 */
+				<0x0 0x29 0x1>,		/* GPIO_DS9 */
+				<0x0 0x2a 0x1>,		/* GPIO_DS10 */
+				<0x0 0x2b 0x1>,		/* GPIO_DS11 */
+				<0x0 0x2c 0x1>,		/* GPIO_DS12 */
+				<0x0 0x2d 0x1>;		/* GPIO_DS13 */
 	};
+
+/* Board-specific: exclude GPIO_DS8 to leave it as GPIO */
+&sbgpio {
+	interrupts =	<0x0 0x29 0x1>,		/* GPIO_DS9 */
+			<0x0 0x2a 0x1>,		/* GPIO_DS10 */
+			<0x0 0x2b 0x1>,		/* GPIO_DS11 */
+			<0x0 0x2c 0x1>,		/* GPIO_DS12 */
+			<0x0 0x2d 0x1>;		/* GPIO_DS13 */
+}
-- 
1.7.1
