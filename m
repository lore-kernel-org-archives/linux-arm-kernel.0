From: fparent@baylibre.com (Fabien Parent)
Date: Tue, 17 Jan 2017 13:57:42 +0100
Subject: [PATCH] ARM: davinci: da850-evm: fix read access to SPI flash
Message-ID: <20170117125742.9536-1-fparent@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read access to the SPI flash are broken on da850-evm, i.e. the data
read is not what is actually programmed on the flash.
According to the datasheet for the M25P64 part present on the da850-evm,
if the SPI frequency is higher than 20MHz then the READ command is not
usable anymore and only the FAST_READ command can be used to read data.

This commit specifies in the DTS that we should use FAST_READ command
instead of the READ command.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 41de15fe15a2..78492a0bbbab 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -99,6 +99,7 @@
 				#size-cells = <1>;
 				compatible = "m25p64";
 				spi-max-frequency = <30000000>;
+				m25p,fast-read;
 				reg = <0>;
 				partition at 0 {
 					label = "U-Boot-SPL";
-- 
2.11.0
