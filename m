From: s-anna@ti.com (Suman Anna)
Date: Tue, 21 Jul 2015 19:01:33 -0500
Subject: [PATCH 3/4] ARM: dts: DRA7: Add common IOMMU nodes
In-Reply-To: <1437523294-20058-1-git-send-email-s-anna@ti.com>
References: <1437523294-20058-1-git-send-email-s-anna@ti.com>
Message-ID: <1437523294-20058-4-git-send-email-s-anna@ti.com>
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
index 1c96729641b6..0754df4ca59c 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -911,6 +911,46 @@
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
2.4.4
