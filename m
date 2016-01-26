From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jan 2016 15:09:55 +0100
Subject: [PATCH 1/7] [media] pwc: hide unused label
Message-ID: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwc driver causes a warning when CONFIG_USB_PWC_INPUT_EVDEV is unset:

drivers/media/usb/pwc/pwc-if.c: In function 'usb_pwc_probe':
drivers/media/usb/pwc/pwc-if.c:1115:1: warning: label 'err_video_unreg' defined but not used [-Wunused-label]

Obviously, the cleanup of &pdev->vdev is not needed without the input device,
so we can just move it inside of the existing #ifdef and remove the
extra label.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/usb/pwc/pwc-if.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index 086cf1c7bd7d..bdd416af84c7 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -1106,14 +1106,13 @@ static int usb_pwc_probe(struct usb_interface *intf, const struct usb_device_id
 	if (rc) {
 		input_free_device(pdev->button_dev);
 		pdev->button_dev = NULL;
-		goto err_video_unreg;
+		video_unregister_device(&pdev->vdev);
+		goto err_unregister_v4l2_dev;
 	}
 #endif
 
 	return 0;
 
-err_video_unreg:
-	video_unregister_device(&pdev->vdev);
 err_unregister_v4l2_dev:
 	v4l2_device_unregister(&pdev->v4l2_dev);
 err_free_controls:
-- 
2.7.0
