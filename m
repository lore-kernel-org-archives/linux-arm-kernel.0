From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 27 Jan 2016 15:11:59 -0600
Subject: [PATCH 11/13] dtb: amd: Add PCIe SMMU device tree node
In-Reply-To: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1453929121-12171-12-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add PCIe SMMU device tree node for AMD Seattle SOC.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index a7fc059..bfccfea 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -210,6 +210,7 @@
 			device_type = "pci";
 			bus-range = <0 0x7f>;
 			msi-parent = <&v2m0>;
+			#stream-id-cells = <16>;
 			reg = <0 0xf0000000 0 0x10000000>;
 
 			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
@@ -230,6 +231,28 @@
 				<0x03000000 0x01 0x00000000 0x01 0x00000000 0x7f 0x00000000>;
 		};
 
+		pcie0_smmu: smmu at e0a00000 {
+			 compatible = "arm,mmu-401";
+			 reg = <0 0xe0a00000 0 0x10000>;
+			 #global-interrupts = <1>;
+			 interrupts = /* Uses combined intr for both
+				       * global and context
+				       */
+				      <0 333 4>,
+				      <0 333 4>;
+			/* Note:
+			 * SID[2:0]  = PCIe function number
+			 * SID[7:3]  = PCIe device number
+			 * SID[14:8] = PCIe bus number
+			 */
+			 mmu-masters = <&pcie0
+				/* 1:00:[0,3] */ 256 257 258 259
+				/* 2:00:[0,3] */ 512 513 514 515
+				/* 3:00:[0,3] */ 768 769 770 771
+				/* 4:00:[0,3] */ 1024 1025 1026 1027
+			 >;
+		 };
+
 		/* Perf CCN504 PMU */
 		ccn: ccn at 0xe8000000 {
 			compatible = "arm,ccn-504";
-- 
2.5.0
