From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun,  6 Dec 2009 15:45:43 +0200
Subject: [PATCH] [ARM] pxa/em-x270: fix usb hub power up/reset sequence
Message-ID: <1260107143-11779-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/em-x270.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index aec7f42..86a8732 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -497,16 +497,15 @@ static int em_x270_usb_hub_init(void)
 		goto err_free_vbus_gpio;
 
 	/* USB Hub power-on and reset */
-	gpio_direction_output(usb_hub_reset, 0);
+	gpio_direction_output(usb_hub_reset, 1);
+	gpio_direction_output(GPIO9_USB_VBUS_EN, 0);
 	regulator_enable(em_x270_usb_ldo);
-	gpio_set_value(usb_hub_reset, 1);
 	gpio_set_value(usb_hub_reset, 0);
+	gpio_set_value(usb_hub_reset, 1);
 	regulator_disable(em_x270_usb_ldo);
 	regulator_enable(em_x270_usb_ldo);
-	gpio_set_value(usb_hub_reset, 1);
-
-	/* enable VBUS */
-	gpio_direction_output(GPIO9_USB_VBUS_EN, 1);
+	gpio_set_value(usb_hub_reset, 0);
+	gpio_set_value(GPIO9_USB_VBUS_EN, 1);
 
 	return 0;
 
-- 
1.6.4.4
