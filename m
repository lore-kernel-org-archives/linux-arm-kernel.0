From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 23 Sep 2015 17:11:15 -0500
Subject: [PATCH 2/2] ARM: socfpga: dts: enable USB and I2C on Arria10 SoCDK
In-Reply-To: <1443046275-26421-1-git-send-email-dinguyen@opensource.altera.com>
References: <1443046275-26421-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1443046275-26421-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

On the Arria10 Devkit, the I2C bus has a serial EEPROM and an RTC
hanging off it. Also, enable the USB node.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 99aa9a1..567df98 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -70,6 +70,33 @@
 	status = "okay";
 };
 
+&i2c1 {
+	speed-mode = <0>;
+	status = "okay";
+
+	/*
+	 * adjust the falling times to decrease the i2c frequency to 50Khz
+	 * because the LCD module does not work at the standard 100Khz
+	 */
+	i2c-sda-falling-time-ns = <6000>;
+	i2c-scl-falling-time-ns = <6000>;
+
+	eeprom at 51 {
+		compatible = "atmel,24c32";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+
+	rtc at 68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
+
 &uart1 {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+};
-- 
2.4.5
