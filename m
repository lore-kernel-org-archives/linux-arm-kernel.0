From: stefan@olimex.com (Stefan Mavrodiev)
Date: Tue, 22 Aug 2017 14:43:11 +0300
Subject: [PATCH 1/3] ARM: dts: sun7i: Fix A20-OLinuXino-MICRO dts for use with
 LAN8710
In-Reply-To: <20170822114313.9038-1-stefan@olimex.com>
References: <20170822114313.9038-1-stefan@olimex.com>
Message-ID: <20170822114313.9038-2-stefan@olimex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From revision J the board uses new phy chip LAN8710. Compared
with RTL8201, RA17 pin is TXERR. It has pullup which causes phy
not to work. To fix this, PA17 must be configured output-low.

This patch is compatible with earlier board revisions, since this
pin wasn't connected to phy.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 0b7403e4d687..578c761b551a 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -102,7 +102,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_mii_a>;
+	pinctrl-0 = <&gmac_pins_mii_a>,<&gmac_txerr_pin>;
 	phy = <&phy1>;
 	phy-mode = "mii";
 	status = "okay";
@@ -229,6 +229,11 @@
 };
 
 &pio {
+	gmac_txerr_pin: gmac_txerr_pin at 0 {
+		pins = "PA17";
+		function = "gpio_out"
+	};
+
 	mmc3_cd_pin_olinuxinom: mmc3_cd_pin at 0 {
 		pins = "PH11";
 		function = "gpio_in";
-- 
2.11.0
