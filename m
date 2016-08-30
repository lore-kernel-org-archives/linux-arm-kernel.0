From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 30 Aug 2016 22:52:50 +0200
Subject: [PATCH 3/3] ARM: dts: efm32: remove skeleton.dtsi include and fix
 unit address warnings
In-Reply-To: <20160830205250.15616-1-manabian@gmail.com>
References: <20160830205250.15616-1-manabian@gmail.com>
Message-ID: <20160830205250.15616-4-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removale of skeleton.dtsi allows us also to fix the following
warning from the dts compiler:
  Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

by adding proper unit addresses to the memory nodes. Also add missing
device_type to the memory node while at it.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi Uwe,

If you want I can take this through the lpc18xx tree. There doesn't seem
too be many patches for efm32 lately (last one dates from 2014).

 arch/arm/boot/dts/efm32gg-dk3750.dts | 5 +++--
 arch/arm/boot/dts/efm32gg.dtsi       | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
index 504cf45..98fc667 100644
--- a/arch/arm/boot/dts/efm32gg-dk3750.dts
+++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
@@ -16,7 +16,8 @@
 		bootargs = "console=ttyefm4,115200 init=/linuxrc ignore_loglevel ihash_entries=64 dhash_entries=64 earlyprintk uclinux.physaddr=0x8c400000 root=/dev/mtdblock0";
 	};
 
-	memory {
+	memory at 88000000 {
+		device_type = "memory";
 		reg = <0x88000000 0x400000>;
 	};
 
@@ -74,7 +75,7 @@
 			status = "ok";
 		};
 
-		boardfpga: boardfpga {
+		boardfpga: boardfpga at 80000000 {
 			compatible = "efm32board";
 			reg = <0x80000000 0x400>;
 			irq-gpios = <&gpio 64 1>;
diff --git a/arch/arm/boot/dts/efm32gg.dtsi b/arch/arm/boot/dts/efm32gg.dtsi
index d9dbf7f..b78c57e 100644
--- a/arch/arm/boot/dts/efm32gg.dtsi
+++ b/arch/arm/boot/dts/efm32gg.dtsi
@@ -5,11 +5,13 @@
  * http://www.silabs.com/Support%20Documents/TechnicalDocs/EFM32GG-RM.pdf
  */
 
-#include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include "dt-bindings/clock/efm32-cmu.h"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
-- 
2.9.3
