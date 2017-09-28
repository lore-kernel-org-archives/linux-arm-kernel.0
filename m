From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Sep 2017 14:45:50 +0200
Subject: [PATCH 2/2] arm64: dts: marvell: fix interrupt-map property for
 Armada CP110 slave PCIe controller
In-Reply-To: <20170928124550.11492-1-thomas.petazzoni@free-electrons.com>
References: <20170928124550.11492-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170928124550.11492-3-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt-map property used in the description of the Marvell
Armada 7K/8K PCIe controllers has a bogus extraneous 0 that causes the
interrupt conversion to not be done properly. This causes the PCIe PME
and AER root port service drivers to fail their initialization:

[    5.019900] genirq: Setting trigger mode 7 for irq 114 failed (irq_chip_set_type_parent+0x0/0x30)
[    5.028821] pcie_pme: probe of 0001:00:00.0:pcie001 failed with error -22
[    5.035687] genirq: Setting trigger mode 7 for irq 114 failed (irq_chip_set_type_parent+0x0/0x30)
[    5.044614] aer: probe of 0001:00:00.0:pcie002 failed with error -22

This problem exists since the Device Tree description of the slave
CP110 was added to the kernel.

Fixes: 4eef78a0091b5 ("arm64: dts: marvell: add description for the slave CP110 in Armada 8K")
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index b71ee6c83668..4fe70323abb3 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -335,7 +335,7 @@
 				/* non-prefetchable memory */
 				0x82000000 0 0xfa000000 0  0xfa000000 0 0xf00000>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &cps_icu 0 ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 0 &cps_icu ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
 			interrupts = <ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
 			num-lanes = <1>;
 			clocks = <&cps_clk 1 13>;
@@ -361,7 +361,7 @@
 				/* non-prefetchable memory */
 				0x82000000 0 0xfb000000 0  0xfb000000 0 0xf00000>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &cps_icu 0 ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 0 &cps_icu ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
 			interrupts = <ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
 
 			num-lanes = <1>;
@@ -388,7 +388,7 @@
 				/* non-prefetchable memory */
 				0x82000000 0 0xfc000000 0  0xfc000000 0 0xf00000>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &cps_icu 0 ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 0 &cps_icu ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
 			interrupts = <ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
 
 			num-lanes = <1>;
-- 
2.13.5
