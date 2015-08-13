From: eric@anholt.net (Eric Anholt)
Date: Thu, 13 Aug 2015 16:05:42 -0700
Subject: [PATCH v5 3/3] ARM: bcm2835: Add DT for the firmware clocks driver.
In-Reply-To: <1439507142-2965-1-git-send-email-eric@anholt.net>
References: <1439507142-2965-1-git-send-email-eric@anholt.net>
Message-ID: <1439507142-2965-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Lee Jones <lee@kernel.org>
---

v2: Rename our compat string to mention bcm2835, and make our firmware
    phandle be under a vendor-namespaced property.

v3: Squashed in the patches to reference the other clocks, to avoid
    regressions now that we register all clocks at boot.  Dropped
    Stephen's ack, since he hadn't acked the new EMMC change yet.

 arch/arm/boot/dts/bcm2835-rpi.dtsi | 18 ++++++++++++++++++
 arch/arm/boot/dts/bcm2835.dtsi     |  3 +--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index ab5474e..5d370cb 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,3 +1,4 @@
+#include <dt-bindings/clk/raspberrypi.h>
 #include "bcm2835.dtsi"
 
 / {
@@ -20,6 +21,12 @@
 			compatible = "raspberrypi,bcm2835-firmware";
 			mboxes = <&mailbox>;
 		};
+
+		firmware_clocks: firmware-clocks {
+			compatible = "raspberrypi,bcm2835-firmware-clocks";
+			#clock-cells = <1>;
+			raspberrypi,firmware = <&firmware>;
+		};
 	};
 };
 
@@ -55,4 +62,15 @@
 &sdhci {
 	status = "okay";
 	bus-width = <4>;
+	clocks = <&firmware_clocks RPI_CLOCK_EMMC>;
+};
+
+&uart0 {
+	clocks = <&firmware_clocks RPI_CLOCK_UART0>,
+		 <&firmware_clocks RPI_CLOCK_CORE>;
+	clock-names = "uartclk", "apb_pclk";
+};
+
+&spi {
+	clocks = <&firmware_clocks RPI_CLOCK_CORE>;
 };
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 301c73f..5be2862 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -92,11 +92,10 @@
 			#interrupt-cells = <2>;
 		};
 
-		uart at 7e201000 {
+		uart0: uart at 7e201000 {
 			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
 			reg = <0x7e201000 0x1000>;
 			interrupts = <2 25>;
-			clock-frequency = <3000000>;
 			arm,primecell-periphid = <0x00241011>;
 		};
 
-- 
2.1.4
