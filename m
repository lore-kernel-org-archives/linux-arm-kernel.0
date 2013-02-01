From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 01 Feb 2013 18:21:55 +0530
Subject: [PATCH V2 3/4] ARM: dts: Add #dma-cells for generic dma binding
 support
In-Reply-To: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
References: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
Message-ID: <1359723116-18173-4-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds #dma-cells property to PL330 DMA controller
nodes for supporting generic dma dt bindings on samsung
exynos5250 platform.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 .../devicetree/bindings/dma/arm-pl330.txt          |   15 +++++++++++----
 arch/arm/boot/dts/exynos5250.dtsi                  |    4 ++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
index 36e27d5..1fdbff6 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl330.txt
+++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
@@ -8,6 +8,8 @@ Required properties:
   - reg: physical base address of the controller and length of memory mapped
     region.
   - interrupts: interrupt number to the cpu.
+  - #dma-cells: must be <1>. used to represent the number of integer
+    cells in the dmas property of client device.
 
 Optional properties:
 - dma-coherent      : Present if dma operations are coherent
@@ -18,16 +20,21 @@ Example:
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x12680000 0x1000>;
 		interrupts = <99>;
+		#dma-cells = <1>;
 	};
 
 Client drivers (device nodes requiring dma transfers from dev-to-mem or
-mem-to-dev) should specify the DMA channel numbers using a two-value pair
+mem-to-dev) should specify the DMA channel numbers and dma channel names
 as shown below.
 
   [property name]  = <[phandle of the dma controller] [dma request id]>;
+  [property name]  = <[dma channel name]>
 
       where 'dma request id' is the dma request number which is connected
-      to the client controller. The 'property name' is recommended to be
-      of the form <name>-dma-channel.
+      to the client controller. The 'property name' 'dmas' and 'dma-names'
+      as required by the generic dma device tree binding helpers. The dma
+      names correspond 1:1 with the dma request ids in the dmas property.
 
-  Example:  tx-dma-channel = <&pdma0 12>;
+  Example:  dmas = <&pdma0 12
+		    &pdma1 11>;
+	    dma-names = "tx", "rx";
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index f50b4e8..724f5bd 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -312,24 +312,28 @@
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121A0000 0x1000>;
 			interrupts = <0 34 0>;
+			#dma-cells = <1>;
 		};
 
 		pdma1: pdma at 121B0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121B0000 0x1000>;
 			interrupts = <0 35 0>;
+			#dma-cells = <1>;
 		};
 
 		mdma0: mdma at 10800000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x10800000 0x1000>;
 			interrupts = <0 33 0>;
+			#dma-cells = <1>;
 		};
 
 		mdma1: mdma at 11C10000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x11C10000 0x1000>;
 			interrupts = <0 124 0>;
+			#dma-cells = <1>;
 		};
 	};
 
-- 
1.7.4.4
