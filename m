From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Wed, 09 Sep 2015 15:04:11 +0200
Subject: Almost certainly confirmed, sun7i-a20 does not support 8 bit mmc.
Message-ID: <55F02E4B.70708@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey all,

After experimenting with a Micron eMMC chip, I made some interesting 
finds I wanted to share with you all.

For a while now, some had hopes or guessed that the A20 could have 
support for 8 bit wide bused on the SDC2. Reason for thinking this was, 
because the sun7i uses the same IP as the sun5i which does support 8 bit 
wide eMMC. The usermanual does mention 1/4/8 bit data buses and jedec 
4.3 support of the MMC spec. Unfortunately so far, it appears that the 
extra data pins have not been muxed out to the PC pads.

I used the following code to enable the extra pins on the A20:
                         mmc2_pins_a: mmc2 at 0 {
-                               allwinner,pins = "PC6", "PC7", "PC8",
-                                                "PC9", "PC10", "PC11";
+                               allwinner,pins = "PC6", "PC7",
+                                                "PC8", "PC9", "PC10", 
"PC11",
+                                                "PC12", "PC13", "PC14", 
"PC15";

and
         SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 12),
                   SUNXI_FUNCTION(0x0, "gpio_in"),
                   SUNXI_FUNCTION(0x1, "gpio_out"),
-                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ4 */
+                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ4 */
+                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D4 */
         SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 13),
                   SUNXI_FUNCTION(0x0, "gpio_in"),
                   SUNXI_FUNCTION(0x1, "gpio_out"),
-                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ5 */
+                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ5 */
+                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D5 */
         SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 14),
                   SUNXI_FUNCTION(0x0, "gpio_in"),
                   SUNXI_FUNCTION(0x1, "gpio_out"),
-                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ6 */
+                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ6 */
+                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D6 */
         SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 15),
                   SUNXI_FUNCTION(0x0, "gpio_in"),
                   SUNXI_FUNCTION(0x1, "gpio_out"),
-                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ7 */
+                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ7 */
+                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D7 */

which I think should be enough? Unfortunatly after booting i get the 
following:

[    0.971642] sunxi-mmc 1c11000.mmc: smc 1 err, cmd 8, RTO !!
[    0.981346] sunxi-mmc 1c11000.mmc: smc 1 err, cmd 55, RTO !!
[    0.987873] sunxi-mmc 1c11000.mmc: smc 1 err, cmd 55, RTO !!
[    0.988704] sunxi-mmc 1c11000.mmc: smc 1 err, cmd 55, RTO !!
[    0.989531] sunxi-mmc 1c11000.mmc: smc 1 err, cmd 55, RTO !!
[    1.020574] mmc1: MAN_BKOPS_EN bit is not set
(This I always get for some reason btw, so if somebody has a thought 
that'd be appreciated)

[    1.024234] sunxi-mmc 1c11000.mmc: smc 1 err, cmd 8, RD EBE !!
[    1.024265] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    1.024276] sunxi-mmc 1c11000.mmc: send stop command failed
[    1.024295] mmc1: switch to bus width 2 failed
[    1.028642] mmc1: new high speed MMC card at address 0001
[    1.029133] mmcblk1: mmc1:0001 P1XXXX 3.60 GiB
[    1.031071] mmcblk1boot0: mmc1:0001 P1XXXX partition 1 16.0 MiB
[    1.031207] mmcblk1boot1: mmc1:0001 P1XXXX partition 2 16.0 MiB
[    1.032305]  mmcblk1: p1 p2 p3

Hence, the controller fails to enable 8 bit mode. mmc1's ios confirms 
this afterwards:
/sys/kernel/debug/mmc1# cat ios
clock:          50000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    1 (mmc high-speed)
signal voltage: 0 (3.30 V)

On the upside, performance is pretty good however. Using a sequential dd 
test on the whole 4GB of storage to /dev/null and reading to a 3GB file 
from /dev/zero, I'm hitting 22 MB/s read and 13 MB/s write. The 
datasheet of the eMMC chip obviously has exotic values in the 75MB/s 
range, but compared to ~12 MB/s read/write from a regular 8gb 'class 10' 
SD card, and 4-6 MB/s read/write from the regular onboard NAND flash, 
this is pretty decent.

A photograph of the soldering handy work (not by me) can be seen at the 
linux-sunxi wiki [0].

Olliver

[0] http://linux-sunxi.org/File:Lime2_emmc.jpg
