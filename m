From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 May 2010 10:58:45 +0100
Subject: [PATCH] Optionally allow ARMv6 to use 'normal, bufferable' memory
	for DMA
Message-ID: <20100515095845.GA17080@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a configuration option to allow the ARMv6 to use normal
bufferable memory for coherent DMA.  This option is forced to 'y'
for ARMv7, and offered as a configuration option on ARMv6.

Enabling this option requires drivers to have the necessary barriers
to ensure that data in DMA coherent memory is visible prior to the
DMA operation commencing.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/pgtable.h |    2 +-
 arch/arm/include/asm/system.h  |    2 +-
 arch/arm/mm/Kconfig            |   19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 1139768..ab68cf1 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -314,7 +314,7 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED)
 #define pgprot_writecombine(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE)
-#if __LINUX_ARM_ARCH__ >= 7
+#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
 #define pgprot_dmacoherent(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_BUFFERABLE)
 #else
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 058e7e9..020891e 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -137,7 +137,7 @@ extern unsigned int user_debug;
 #define dmb() __asm__ __volatile__ ("" : : : "memory")
 #endif
 
-#if __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
+#if defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
 #define mb()		dmb()
 #define rmb()		dmb()
 #define wmb()		dmb()
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index baf6384..f0a3576 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -781,3 +781,22 @@ config ARM_L1_CACHE_SHIFT
 	int
 	default 6 if ARM_L1_CACHE_SHIFT_6
 	default 5
+
+config ARM_DMA_MEM_BUFFERABLE
+	bool "Use non-cacheable memory for DMA" if CPU_V6 && !CPU_V7
+	default y if CPU_V6 || CPU_V7
+	help
+	  Historically, the kernel has used strongly ordered mappings to
+	  provide DMA coherent memory.  With the advent of ARMv7, mapping
+	  memory with differing types results in unpredictable behaviour,
+	  so on these CPUs, this option is forced on.
+
+	  Multiple mappings with differing attributes is also unpredictable
+	  on ARMv6 CPUs, but since they do not have aggressive speculative
+	  prefetch, no harm appears to occur.
+
+	  However, drivers may be missing the necessary barriers for ARMv6,
+	  and therefore turning this on may result in unpredictable driver
+	  behaviour.  Therefore, we offer this as an option.
+
+	  You are recommended say 'Y' here and debug any affected drivers.
