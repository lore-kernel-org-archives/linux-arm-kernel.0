From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Mon, 4 Mar 2013 18:29:15 +0530
Subject: [PATCH v2 4/4] ARM: davinci: da850-evm: add SPI flash support
In-Reply-To: <1362401955-9616-1-git-send-email-prakash.pm@ti.com>
References: <1362401955-9616-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1362401955-9616-5-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable m25p64 SPI flash support on da850-EVM. Also
add partition information of SPI flash.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Since v1:
Look for m25p64 instead of m25p80.
Corrected the filesystem partition information.

 arch/arm/boot/dts/da850-evm.dts |   40 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index c359872..3306d82 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -41,6 +41,46 @@
 		wdt: wdt at 1c21000 {
 			status = "okay";
 		};
+		spi1: spi at 1f0e000 {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_pins>;
+			flash: m25p80 at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "m25p64";
+				spi-max-frequency = <30000000>;
+				reg = <0>;
+				partition at 0 {
+					label = "U-Boot-SPL";
+					reg = <0x00000000 0x00010000>;
+					read-only;
+				};
+				partition at 1 {
+					label = "U-Boot";
+					reg = <0x00010000 0x00080000>;
+					read-only;
+				};
+				partition at 2 {
+					label = "U-Boot-Env";
+					reg = <0x00090000 0x00010000>;
+					read-only;
+				};
+				partition at 3 {
+					label = "Kernel";
+					reg = <0x000a0000 0x00280000>;
+				};
+				partition at 4 {
+					label = "Filesystem";
+					reg = <0x00320000 0x00400000>;
+				};
+				partition at 5 {
+					label = "MAC-Address";
+					reg = <0x00720000 0x00010000>;
+					read-only;
+				};
+			};
+		};
 	};
 	nand_cs3 at 62000000 {
 		status = "okay";
-- 
1.7.4.1
