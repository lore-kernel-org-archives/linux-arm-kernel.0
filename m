From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Mar 2016 17:00:36 +0100
Subject: [PATCH 8/8] ARM: dts: sun8i: Add eMMC dt node on Orangepi Plus boards
In-Reply-To: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
References: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1458489636-2825-9-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orangepi Plus has a 16GB eMMC, the vcc, the lack of pull-ups and
the use of the hw-reset pin have all been verified with the board
schematic.

With this dts node for mmc2, the eMMC runs at the following ios settings:
clock:          52000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    8 (mmc DDR52)
signal voltage: 0 (3.30 V)
driver type:    0 (driver type B)

Note the mmcblk1boot0/boot1 partitions are unused as the BROM will load
the SPL from 8k from the start of the main blockdev, just as with a
regular sdcard in mmc0.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index f5aa694..7129aff 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -192,6 +192,23 @@
 	status = "okay";
 };
 
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&mmc2_8bit_pins {
+	/* Increase drive strength for DDR modes */
+	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
+	/* eMMC is missing pull-ups */
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
 &reg_usb1_vbus {
 	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
 	status = "okay";
-- 
2.7.3
