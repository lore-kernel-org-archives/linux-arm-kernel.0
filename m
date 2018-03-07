From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 7 Mar 2018 12:28:28 +0100 (CET)
Subject: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial
 slave
In-Reply-To: <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-4-git-send-email-stefan.wahren@i2se.com>
 <84F7E645-59B4-4618-8C91-A5CD654E16A6@holtmann.org>
 <648118289.71086.1519593373795@email.1und1.de>
 <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org>
Message-ID: <438185389.274708.1520422108782@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcel,

> Marcel Holtmann <marcel@holtmann.org> hat am 25. Februar 2018 um 22:38 geschrieben:
> 
> 
> Hi Stefan,
> 
> >>> Add BCM43438 (bluetooth) as a serdev slave device of uart0 (pl011/ttyAMA0).
> >>> This allows to automatically insert the bcm43438 to the bluetooth
> >>> subsystem instead of relying on patched userspace helpers (hciattach).
> >>> 
> >>> In order to keep a debug UART we need to switch to uart1.
> >>> 
> >>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >>> ---
> >>> arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 14 +++++++++++++-
> >>> 1 file changed, 13 insertions(+), 1 deletion(-)
> >>> 
> >>> diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> >>> index cf53436..b7f79f1 100644
> >>> --- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> >>> +++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> >>> @@ -131,6 +131,18 @@
> >>> 
> >>> &uart0 {
> >>> 	pinctrl-names = "default";
> >>> -	pinctrl-0 = <&uart0_gpio14>;
> >>> +	pinctrl-0 = <&uart0_gpio32 &uart0_ctsrts_gpio30>;
> >>> +	status = "okay";
> >>> +
> >>> +	bluetooth {
> >>> +		compatible = "brcm,bcm43438-bt";
> >>> +		max-speed = <2000000>;
> >>> +		shutdown-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
> >>> +	};
> >>> +};
> >> 
> >> is the shutdown GPIO working as expected with this hardware. So even module unload and reload works fine?
> > 
> > Yes, unload and reload works fine. 
> > 
> >> Meaning we are getting back to the 115200 default baud rate on the UART?
> > 
> > I assume that, because reload works as expected. 
> 
> awesome. That is good news.
> 
> Since you said that the GPIO expander driver for the RPi 3 has been accepted, did you test it there as well? If so, then it would be good to get a patch that also provides shutdown-gpios for RPi 3.

after applying Loic's patch and the necessary patch for the RPi 3 dts file (see below), i will get this output:

[    4.873246] Bluetooth: HCI UART driver ver 2.3
[    4.873260] Bluetooth: HCI UART protocol H4 registered
[    4.873265] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    4.873751] Bluetooth: HCI UART protocol Broadcom registered
[    4.877279] uart-pl011 3f201000.serial: no DMA platform data
[    6.952382] Bluetooth: hci0: command 0xfc18 tx timeout
[   15.192298] Bluetooth: hci0: BCM: failed to write update baudrate (-110)
[   15.192312] Bluetooth: hci0: Failed to set baudrate
[   15.316415] Bluetooth: hci0: BCM: chip id 94
[   15.318567] Bluetooth: hci0: BCM: features 0x2e
[   15.341538] Bluetooth: hci0: BCM43430A1
[   15.341560] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
[   19.112670] Bluetooth: hci0: BCM (001.002.009) build 0360
[  274.713732] Bluetooth: hci0: command 0x0c14 tx timeout
[  274.714085] Bluetooth: hci0: Frame reassembly failed (-84)
[  317.275941] Bluetooth: hci0: last event is not cmd complete (0x0f)

I don't see these errors on RPi Zero W. Maybe the reason for this is the lack of hardware flowcontrol on RPi 3. Or some of the downstream patches on BlueZ must be adapted for the kernel [1].

Btw the bcm43438 is detected even after unloading and reloading the driver. But the timeout occurs also on driver reload. Reducing the baudrate to 115200 doesn't help here.

Sorry in case this patch gets corrupted by my webmailer.

Stefan

[1] - https://gist.github.com/pelwell/c8230c48ea24698527cd

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index 0b31d99..3e87ed0 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -20,9 +20,14 @@
 
 	leds {
 		act {
-			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
+			gpios = <&expgpio 2 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&expgpio 1 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &firmware {
@@ -42,6 +47,10 @@
 	};
 };
 
+&hdmi {
+	hpd-gpios = <&expgpio 4 GPIO_ACTIVE_LOW>;
+};
+
 /* uart0 communicates with the BT module */
 &uart0 {
 	pinctrl-names = "default";
@@ -51,6 +60,7 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		max-speed = <2000000>;
+		shutdown-gpios = <&expgpio 0 GPIO_ACTIVE_HIGH>;
 	};
 };
 
@@ -63,11 +73,19 @@
 
 /* SDHCI is used to control the SDIO for wireless */
 &sdhci {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_gpio34>;
 	status = "okay";
 	bus-width = <4>;
 	non-removable;
+	mmc-pwrseq = <&wifi_pwrseq>;
+
+	brcmf: wifi at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
 };
 
 /* SDHOST is used to drive the SD card */

> 
> Regards
> 
> Marcel
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
