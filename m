From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 22:17:45 +0100
Subject: [PATCH 5/7] [media] gspca: add INPUT dependency
In-Reply-To: <1422479867-3370921-1-git-send-email-arnd@arndb.de>
References: <1422479867-3370921-1-git-send-email-arnd@arndb.de>
Message-ID: <1422479867-3370921-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gspca  driver uses the input_event infrastructure and fails
to link if that is not available:

drivers/built-in.o: In function `gspca_disconnect':
media/usb/gspca/gspca.c:2171: undefined reference to `input_unregister_device'
drivers/built-in.o: In function `gspca_dev_probe2':
media/usb/gspca/gspca.c:2112: undefined reference to `input_allocate_device'
media/usb/gspca/gspca.c:2112: undefined reference to `input_register_device'
media/usb/gspca/gspca.c:2112: undefined reference to `input_unregister_device'
media/usb/gspca/gspca.c:2112: undefined reference to `input_free_device'
drivers/built-in.o: In function `sd_int_pkt_scan':
media/usb/gspca/pac207.c:428: undefined reference to `input_event'
drivers/built-in.o: In function `sd_int_pkt_scan':
media/usb/gspca/pac7302.c:879: undefined reference to `input_event'
drivers/built-in.o: In function `sd_int_pkt_scan':
media/usb/gspca/se401.c:612: undefined reference to `input_event'
drivers/built-in.o: In function `sd_stop0':
media/usb/gspca/xirlink_cit.c:2742: undefined reference to `input_event'
drivers/built-in.o: In function `cit_check_button':
media/usb/gspca/xirlink_cit.c:2935: undefined reference to `input_event'
drivers/built-in.o:/git/arm-soc/include/linux/input.h:414: more undefined references to `input_event' follow

This adds an explicit dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/usb/gspca/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/gspca/Kconfig b/drivers/media/usb/gspca/Kconfig
index eed10d782535..2b23aad5a9f2 100644
--- a/drivers/media/usb/gspca/Kconfig
+++ b/drivers/media/usb/gspca/Kconfig
@@ -1,6 +1,7 @@
 menuconfig USB_GSPCA
 	tristate "GSPCA based webcams"
 	depends on VIDEO_V4L2
+	depends on INPUT
 	default m
 	---help---
 	  Say Y here if you want to enable selecting webcams based
-- 
2.1.0.rc2
