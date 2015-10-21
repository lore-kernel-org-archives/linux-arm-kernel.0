From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:09:58 +0100
Subject: [PATCH 01/19] Documentation: devicetree: standardize/consolidate on
 "wakeup-source" property
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1445422216-29375-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently different drivers use multiple forms of annotating devices
that should be set up as wakeup sources for the system.

This patch adds a separate binding document inorder to standardize and
consolidate to use "wakeup-source" boolean property to mark the devices
as wakeup capable.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../devicetree/bindings/power/wakeup-source.txt    | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/wakeup-source.txt

diff --git a/Documentation/devicetree/bindings/power/wakeup-source.txt b/Documentation/devicetree/bindings/power/wakeup-source.txt
new file mode 100644
index 000000000000..963c6dfd484d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/wakeup-source.txt
@@ -0,0 +1,71 @@
+Specifying wakeup capability for devices
+============================================
+
+Any device nodes
+----------------
+Nodes that describe devices which has wakeup capability must contain an
+"wakeup-source" boolean property.
+
+Also, if device is marked as a wakeup source, then all the primary
+interrupt(s) can be used as wakeup interrupt(s).
+
+However if the devices have dedicated interrupt as the wakeup source
+then they need to specify/identify the same using device specific
+interrupt name. In such cases only that interrupt can be used as wakeup
+interrupt.
+
+List of legacy properties and respective binding document
+---------------------------------------------------------
+
+1. "enable-sdio-wakeup"		Documentation/devicetree/bindings/mmc/mmc.txt
+2. "gpio-key,wakeup"		Documentation/devicetree/bindings/input/gpio-keys{,-polled}.txt
+3. "has-tpo"			Documentation/devicetree/bindings/rtc/rtc-opal.txt
+4. "isil,irq2-can-wakeup-machine" Documentation/devicetree/bindings/rtc/isil,isl12057.txt
+5. "linux,wakeup"		Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
+				Documentation/devicetree/bindings/mfd/tc3589x.txt
+				Documentation/devicetree/bindings/input/ads7846.txt
+6. "linux,keypad-wakeup"	Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
+7. "linux,input-wakeup"		Documentation/devicetree/bindings/input/samsung-keypad.txt
+8. "nvidia,wakeup-source"	Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
+
+Examples
+--------
+
+1. With "wakeup" interrupt name
+
+	device at 10000 {
+		compatible	= "vendor,device-id";
+		reg		= <0x10000 0x1000>;
+		interrupts	= <0 19 4>, <0 21 4>, <0 22 4>;
+		interrupt-names	= "ack", "err", "wakeup";
+		wakeup-source;
+	};
+
+2. Without "wakeup" interrupt name
+
+	embedded-controller {
+		compatible = "google,cros-ec-i2c";
+		reg = <0x1e>;
+		interrupts = <6 0>;
+		interrupt-parent = <&gpx1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ec_irq>;
+		wakeup-source;
+	};
+
+3. Without interrupts
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 1 {
+			debounce_interval = <50>;
+			wakeup-source;
+			linux,code = <116>;
+			label = "POWER";
+			gpios = <&iofpga_gpio0 0 0x4>;
+		};
+		[....]
+	};
-- 
1.9.1
