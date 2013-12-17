From: ynvich@gmail.com (Sergei Ianovich)
Date: Tue, 17 Dec 2013 23:37:36 +0400
Subject: [PATCH v3 06/21] ARM: dts: provide DMA config to pxamci on PXA27x
In-Reply-To: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
References: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
 <1387309071-22382-1-git-send-email-ynvich@gmail.com>
Message-ID: <1387309071-22382-7-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Non-dts implementation supply required DMA channel numbers as
IORESOURCE_DMA. We can also get them from the device tree, if it
is present.

This patch updates device tree with the proper dmaengine-based
"marvell,pdma-1.0" DMA.

There is no actual data handling in this patch, because the existing
driver cannot get DMA channel number from dmaengine API. The patch
in the series will provide temporary workaround by manually parsing
node attributes, until Daniel's series is ready to be merged.

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Daniel Mack <zonque@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
   v2..v3
   * split into good (this one) and temporary (PATCH 07/21) parts

   v1..v2
   * add binding for next-gen dma controller
   * use correct dma declararion
   * number changed from 5 to 3

 Documentation/devicetree/bindings/mmc/pxa-mmc.txt |  5 +++++
 arch/arm/boot/dts/pxa27x.dtsi                     | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/pxa-mmc.txt b/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
index b7025de..9f54c69 100644
--- a/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
@@ -5,6 +5,8 @@ Driver bindings for the PXA MCI (MMC/SDIO) interfaces
 Required properties:
 - compatible: Should be "marvell,pxa-mmc".
 - vmmc-supply: A regulator for VMMC
+- dmas: Should be DMA specifiers for RX and TX
+- dma-names: Should be "rx" and "tx"
 
 Optional properties:
 - marvell,detect-delay-ms: sets the detection delay timeout in ms.
@@ -21,5 +23,8 @@ mmc0: mmc at 41100000 {
 	interrupts = <23>;
 	cd-gpios = <&gpio 23 0>;
 	wp-gpios = <&gpio 24 0>;
+	dmas = <&dma 21
+		&dma 22>;
+	dma-names = "rx", "tx";
 };
 
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 44df554..c2a90c5 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -11,10 +11,24 @@
 			marvell,intc-nr-irqs = <34>;
 		};
 
+		dma: dma-controller at 40000000 {
+			compatible = "marvell,pdma-1.0";
+			reg = <0x40000000 0x10000>;
+			interrupts = <25>;
+			#dma-cells = <1>;
+			dma-channels = <32>;
+		};
+
 		gpio: gpio at 40e00000 {
 			compatible = "intel,pxa27x-gpio";
 			interrupts = <8>, <9>, <10>;
 			interrupt-names = "gpio0", "gpio1", "gpio_mux";
 		};
+
+		mmc at 41100000 {
+			dmas = <&dma 21
+				&dma 22>;
+			dma-names = "rx", "tx";
+		};
 	};
 };
-- 
1.8.4.2
