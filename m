From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 27 Apr 2015 15:37:17 -0700
Subject: [PATCH V7 4/9] mfd: Add binding document for NVIDIA Tegra XUSB
In-Reply-To: <1430174242-29465-1-git-send-email-abrestic@chromium.org>
References: <1430174242-29465-1-git-send-email-abrestic@chromium.org>
Message-ID: <1430174242-29465-5-git-send-email-abrestic@chromium.org>
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
New for v7.
---
 .../bindings/mfd/nvidia,tegra124-xusb.txt          | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt

diff --git a/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
new file mode 100644
index 0000000..6a46680
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
@@ -0,0 +1,46 @@
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
+ - reg: Must contain register base and length for each register set listed
+   in reg-names.
+ - reg-names: Must include the following entries:
+   - xhci
+   - fpci
+   - ipfs
+ - interrupts: Must contain an interrupt for each entry in interrupt-names.
+ - interrupt-names: Must include the following entries:
+   - host
+   - smi
+   - pme
+
+Example:
+--------
+	usb at 0,70090000 {
+		compatible = "nvidia,tegra124-xusb";
+		reg = <0x0 0x70090000 0x0 0x8000>,
+		      <0x0 0x70098000 0x0 0x1000>,
+		      <0x0 0x70099000 0x0 0x1000>;
+		reg-names = "xhci", "fpci", "ipfs";
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 40 IRQ_TYPE_LEVEL_HGIH>,
+			     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host", "smi", "pme";
+
+		usb-host {
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
