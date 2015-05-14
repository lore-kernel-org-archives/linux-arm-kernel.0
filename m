From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 May 2015 14:10:11 +0800
Subject: [RFC 7/7] ARM: dts: sun9i: Add secure SRAM node used for MCPM SMP
 hotplug
In-Reply-To: <1431583811-25780-1-git-send-email-wens@csie.org>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
Message-ID: <1431583811-25780-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 stores some magic flags in a portion of the secure SRAM. The
BROM jumps directly to the software entry point set by the SMP code
if the flags are set. This is required for CPU0 hotplugging.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 1507bd2a88f0..0695215634d4 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -366,6 +366,26 @@
 		 */
 		ranges = <0 0 0 0x20000000>;
 
+		sram_b: sram at 00020000 {
+			/* 256 KiB secure SRAM at 0x20000 */
+			compatible = "mmio-sram";
+			reg = <0x00020000 0x40000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x00020000 0x40000>;
+
+			smp-sram at 1000 {
+				/*
+				 * This is checked by BROM to determine if
+				 * cpu0 should jump to SMP entry vector
+				 */
+				compatible = "allwinner,sun9i-smp-sram";
+				reg = <0x1000 0x8>;
+			};
+		};
+
+
 		ehci0: usb at 00a00000 {
 			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
 			reg = <0x00a00000 0x100>;
-- 
2.1.4
