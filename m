From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  4 Jan 2018 22:37:52 +0800
Subject: [PATCH v2 6/8] dt-bindings: ARM: sunxi: Document A80 SoC secure SRAM
 usage by SMP hotplug
In-Reply-To: <20180104143754.2425-1-wens@csie.org>
References: <20180104143754.2425-1-wens@csie.org>
Message-ID: <20180104143754.2425-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Allwinner A80 SoC the BROM supports hotplugging the primary core
(cpu0) by checking two 32bit values at a specific location within the
secure SRAM block. This region needs to be reserved and accessible to
the SMP code.

Document its usage.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/arm/sunxi/smp-sram.txt     | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt

diff --git a/Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt b/Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt
new file mode 100644
index 000000000000..082e6a9382d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sunxi/smp-sram.txt
@@ -0,0 +1,44 @@
+Allwinner SRAM for smp bringup:
+------------------------------------------------
+
+Allwinner's A80 SoC uses part of the secure sram for hotplugging of the
+primary core (cpu0). Once the core gets powered up it checks if a magic
+value is set at a specific location. If it is then the BROM will jump
+to the software entry address, instead of executing a standard boot.
+
+Therefore a reserved section sub-node has to be added to the mmio-sram
+declaration.
+
+Note that this is separate from the Allwinner SRAM controller found in
+../../sram/sunxi-sram.txt. This SRAM is secure only and not mappable to
+any device.
+
+Also there are no "secure-only" properties. The implementation should
+check if this SRAM is usable first.
+
+Required sub-node properties:
+- compatible : depending on the SoC this should be one of:
+		"allwinner,sun9i-a80-smp-sram"
+
+The rest of the properties should follow the generic mmio-sram discription
+found in ../../misc/sram.txt
+
+Example:
+
+	sram_b: sram at 20000 {
+		/* 256 KiB secure SRAM at 0x20000 */
+		compatible = "mmio-sram";
+		reg = <0x00020000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x00020000 0x40000>;
+
+		smp-sram at 1000 {
+			/*
+			 * This is checked by BROM to determine if
+			 * cpu0 should jump to SMP entry vector
+			 */
+			compatible = "allwinner,sun9i-a80-smp-sram";
+			reg = <0x1000 0x8>;
+		};
+	};
-- 
2.15.1
