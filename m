From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 22 May 2014 16:48:35 +0300
Subject: [Patch v5 6/7] ARM: dts: keystone: update reset node to work with
 reset driver
In-Reply-To: <1400766516-14537-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400766516-14537-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1400766516-14537-7-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pll controller register set and device state control registers
include sets of registers with different purposes, so it's logically
to add syscon entry to be able to access them from appropriate places.

So added pll controller and device state control syscon entries.

The keystone driver requires the next additional properties:

"ti,syscon-pll" - phandle/offset pair. The phandle to syscon used to
		  access pll controller registers and the offset to use
		  reset control registers.

"ti,syscon-dev" - phandle/offset pair. The phandle to syscon used to
		  access device state control registers and the offset
		  in order to use mux block registers for all watchdogs.

"ti,wdt_list"	- option to declare what watchdogs are used to reboot
		  the SoC, so set "0" WDT as default.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index d9f99e7..12f66dd 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -66,9 +66,21 @@
 		ranges = <0x0 0x0 0x0 0xc0000000>;
 		dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
 
+		pllctrl: pll-controller {
+			compatible = "ti,keystone-pllctrl", "syscon";
+			reg = <0x02310000 0x200>;
+		};
+
+		devctrl: device-state-control {
+			compatible = "ti,keystone-devctrl", "syscon";
+			reg = <0x02620000 0x1000>;
+		};
+
 		rstctrl: reset-controller {
 			compatible = "ti,keystone-reset";
-			reg = <0x023100e8 4>;	/* pll reset control reg */
+			ti,syscon-pll = <&pllctrl 0xe4>;
+			ti,syscon-dev = <&devctrl 0x328>;
+			ti,wdt_list = <0>;
 		};
 
 		/include/ "keystone-clocks.dtsi"
-- 
1.8.3.2
