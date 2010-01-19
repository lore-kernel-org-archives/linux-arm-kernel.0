From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Jan 2010 10:13:14 +0100
Subject: [PATCH] arm: deprecate support for old way to pass kernel parameters
In-Reply-To: <20100119085444.GB24447@n2100.arm.linux.org.uk>
References: <20100119085444.GB24447@n2100.arm.linux.org.uk>
Message-ID: <1263892394-5903-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was deprecated in 2001 and announced to live on for 5 years.

For now provide a kernel parameter for those who still need it.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig         |    6 ++++++
 arch/arm/kernel/Makefile |    4 +++-
 arch/arm/kernel/compat.c |    7 -------
 arch/arm/kernel/compat.h |    2 --
 arch/arm/kernel/setup.c  |   11 +++++++++++
 5 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c2238cd..48d4dc0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1254,6 +1254,12 @@ config UACCESS_WITH_MEMCPY
 	  However, if the CPU data cache is using a write-allocate mode,
 	  this option is unlikely to provide any performance gain.
 
+config DEPRECATED_PARAM_STRUCT
+	bool "Provide old way to pass kernel parameters"
+	help
+	  This was deprecated in 2001 and announced to live on for 5 years.
+	  Some old boot loaders still use this way.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index dd00f74..8b54618 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -13,10 +13,12 @@ CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
 
-obj-y		:= compat.o elf.o entry-armv.o entry-common.o irq.o \
+obj-y		:= elf.o entry-armv.o entry-common.o irq.o \
 		   process.o ptrace.o return_address.o setup.o signal.o \
 		   sys_arm.o stacktrace.o time.o traps.o
 
+obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += compat.o
+
 obj-$(CONFIG_OC_ETM)		+= etm.o
 
 obj-$(CONFIG_ISA_DMA_API)	+= dma.o
diff --git a/arch/arm/kernel/compat.c b/arch/arm/kernel/compat.c
index 0a13854..9256523 100644
--- a/arch/arm/kernel/compat.c
+++ b/arch/arm/kernel/compat.c
@@ -217,10 +217,3 @@ void __init convert_to_tag_list(struct tag *tags)
 	struct param_struct *params = (struct param_struct *)tags;
 	build_tag_list(params, &params->u2);
 }
-
-void __init squash_mem_tags(struct tag *tag)
-{
-	for (; tag->hdr.size; tag = tag_next(tag))
-		if (tag->hdr.tag == ATAG_MEM)
-			tag->hdr.tag = ATAG_NONE;
-}
diff --git a/arch/arm/kernel/compat.h b/arch/arm/kernel/compat.h
index 27e61a6..39264ab 100644
--- a/arch/arm/kernel/compat.h
+++ b/arch/arm/kernel/compat.h
@@ -9,5 +9,3 @@
 */
 
 extern void convert_to_tag_list(struct tag *tags);
-
-extern void squash_mem_tags(struct tag *tag);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 84a6e1f..0636ddd 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -43,7 +43,9 @@
 #include <asm/traps.h>
 #include <asm/unwind.h>
 
+#if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
 #include "compat.h"
+#endif
 #include "atags.h"
 #include "tcm.h"
 
@@ -699,6 +701,13 @@ static int __init customize_machine(void)
 }
 arch_initcall(customize_machine);
 
+static void __init squash_mem_tags(struct tag *tag)
+{
+	for (; tag->hdr.size; tag = tag_next(tag))
+		if (tag->hdr.tag == ATAG_MEM)
+			tag->hdr.tag = ATAG_NONE;
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	struct tag *tags = (struct tag *)&init_tags;
@@ -719,12 +728,14 @@ void __init setup_arch(char **cmdline_p)
 	else if (mdesc->boot_params)
 		tags = phys_to_virt(mdesc->boot_params);
 
+#if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
 	/*
 	 * If we have the old style parameters, convert them to
 	 * a tag list.
 	 */
 	if (tags->hdr.tag != ATAG_CORE)
 		convert_to_tag_list(tags);
+#endif
 	if (tags->hdr.tag != ATAG_CORE)
 		tags = (struct tag *)&init_tags;
 
-- 
1.6.6
