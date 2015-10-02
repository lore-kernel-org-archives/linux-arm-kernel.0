From: s-anna@ti.com (Suman Anna)
Date: Fri, 2 Oct 2015 18:23:24 -0500
Subject: [REPOST PATCH 3/4] ARM: dts: DRA7: Add common IOMMU nodes
In-Reply-To: <1443828205-18706-1-git-send-email-s-anna@ti.com>
References: <1443828205-18706-1-git-send-email-s-anna@ti.com>
Message-ID: <1443828205-18706-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRA7xx family of SOCs have two IPUs and one DSP processor
subsystems in common. The IOMMU DT nodes have been added for
these processor subsystems, and have been disabled by default.

These MMUs are very similar to those on OMAP4 and OMAP5, with
the only difference being the presence of a second MMU within
the DSP subsystem for the EDMA port. The DSP IOMMUs also need
an additional 'ti,syscon-mmuconfig' property compared to the
IPU IOMMUs.

NOTE: The enabling of these nodes is left to the respective
board dts files.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 62055094e8d5..9f6bafcad385 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -916,6 +916,46 @@
 			status = "disabled";
 		};
 
+		mmu0_dsp1: mmu at 40d01000 {
+			compatible = "ti,dra7-dsp-iommu";
+			reg = <0x40d01000 0x100>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu0_dsp1";
+			#iommu-cells = <0>;
+			ti,syscon-mmuconfig = <&dsp1_system 0x0>;
+			status = "disabled";
+		};
+
+		mmu1_dsp1: mmu at 40d02000 {
+			compatible = "ti,dra7-dsp-iommu";
+			reg = <0x40d02000 0x100>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu1_dsp1";
+			#iommu-cells = <0>;
+			ti,syscon-mmuconfig = <&dsp1_system 0x1>;
+			status = "disabled";
+		};
+
+		mmu_ipu1: mmu at 58882000 {
+			compatible = "ti,dra7-iommu";
+			reg = <0x58882000 0x100>;
+			interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_ipu1";
+			#iommu-cells = <0>;
+			ti,iommu-bus-err-back;
+			status = "disabled";
+		};
+
+		mmu_ipu2: mmu at 55082000 {
+			compatible = "ti,dra7-iommu";
+			reg = <0x55082000 0x100>;
+			interrupts = <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_ipu2";
+			#iommu-cells = <0>;
+			ti,iommu-bus-err-back;
+			status = "disabled";
+		};
+
 		abb_mpu: regulator-abb-mpu {
 			compatible = "ti,abb-v3";
 			regulator-name = "abb_mpu";
-- 
2.6.0
