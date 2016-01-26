From: ralf@ramses-pyramidenbau.de (Ralf Ramsauer)
Date: Tue, 26 Jan 2016 17:59:18 +0100
Subject: [PATCH v2 2/2] ARM: tegra: Add high speed UARTs to Jetson TK1 device
 tree
In-Reply-To: <1453827558-10954-1-git-send-email-ralf@ramses-pyramidenbau.de>
References: <1453827558-10954-1-git-send-email-ralf@ramses-pyramidenbau.de>
Message-ID: <1453827558-10954-3-git-send-email-ralf@ramses-pyramidenbau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the APB DMA high speed UARTs of the Jetson TK1. So
far, they were only enabled in NVidia's official BSP.

Those additional UARTs are exposed on the expansion connector J3A2:

 UART1:
  Pin 41: BR_UART1_TXD
  Pin 44: BR_UART1_RXD

 UART2:
  Pin 65: UART2_RXD
  Pin 68: UART2_TXD
  Pin 71: UART2_CTS_L
  Pin 74: UART2_RTS_L

Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 66b4451..4ee2e63 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -12,7 +12,11 @@
 	aliases {
 		rtc0 = "/i2c at 0,7000d000/pmic at 40";
 		rtc1 = "/rtc at 0,7000e000";
+
+		/* This order keeps the mapping DB9 connector <-> ttyS0 */
 		serial0 = &uartd;
+		serial1 = &uarta;
+		serial2 = &uartb;
 	};
 
 	memory {
@@ -1367,6 +1371,28 @@
 		};
 	};
 
+	/*
+	 * First high speed UART, exposed on the expansion connector J3A2
+	 *   Pin 41: BR_UART1_TXD
+	 *   Pin 44: BR_UART1_RXD
+	 */
+	serial at 0,70006000 {
+		compatible = "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart";
+		status = "okay";
+	};
+
+	/*
+	 * Second high speed UART, exposed on the expansion connector J3A2
+	 *   Pin 65: UART2_RXD
+	 *   Pin 68: UART2_TXD
+	 *   Pin 71: UART2_CTS_L
+	 *   Pin 74: UART2_RTS_L
+	 */
+	serial at 0,70006040 {
+		compatible = "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart";
+		status = "okay";
+	};
+
 	/* DB9 serial port */
 	serial at 0,70006300 {
 		status = "okay";
-- 
2.4.10
