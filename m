From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Jun 2015 16:47:39 +0200
Subject: [PATCH] ARM: ep93xx: toss the device ID into the entropy pool
Message-ID: <1434638859-27381-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't hurt to add this random stuff into the entropy pool
as is custom to do with device-unique numbers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ep93xx/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 5e2151bcc0c5..c393b1b0310d 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -37,6 +37,7 @@
 #include <linux/irqchip/arm-vic.h>
 #include <linux/reboot.h>
 #include <linux/usb/ohci_pdriver.h>
+#include <linux/random.h>
 
 #include <mach/hardware.h>
 #include <linux/platform_data/video-ep93xx.h>
@@ -862,6 +863,12 @@ static const char __init *ep93xx_get_soc_id(void)
 	if (id != id2)
 		return "invalid";
 
+	/* Toss the unique ID into the entropy pool */
+	add_device_randomness(&id2, 4);
+	add_device_randomness(&id3, 4);
+	add_device_randomness(&id4, 4);
+	add_device_randomness(&id5, 4);
+
 	snprintf(ep93xx_soc_id, sizeof(ep93xx_soc_id),
 		 "%08x%08x%08x%08x", id2, id3, id4, id5);
 
-- 
1.9.3
