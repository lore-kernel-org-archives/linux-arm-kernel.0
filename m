From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu,  8 Oct 2015 15:31:14 +0200
Subject: [PATCH v4 3/8] ARM: dts: rockchip: Add SPDIF transceiver for RK3188
In-Reply-To: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1444311079-2892-4-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SPDIF transceiver controller and pin for RK3188

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

Changes in v4:
- Adjust clock names to match the new names (hclk/mclk)

Changes in v3: None
Changes in v2:
- Sort the spdif node properties
- Drop the 0x prefix from the node name
- Rename the spdif@ node to sound@

 arch/arm/boot/dts/rk3188.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 3163042..04e38af 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -121,6 +121,22 @@
 		status = "disabled";
 	};
 
+	spdif: sound at 1011e000 {
+		compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
+		reg = <0x1011e000 0x2000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#sound-dai-cells = <0>;
+		clock-names = "hclk", "mclk";
+		clocks = <&cru HCLK_SPDIF>, <&cru SCLK_SPDIF>;
+		dmas = <&dmac1_s 8>;
+		dma-names = "tx";
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_tx>;
+		status = "disabled";
+	};
+
 	cru: clock-controller at 20000000 {
 		compatible = "rockchip,rk3188-cru";
 		reg = <0x20000000 0x1000>;
@@ -484,6 +500,12 @@
 						<RK_GPIO1 21 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
+
+		spdif {
+			spdif_tx: spdif-tx {
+				rockchip,pins = <RK_GPIO1 14 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
 	};
 };
 
-- 
2.6.1
