From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 22 May 2015 12:13:10 +0100
Subject: [PATCH v3 6/6] Documentation: bindings: Add DT bindings for ARM Juno
 boards.
In-Reply-To: <1432293190-13012-1-git-send-email-Liviu.Dudau@arm.com>
References: <1432293190-13012-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1432293190-13012-7-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

List the required properties and nodes used to describe the
ARM Juno boards.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 Documentation/devicetree/bindings/arm/arm-boards | 66 ++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index b78564b..1a70997 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -157,3 +157,69 @@ Example:
 
 	};
 };
+
+ARM Versatile Express Boards
+-----------------------------
+For details on the device tree bindings for ARM Versatile Express boards
+please consult the vexpress.txt file in the same directory as this file.
+
+ARM Juno Boards
+----------------
+The Juno boards are targeting development for AArch64 systems. The first
+iteration, Juno r0, is a vehicle for evaluating big.LITTLE on AArch64,
+with the second iteration, Juno r1, mainly aimed at development of PCIe
+based systems. Juno r1 also has support for AXI masters placed on the TLX
+connectors to join the coherency domain.
+
+Juno boards are described in a similar way to ARM Versatile Express boards,
+with the motherboard part of the hardware being described in a separate file
+to highlight the fact that is part of the support infrastructure for the SoC.
+Juno device tree bindings also share the Versatile Express bindings as
+described under the RS1 memory mapping.
+
+Required properties (in root node):
+	compatible = "arm,juno";	/* For Juno r0 board */
+	compatible = "arm,juno-r1";	/* For Juno r1 board */
+
+Required nodes:
+The description for the board must include:
+   - a "psci" node describing the boot method used for the secondary CPUs.
+     A detailed description of the bindings used for "psci" nodes is present
+     in the psci.txt file.
+   - a "cpus" node describing the available cores and their associated
+     "enable-method"s. For more details see cpus.txt file.
+
+Example:
+
+/dts-v1/;
+/ {
+	model = "ARM Juno development board (r0)";
+	compatible = "arm,juno", "arm,vexpress";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		A57_0: cpu at 0 {
+			compatible = "arm,cortex-a57","arm,armv8";
+			reg = <0x0 0x0>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+
+		.....
+
+		A53_0: cpu at 100 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x0 0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+
+		.....
+	};
+
+};
-- 
2.4.0
