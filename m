From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 15 Jun 2017 11:04:12 +0800
Subject: [PATCH v4 15/20] arm64: dts: hisi: add kirin pcie node
In-Reply-To: <20170615030417.14059-1-guodong.xu@linaro.org>
References: <20170615030417.14059-1-guodong.xu@linaro.org>
Message-ID: <20170615030417.14059-16-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiaowei Song <songxiaowei@hisilicon.com>

Add PCIe node for hi3660, and add binding documentation.

Cc: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index e138973..529cf08 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -754,5 +754,37 @@
 			cs-gpios = <&gpio18 5 0>;
 			status = "disabled";
 		};
+
+		pcie at f4000000 {
+			compatible = "hisilicon,kirin960-pcie";
+			reg = <0x0 0xf4000000 0x0 0x1000>,
+			      <0x0 0xff3fe000 0x0 0x1000>,
+			      <0x0 0xf3f20000 0x0 0x40000>,
+			      <0x0 0xf5000000 0x0 0x2000>;
+			reg-names = "dbi", "apb", "phy", "config";
+			bus-range = <0x0  0x1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0x00000000 0x0
+				  0xf6000000 0x0 0x2000000>;
+			num-lanes = <1>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <0x0 0 0 1 &gic 0 0 0 282 4>,
+					<0x0 0 0 2 &gic 0 0 0  283 4>,
+					<0x0 0 0 3 &gic 0 0 0  284 4>,
+					<0x0 0 0 4 &gic 0 0 0  285 4>;
+			clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
+				 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
+				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
+				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
+				 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
+			clock-names = "pcie_phy_ref", "pcie_aux",
+				      "pcie_apb_phy", "pcie_apb_sys",
+				      "pcie_aclk";
+			reset-gpios = <&gpio11 1 0 >;
+			status = "ok";
+		};
 	};
 };
-- 
2.10.2
