From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu,  1 Mar 2012 14:10:28 +0800
Subject: [PATCH 8/8] Document: devicetree: add OF documents for arch-mmp
In-Reply-To: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330582228-12424-9-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OF support in Document/devicetree directory.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 Documentation/devicetree/bindings/arm/mrvl.txt     |    6 +++
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |   27 ++++++++++++++
 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   37 ++++++++++++++++++++
 .../devicetree/bindings/rtc/sa1100-rtc.txt         |   15 ++++++++
 4 files changed, 85 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/sa1100-rtc.txt

diff --git a/Documentation/devicetree/bindings/arm/mrvl.txt b/Documentation/devicetree/bindings/arm/mrvl.txt
new file mode 100644
index 0000000..d8de933
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mrvl.txt
@@ -0,0 +1,6 @@
+Marvell Platforms Device Tree Bindings
+----------------------------------------------------
+
+PXA168 Aspenite Board
+Required root node properties:
+	- compatible = "mrvl,pxa168-aspenite", "mrvl,pxa168";
diff --git a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
new file mode 100644
index 0000000..c2c7995
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
@@ -0,0 +1,27 @@
+* Marvell PXA GPIO controller
+
+Required properties:
+- compatible : Should be "mrvl,pxa-gpio" or "mrvl,mmp-gpio"
+- reg : Address and length of the register set for the device
+- interrupts : Should be the port interrupt shared by all gpio pins, if
+  one number.
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells : Should be one.  It is the pin number.
+
+Recommended properties:
+- mrvl,gpio-irq0: Should be interrupt number of gpio0 in pxa2xx/pxa3xx/pxa95x.
+- mrvl,gpio-irq1: should be interrupt number of gpio1 in pxa2xx/pxa3xx/pxa95x.
+
+Example:
+
+	gpio: gpio at d4019000 {
+		compatible = "mrvl,mmp-gpio", "mrvl,pxa-gpio";
+		reg = <0xd4019000 0x1000>;
+		interrupts = <49>;
+		gpio-controller;
+		#gpio-cells = <1>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		mrvl,gpio-irq0 = <17>;
+		mrvl,gpio-irq1 = <18>;
+	};
diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
new file mode 100644
index 0000000..699c7ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
@@ -0,0 +1,37 @@
+* I2C
+
+Required properties :
+
+ - reg : Offset and length of the register set for the device
+ - compatible : should be "mrvl,mmp-twsi" where CHIP is the name of a
+   compatible processor, e.g. pxa168, pxa910, mmp2, mmp3.
+   For the pxa2xx/pxa3xx, an additional node "mrvl,pxa-i2c" is required
+   as shown in the example below.
+
+Recommended properties :
+
+ - interrupts : <a b> where a is the interrupt number and b is a
+   field that represents an encoding of the sense and level
+   information for the interrupt.  This should be encoded based on
+   the information in section 2) depending on the type of interrupt
+   controller you have.
+ - interrupt-parent : the phandle for the interrupt controller that
+   services interrupts for this device.
+ - mrvl,i2c-polling : Disable interrupt of i2c controller. Polling
+   status register of i2c controller instead.
+ - mrvl,i2c-mode : "fast" means fast mode of i2c controller.
+
+Examples:
+	twsi1: i2c at d4011000 {
+		compatible = "mrvl,mmp-twsi", "mrvl,pxa-i2c";
+		reg = <0xd4011000 0x1000>;
+		interrupts = <7>;
+		mrvl,i2c-mode = "fast";
+	};
+	
+	twsi2: i2c at d4025000 {
+		compatible = "mrvl,mmp-twsi", "mrvl,pxa-i2c";
+		reg = <0xd4025000 0x1000>;
+		interrupts = <58>;
+	};
+
diff --git a/Documentation/devicetree/bindings/rtc/sa1100-rtc.txt b/Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
new file mode 100644
index 0000000..f3a0118
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
@@ -0,0 +1,15 @@
+* Marvell Real Time Clock controller
+
+Required properties:
+- compatible: should be "mrvl,sa1100-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: Should be two. The first interrupt number is the rtc alarm
+  interrupt and the second interrupt number is the rtc hz interrupt.
+
+Example:
+	rtc: rtc at d4010000 {
+		compatible = "mrvl,mmp-rtc";
+		reg = <0xd4010000 0x1000>;
+		interrupts = <6 5>;
+	};
-- 
1.7.0.4
