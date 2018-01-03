From: rasmus.villemoes@prevas.dk (Rasmus Villemoes)
Date: Wed, 3 Jan 2018 16:45:45 +0100
Subject: [PATCH v2] ARM: dts: ls1021a: add nodes for on-chip ram
In-Reply-To: <1513870698-31264-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1513870698-31264-1-git-send-email-rasmus.villemoes@prevas.dk>
Message-ID: <1514994345-2471-1-git-send-email-rasmus.villemoes@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although the two nodes constitute one contiguous 128K region, still
describe them separately:

- That's how they are described in the reference manual: "Each OCRAM
  occupies a 64 KB of address region...", and the names ocram1 and
  ocram2 are also as used in the manual.

- The two areas are treated differently by the boot ROM code: OCRAM2 is
  zero-initialized, while, again quoting the RM, "software must perform
  the zero initialization of OCRAM1."

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
v2: add changelog explaining the split in two nodes.

arch/arm/boot/dts/ls1021a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 96aa7752dd0d..7bb5896b3726 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -748,5 +748,21 @@
 					<0000 0 0 3 &gic GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		ocram1: sram at 10000000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0x10000000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x10000000 0x10000>;
+		};
+
+		ocram2: sram at 10010000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0x10010000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x10010000 0x10000>;
+		};
 	};
 };
-- 
2.7.4
