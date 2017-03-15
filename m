From: npcomplete13@gmail.com (Vivek Unune)
Date: Wed, 15 Mar 2017 11:00:33 -0400
Subject: [PATCH] ARM: dts: BCM5301X: Add support for Linksys EA9500
Message-ID: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hardware Info
-------------

Processor	- Broadcom BCM4709C0KFEBG dual-core @ 1.4 GHz
Switch		- BCM53012 in BCM4709C0KFEBG & external BCM53125
DDR3 RAM	- 256 MB
Flash		- 128 MB (Toshiba TC58BVG0S3HTA00)
2.4GHz		- BCM4366 4?4 2.4/5G single chip 802.11ac SoC
Power Amp	- Skyworks SE2623L 2.4 GHz power amp (x4)
5GHz x 2	- BCM4366 4?4 2.4/5G single chip 802.11ac SoC
Power Amp	- PLX Technology PEX8603 3-lane, 3-port PCIe switch
Ports		- 8 Ports, 1 WAN Ports
Antennas	- 8 Antennas
Serial Port	- @J6 [GND,TX,RX] (VCC NC)    115200 8n1

I was able to test this with Lede with following quirks.

- Broadcom 4366c0 wireless chip is used and it's firmware package doesn't
  exist yet. I was able to test it with firmware that came buried in the
  router's dhd.ko
- CPU is connected to port 5
- It has two switches in order to support 8 lan ports. Internal switch is
  BCM53012. The external switch BCM53125 currently works as "dumb switch"
- Using 8 bit ECC gives errors, switching to 1 bit ECC solved the issue
- It uses dual firmware (trx) copies for failsafe purposes.

Installation
------------

Linksys gpg-signs their firmware for this router, hence it is not
possible to install using Factory UI.

This router needs serial cable hooked up to J6. Then interrupt the boot
   process by Ctrl+C to enter CFE prompt
   From there execute:
        `flash -noheader 192.168.1.10:/lede.trx nflash0.trx`
   where 192.168.1.10 is where your tftp server should is running.
You may want to reset partial boots using
  `nvram set partialboot=0 && nvram commit' while at CFE prompt.

TODO
----

- Add BCM53125 (secondary switch) to dts
- Add robo_reset gpio (pin# 10 active low) to dts

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts | 97 ++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index b6750f7..75537ed 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -7,7 +7,7 @@
 /dts-v1/;
 
 #include "bcm47094.dtsi"
-#include "bcm5301x-nand-cs0-bch8.dtsi"
+#include "bcm5301x-nand-cs0-bch1.dtsi"
 
 / {
 	compatible = "linksys,panamera", "brcm,bcm47094", "brcm,bcm4708";
@@ -32,5 +32,100 @@
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
+
+		rfkill {
+		label = "WiFi";
+		linux,code = <KEY_RFKILL>;
+		gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
+		};
+
+		reset {
+		label = "Reset";
+		linux,code = <KEY_RESTART>;
+		gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		wps {
+		label = "bcm53xx:white:wps";
+		gpios = <&chipcommon 22 GPIO_ACTIVE_LOW>;
+		};
+
+		usb2 {
+		label = "bcm53xx:green:usb2";
+		gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
+		};
+
+		usb3 {
+		label = "bcm53xx:green:usb3";
+		gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
+		};
+
+		power {
+		label = "bcm53xx:white:power";
+		gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		wifi-disabled {
+		label = "bcm53xx:amber:wifi-disabled";
+		gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
+		};
+
+		wifi-enabled {
+		label = "bcm53xx:white:wifi-enabled";
+		gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar1 {
+		label = "bcm53xx:white:bluebar1";
+		gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar2 {
+		label = "bcm53xx:white:bluebar2";
+		gpios = <&chipcommon 12 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar3 {
+		label = "bcm53xx:white:bluebar3";
+		gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
+		};
+
+		bluebar4 {
+		label = "bcm53xx:white:bluebar4";
+		gpios = <&chipcommon 18 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar5 {
+		label = "bcm53xx:white:bluebar5";
+		gpios = <&chipcommon 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar6 {
+		label = "bcm53xx:white:bluebar6";
+		gpios = <&chipcommon 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar7 {
+		label = "bcm53xx:white:bluebar7";
+		gpios = <&chipcommon 21 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar8 {
+		label = "bcm53xx:white:bluebar8";
+		gpios = <&chipcommon 8 GPIO_ACTIVE_HIGH>;
+		};
+
 	};
 };
+
+&usb2 {
+	vcc-gpio = <&chipcommon 13 GPIO_ACTIVE_HIGH>;
+};
+
+&usb3 {
+	vcc-gpio = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
+};
-- 
2.7.4
