From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 23 Feb 2017 18:30:44 +0100
Subject: [PATCH 02/11] arm64: tegra: Add ethernet support for Tegra186
In-Reply-To: <20170223173053.19701-1-thierry.reding@gmail.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
Message-ID: <20170223173053.19701-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The NVIDIA Tegra186 SoC contains an instance of the Synopsys DWC
ethernet QOS IP block, which supports 10, 100 and 1000 Mbps data
transfer rates.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index d6955bb46ae0..3ea5e6369bc3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -27,6 +27,37 @@
 		gpio-controller;
 	};
 
+	ethernet at 2490000 {
+		compatible = "nvidia,tegra186-eqos",
+			     "snps,dwc-qos-ethernet-4.10";
+		reg = <0x0 0x02490000 0x0 0x10000>;
+		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>, /* common */
+			     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>, /* power */
+			     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>, /* rx0 */
+			     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>, /* tx0 */
+			     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>, /* rx1 */
+			     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>, /* tx1 */
+			     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>, /* rx2 */
+			     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* tx2 */
+			     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>, /* rx3 */
+			     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>; /* tx3 */
+		clocks = <&bpmp TEGRA186_CLK_AXI_CBB>,
+			 <&bpmp TEGRA186_CLK_EQOS_AXI>,
+			 <&bpmp TEGRA186_CLK_EQOS_RX>,
+			 <&bpmp TEGRA186_CLK_EQOS_TX>,
+			 <&bpmp TEGRA186_CLK_EQOS_PTP_REF>;
+		clock-names = "master_bus", "slave_bus", "rx", "tx", "ptp_ref";
+		resets = <&bpmp TEGRA186_RESET_EQOS>;
+		reset-names = "eqos";
+		status = "disabled";
+
+		snps,write-requests = <1>;
+		snps,read-requests = <3>;
+		snps,burst-map = <0x7>;
+		snps,txpbl = <32>;
+		snps,rxpbl = <8>;
+	};
+
 	uarta: serial at 3100000 {
 		compatible = "nvidia,tegra186-uart", "nvidia,tegra20-uart";
 		reg = <0x0 0x03100000 0x0 0x40>;
-- 
2.11.1
