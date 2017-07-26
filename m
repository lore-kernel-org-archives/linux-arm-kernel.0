From: eric@anholt.net (Eric Anholt)
Date: Wed, 26 Jul 2017 13:01:56 -0700
Subject: [PATCH v2] ARM: dts: bcm283x: Move the BCM2837 DT contents from arm64
 to arm.
Message-ID: <20170726200156.30161-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BCM2837 is somewhat unusual in that we build its DT on both arm32 and
arm64.  Most devices are being run in arm32 mode.

Having the body of the DT for 2837 separate from 2835/6 has been a
source of pain, as we often need to make changes that span both
directories simultaneously (for example, the thermal changes for 4.13,
or anything that changes the name of a node referenced by '&' from
board files).  Other changes are made more complicated than they need
to be, such as the SDHOST enabling, because we have to split a single
logical change into a 283[56] half and a 2837 half.

To fix this, make the stub board include file live in arm64 instead of
arm32, and keep all of BCM283x's contents in arm32.  From here on, our
changes to DT contents can be submitted through a single tree.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Drop the .dtsi symlinks from arm64 -- they get successfully found
    by the .dtsi in arm/

 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              | 42 +++++++++++++++++++++-
 .../dts/broadcom => arm/boot/dts}/bcm2837.dtsi     |  0
 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi      |  1 -
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts   | 42 +---------------------
 .../boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi    |  1 -
 .../boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi    |  1 -
 arch/arm64/boot/dts/broadcom/bcm283x.dtsi          |  1 -
 7 files changed, 42 insertions(+), 46 deletions(-)
 rename arch/{arm64/boot/dts/broadcom => arm/boot/dts}/bcm2837.dtsi (100%)
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x.dtsi

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index c72a27d908b6..972f14db28ac 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -1 +1,41 @@
-#include "arm64/broadcom/bcm2837-rpi-3-b.dts"
+/dts-v1/;
+#include "bcm2837.dtsi"
+#include "bcm2835-rpi.dtsi"
+#include "bcm283x-rpi-smsc9514.dtsi"
+#include "bcm283x-rpi-usb-host.dtsi"
+
+/ {
+	compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
+	model = "Raspberry Pi 3 Model B";
+
+	memory {
+		reg = <0 0x40000000>;
+	};
+
+	leds {
+		act {
+			gpios = <&gpio 47 0>;
+		};
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+/* SDHCI is used to control the SDIO for wireless */
+&sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_gpio34>;
+	status = "okay";
+	bus-width = <4>;
+	non-removable;
+};
+
+/* SDHOST is used to drive the SD card */
+&sdhost {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhost_gpio48>;
+	status = "okay";
+	bus-width = <4>;
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm2837.dtsi
rename to arch/arm/boot/dts/bcm2837.dtsi
diff --git a/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi b/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
deleted file mode 120000
index 3937b77cb310..000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/bcm2835-rpi.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index 972f14db28ac..699d340a3437 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -1,41 +1 @@
-/dts-v1/;
-#include "bcm2837.dtsi"
-#include "bcm2835-rpi.dtsi"
-#include "bcm283x-rpi-smsc9514.dtsi"
-#include "bcm283x-rpi-usb-host.dtsi"
-
-/ {
-	compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
-	model = "Raspberry Pi 3 Model B";
-
-	memory {
-		reg = <0 0x40000000>;
-	};
-
-	leds {
-		act {
-			gpios = <&gpio 47 0>;
-		};
-	};
-};
-
-&uart1 {
-	status = "okay";
-};
-
-/* SDHCI is used to control the SDIO for wireless */
-&sdhci {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_gpio34>;
-	status = "okay";
-	bus-width = <4>;
-	non-removable;
-};
-
-/* SDHOST is used to drive the SD card */
-&sdhost {
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhost_gpio48>;
-	status = "okay";
-	bus-width = <4>;
-};
+#include "arm/bcm2837-rpi-3-b.dts"
diff --git a/arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi b/arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
deleted file mode 120000
index dca7c057d5a5..000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi b/arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
deleted file mode 120000
index cbeebe312ff8..000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/bcm283x-rpi-usb-host.dtsi
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/broadcom/bcm283x.dtsi b/arch/arm64/boot/dts/broadcom/bcm283x.dtsi
deleted file mode 120000
index 5f54e4cab99b..000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm283x.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/bcm283x.dtsi
\ No newline at end of file
-- 
2.13.3
