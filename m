From: viliam.mateicka@gmail.com (Viliam Mateicka)
Date: Thu, 16 Jun 2011 10:04:36 +0200
Subject: [PATCH] s3c2410_udc: fix custom UDC command handling
Message-ID: <BANLkTin2w5muF+LV269DV1=L+_j8P6DT_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a bug in Samsung's UDC driver, which is completely disabling
the USB device when a custom UDC command is used.
Following patch seems to get the right?behavior (e.g. enabling pull-up
instead of disabling then Vcc is applied). Also I'm not in mailing
list so please CC me.

Greetingz,
Vilo

Signed-off-by: Viliam Mateicka <viliam.mateicka@gmail.com>

--- drivers/usb/gadget/s3c2410_udc.c.orig ? ? ? 2011-05-19
06:06:34.000000000 +0200
+++ drivers/usb/gadget/s3c2410_udc.c ? ?2011-06-16 08:57:19.000000000 +0200
@@ -1566,7 +1566,7 @@ static void s3c2410_udc_command(enum s3c
? ? ? ? ? ? ? ? return;
? ? ? ? if (udc_info->udc_command) {
- ? ? ? ? ? ? ? udc_info->udc_command(S3C2410_UDC_P_DISABLE);
+ ? ? ? ? ? ? ? udc_info->udc_command(cmd);
? ? ? ? } else if (gpio_is_valid(udc_info->pullup_pin)) {
? ? ? ? ? ? ? ? int value;
