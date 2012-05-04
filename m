From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri,  4 May 2012 20:30:26 +0800
Subject: [PATCH v2 9/9] Documentation: update docs for mmp dt
In-Reply-To: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1336134626-12262-10-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append interrupt controller and timer document for mmp. Updates
documents for gpio and i2c.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 Documentation/devicetree/bindings/arm/mrvl.txt     |    6 ---
 .../devicetree/bindings/arm/mrvl/intc.txt          |   40 ++++++++++++++++++++
 .../devicetree/bindings/arm/mrvl/mrvl.txt          |   14 +++++++
 .../devicetree/bindings/arm/mrvl/timer.txt         |   13 ++++++
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |   18 ++++++---
 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   15 +++----
 6 files changed, 85 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mrvl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/intc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/timer.txt

diff --git a/Documentation/devicetree/bindings/arm/mrvl.txt b/Documentation/devicetree/bindings/arm/mrvl.txt
deleted file mode 100644
index d8de933..0000000
--- a/Documentation/devicetree/bindings/arm/mrvl.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-Marvell Platforms Device Tree Bindings
-----------------------------------------------------
-
-PXA168 Aspenite Board
-Required root node properties:
-	- compatible = "mrvl,pxa168-aspenite", "mrvl,pxa168";
diff --git a/Documentation/devicetree/bindings/arm/mrvl/intc.txt b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
new file mode 100644
index 0000000..80b9a94
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
@@ -0,0 +1,40 @@
+* Marvell MMP Interrupt controller
+
+Required properties:
+- compatible : Should be "mrvl,mmp-intc", "mrvl,mmp2-intc" or
+  "mrvl,mmp2-mux-intc"
+- reg : Address and length of the register set of the interrupt controller.
+  If the interrupt controller is intc, address and length means the range
+  of the whold interrupt controller. If the interrupt controller is mux-intc,
+  address and length means one register. Since address of mux-intc is in the
+  range of intc. mux-intc is secondary interrupt controller.
+- reg-names : Name of the register set of the interrupt controller. It's
+  only required in mux-intc interrupt controller.
+- interrupts : Should be the port interrupt shared by mux interrupts. It's
+  only required in mux-intc interrupt controller.
+- interrupt-controller : Identifies the node as an interrupt controller.
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source.
+- mrvl,intc-nr-irqs : Specifies the number of interrupts in the interrupt
+  controller.
+- mrvl,clr-mfp-irq : Specifies the interrupt that needs to clear MFP edge
+  detection first.
+
+Example:
+	intc: interrupt-controller at d4282000 {
+		compatible = "mrvl,mmp2-intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xd4282000 0x1000>;
+		mrvl,intc-nr-irqs = <64>;
+	};
+
+	intcmux4 at d4282150 {
+		compatible = "mrvl,mmp2-mux-intc";
+		interrupts = <4>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x150 0x4>, <0x168 0x4>;
+		reg-names = "mux status", "mux mask";
+		mrvl,intc-nr-irqs = <2>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
new file mode 100644
index 0000000..117d741
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
@@ -0,0 +1,14 @@
+Marvell Platforms Device Tree Bindings
+----------------------------------------------------
+
+PXA168 Aspenite Board
+Required root node properties:
+	- compatible = "mrvl,pxa168-aspenite", "mrvl,pxa168";
+
+PXA910 DKB Board
+Required root node properties:
+	- compatible = "mrvl,pxa910-dkb";
+
+MMP2 Brownstone Board
+Required root node properties:
+	- compatible = "mrvl,mmp2-brownstone";
diff --git a/Documentation/devicetree/bindings/arm/mrvl/timer.txt b/Documentation/devicetree/bindings/arm/mrvl/timer.txt
new file mode 100644
index 0000000..9a6e251
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mrvl/timer.txt
@@ -0,0 +1,13 @@
+* Marvell MMP Timer controller
+
+Required properties:
+- compatible : Should be "mrvl,mmp-timer".
+- reg : Address and length of the register set of timer controller.
+- interrupts : Should be the interrupt number.
+
+Example:
+	timer0: timer at d4014000 {
+		compatible = "mrvl,mmp-timer";
+		reg = <0xd4014000 0x100>;
+		interrupts = <13>;
+	};
diff --git a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
index 1e34cfe..05428f3 100644
--- a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
@@ -3,19 +3,25 @@
 Required properties:
 - compatible : Should be "mrvl,pxa-gpio" or "mrvl,mmp-gpio"
 - reg : Address and length of the register set for the device
-- interrupts : Should be the port interrupt shared by all gpio pins, if
-- interrupt-name : Should be the name of irq resource.
-  one number.
+- interrupts : Should be the port interrupt shared by all gpio pins.
+  There're three gpio interrupts in arch-pxa, and they're gpio0,
+  gpio1 and gpio_mux. There're only one gpio interrupt in arch-mmp,
+  gpio_mux.
+- interrupt-name : Should be the name of irq resource. Each interrupt
+  binds its interrupt-name.
+- interrupt-controller : Identifies the node as an interrupt controller.
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source.
 - gpio-controller : Marks the device node as a gpio controller.
 - #gpio-cells : Should be one.  It is the pin number.
 
 Example:
 
 	gpio: gpio at d4019000 {
-		compatible = "mrvl,mmp-gpio", "mrvl,pxa-gpio";
+		compatible = "mrvl,mmp-gpio";
 		reg = <0xd4019000 0x1000>;
-		interrupts = <49>, <17>, <18>;
-		interrupt-name = "gpio_mux", "gpio0", "gpio1";
+		interrupts = <49>;
+		interrupt-name = "gpio_mux";
 		gpio-controller;
 		#gpio-cells = <1>;
 		interrupt-controller;
diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
index 071eb3c..b891ee2 100644
--- a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
@@ -3,34 +3,31 @@
 Required properties :
 
  - reg : Offset and length of the register set for the device
- - compatible : should be "mrvl,mmp-twsi" where CHIP is the name of a
+ - compatible : should be "mrvl,mmp-twsi" where mmp is the name of a
    compatible processor, e.g. pxa168, pxa910, mmp2, mmp3.
    For the pxa2xx/pxa3xx, an additional node "mrvl,pxa-i2c" is required
    as shown in the example below.
 
 Recommended properties :
 
- - interrupts : <a b> where a is the interrupt number and b is a
-   field that represents an encoding of the sense and level
-   information for the interrupt.  This should be encoded based on
-   the information in section 2) depending on the type of interrupt
-   controller you have.
+ - interrupts : the interrupt number
  - interrupt-parent : the phandle for the interrupt controller that
-   services interrupts for this device.
+   services interrupts for this device. If the parent is the default
+   interrupt controller in device tree, it could be ignored.
  - mrvl,i2c-polling : Disable interrupt of i2c controller. Polling
    status register of i2c controller instead.
  - mrvl,i2c-fast-mode : Enable fast mode of i2c controller.
 
 Examples:
 	twsi1: i2c at d4011000 {
-		compatible = "mrvl,mmp-twsi", "mrvl,pxa-i2c";
+		compatible = "mrvl,mmp-twsi";
 		reg = <0xd4011000 0x1000>;
 		interrupts = <7>;
 		mrvl,i2c-fast-mode;
 	};
 	
 	twsi2: i2c at d4025000 {
-		compatible = "mrvl,mmp-twsi", "mrvl,pxa-i2c";
+		compatible = "mrvl,mmp-twsi";
 		reg = <0xd4025000 0x1000>;
 		interrupts = <58>;
 	};
-- 
1.7.5.4
