From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 08 Jan 2015 10:40:52 +0900
Subject: [PATCHv3 3/8] ARM: dts: Add memory bus node for Exynos3250
In-Reply-To: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
References: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1420681257-3078-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the memory bus node for Exynos3250 SoC. Exynos3250 has
following memory buses to translate data between DRAM and eMMC/sub-IPs.

Following list specifies the detailed relation between memory bus clock and DMC
IP in MIF (Memory Interface) block:
- DMC clock : DMC (Dynamic Memory Controller)

Following list specifies the detailed relation between memory bus clock and
sub-IPs in INT (Internal) block:
- ACLK100 clock : PERIL
- ACLK160 clock : LCD0
- ACLK200 clock : FSYS
- ACLK266 clock : ISP
- GDL/GDR clock : leftbus/rightbus
- SCLK_MFC clock : MFC

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 125 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 9ed1260..3eaed53 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -99,6 +99,131 @@
 			};
 		};
 
+		memory_bus_mif: memory_bus at 0 {
+			compatible = "samsung,exynos-memory-bus";
+
+			operating-points = <
+				400000 875000
+				200000 800000
+				133000 800000
+				100000 800000
+				50000  800000>;
+			status = "disabled";
+
+			blocks {
+				dmc_block: memory_bus_block1 {
+					clocks = <&cmu_dmc CLK_DIV_DMC>;
+					clock-names = "memory-bus";
+					frequency = <
+						400000
+						200000
+						133000
+						100000
+						50000>;
+				};
+			};
+		};
+
+		memory_bus_int: memory_bus at 1 {
+			compatible = "samsung,exynos-memory-bus";
+
+			operating-points = <
+				400000 950000
+				200000 950000
+				133000 925000
+				100000 850000
+				80000  850000
+				50000  850000>;
+
+			status = "disabled";
+
+			blocks {
+				peril_block: memory_bus_block1 {
+					clocks = <&cmu CLK_DIV_ACLK_100>;
+					clock-names = "memory-bus";
+					frequency = <
+						100000
+						100000
+						100000
+						100000
+						50000
+						50000>;
+				};
+
+				lcd0_block: memory_bus_block2 {
+					clocks = <&cmu CLK_DIV_ACLK_160>;
+					clock-names = "memory-bus";
+					frequency = <
+						200000
+						160000
+						100000
+						80000
+						80000
+						50000>;
+				};
+
+				fsys_block: memory_bus_block3 {
+					clocks = <&cmu CLK_DIV_ACLK_200>;
+					clock-names = "memory-bus";
+					frequency = <
+						200000
+						200000
+						100000
+						80000
+						50000
+						50000>;
+				};
+
+				isp_block: memory_bus_block4 {
+					clocks = <&cmu CLK_DIV_ACLK_266>;
+					clock-names = "memory-bus";
+					frequency = <
+						300000
+						200000
+						133000
+						100000
+						50000
+						50000>;
+				};
+
+				leftbus_block: memory_bus_block5 {
+					clocks = <&cmu CLK_DIV_GDL>;
+					clock-names = "memory-bus";
+					frequency = <
+						200000
+						200000
+						133000
+						100000
+						100000
+						100000>;
+				};
+
+				rightbus_block: memory_bus_block6 {
+					clocks = <&cmu CLK_DIV_GDR>;
+					clock-names = "memory-bus";
+					frequency = <
+						200000
+						200000
+						133000
+						100000
+						100000
+						100000>;
+				};
+
+				mfc_block: memory_bus_block7 {
+					clocks = <&cmu CLK_SCLK_MFC>;
+					clock-names = "memory-bus";
+					frequency = <
+						200000
+						200000
+						200000
+						133000
+						100000
+						80000>;
+				};
+			};
+		};
+
 		sysram at 02020000 {
 			compatible = "mmio-sram";
 			reg = <0x02020000 0x40000>;
-- 
1.8.5.5
