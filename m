From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:33 +0900
Subject: [PATCH 037/142] sh: sh7757: Add pin control resources
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-38-git-send-email-horms+renesas@verge.net.au>
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
 arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
index cda6bd1..567745d 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
@@ -13,12 +13,23 @@
  * for more details.
  */
 
+#include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/ioport.h>
 #include <cpu/pfc.h>
 
+static struct resource sh7757_pfc_resources[] = {
+	[0] = {
+		.start	= 0xffec0000,
+		.end	= 0xffec008f,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 static int __init plat_pinmux_setup(void)
 {
-	return sh_pfc_register("pfc-sh7757", NULL, 0);
+	return sh_pfc_register("pfc-sh7757", sh7757_pfc_resources,
+			       ARRAY_SIZE(sh7757_pfc_resources));
 }
 arch_initcall(plat_pinmux_setup);
-- 
1.7.10.4
