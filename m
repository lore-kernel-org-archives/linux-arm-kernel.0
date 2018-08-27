From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 27 Aug 2018 13:03:42 -0700
Subject: [PATCH 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
In-Reply-To: <20180827200344.16158-1-f.fainelli@gmail.com>
References: <20180827200344.16158-1-f.fainelli@gmail.com>
Message-ID: <20180827200344.16158-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the SFP connected to port 5 of the switch and wire up all GPIOs
to the SFP cage. Because of a hardware limitation of the i2c controller
on the iProc SoCs which prevents large i2c (> 256 bytes) transactions to
work, we use the i2c-gpio interface instead, which does not have that
limitation. This allows us to read the SFP module EEPROM, which would
not be possible otherwise since it exceeds that size during a single
read transfer.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm958625hr.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index ea3fc194f8f3..05751c895a0e 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -58,6 +58,24 @@
 		open-source;
 		priority = <200>;
 	};
+
+	/* Hardware I2C block has limitations on number of bytes it can
+	 * transfer, which breaks with SFP/SFF modules.
+	 */
+	i2c1: i2c1 {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpioa 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpioa 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	};
+
+	sfp: sfp {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c1>;
+		mod-def0-gpios = <&gpioa 28 GPIO_ACTIVE_LOW>;
+		los-gpios = <&gpioa 24 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&gpioa 30 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpios = <&gpioa 26 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &amac0 {
@@ -210,6 +228,17 @@
 			reg = <4>;
 		};
 
+		port at 5 {
+			label = "sfp";
+			phy-mode = "sgmii";
+			reg = <5>;
+			sfp = <&sfp>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
 		port at 8 {
 			ethernet = <&amac2>;
 			label = "cpu";
-- 
2.17.1
