From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:32 +0900
Subject: [PATCH 036/142] sh: sh7724: Add pin control resources
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-37-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add memory resources for the pin control platform device to let the
sh-pfc driver ioremap() registers properly instead of evily casting
register physical addresses to virtual addresses.

The memory resource address range has been extracted from the config and
data registes lists in the sh-pfc driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c
index 5c3541d..63be474 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c
@@ -13,12 +13,23 @@
  * for more details.
  */
 
+#include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/ioport.h>
 #include <cpu/pfc.h>
 
+static struct resource sh7724_pfc_resources[] = {
+	[0] = {
+		.start	= 0xa4050100,
+		.end	= 0xa405016f,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 static int __init plat_pinmux_setup(void)
 {
-	return sh_pfc_register("pfc-sh7724", NULL, 0);
+	return sh_pfc_register("pfc-sh7724", sh7724_pfc_resources,
+			       ARRAY_SIZE(sh7724_pfc_resources));
 }
 arch_initcall(plat_pinmux_setup);
-- 
1.7.10.4
