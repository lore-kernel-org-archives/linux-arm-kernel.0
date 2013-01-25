From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:24:09 +0900
Subject: [PATCH 33/80] sh: sh7720: Register PFC platform device
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-34-git-send-email-horms+renesas@verge.net.au>
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
 arch/sh/Kconfig                        |    1 +
 arch/sh/kernel/cpu/sh3/pinmux-sh7720.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index b934d7d..bfb8b3e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -367,6 +367,7 @@ config CPU_SUBTYPE_SH7720
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_ARCH_HAS_OHCI
 	select USB_OHCI_SH if USB_OHCI_HCD
+	select PINCTRL
 	help
 	  Select SH7720 if you have a SH3-DSP SH7720 CPU.
 
diff --git a/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c b/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
index 9ca1546..df0648f 100644
--- a/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7720.h>
 
 enum {
@@ -1236,7 +1237,7 @@ static struct pinmux_info sh7720_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7720_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7720_pinmux_info);
 }
 
 arch_initcall(plat_pinmux_setup);
-- 
1.7.10.4
