From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:24:10 +0900
Subject: [PATCH 34/80] sh: sh7722: Register PFC platform device
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-35-git-send-email-horms+renesas@verge.net.au>
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
 arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index bfb8b3e..2f0d9bf 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -527,6 +527,7 @@ config CPU_SUBTYPE_SH7722
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_CMT
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 
 config CPU_SUBTYPE_SH7366
 	bool "Support SH7366 processor"
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c
index 0688a75..11dbce3 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c
@@ -1,6 +1,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7722.h>
 
 enum {
@@ -1778,7 +1779,7 @@ static struct pinmux_info sh7722_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7722_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7722_pinmux_info);
 }
 
 arch_initcall(plat_pinmux_setup);
-- 
1.7.10.4
