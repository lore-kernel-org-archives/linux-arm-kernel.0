From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:23 +0800
Subject: [PATCH 08/13] [ARM] Make VMALLOC_END into a global variable if not
	defined
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-9-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/include/asm/mach/arch.h |    1 +
 arch/arm/include/asm/pgtable.h   |    5 +++++
 arch/arm/kernel/setup.c          |    6 ++++++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 52bea4c..2191d40 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -27,6 +27,7 @@ struct machine_class {
 						 * page tabe entry	*/
 	const char		*name;		/* machine class name	*/
 	unsigned long		boot_params;	/* tagged list		*/
+	unsigned long		vmalloc_end;	/* VMALLOC_END		*/
 
 	void			(*map_io)(void);/* IO mapping function */
 	void			(*init_irq)(void);
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index ab68cf1..478249a 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -40,6 +40,11 @@
 #define VMALLOC_START		(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
 #endif
 
+#ifndef VMALLOC_END
+extern unsigned long vmalloc_end;
+#define VMALLOC_END (vmalloc_end)
+#endif
+
 /*
  * Hardware-wise, we have a two level page table structure, where the first
  * level has 4096 entries, and the second level has 256 entries.  Each entry
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 295de99..672a8ec 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -95,6 +95,9 @@ EXPORT_SYMBOL(isa_dma_threshold);
 unsigned long max_dma_address = 0xffffffffUL;
 EXPORT_SYMBOL(max_dma_address);
 
+unsigned long vmalloc_end = 0xffffffffUL;
+EXPORT_SYMBOL(vmalloc_end);
+
 #ifdef MULTI_CPU
 struct processor processor;
 #endif
@@ -684,6 +687,9 @@ void __init setup_arch(char **cmdline_p)
 	class = mdesc->class;
 	machine_name = mdesc->name;
 
+	if (class)
+		vmalloc_end = class->vmalloc_end;
+
 	if (mdesc->soft_reboot)
 		reboot_setup("s");
 
-- 
1.7.1
