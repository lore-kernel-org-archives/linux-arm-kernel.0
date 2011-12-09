From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 9 Dec 2011 15:02:38 +0100
Subject: [PATCH v2 07/10] arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
In-Reply-To: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
Message-ID: <1323439361-1647-8-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update pandaboard dts file with required clock frequencies
for the i2c client devices existing on pandaboard.

Add the twl6030 node in i2c1 controller.

This is the minimal support needed to boot OMAP4 boards
without any crash.
The support for all the features included in this MFD will be
added later.

Add a generic i2c EEPROM entry.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap4-panda.dts |   45 +++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 9755ad5..b66bcd6 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -18,3 +18,48 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	/*
+	 * Integrated Power Management Chip
+	 * http://www.ti.com/lit/ds/symlink/twl6030.pdf
+	 */
+	twl at 48 {
+		compatible = "ti,twl6030";
+		reg = <0x48>;
+		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
+		interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&gic>;
+
+		/* twl is a MFD, so it will contain a bunch of sub-ips */
+		rtc {
+			compatible = "ti,twl4030-rtc";
+			interrupts = <11>;
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+
+	/*
+	 * Display monitor features are burnt in their EEPROM as EDID data.
+	 * The EEPROM is connected as I2C slave device.
+	 */
+	eeprom at 50 {
+		compatible = "ti,eeprom";
+		reg = <0x50>;
+	};
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+};
-- 
1.7.0.4
