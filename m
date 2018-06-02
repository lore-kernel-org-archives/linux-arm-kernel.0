From: vbhadram@nvidia.com (Bhadram Varka)
Date: Sat, 2 Jun 2018 14:41:52 +0530
Subject: [PATCH 2/3] arm64: tegra: Enable multi-queue for DWC EQOS
In-Reply-To: <1527930713-4479-1-git-send-email-vbhadram@nvidia.com>
References: <1527930713-4479-1-git-send-email-vbhadram@nvidia.com>
Message-ID: <1527930713-4479-2-git-send-email-vbhadram@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DWC EQOS supports four MTL queues for Tx and Rx
separately.

Signed-off-by: Bhadram Varka <vbhadram@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 0f4bed8..f27730d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -37,6 +37,52 @@
 		gpio-controller;
 	};
 
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,priority = <0x0>;
+		};
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,priority = <0x1>;
+		};
+		queue2 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,priority = <0x2>;
+		};
+		queue3 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,priority = <0x3>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+		snps,tx-sched-sp;
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x0>;
+		};
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x3>;
+		};
+	};
+
 	ethernet at 2490000 {
 		compatible = "nvidia,tegra186-eqos",
 			     "snps,dwc-qos-ethernet-4.10";
@@ -57,6 +103,8 @@
 		snps,burst-map = <0x7>;
 		snps,txpbl = <32>;
 		snps,rxpbl = <8>;
+		snps,mtl-rx-config = <&mtl_rx_setup>;
+		snps,mtl-tx-config = <&mtl_tx_setup>;
 	};
 
 	memory-controller at 2c00000 {
-- 
2.7.4
