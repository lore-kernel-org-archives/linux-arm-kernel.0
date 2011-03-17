From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Mar 2011 22:52:32 -0300
Subject: [PATCH 2/4] ARM: mx5/babbage: Use gpio_request_one in
	babbage_usbhub_reset
In-Reply-To: <1300326754-4629-1-git-send-email-festevam@gmail.com>
References: <1300326754-4629-1-git-send-email-festevam@gmail.com>
Message-ID: <1300326754-4629-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code inside babbage_usbhub_reset uses gpio_direction_output with initial value of the GPIO and also sets 
the GPIO value via gpio_set_value to the same level right after. This is not needed. 

By using gpio_request_one it is possible to set the direction and initial value in one shot.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index ff79395..cba8307 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -209,17 +209,14 @@ static inline void babbage_usbhub_reset(void)
 	int ret;
 
 	/* Bring USB hub out of reset */
-	ret = gpio_request(BABBAGE_USB_HUB_RESET, "GPIO1_7");
+	ret = gpio_request_one(BABBAGE_USB_HUB_RESET, 
+					GPIOF_OUT_INIT_LOW, "GPIO1_7");
 	if (ret) {
 		printk(KERN_ERR"failed to get GPIO_USB_HUB_RESET: %d\n", ret);
 		return;
 	}
-	gpio_direction_output(BABBAGE_USB_HUB_RESET, 0);
 
-	/* USB HUB RESET - De-assert USB HUB RESET_N */
-	msleep(1);
-	gpio_set_value(BABBAGE_USB_HUB_RESET, 0);
-	msleep(1);
+	msleep(2);
 	gpio_set_value(BABBAGE_USB_HUB_RESET, 1);
 }
 
-- 
1.6.0.4
