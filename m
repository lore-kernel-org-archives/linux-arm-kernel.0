From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 28 Aug 2016 18:16:37 +0200
Subject: [PATCH v3 5/5] ARM64: dts: meson-gxbb: use the new GXBB DWMAC glue
 driver
In-Reply-To: <20160828161637.9941-1-martin.blumenstingl@googlemail.com>
References: <20160820093538.9707-1-martin.blumenstingl@googlemail.com>
 <20160828161637.9941-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160828161637.9941-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic reference driver uses the "mc_val" devicetree property to
configure the PRG_ETHERNET_ADDR0 register. Unfortunately it uses magic
values for this configuration.
According to the datasheet the PRG_ETHERNET_ADDR0 register is at address
0xc8834108. However, the reference driver uses 0xc8834540 instead.
According to my tests, the value from the reference driver is correct.

No changes are required to the board dts files because the only
required configuration option is the phy-mode, which had to be
configured correctly before as well.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 4f42316..ab817d3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -373,13 +373,15 @@
 		};
 
 		ethmac: ethernet at c9410000 {
-			compatible = "amlogic,meson6-dwmac", "snps,dwmac";
+			compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
 			reg = <0x0 0xc9410000 0x0 0x10000
 			       0x0 0xc8834540 0x0 0x4>;
 			interrupts = <0 8 1>;
 			interrupt-names = "macirq";
-			clocks = <&clkc CLKID_ETH>;
-			clock-names = "stmmaceth";
+			clocks = <&clkc CLKID_ETH>,
+				 <&clkc CLKID_FCLK_DIV2>,
+				 <&clkc CLKID_MPLL2>;
+			clock-names = "stmmaceth", "clkin0", "clkin1";
 			phy-mode = "rgmii";
 			status = "disabled";
 		};
-- 
2.9.3
