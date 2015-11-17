From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 17:17:39 +0100
Subject: [PATCH] [MEDIA] dvb: usb: fix dib3000mc dependencies
Message-ID: <3984729.n55BH9Zr8c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dibusb_read_eeprom_byte function is defined in dibusb-common.c,
but that file is not compiled for CONFIG_DVB_USB_DIBUSB_MB as it
is for the other driver using the common functions, so we can
get a link error:

drivers/built-in.o: In function `dibusb_dib3000mc_tuner_attach':
(.text+0x2c5124): undefined reference to `dibusb_read_eeprom_byte'
(.text+0x2c5134): undefined reference to `dibusb_read_eeprom_byte'

This changes the Makefile to treat the file like all the others
in this directory, and enforce building dvb-usb-dibusb-common.o
as a dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/media/usb/dvb-usb/Makefile b/drivers/media/usb/dvb-usb/Makefile
index 8da26352f73b..048ab0b6c36d 100644
--- a/drivers/media/usb/dvb-usb/Makefile
+++ b/drivers/media/usb/dvb-usb/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_DVB_USB_DTT200U) += dvb-usb-dtt200u.o
 dvb-usb-dibusb-common-objs := dibusb-common.o
 
 dvb-usb-dibusb-mc-common-objs := dibusb-mc-common.o
-obj-$(CONFIG_DVB_USB_DIB3000MC)	+= dvb-usb-dibusb-mc-common.o
+obj-$(CONFIG_DVB_USB_DIB3000MC)	+= dvb-usb-dibusb-common.o dvb-usb-dibusb-mc-common.o
 
 dvb-usb-a800-objs := a800.o
 obj-$(CONFIG_DVB_USB_A800) += dvb-usb-dibusb-common.o dvb-usb-a800.o
