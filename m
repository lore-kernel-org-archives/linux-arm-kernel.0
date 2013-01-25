From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:58 +0900
Subject: [PATCH 22/80] ARM: shmobile: r8a7740: Register PFC platform device
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-23-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/mach-shmobile/pfc-r8a7740.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pfc-r8a7740.c b/arch/arm/mach-shmobile/pfc-r8a7740.c
index 134d1b9..8a412b1 100644
--- a/arch/arm/mach-shmobile/pfc-r8a7740.c
+++ b/arch/arm/mach-shmobile/pfc-r8a7740.c
@@ -20,6 +20,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/sh_pfc.h>
 #include <mach/r8a7740.h>
 #include <mach/irqs.h>
@@ -2611,7 +2612,15 @@ static struct pinmux_info r8a7740_pinmux_info = {
 	.gpio_irq_size	= ARRAY_SIZE(pinmux_irqs),
 };
 
+static struct platform_device r8a7740_pfc_device = {
+	.name		= "sh-pfc",
+	.id		= -1,
+	.dev = {
+		.platform_data = &r8a7740_pinmux_info,
+	},
+};
+
 void r8a7740_pinmux_init(void)
 {
-	register_pinmux(&r8a7740_pinmux_info);
+	platform_device_register(&r8a7740_pfc_device);
 }
-- 
1.7.10.4
