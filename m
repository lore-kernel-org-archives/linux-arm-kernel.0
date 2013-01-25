From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:24:11 +0900
Subject: [PATCH 35/80] sh: sh7723: Register PFC platform device
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-36-git-send-email-horms+renesas@verge.net.au>
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
 arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 2f0d9bf..89fb594 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -433,6 +433,7 @@ config CPU_SUBTYPE_SH7723
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_CMT
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 	help
 	  Select SH7723 if you have an SH-MobileR2 CPU.
 
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
index 2037915..ba22b2b 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7723.h>
 
 enum {
@@ -1903,7 +1904,7 @@ static struct pinmux_info sh7723_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7723_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7723_pinmux_info);
 }
 
 arch_initcall(plat_pinmux_setup);
-- 
1.7.10.4
