From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:24:06 +0900
Subject: [PATCH 30/80] sh: sh7203: Register PFC platform device
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-31-git-send-email-horms+renesas@verge.net.au>
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
 arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index babc2b8..023b2ad 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -276,6 +276,7 @@ config CPU_SUBTYPE_SH7203
 	select SYS_SUPPORTS_CMT
 	select SYS_SUPPORTS_MTU2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 
 config CPU_SUBTYPE_SH7206
 	bool "Support SH7206 processor"
diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
index c465af7..814926e 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7203.h>
 
 enum {
@@ -1592,6 +1593,6 @@ static struct pinmux_info sh7203_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7203_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7203_pinmux_info);
 }
 arch_initcall(plat_pinmux_setup);
-- 
1.7.10.4
