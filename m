From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  7 Oct 2016 10:52:17 +0200
Subject: [PATCH] ARM: dts: fix the SD card on the Snowball
Message-ID: <1475830337-13016-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a very annoying regression on the Snowball SD card
that has been around for a while. It turns out that the device
tree does not configure the direction pins properly, nor sets
up the pins for the voltage converter properly at boot. Unless
all things are correctly set up, the feedback clock will not
work, and makes the driver spew messages in the console (but
it works, very slowly):

root at Ux500:/ mount /dev/mmcblk0p2 /mnt/
[    9.953460] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[    9.960296] mmcblk0: error -110 sending status command, retrying
[    9.966461] mmcblk0: error -110 sending status command, retrying
[    9.972534] mmcblk0: error -110 sending status command, aborting

Fix this by rectifying the device tree to correspond to that of
the Ux500 HREF boards plus the DAT31DIR setting that is unique for
the Snowball, and things start working smoothly. Add in the SDR12
and SDR25 modes which this host can do without any problems.

I don't know if this has ever been correct, sadly. It works after
this patch.

Cc: stable at vger.kernel.org
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for fixes.
---
 arch/arm/boot/dts/ste-snowball.dts | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index b3df1c60d465..386eee6de232 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -239,14 +239,25 @@
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <100000000>;
 			bus-width = <4>;
+			cap-sd-highspeed;
 			cap-mmc-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			/* All direction control is used */
+			st,sig-dir-cmd;
+			st,sig-dir-dat0;
+			st,sig-dir-dat2;
+			st,sig-dir-dat31;
+			st,sig-pin-fbclk;
+			full-pwr-cycle;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 			vqmmc-supply = <&vmmci>;
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdi0_default_mode>;
 			pinctrl-1 = <&sdi0_sleep_mode>;
 
-			cd-gpios  = <&gpio6 26 GPIO_ACTIVE_LOW>; // 218
+			/* GPIO218 MMC_CD */
+			cd-gpios  = <&gpio6 26 GPIO_ACTIVE_LOW>;
 
 			status = "okay";
 		};
@@ -549,7 +560,7 @@
 					/* VMMCI level-shifter enable */
 					snowball_cfg3 {
 						pins = "GPIO217_AH12";
-						ste,config = <&gpio_out_lo>;
+						ste,config = <&gpio_out_hi>;
 					};
 					/* VMMCI level-shifter voltage select */
 					snowball_cfg4 {
-- 
2.7.4
