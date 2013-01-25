From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:24:17 +0900
Subject: [PATCH 41/80] sh: shx3: Register PFC platform device
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-42-git-send-email-horms+renesas@verge.net.au>
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
 arch/sh/Kconfig                       |    1 +
 arch/sh/kernel/cpu/sh4a/pinmux-shx3.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 27f0b73..c72b616 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -515,6 +515,7 @@ config CPU_SUBTYPE_SHX3
 	select CPU_SHX3
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select ARCH_REQUIRE_GPIOLIB
+	select PINCTRL
 
 # SH4AL-DSP Processor Support
 
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
index 2ebb983..eef1b8f 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <cpu/pfc.h>
 #include <cpu/shx3.h>
 
 enum {
@@ -582,6 +583,6 @@ static struct pinmux_info shx3_pinmux_info = {
 
 static int __init shx3_pinmux_setup(void)
 {
-	return register_pinmux(&shx3_pinmux_info);
+	return sh_pfc_register_info(NULL, NULL, 0, &shx3_pinmux_info);
 }
 arch_initcall(shx3_pinmux_setup);
-- 
1.7.10.4
