From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon,  4 May 2015 10:36:37 -0700
Subject: [PATCH v8 4/9] mfd: Add binding document for NVIDIA Tegra XUSB
In-Reply-To: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
Message-ID: <1430761002-9327-5-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding document for the XUSB host complex on NVIDIA Tegra124
and later SoCs.  The XUSB host complex includes a mailbox for
communication with the XUSB micro-controller and an xHCI host-controller.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
Changes from v7:
 - Move non-shared resources into child nodes.
New for v7.
---
 .../bindings/mfd/nvidia,tegra124-xusb.txt          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt

diff --git a/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
new file mode 100644
index 0000000..bc50110
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
@@ -0,0 +1,37 @@
+NVIDIA Tegra XUSB host copmlex
+==============================
+
+The XUSB host complex on Tegra124 and later SoCs contains an xHCI host
+controller and a mailbox for communication with the XUSB micro-controller.
+
+Required properties:
+--------------------
+ - compatible: For Tegra124, must contain "nvidia,tegra124-xusb".
+   Otherwise, must contain '"nvidia,<chip>-xusb", "nvidia,tegra124-xusb"'
+   where <chip> is tegra132.
+ - reg: Must contain the base and length of the XUSB FPCI registers.
+ - ranges: Bus address mapping for the XUSB block.  Can be empty since the
+   mapping is 1:1.
+ - #address-cells: Must be 2.
+ - #size-cells: Must be 2.
+
+Example:
+--------
+	usb at 0,70098000 {
+		compatible = "nvidia,tegra124-xusb";
+		reg = <0x0 0x70098000 0x0 0x1000>;
+		ranges;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		usb-host at 0,70090000 {
+			compatible = "nvidia,tegra124-xhci";
+			...
+		};
+
+		mailbox {
+			compatible = "nvidia,tegra124-xusb-mbox";
+			...
+		};
+	};
-- 
2.2.0.rc0.207.ga3a616c
