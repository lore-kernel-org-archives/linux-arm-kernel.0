From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:24:07 +0900
Subject: [PATCH 31/80] sh: sh7264: Register PFC platform device
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-32-git-send-email-horms+renesas@verge.net.au>
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
 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 023b2ad..0626044 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -297,6 +297,7 @@ config CPU_SUBTYPE_SH7264
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_CMT
 	select SYS_SUPPORTS_MTU2
+	select PINCTRL
 
 config CPU_SUBTYPE_SH7269
 	bool "Support SH7269 processor"
diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
index 79a0d60..ed9fc39 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7264.h>
 
 enum {
@@ -2131,6 +2132,6 @@ static struct pinmux_info sh7264_pinmux_info = {
 
 static int __init plat_pinmux_setup(void)
 {
-	return register_pinmux(&sh7264_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &sh7264_pinmux_info);
 }
 arch_initcall(plat_pinmux_setup);
-- 
1.7.10.4
