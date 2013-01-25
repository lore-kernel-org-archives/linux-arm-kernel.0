From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:59 +0900
Subject: [PATCH 23/80] ARM: shmobile: r8a7779: Register PFC platform device
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-24-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/mach-shmobile/pfc-r8a7779.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-r8a7779.c b/arch/arm/mach-shmobile/pfc-r8a7779.c
index 9513234..3d333b1 100644
--- a/arch/arm/mach-shmobile/pfc-r8a7779.c
+++ b/arch/arm/mach-shmobile/pfc-r8a7779.c
@@ -19,6 +19,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/sh_pfc.h>
 #include <linux/ioport.h>
 #include <mach/r8a7779.h>
@@ -2616,9 +2617,6 @@ static struct resource r8a7779_pfc_resources[] = {
 static struct pinmux_info r8a7779_pinmux_info = {
 	.name = "r8a7779_pfc",
 
-	.resource = r8a7779_pfc_resources,
-	.num_resources = ARRAY_SIZE(r8a7779_pfc_resources),
-
 	.unlock_reg = 0xfffc0000, /* PMMR */
 
 	.reserved_id = PINMUX_RESERVED,
@@ -2639,7 +2637,17 @@ static struct pinmux_info r8a7779_pinmux_info = {
 	.gpio_data_size = ARRAY_SIZE(pinmux_data),
 };
 
+static struct platform_device r8a7779_pfc_device = {
+	.name		= "sh-pfc",
+	.id		= -1,
+	.resource	= r8a7779_pfc_resources,
+	.num_resources	= ARRAY_SIZE(r8a7779_pfc_resources),
+	.dev = {
+		.platform_data = &r8a7779_pinmux_info,
+	},
+};
+
 void r8a7779_pinmux_init(void)
 {
-	register_pinmux(&r8a7779_pinmux_info);
+	platform_device_register(&r8a7779_pfc_device);
 }
-- 
1.7.10.4
