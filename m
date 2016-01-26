From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jan 2016 17:17:24 +0100
Subject: [PATCH] [SUBMITTED] [media] pwc: hide unused label
Message-ID: <1453825059-3339577-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwc driver causes a warning when CONFIG_USB_PWC_INPUT_EVDEV is unset:

drivers/media/usb/pwc/pwc-if.c: In function 'usb_pwc_probe':
drivers/media/usb/pwc/pwc-if.c:1115:1: warning: label 'err_video_unreg' defined but not used [-Wunused-label]

This moves the unused label and code inside another #ifdef to
get rid of the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/usb/pwc/pwc-if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index 086cf1c7bd7d..432554d07e6e 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -1112,8 +1112,10 @@ static int usb_pwc_probe(struct usb_interface *intf, const struct usb_device_id
 
 	return 0;
 
+#ifdef CONFIG_USB_PWC_INPUT_EVDEV
 err_video_unreg:
 	video_unregister_device(&pdev->vdev);
+#endif
 err_unregister_v4l2_dev:
 	v4l2_device_unregister(&pdev->v4l2_dev);
 err_free_controls:
-- 
2.7.0
