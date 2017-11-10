From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 14:25:18 +0100
Subject: [PATCH v5 01/15] arm64: dts: renesas: r8a7795: Add IPMMU device nodes
In-Reply-To: <20171110132532.1202-1-horms+renesas@verge.net.au>
References: <20171110132532.1202-1-horms+renesas@verge.net.au>
Message-ID: <20171110132532.1202-2-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add r8a7795 IPMMU nodes and keep all disabled by default.

This includes all IPMMU devices for r8a7795 ES2.0. Those
not present in r8a7795 ES1.x are removed from the DT for those
SoCs using delete-node. A follow-up patch will add IPMMU devices
to ES1.x which are not also present in ES2.0.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v5 [Simon Horman]
* Correct ES1.x override for ipmmu_vc0
* Add ES1.x override for ipmmu_vc1
* Drop mostly redundant comments from nodes
* Add power domains
* Consistently mark all nodes as disabled

v4 [Simon Horman]
* Add IPMMU-VI1, IPMMU-VP1 IPMMU-PV2 and IPMMU-PV3
* Rename IPMMU-VP as IPMMU-VP0 and IPMMU-VI as IPMMU-VI0
  as per recent datasheet naming
* Do not add IPMMU-MP1 or IPMMU-SY,
  these will be added to ES1.x by follow-up patch

v1 - v3 [Magnus Damm]
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi |  25 +++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 145 +++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 655dd30639c5..246323eacb56 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -21,6 +21,11 @@
 		status = "disabled";
 	};
 
+	/delete-node/ mmu at febe0000;
+	/delete-node/ mmu at fe980000;
+	/delete-node/ mmu at fd960000;
+	/delete-node/ mmu at fd970000;
+
 	/delete-node/ usb-phy at ee0e0200;
 	/delete-node/ usb at ee0e0100;
 	/delete-node/ usb at ee0e0000;
@@ -86,6 +91,26 @@
 	};
 };
 
+&ipmmu_vi0 {
+	renesas,ipmmu-main = <&ipmmu_mm 11>;
+};
+
+&ipmmu_vp0 {
+	renesas,ipmmu-main = <&ipmmu_mm 12>;
+};
+
+&ipmmu_vc0 {
+	renesas,ipmmu-main = <&ipmmu_mm 9>;
+};
+
+&ipmmu_vc1 {
+	renesas,ipmmu-main = <&ipmmu_mm 10>;
+};
+
+&ipmmu_rt {
+	renesas,ipmmu-main = <&ipmmu_mm 7>;
+};
+
 &du {
 	vsps = <&vspd0 &vspd1 &vspd2 &vspd3>;
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 42c51f2ec30b..469ce4081b29 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -421,6 +421,151 @@
 			resets = <&cpg 407>;
 		};
 
+		ipmmu_vi0: mmu at febd0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfebd0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 14>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_vi1: mmu at febe0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfebe0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 15>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_vp0: mmu at fe990000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfe990000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 16>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_vp1: mmu at fe980000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfe980000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 17>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_vc0: mmu at fe6b0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfe6b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 12>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_vc1: mmu at fe6f0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfe6f0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 13>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_pv0: mmu at fd800000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfd800000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 6>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_pv2: mmu at fd960000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfd960000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 8>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_pv3: mmu at fd970000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfd970000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 9>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_ir: mmu at ff8b0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xff8b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 3>;
+			power-domains = <&sysc R8A7795_PD_A3IR>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_hc: mmu at e6570000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xe6570000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 2>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_rt: mmu at ffc80000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xffc80000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 10>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mp0: mmu at ec670000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xec670000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 4>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_ds0: mmu at e6740000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xe6740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_ds1: mmu at e7740000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xe7740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 1>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mm: mmu at e67b0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xe67b0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a7795",
 				     "renesas,rcar-dmac";
-- 
2.11.0
