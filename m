From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:21 +0800
Subject: [PATCH 06/13] [ARM] Allow MAX_DMA_ADDRESS and ISA_DMA_THRESHOLD to be
	variables
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-7-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If MAX_DMA_ADDRESS or ISA_DMA_THRESHOLD is not defined, they will be
defined as their variable couterparts, which are calculated from the
'isa_dma_size' field in 'struct machine_desc'.

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/include/asm/dma.h       |    3 ++-
 arch/arm/include/asm/mach/arch.h |    1 +
 arch/arm/include/asm/memory.h    |    3 ++-
 arch/arm/kernel/setup.c          |    9 +++++++++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index ca51143..daea8ac 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -7,7 +7,8 @@
  * This is the maximum virtual address which can be DMA'd from.
  */
 #ifndef MAX_DMA_ADDRESS
-#define MAX_DMA_ADDRESS	0xffffffff
+extern unsigned long max_dma_address;
+#define MAX_DMA_ADDRESS	(max_dma_address)
 #endif
 
 #ifdef CONFIG_ISA_DMA_API
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 0422d84..52bea4c 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -58,6 +58,7 @@ struct machine_desc {
 	unsigned int		reserve_lp1 :1;	/* never has lp1	*/
 	unsigned int		reserve_lp2 :1;	/* never has lp2	*/
 	unsigned int		soft_reboot :1;	/* soft reboot		*/
+	unsigned long		isa_dma_size;
 	void			(*fixup)(struct machine_desc *,
 					 struct tag *, char **,
 					 struct meminfo *);
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 82df0ae..a3ff72a 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -154,7 +154,8 @@
  * so a successful GFP_DMA allocation will always satisfy this.
  */
 #ifndef ISA_DMA_THRESHOLD
-#define ISA_DMA_THRESHOLD	(0xffffffffULL)
+extern unsigned long isa_dma_threshold;
+#define ISA_DMA_THRESHOLD	(isa_dma_threshold)
 #endif
 
 #ifndef arch_adjust_zones
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index b6a0262..295de99 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -89,6 +89,11 @@ EXPORT_SYMBOL(system_serial_high);
 unsigned int elf_hwcap;
 EXPORT_SYMBOL(elf_hwcap);
 
+unsigned long isa_dma_threshold = 0xffffffffUL;
+EXPORT_SYMBOL(isa_dma_threshold);
+
+unsigned long max_dma_address = 0xffffffffUL;
+EXPORT_SYMBOL(max_dma_address);
 
 #ifdef MULTI_CPU
 struct processor processor;
@@ -383,6 +388,10 @@ static struct machine_desc * __init setup_machine(unsigned int nr)
 
 	printk("Machine: %s\n", list->name);
 
+	if (list->isa_dma_size) {
+		isa_dma_threshold = PHYS_OFFSET + list->isa_dma_size - 1;
+		max_dma_address = PAGE_OFFSET + list->isa_dma_size;
+	}
 	return list;
 }
 
-- 
1.7.1
