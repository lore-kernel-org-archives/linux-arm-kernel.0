From: peter.chen@nxp.com (Peter Chen)
Date: Fri, 17 Jun 2016 18:09:21 +0800
Subject: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc for
 generic usb power sequence driver
In-Reply-To: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding doc for generic usb power sequence driver, and update
generic usb device binding-doc accordingly.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 .../bindings/power/pwrseq/pwrseq-usb-generic.txt   | 31 ++++++++++++++++++++++
 .../devicetree/bindings/usb/usb-device.txt         |  2 ++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt

diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
new file mode 100644
index 0000000..8ad98382
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
@@ -0,0 +1,31 @@
+The power sequence for generic USB Devices
+
+Some hard-wired USB devices need to do power sequence to let the
+device work normally, the typical power sequence like: enable USB
+PHY clock, toggle reset pin, etc. But current Linux USB driver
+lacks of such code to do it, it may cause some hard-wired USB devices
+works abnormal or can't be recognized by controller at all. The
+power sequence will be done before this device can be found at USB
+bus.
+
+Required properties:
+- compatible : contains "usb-pwrseq-generic".
+
+Optional properties:
+- clocks: the input clock for USB device.
+- clock-frequency: the frequency for device's clock.
+- reset-gpios: Should specify the GPIO for reset.
+- reset-duration-us: the duration in microsecond for assert reset signal.
+- enable-gpios: Should specify the GPIO for enable.
+- power-supply: The regulator of the power
+
+Example:
+
+usb2415_pwrseq: usb2415_pwrseq {
+	compatible = "usb-pwrseq-generic";
+	clocks = <&clks IMX6QDL_CLK_CKO>;
+	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+	reset-duration-us = <3000>;
+	enable-gpios = <&gpio7 11 GPIO_ACTIVE_LOW>;
+	power-supply = <&reg_usb_power>;
+};
diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
index 1c35e7b..4c8a25e 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.txt
+++ b/Documentation/devicetree/bindings/usb/usb-device.txt
@@ -12,6 +12,7 @@ Required properties:
   for usbVID,PID.
 - reg: the port number which this device is connecting to, the range
   is 1-31.
+- usb-pwrseq: phandle for power sequence.
 
 Example:
 
@@ -24,5 +25,6 @@ Example:
 	hub: genesys at 1 {
 		compatible = "usb5e3,608";
 		reg = <1>;
+		usb-pwrseq = <&usb_genesys_pwrseq>;
 	};
 }
-- 
1.9.1
