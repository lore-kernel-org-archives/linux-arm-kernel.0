From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:31 -0400
Subject: [PATCH 46/52] ARM: mach-u300: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-46-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Someone was smoking good stuff with CONFIG_MACH_U300_2MB_ALIGNMENT_FIX here...

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-u300/include/mach/memory.h |    8 ++++----
 arch/arm/mach-u300/u300.c                |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-u300/include/mach/memory.h b/arch/arm/mach-u300/include/mach/memory.h
index 888e2e3..f98acd9 100644
--- a/arch/arm/mach-u300/include/mach/memory.h
+++ b/arch/arm/mach-u300/include/mach/memory.h
@@ -16,7 +16,7 @@
 #ifdef CONFIG_MACH_U300_DUAL_RAM
 
 #define PLAT_PHYS_OFFSET		UL(0x48000000)
-#define BOOT_PARAMS_OFFSET	(PHYS_OFFSET + 0x100)
+#define BOOT_PARAMS_OFFSET		0x100
 
 #else
 
@@ -24,14 +24,14 @@
 #define PLAT_PHYS_OFFSET (0x28000000 + \
 	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE - \
 	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1))*1024*1024)
+#define BOOT_PARAMS_OFFSET (0x100 + \
+	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1)*1024*1024*2)
 #else
 #define PLAT_PHYS_OFFSET (0x28000000 + \
 	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE +	\
 	     (CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1))*1024*1024)
+#define BOOT_PARAMS_OFFSET 0x100
 #endif
-#define BOOT_PARAMS_OFFSET (0x28000000 + \
-	    (CONFIG_MACH_U300_ACCESS_MEM_SIZE +		\
-	    (CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1))*1024*1024 + 0x100)
 #endif
 
 /*
diff --git a/arch/arm/mach-u300/u300.c b/arch/arm/mach-u300/u300.c
index 48b3b7f..80e7305 100644
--- a/arch/arm/mach-u300/u300.c
+++ b/arch/arm/mach-u300/u300.c
@@ -61,7 +61,7 @@ static void __init u300_init_machine(void)
 
 MACHINE_START(U300, MACH_U300_STRING)
 	/* Maintainer: Linus Walleij <linus.walleij@stericsson.com> */
-	.boot_params	= BOOT_PARAMS_OFFSET,
+	.atag_offset	= BOOT_PARAMS_OFFSET,
 	.map_io		= u300_map_io,
 	.reserve	= u300_reserve,
 	.init_irq	= u300_init_irq,
-- 
1.7.4
