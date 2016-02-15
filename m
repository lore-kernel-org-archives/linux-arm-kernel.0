From: qnguyen@apm.com (Quan Nguyen)
Date: Mon, 15 Feb 2016 11:57:42 +0700
Subject: [PATCH v6 2/3] Documentation: gpio: Update description for X-Gene
 standby GPIO controller DTS binding
In-Reply-To: <1455512263-18183-1-git-send-email-qnguyen@apm.com>
References: <1455512263-18183-1-git-send-email-qnguyen@apm.com>
Message-ID: <1455512263-18183-3-git-send-email-qnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update description for X-Gene standby GPIO controller DTS binding to
support GPIO line configuration as input, output or external IRQ pin.

Signed-off-by: Y Vo <yvo@apm.com>
Signed-off-by: Quan Nguyen <qnguyen@apm.com>
---
 .../devicetree/bindings/gpio/gpio-xgene-sb.txt     | 47 ++++++++++++++++++----
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
index dae1300..7b8b4cb 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-xgene-sb.txt
@@ -1,10 +1,20 @@
 APM X-Gene Standby GPIO controller bindings
 
-This is a gpio controller in the standby domain.
-
-There are 20 GPIO pins from 0..21. There is no GPIO_DS14 or GPIO_DS15,
-only GPIO_DS8..GPIO_DS13 support interrupts. The IRQ mapping
-is currently 1-to-1 on interrupts 0x28 thru 0x2d.
+This is a gpio controller in the standby domain. It also supports interrupt in
+some particular pins which are sourced to its parent interrupt controller
+as diagram below:
+                           +-----------------+
+                           | X-Gene standby  |
+                           | GPIO controller +--------- GPIO_0
++------------+             |                 | ...
+| Parent IRQ |             |                 +--------- GPIO_8/EXT_INT_0
+| controller |  EXT_INT_0  |                 | ...
+| (GICv2)    +-------------+                 +--------- GPIO_[N+8]/EXT_INT_N
+|            |  ...        |                 |
+|            |  EXT_INT_N  |                 +--------- GPIO_[N+9]
+|            +-------------+                 | ...
+|            |             |                 +--------- GPIO_MAX
++------------+             +-----------------+
 
 Required properties:
 - compatible: "apm,xgene-gpio-sb" for the X-Gene Standby GPIO controller
@@ -15,10 +25,18 @@ Required properties:
 		0 = active high
 		1 = active low
 - gpio-controller: Marks the device node as a GPIO controller.
-- interrupts: Shall contain exactly 6 interrupts.
+- interrupts: The EXT_INT_0 parent interrupt resource must be listed first.
+- interrupt-parent: Phandle of the parent interrupt controller.
+- interrupt-cells: Should be two.
+       - first cell is 0-N coresponding for EXT_INT_0 to EXT_INT_N.
+       - second cell is used to specify flags.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- apm,nr-gpios: Optional, specify number of gpios pin.
+- apm,nr-irqs: Optional, specify number of interrupt pins.
+- apm,irq-start: Optional, specify lowest gpio pin support interrupt.
 
 Example:
-	sbgpio: sbgpio at 17001000 {
+	sbgpio: gpio at 17001000{
 		compatible = "apm,xgene-gpio-sb";
 		reg = <0x0 0x17001000 0x0 0x400>;
 		#gpio-cells = <2>;
@@ -29,4 +47,19 @@ Example:
 				<0x0 0x2b 0x1>,
 				<0x0 0x2c 0x1>,
 				<0x0 0x2d 0x1>;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		apm,nr-gpios = <22>;
+		apm,nr-irqs = <6>;
+		apm,irq-start = <8>;
+	};
+
+	testuser {
+		compatible = "example,testuser";
+		/* Use the GPIO_13/EXT_INT_5 line as an active high triggered
+		 * level interrupt
+		 */
+		interrupts = <5 4>;
+		interrupt-parent = <&sbgpio>;
 	};
-- 
1.7.12.4
