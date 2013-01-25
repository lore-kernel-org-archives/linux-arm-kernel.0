From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:24:00 +0900
Subject: [PATCH 24/80] ARM: shmobile: sh7372: Register PFC platform device
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-25-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add arch code to register the PFC platform device instead of calling the
driver directly. Platform device registration in the sh-pfc driver will
be removed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pfc-sh7372.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pfc-sh7372.c b/arch/arm/mach-shmobile/pfc-sh7372.c
index 7a1525f..dd5e145 100644
--- a/arch/arm/mach-shmobile/pfc-sh7372.c
+++ b/arch/arm/mach-shmobile/pfc-sh7372.c
@@ -22,6 +22,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/sh_pfc.h>
 #include <mach/irqs.h>
 #include <mach/sh7372.h>
@@ -1657,7 +1658,15 @@ static struct pinmux_info sh7372_pinmux_info = {
 	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
 };
 
+static struct platform_device sh7372_pfc_device = {
+	.name		= "sh-pfc",
+	.id		= -1,
+	.dev = {
+		.platform_data = &sh7372_pinmux_info,
+	},
+};
+
 void sh7372_pinmux_init(void)
 {
-	register_pinmux(&sh7372_pinmux_info);
+	platform_device_register(&sh7372_pfc_device);
 }
-- 
1.7.10.4
