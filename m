From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 29 Mar 2017 16:02:18 +0530
Subject: [PATCH] ARM: dts: keystone-k2l: fix broken Ethernet due to disabled
 OSR
Message-ID: <59ba5ef37f17ff1c10d9d52ca06ef341b2d476eb.1490782833.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

Ethernet networking on K2L has been broken since v4.11-rc1. This was
caused by commit 32a34441a9bd ("ARM: keystone: dts: fix netcp clocks
and add names"). This commit inadvertently moves on-chip static RAM
clock to the end of list of clocks provided for netcp. Since keystone
PM domain support does not have a list of recognized con_ids, only the
first clock in the list comes under runtime PM management. This means
the OSR (On-chip Static RAM) clock remains disabled and that broke
networking on K2L.

The OSR is used by QMSS on K2L as an external linking RAM. However this
is a standalone RAM that can be used for non-QMSS usage (as well as from
DSP side). So add a SRAM device node for the same and add the OSR clock
to the node.

Remove the now redundant OSR clock node from netcp.

To manage all clocks defined for netCP's use by runtime PM needs keystone
generic power domain (genpd) driver support which is under works.
Meanwhile, this patch restores K2L networking and is correct irrespective
of any future genpd work since OSR is an independent module and not part
of NetCP anyway.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Acked-by: Tero Kristo <t-kristo@ti.com>
[nsekhar at ti.com: commit message updates, port to latest mainline]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi | 4 ++--
 arch/arm/boot/dts/keystone-k2l.dtsi       | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
index b6f26824e83a..66f615a74118 100644
--- a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
@@ -137,8 +137,8 @@ netcp: netcp at 26000000 {
 	/* NetCP address range */
 	ranges = <0 0x26000000 0x1000000>;
 
-	clocks = <&clkpa>, <&clkcpgmac>, <&chipclk12>, <&clkosr>;
-	clock-names = "pa_clk", "ethss_clk", "cpts", "osr_clk";
+	clocks = <&clkpa>, <&clkcpgmac>, <&chipclk12>;
+	clock-names = "pa_clk", "ethss_clk", "cpts";
 	dma-coherent;
 
 	ti,navigator-dmas = <&dma_gbe 0>,
diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index b58e7ebc0919..148650406cf7 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -232,6 +232,14 @@
 			};
 		};
 
+		osr: sram at 70000000 {
+			compatible = "mmio-sram";
+			reg = <0x70000000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&clkosr>;
+		};
+
 		dspgpio0: keystone_dsp_gpio at 02620240 {
 			compatible = "ti,keystone-dsp-gpio";
 			gpio-controller;
-- 
2.9.0
