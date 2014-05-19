From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 19 May 2014 13:25:54 +0300
Subject: [Patch v3 4/5] ARM: dts: keystone: update reset node to work with
 reset driver
In-Reply-To: <1400495155-11136-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400495155-11136-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1400495155-11136-5-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset controller registers are part of the PLL Controller MMRs.
According to TRM there are the following registers:
RSTYPE, RSCTRL, RSCFG and RSISO. Currently declared only one of them,
but that is not enough to correctly setup reset properties, so add
whole range of pll registers - pllregs.

Also add range for reset multiplex registers for SoC on the device.
These registers are located in Bootcfg memory space and needed
to setup behaviour after appropriate watchdog is triggered.

Add "ti,wdt_list" option to declare what watchdog are used to reboot
the SoC.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 90823eb..9d6b850 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -69,7 +69,9 @@
 
 		rstctrl: reset-controller {
 			compatible = "ti,keystone-reset";
-			reg = <0x023100e8 4>;	/* pll reset control reg */
+			reg = <0x23100e4 0x10>, <0x2620328 0x10>;
+			reg-names = "pllregs", "muxregs";
+			ti,wdt_list = <0>;
 		};
 
 		/include/ "keystone-clocks.dtsi"
-- 
1.8.3.2
