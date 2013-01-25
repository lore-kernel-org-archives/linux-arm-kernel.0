From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:24:13 +0900
Subject: [PATCH 37/80] sh: sh7734: Register PFC platform device
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-38-git-send-email-horms+renesas@verge.net.au>
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
 arch/sh/Kconfig                         |    1 +
 arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 1885213..7a7d2ec 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -456,6 +456,7 @@ config CPU_SUBTYPE_SH7734
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_ARCH_HAS_OHCI
 	select USB_ARCH_HAS_EHCI
+	select PINCTRL
 	help
 	  Select SH7734 if you have a SH4A SH7734 CPU.
 
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c
index eed3b9d..fa33583 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/ioport.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7734.h>
 
 #define CPU_32_PORT(fn, pfx, sfx)				\
@@ -2467,9 +2468,6 @@ static struct resource sh7734_pfc_resources[] = {
 static struct pinmux_info sh7734_pinmux_info = {
 	.name = "sh7734_pfc",
 
-	.resource = sh7734_pfc_resources,
-	.num_resources = ARRAY_SIZE(sh7734_pfc_resources),
-
 	.unlock_reg = 0xFFFC0000,
 
 	.reserved_id = PINMUX_RESERVED,
@@ -2492,6 +2490,8 @@ static struct pinmux_info sh7734_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7734_pinmux_info);
+	return sh_pfc_register_info(NULL, sh7734_pfc_resources,
+				    ARRAY_SIZE(sh7734_pfc_resources),
+				    &sh7734_pinmux_info);
 }
 arch_initcall(plat_pinmux_setup);
-- 
1.7.10.4
