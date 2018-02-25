From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 25 Feb 2018 15:10:54 +0100
Subject: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial slave
In-Reply-To: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1519567855-26105-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add BCM43438 (bluetooth) as a serdev slave device of uart0 (pl011/ttyAMA0).
This allows to automatically insert the bcm43438 to the bluetooth
subsystem instead of relying on patched userspace helpers (hciattach).

In order to keep a debug UART we need to switch to uart1.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
index cf53436..b7f79f1 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -131,6 +131,18 @@
 
 &uart0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_gpio14>;
+	pinctrl-0 = <&uart0_gpio32 &uart0_ctsrts_gpio30>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <2000000>;
+		shutdown-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_gpio14>;
 	status = "okay";
 };
-- 
2.7.4
