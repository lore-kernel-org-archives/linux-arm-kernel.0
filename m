From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 8 Mar 2013 19:23:00 +0530
Subject: [PATCH 3/5] ARM: DT: tegra114:add aliases and DMA requestor for
 serial controller
In-Reply-To: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
References: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1362750782-15174-4-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add APB DMA requestor and serial aliases for serial controller.
There will be two serial driver i.e. 8250 based simple serial driver
and APB DMA based serial driver for higher baudrate and performace.

The simple serial driver get enabled with compatible nvidia,tegra20-uart
and APB DMA based driver will get enabled with compatible
nvidia,tegra30-hsuart.

Also Fix the clock id for the UARTB.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 14afbc8..686e33f 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -4,6 +4,13 @@
 	compatible = "nvidia,tegra114";
 	interrupt-parent = <&gic>;
 
+	aliases {
+		serial0 = &uarta;
+		serial1 = &uartb;
+		serial2 = &uartc;
+		serial3 = &uartd;
+	};
+
 	gic: interrupt-controller {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
@@ -99,38 +106,50 @@
 		       0x70003000 0x40c>;	/* Mux registers */
 	};
 
-	serial at 70006000 {
+	/*
+	 * There are two serial driver i.e. 8250 based simple serial
+	 * driver and APB DMA based serial driver for higher baudrate
+	 * and performace. To enable the 8250 based driver, the compatible
+	 * is "nvidia,tegra30-uart", "nvidia,tegra20-uart" and to enable
+	 * the APB DMA based serial driver, the comptible is
+	 * "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart".
+	 */
+	uarta: serial at 70006000 {
 		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
+		nvidia,dma-request-selector = <&apbdma 8>;
 		status = "disabled";
 		clocks = <&tegra_car 6>;
 	};
 
-	serial at 70006040 {
+	uartb: serial at 70006040 {
 		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
+		nvidia,dma-request-selector = <&apbdma 9>;
 		status = "disabled";
-		clocks = <&tegra_car 192>;
+		clocks = <&tegra_car 7>;
 	};
 
-	serial at 70006200 {
+	uartc: serial at 70006200 {
 		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 46 0x04>;
+		nvidia,dma-request-selector = <&apbdma 10>;
 		status = "disabled";
 		clocks = <&tegra_car 55>;
 	};
 
-	serial at 70006300 {
+	uartd: serial at 70006300 {
 		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
 		interrupts = <0 90 0x04>;
+		nvidia,dma-request-selector = <&apbdma 19>;
 		status = "disabled";
 		clocks = <&tegra_car 65>;
 	};
-- 
1.7.1.1
