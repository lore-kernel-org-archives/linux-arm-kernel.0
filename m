From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 18 Dec 2013 22:32:00 +0100
Subject: [PATCH V2 4/5] arm: shmobile: genmai: adapt dts to use native i2c
 driver
In-Reply-To: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1387402321-21866-5-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Switch from the gpio-driver to the shiny new native driver. Tested by
accessing the eeprom on the genmai board.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Magnus Damm <damm@opensource.se>
---

V2: fixed the eeprom label

 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 29 ++++++++++---------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index ce5da0b..5e9f41d 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -39,24 +39,6 @@
 			gpios = <&port4 11 GPIO_ACTIVE_LOW>;
 		};
 	};
-
-	i2c at 0 {
-		compatible = "i2c-gpio";
-		gpios = <&port1 5 GPIO_ACTIVE_HIGH /* sda */
-			 &port1 4 GPIO_ACTIVE_HIGH /* scl */
-			>;
-		i2c-gpio,sda-open-drain;
-		i2c-gpio,scl-open-drain;
-		i2c-gpio,delay-us = <5>;	/* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		flash at 50 {
-			compatible = "renesas,24c128";
-			reg = <0x50>;
-			pagesize = <64>;
-		};
-	};
 };
 
 &pfc {
@@ -68,3 +50,14 @@
 		renesas,function = "scif2";
 	};
 };
+
+&i2c2 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom at 50 {
+		compatible = "renesas,24c128";
+		reg = <0x50>;
+		pagesize = <64>;
+	};
+};
-- 
1.8.4.2
