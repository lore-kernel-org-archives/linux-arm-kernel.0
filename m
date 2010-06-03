From: eric.miao@canonical.com (Eric Miao)
Date: Thu,  3 Jun 2010 17:43:35 +0800
Subject: [PATCH 2/2] [ARM] Allow PHYS_OFFSET to be runtime determined
In-Reply-To: <1275558215-12743-1-git-send-email-eric.miao@canonical.com>
References: <1275558215-12743-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1275558215-12743-3-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Original patch from: "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>

Changes to the original patch:

1. simplify the algorithm of getting phys_offset by masking PC with
   0xf000_0000, this works for most platforms, but we can possibly
   loosen this restriction to 0xf800_0000 or 0xfc00_0000 to cover
   more platforms like ARCH_MX1/ARCH_SHARK and ARCH_S3C2400. It is
   a bit more difficult to support the U300 platform though.

2. Assigning 0xdeadbeef to phys_offset might be a bit hackish,
   explicitly specify the section for it.

3. Make RUNTIME_PHYS_OFFSET a toggle-able option in case someone
   want to manually enable or disable it. And make it valid only
   when MMU is enabled and XIP_KERNEL is disabled.

Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Steve Chen <schen@mvista.com>
Cc: Mark A. Greer <mgreer@mvista.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/Kconfig              |    9 +++++++++
 arch/arm/include/asm/memory.h |    6 ++++++
 arch/arm/kernel/head.S        |   14 +++++++++++++-
 arch/arm/kernel/setup.c       |   10 +++++++++-
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 818f731..add2c15 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1498,6 +1498,15 @@ config TEXT_OFFSET
 	  memory start. Currently, it is expected the least significant 16
 	  bits to be 0x8000, so to leave space for the initial page table.
 
+config RUNTIME_PHYS_OFFSET
+	bool "Auto calculate the physical address of the memory start"
+	depends on MMU && !XIP_KERNEL
+	help
+	  PHYS_OFFSET can be automatically caculated at run time by
+	  masking the PC with 0xf0000000 if the memory starts at 256MB
+	  boundary (most platforms do). Do not select this option if
+	  it is not a correct assumption on your platform.
+
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address"
 	depends on !ZBOOT_ROM && !(ARCH_MX1 || ARCH_SHARK || ARCH_U300)
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 4312ee5..fb18aff 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -147,6 +147,12 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_RUNTIME_PHYS_OFFSET
+extern unsigned long phys_offset;
+#undef  PHYS_OFFSET
+#define PHYS_OFFSET	phys_offset
+#endif
+
 /*
  * The DMA mask corresponding to the maximum bus address allocatable
  * using GFP_DMA.  The default here places no restriction on DMA
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index db789fb..c77db05 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -22,7 +22,7 @@
 #include <asm/thread_info.h>
 #include <asm/system.h>
 
-#if (PHYS_OFFSET & 0x001fffff)
+#if !defined(CONFIG_RUNTIME_PHYS_OFFSET) && (PHYS_OFFSET & 0x001fffff)
 #error "PHYS_OFFSET must be at an even 2MiB boundary!"
 #endif
 
@@ -48,9 +48,15 @@
 	add	\rd, \phys_offset, #(TEXT_OFFSET - 0x4000)
 	.endm
 
+#ifndef CONFIG_RUNTIME_PHYS_OFFSET
 	.macro	get_phys_offset, rd
 	ldr	\rd, =(PHYS_OFFSET & 0xfff00000)
 	.endm
+#else
+	.macro	get_phys_offset, rd
+	and	\rd, pc, #0xf0000000
+	.endm
+#endif
 
 #ifdef CONFIG_XIP_KERNEL
 #define KERNEL_START	XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
@@ -332,6 +338,12 @@ __create_page_tables:
 	str	r3, [r0]
 #endif
 #endif
+
+#ifdef CONFIG_RUNTIME_PHYS_OFFSET
+	@ save to __phys_to_virt(phys_offset)
+	ldr	r0, =(phys_offset - PAGE_OFFSET)
+	str	r5, [r0, r5]
+#endif
 	mov	pc, lr
 ENDPROC(__create_page_tables)
 	.ltorg
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 122d999..e11fdb7 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -105,6 +105,12 @@ struct cpu_cache_fns cpu_cache;
 struct outer_cache_fns outer_cache;
 EXPORT_SYMBOL(outer_cache);
 #endif
+#ifdef CONFIG_RUNTIME_PHYS_OFFSET
+/* prevent phys_offset from being end up in bss */
+unsigned long phys_offset __attribute__(section(".data"));
+EXPORT_SYMBOL(phys_offset);
+#endif
+
 
 struct stack {
 	u32 irq[3];
@@ -648,7 +654,7 @@ static struct init_tags {
 	{ tag_size(tag_core), ATAG_CORE },
 	{ 1, PAGE_SIZE, 0xff },
 	{ tag_size(tag_mem32), ATAG_MEM },
-	{ MEM_SIZE, PHYS_OFFSET },
+	{ MEM_SIZE, },
 	{ 0, ATAG_NONE }
 };
 
@@ -678,6 +684,8 @@ void __init setup_arch(char **cmdline_p)
 	if (mdesc->soft_reboot)
 		reboot_setup("s");
 
+	init_tags.mem.start = PHYS_OFFSET;
+
 	if (__atags_pointer)
 		tags = phys_to_virt(__atags_pointer);
 	else if (mdesc->boot_params)
-- 
1.7.0.4
