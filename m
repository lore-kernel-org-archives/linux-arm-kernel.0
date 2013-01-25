From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:24:54 +0900
Subject: [PATCH 78/80] sh: Remove unused sh_pfc_register_info() function
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-79-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All boards use sh_pfc_register() directly, remove the unused
sh_pfc_register_info() function.

Make the name argument to sh_pfc_register() mandatory as it's now
supplied by all callers.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/include/asm/gpio.h           |    2 +-
 arch/sh/include/cpu-common/cpu/pfc.h |    4 ----
 arch/sh/kernel/cpu/pfc.c             |   13 +------------
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/sh/include/asm/gpio.h b/arch/sh/include/asm/gpio.h
index 04f53d3..7dfe15e 100644
--- a/arch/sh/include/asm/gpio.h
+++ b/arch/sh/include/asm/gpio.h
@@ -20,7 +20,7 @@
 #endif
 
 #define ARCH_NR_GPIOS 512
-#include <linux/sh_pfc.h>
+#include <asm-generic/gpio.h>
 
 #ifdef CONFIG_GPIOLIB
 
diff --git a/arch/sh/include/cpu-common/cpu/pfc.h b/arch/sh/include/cpu-common/cpu/pfc.h
index 40e8643..e538813 100644
--- a/arch/sh/include/cpu-common/cpu/pfc.h
+++ b/arch/sh/include/cpu-common/cpu/pfc.h
@@ -18,13 +18,9 @@
 
 #include <linux/types.h>
 
-struct pinmux_info;
 struct resource;
 
 int sh_pfc_register(const char *name,
 		    struct resource *resource, u32 num_resources);
-int sh_pfc_register_info(const char *name,
-			 struct resource *resource, u32 num_resources,
-			 struct pinmux_info *pdata);
 
 #endif /* __ARCH_SH_CPU_PFC_H__ */
diff --git a/arch/sh/kernel/cpu/pfc.c b/arch/sh/kernel/cpu/pfc.c
index d045d75..d766564 100644
--- a/arch/sh/kernel/cpu/pfc.c
+++ b/arch/sh/kernel/cpu/pfc.c
@@ -19,26 +19,15 @@
 #include <cpu/pfc.h>
 
 static struct platform_device sh_pfc_device = {
-	.name		= "sh-pfc",
 	.id		= -1,
 };
 
 int __init sh_pfc_register(const char *name,
 			   struct resource *resource, u32 num_resources)
 {
-	if (name)
-		sh_pfc_device.name = name;
+	sh_pfc_device.name = name;
 	sh_pfc_device.num_resources = num_resources;
 	sh_pfc_device.resource = resource;
 
 	return platform_device_register(&sh_pfc_device);
 }
-
-int __init sh_pfc_register_info(const char *name,
-				struct resource *resource, u32 num_resources,
-				struct pinmux_info *pdata)
-{
-	sh_pfc_device.dev.platform_data = pdata;
-
-	return sh_pfc_register(name, resource, num_resources);
-}
-- 
1.7.10.4
