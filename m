From: s-anna@ti.com (Suman Anna)
Date: Thu, 13 Feb 2014 12:22:55 -0600
Subject: [PATCH 3/4] ARM: dts: OMAP4: Add IOMMU nodes
In-Reply-To: <1392315776-33197-1-git-send-email-s-anna@ti.com>
References: <1392315776-33197-1-git-send-email-s-anna@ti.com>
Message-ID: <1392315776-33197-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Vaussard <florian.vaussard@epfl.ch>

Add the IOMMU nodes for the DSP and IPU subsystems. The external
address space for DSP starts at 0x20000000 in OMAP4 compared to
0x11000000 in OMAP3, and the addresses beyond 0xE0000000 are
private address space for the Cortex-M3 cores in the IPU subsystem.
The MMU within the IPU sub-system also supports a bus error back
capability, not available on the DSP MMU.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
[s-anna at ti.com: dma-window updates and bus error back addition]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..1885f90 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -461,6 +461,23 @@
 			dma-names = "tx", "rx";
 		};
 
+		mmu_dsp: mmu at 4a066000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x4a066000 0xff>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_dsp";
+			dma-window = <0x20000000 0xdffff000>;
+		};
+
+		mmu_ipu: mmu at 55082000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x55082000 0xff>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_ipu";
+			dma-window = <0 0xdffff000>;
+			ti,iommu-bus-err-back;
+		};
+
 		wdt2: wdt at 4a314000 {
 			compatible = "ti,omap4-wdt", "ti,omap3-wdt";
 			reg = <0x4a314000 0x80>;
-- 
1.8.5.3
