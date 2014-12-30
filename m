From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Dec 2014 13:28:30 -0600
Subject: [PATCH 1/9] dt/bindings: add versatile PCI binding
In-Reply-To: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
Message-ID: <1419967718-26909-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Add binding documentation for the PCI controller found on Versatile PB
boards.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
 .../devicetree/bindings/pci/versatile.txt          | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/versatile.txt

diff --git a/Documentation/devicetree/bindings/pci/versatile.txt b/Documentation/devicetree/bindings/pci/versatile.txt
new file mode 100644
index 0000000..2cc6071
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/versatile.txt
@@ -0,0 +1,59 @@
+* ARM Versatile Platform Baseboard PCI interface
+
+PCI host controller found on the ARM Versatile PB board's FPGA.
+
+Required properties:
+- compatible: should contain "arm,versatile-pci" to identify the Versatile PCI
+  controller.
+- reg: base addresses and lengths of the pci controller. There must be 3
+  entries:
+	- Versatile specific registers
+	- Self Config space
+	- Config space
+- #address-cells: set to <3>
+- #size-cells: set to <2>
+- device_type: set to "pci"
+- bus-range: set to <0 0xff>
+- ranges: ranges for the PCI memory and I/O regions
+- #interrupt-cells: set to <1>
+- interrupt-map-mask and interrupt-map: standard PCI properties	to define
+	the mapping of the PCI interface to interrupt numbers.
+
+Example:
+
+pci-controller at 10001000 {
+	compatible = "arm,versatile-pci";
+	device_type = "pci";
+	reg = <0x10001000 0x1000
+	       0x41000000 0x10000
+	       0x42000000 0x100000>;
+	bus-range = <0 0xff>;
+	#address-cells = <3>;
+	#size-cells = <2>;
+	#interrupt-cells = <1>;
+
+	ranges = <0x01000000 0 0x00000000 0x43000000 0 0x00010000   /* downstream I/O */
+		  0x02000000 0 0x50000000 0x50000000 0 0x10000000   /* non-prefetchable memory */
+		  0x42000000 0 0x60000000 0x60000000 0 0x10000000>; /* prefetchable memory */
+
+	interrupt-map-mask = <0x1800 0 0 7>;
+	interrupt-map = <0x1800 0 0 1 &sic 28
+			 0x1800 0 0 2 &sic 29
+			 0x1800 0 0 3 &sic 30
+			 0x1800 0 0 4 &sic 27
+
+			 0x1000 0 0 1 &sic 27
+			 0x1000 0 0 2 &sic 28
+			 0x1000 0 0 3 &sic 29
+			 0x1000 0 0 4 &sic 30
+
+			 0x0800 0 0 1 &sic 30
+			 0x0800 0 0 2 &sic 27
+			 0x0800 0 0 3 &sic 28
+			 0x0800 0 0 4 &sic 29
+
+			 0x0000 0 0 1 &sic 29
+			 0x0000 0 0 2 &sic 30
+			 0x0000 0 0 3 &sic 27
+			 0x0000 0 0 4 &sic 28>;
+};
-- 
2.1.0
